From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug: build from tarball uses git-describe
Date: Wed, 14 Feb 2007 02:10:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702140206550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eqtfso$7mo$1@sea.gmane.org>
 <Pine.LNX.4.63.0702140159440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd54dwnvb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 02:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH8fU-0003PZ-U8
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 02:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbXBNBKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 20:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbXBNBKl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 20:10:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:57277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932212AbXBNBKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 20:10:40 -0500
Received: (qmail invoked by alias); 14 Feb 2007 01:10:39 -0000
X-Provags-ID: V01U2FsdGVkX187U3F++iU7p7YYlVuh0YjSKUh/j3RPa9MdulqhdK
	nV0A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vd54dwnvb.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39605>

Hi,

On Tue, 13 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Does this (totally untested) patch help?
> >
> > --
> >
> >  GIT-VERSION-GEN |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> > index 7a10b60..e6f89cb 100755
> > --- a/GIT-VERSION-GEN
> > +++ b/GIT-VERSION-GEN
> > @@ -8,7 +8,7 @@ LF='
> >  
> >  # First try git-describe, then see if there is a version file
> >  # (included in release tarballs), then default
> > -if VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
> > +if test -d .git && VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
> >     case "$VN" in
> >     *$LF*) (exit 1) ;;
> >     v[0-9]*) : happy ;;
> 
> Have you checked what the elif part does in the if statement you
> are patching?

It checks if the file "version" exists, and takes the contents of that as 
version, otherwise $DEF_VER.

> After all fresh tarball is how we build rpm packages and we do
> not have .git in that build environment, so I am quite puzzled.

Yes, the idea was: if there is no .git, do not even bother checking the 
output of git-describe (it might find a .git directory in a parent 
directory, after all).

Ciao,
Dscho
