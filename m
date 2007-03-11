From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-upload-pack: the timeout gets corrupted?!
Date: Sun, 11 Mar 2007 23:01:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703112300520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45F35F38.1080206@zytor.com> <7vy7m4wcfb.fsf@assigned-by-dhcp.cox.net>
 <45F3CAAF.7030909@zytor.com> <Pine.LNX.4.63.0703111314150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F427EA.8000905@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 23:01:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQW6v-0005CN-DW
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 23:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbXCKWB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 18:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932886AbXCKWB0
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 18:01:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:37983 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932883AbXCKWBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 18:01:25 -0400
Received: (qmail invoked by alias); 11 Mar 2007 22:01:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 11 Mar 2007 23:01:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8fCgW7mv8zHI3DKdCjZT+XDvY12rAfA+HKa0dgh
	j9civ3Slxkz/pc
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45F427EA.8000905@zytor.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41994>

Hi,

On Sun, 11 Mar 2007, H. Peter Anvin wrote:

> Johannes Schindelin wrote:
> > 
> > Something like this (totally untested):
> > 
> >  upload-pack.c |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/upload-pack.c b/upload-pack.c
> > index 498bf50..bafd90f 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -119,6 +119,8 @@ static void create_pack_file(void)
> >  		int i;
> >  		struct rev_info revs;
> >  +		close(0);
> > +
> >  		pack_pipe = fdopen(lp_pipe[1], "w");
> >   		if (create_full_pack)
> 
> Shouldn't that be close(lp_pipe[0]);?

Yes, of course!

> > @@ -167,6 +169,10 @@ static void create_pack_file(void)
> >  		const char *argv[10];
> >  		int i = 0;
> >  +		close(0);
> > +		close(1);
> > +		close(2);
> > +
> >  		dup2(lp_pipe[0], 0);
> >  		dup2(pu_pipe[1], 1);
> >  		dup2(pe_pipe[1], 2);
> > 
> 
> Those close()'s are redundant with the dup2's...

I didn't know that, but that makes sense.

Ciao,
Dscho
