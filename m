From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Sun, 11 Sep 2005 11:07:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509111100260.3242@g5.osdl.org>
References: <deofnh$jl0$1@sea.gmane.org> <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Ellson <ellson@research.att.com>, git@vger.kernel.org,
	Patrick Mauritz <oxygene@studentenbude.ath.cx>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 11 20:08:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEWEx-0005M3-FJ
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 20:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVIKSHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 14:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVIKSHk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 14:07:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965001AbVIKSHk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 14:07:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8BI7FBo015295
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 11:07:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8BI77Wg015149;
	Sun, 11 Sep 2005 11:07:09 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8311>



On Sun, 11 Sep 2005, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I have three fixes in my personal tree without which git refuses to 
> > compile:
> >
> > - daemon.c needs a define or typedef for socklen_t.
> 
> I still keep that patch around (the patch was end of July), but
> have not touched it only because I did not hear from you asking
> about its inclusion.

Side note: one simple solution for "socklen_t" is to just replace it with 
"int".

Any operating system where socklen_t is anything else than "int" is 
terminally broken. The people who introduced that typedef were confused, 
and I actually had to argue with them that it was fundamentally wrong: 
there is no other valid type than "int" that makes sense for it.

In case anybody cares: not only is "int" obviously "big enough" even on 
some theoretical 16-bit architecture, so there's never any real _reason_ 
to use anything else.

But more importantly, the core BSD networking functions have historically
had declarations like

	int accept(int s, struct sockaddr *addr, int *addrlen);

which means that if 'socklen_t' is ever anything else than "int", you'd 
break all old applications. For no good reason. 

Ergo, any operating system that has socklen_t != int is so broken that 
it's simply not worth playing with.

(POSIX for a short while had _defined_ it to be the same as "size_t", I 
really had to scream at some people over it, and told people that Linux 
would never do anything that stupid. Apparently Linux was the first 
64-bit operating system that people actually ever tried to use).

		Linus
