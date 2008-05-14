From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] diff options: Introduce --ignore-submodules
Date: Wed, 14 May 2008 19:42:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141940460.30431@racer>
References: <alpine.DEB.1.00.0805141802480.30431@racer> <alpine.DEB.1.00.0805141803240.30431@racer> <7vbq38oi3j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 20:44:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwLxO-0004lL-VR
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 20:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760209AbYENSmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 14:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760611AbYENSmz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 14:42:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:41580 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759359AbYENSmy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 14:42:54 -0400
Received: (qmail invoked by alias); 14 May 2008 18:42:52 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp008) with SMTP; 14 May 2008 20:42:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BnNsNe0vBJCei95Hsp1nojVZX+jfp5YaKi+2aBo
	2NKK57qjrcE/6h
X-X-Sender: gene099@racer
In-Reply-To: <7vbq38oi3j.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82132>

Hi,

On Wed, 14 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > @@ -3355,6 +3357,9 @@ void diff_addremove(struct diff_options *options,
> >  	char concatpath[PATH_MAX];
> >  	struct diff_filespec *one, *two;
> >  
> > +	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES) && S_ISGITLINK(mode))
> > +		return;
> > +
> >  	/* This may look odd, but it is a preparation for
> >  	 * feeding "there are unchanged files which should
> >  	 * not produce diffs, but when you are doing copy
> 
> So both removal and addition of a submodule is an uninteresting event.

Yes.

> > @@ -3399,6 +3404,10 @@ void diff_change(struct diff_options *options,
> >  	char concatpath[PATH_MAX];
> >  	struct diff_filespec *one, *two;
> >  
> > +	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES) && S_ISGITLINK(old_mode)
> > +			&& S_ISGITLINK(new_mode))
> > +		return;
> 
> And a submodule changing from revision A to B is uninteresting.
> 
> Is it interesting if something that used to be a blob turns into a
> submodule, or vice versa?  The code says it is, but I think it would be
> more convenient to treat it as a removal of blob and addition of a
> submodule.

The point is: for the sake of a script (which wants to ignore 
submodules) asking if there is a diff, I think it makes sense to not 
ignore those changes.  IOW I think my patch is enough for the purpose of 
getting stash/rebase to behave.

Ciao,
Dscho
