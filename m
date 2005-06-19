From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sat, 18 Jun 2005 22:30:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506182218180.2268@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org><2cfc403205061817181e4d6d5e@mail.gmail.com>
 <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
 <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
 <Pine.LNX.4.62.0506182204350.11617@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jon@blackcubes.dyndns.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 19 07:23:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjsGx-00049B-Dt
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 07:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVFSF2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 01:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVFSF2k
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 01:28:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261851AbVFSF2g (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 01:28:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5J5SWjA003449
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 18 Jun 2005 22:28:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5J5SVOw026196;
	Sat, 18 Jun 2005 22:28:31 -0700
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0506182204350.11617@qynat.qvtvafvgr.pbz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 18 Jun 2005, David Lang wrote:
> 
> if it takes you about as long to type the command (and scan it to make 
> sure you didn't mistype it) as it does to execute you don't have a 
> performance problem :-)

Yeah, well, in all honesty, I haven't actually verified that my bisection 
gives the right answer.

I verified "visually" that it does something half-way sane with this:

  git-rev-list --bisect HEAD ^v2.6.12-rc2 > .git/refs/tags/bisect-1
  git-rev-list --bisect HEAD ^v2.6.12-rc2 ^bisect-1 > .git/refs/tags/bisect-2
  git-rev-list --bisect HEAD ^v2.6.12-rc2 ^bisect-1 ^bisect-2 > .git/refs/tags/bisect-3
  git-rev-list --bisect HEAD ^v2.6.12-rc2 ^bisect-1 ^bisect-2 ^bisect-3 > .git/refs/tags/bisect-4
  git-rev-list --bisect HEAD ^v2.6.12-rc2 ^bisect-1 ^bisect-2 ^bisect-3 ^bisect-4 > .git/refs/tags/bisect-5
  gitk

and it looked sane (ie "bisect-1" should show up as a tag about half-way, 
and the others should get progressively closer to the HEAD). But when I 
now tried it again (I did the above originally with plain 2.6.12), I get 
errors from "gitk":

	ERROR: none of the pending commits can be done yet:
	  bd6ae2f6d61da0f90c6b66e9a4ab6c53ef8c159a
	  2512809255d018744fe6c2f5e996c83769846c07
	  88d7bd8cb9eb8d64bf7997600b0d64f7834047c5
	  b3214970abbe983cd89842ae24ea00e21bba79f6

which looks like the current kernel overflows gitk some way (there's 
suddenly a lot more parallellism, since there were a number of merges that 
were pending, waiting for the 2.6.12 release).

		Linus
