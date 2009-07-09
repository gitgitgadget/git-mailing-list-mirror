From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: found a resource leak in file builtin-fast-export.c
Date: Thu, 9 Jul 2009 13:04:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907091302520.4339@intel-tinevez-2-302>
References: <20090709075728.137880@gmx.net> <200907091031.43494.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Ettl <ettl.martin@gmx.de>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 09 13:04:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOrQS-0001ff-SF
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 13:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbZGILEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 07:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbZGILEW
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 07:04:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:36691 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753482AbZGILEV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 07:04:21 -0400
Received: (qmail invoked by alias); 09 Jul 2009 11:04:20 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp004) with SMTP; 09 Jul 2009 13:04:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fO8VrI31fJwfBe+CnXT/t3d8YfklO+Zftum3A5k
	oJum/4fuvAJlbv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200907091031.43494.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122966>

Hi,

On Thu, 9 Jul 2009, Thomas Rast wrote:

> Martin Ettl wrote:
> > 
> > I have attached a patch to resolve this.
> 
> Please read Documentation/SubmittingPatches in the source tree.  And
> use git to track git.git!
> 
> As for the actual patch:

Thanks for inlining it and sparing me (and others) the hassle.

> > --- git-1.6.3.3/builtin-fast-export.c	2009-06-22 08:24:25.000000000 +0200
> > +++ git-1.6.3.3/builtin-fast-export_new.c	2009-07-09 09:44:28.000000000 +0200
> > @@ -442,8 +442,9 @@ static void export_marks(char *file)
> >  		deco++;
> >  	}
> >  
> > -	if (ferror(f) || fclose(f))
> > +	if (ferror(f))
> >  		error("Unable to write marks file %s.", file);
> > +  	fclose(f);
> 
> You no longer check the error returned by fclose().  This is
> important, because the FILE* API may buffer writes, and a write error
> may only become apparent when fclose() flushes the file.

Indeed.  A better fix would be to replace the || by a |, but this must be 
accompanied by a comment so it does not get removed due to overzealous 
compiler warnings.

Ciao,
Dscho
