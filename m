From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MinGW: fix diff --no-index /dev/null ...
Date: Sat, 7 Mar 2009 21:47:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903072133270.10279@pacific.mpi-cbg.de>
References: <cover.1236441065u.git.johannes.schindelin@gmx.de> <dba002b9e521c639847650fbaeb8b87b66b9562e.1236441065u.git.johannes.schindelin@gmx.de> <7v8wnhnl6t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 21:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg3QR-0000NS-6H
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 21:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbZCGUpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 15:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbZCGUpr
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 15:45:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:47148 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753519AbZCGUpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 15:45:46 -0500
Received: (qmail invoked by alias); 07 Mar 2009 20:45:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 07 Mar 2009 21:45:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19azVVogsZagRLvncBTd8ZmzZkJWLYAt/R6uFQyZI
	u++8zFAJ7WAokS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v8wnhnl6t.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112579>

Hi,

On Sat, 7 Mar 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/diff-no-index.c b/diff-no-index.c
> > index 0a14268..598687b 100644
> > --- a/diff-no-index.c
> > +++ b/diff-no-index.c
> > @@ -38,6 +38,10 @@ static int get_mode(const char *path, int *mode)
> >  
> >  	if (!path || !strcmp(path, "/dev/null"))
> >  		*mode = 0;
> > +#ifdef _WIN32
> > +	else if (!strcasecmp(path, "nul"))
> > +		*mode = 0;
> > +#endif
> >  	else if (!strcmp(path, "-"))
> >  		*mode = create_ce_mode(0666);
> >  	else if (lstat(path, &st))
> 
> I had a brief "Huh? -- doesn't this call for an is_dev_null() helper"
> moment, but I think you are right that diff-no-index.c is the right place
> to special case it.

You're right, it needs to be explained in the commit message.  So how 
about this:

-- snip --
Unlike other places where a string is compared to /dev/null, in this case 
do not parse a diff, but rather command line parameters that have 
possibly been transformed from /dev/null to nul, so that the file can be 
opened.
-- snap --

If you like it, may I ask you to amend the message?

> Should this go to 'maint'?

Technically, yes, as it is a fix.

However, it might not be necessary, as literally all Windows work on Git 
happens in git/mingw.git, git/mingw/j6t.git and git/mingw/4msysgit.git.

Your call.

Thanks,
Dscho
