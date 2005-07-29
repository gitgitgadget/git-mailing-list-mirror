From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Fri, 29 Jul 2005 09:31:34 +0200
Message-ID: <20050729073134.GA6507@mars.ravnborg.org>
References: <20050727083910.GG19290@mythryan2.michonline.com> <7v4qafrk8w.fsf@assigned-by-dhcp.cox.net> <20050729065335.GA32263@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 09:31:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyPKx-00040h-LZ
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 09:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVG2Hat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 03:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVG2Hat
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 03:30:49 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:19864 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262480AbVG2Hab
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 03:30:31 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepc.post.tele.dk (Postfix) with ESMTP id 3109D26286C;
	Fri, 29 Jul 2005 09:30:22 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 057116AC01D; Fri, 29 Jul 2005 09:31:35 +0200 (CEST)
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20050729065335.GA32263@mythryan2.michonline.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> > While I do not have strong objections to make the build process
> > go faster, it is somewhat disturbing that the Makefile pieces
> > maintained in subdirectories need to name things they touch
> > using paths that include the subdirectory names.  I do not have
> > a better alternative to suggest, though...

If the goal is to speed up the build process the only sane way is to fix
the dependencies. In kbuild fixdep is used to parse the .c file and it
locates all references to .h files (recursive) and also detects any
usage of CONFIG_ symbols.
This part should be relative straightforward to include in git.

> I think I'm going to rethink this, a bit more.  I'm unhappy with how I
> had to edit the sub-dir Makefiles to include directory names.  Sam, if
> you happen to be reading this, feel free to help out!
> 
> I'm almost thinking that something like:
> 
> 	PROGS := 
> 	SCRIPTS :=
> 	include x/Makefile.inc
> 	PROGRAMS += $(addprefix x/,$PROGS)
> 	ALL_SCRIPTS += $(addprefix x/,$SCRIPTS)

That is doable for sure. But it hits you hard when you have to create
some special rules in a subdirectory - then you need to know in what
directory you are placed. You could assing sub := x before including
x/Makefile.inc.

On the other hand. The recursive make considered harmful is IMHO a bit
overaggregated. See the kernel where it is used extensively. And it
works with no hassle. For a small project like git it should be possible
to keep the dependencies in proper shape so there is no cross directory
boundaries to worry about - or at least only a few.

	Sam
