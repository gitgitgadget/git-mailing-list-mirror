From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 03 May 2005 11:04:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505031104080.14033@localhost.localdomain>
References: <200505030657.38309.alonz@nolaviz.org>
 <200505031013.57476.mason@suse.com>
 <Pine.LNX.4.62.0505031022340.14033@localhost.localdomain>
 <200505031037.38005.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 17:00:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSyri-0001q9-5a
	for gcvg-git@gmane.org; Tue, 03 May 2005 16:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVECPFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 11:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVECPFX
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 11:05:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58842 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261642AbVECPFO
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 11:05:14 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFX005A25W3WM@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 May 2005 11:04:52 -0400 (EDT)
In-reply-to: <200505031037.38005.mason@suse.com>
X-X-Sender: nico@localhost.localdomain
To: Chris Mason <mason@suse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 3 May 2005, Chris Mason wrote:

> On Tuesday 03 May 2005 10:24, Nicolas Pitre wrote:
> > On Tue, 3 May 2005, Chris Mason wrote:
> > > Hmmm, something is strange here, am I using this wrong?
> > >
> > > coffee:~/git/linus.orig # ./test-delta -d foo foo2 delta1
> > > coffee:~/git/linus.orig # ./test-delta -p foo delta1 out
> > > *** glibc detected *** free(): invalid next size (fast): 0x0804b008 ***
> > > Aborted
> >
> > Can you send me your foo and delta2 files?
> >
> Sorry, thought I had the whole command history in there.  I went for something 
> small to start ;)
> 
> coffee:~/git/linus.orig # echo foo > foo
> coffee:~/git/linus.orig # echo foo2 > foo2
> coffee:~/git/linus.orig # ./test-delta -d foo foo2 delta1
> coffee:~/git/linus.orig # ls -la delta1
> -rw-r--r--  1 root root 14 2005-05-03 10:36 delta1
> coffee:~/git/linus.orig # ./test-delta -p foo delta1 out
> *** glibc detected *** free(): invalid next size (fast): 0x0804b008 ***

OK, doh!

--- diff-delta.c.orig	2005-05-03 11:00:39.900529634 -0400
+++ diff-delta.c	2005-05-03 11:01:03.210031176 -0400
@@ -307,7 +307,7 @@
 	}
 
 	if (inscnt)
-		out[-inscnt - 1] = inscnt;
+		out[outpos - inscnt - 1] = inscnt;
 
 	delta_cleanup(&bdf);
 	*delta_size = outpos;
