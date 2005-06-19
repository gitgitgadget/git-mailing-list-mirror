From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sun, 19 Jun 2005 12:01:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506191153350.2268@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
 <2cfc403205061817181e4d6d5e@mail.gmail.com> <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
 <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org> <2cfc403205061903155a6090db@mail.gmail.com>
 <2cfc40320506190741409f3a5@mail.gmail.com> <Pine.LNX.4.58.0506190951330.2268@ppc970.osdl.org>
 <20050619173634.GA25768@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jon@blackcubes.dyndns.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 19 20:54:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk4vd-0006SM-BL
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 20:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFSS7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 14:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVFSS7l
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 14:59:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17801 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261184AbVFSS7i (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 14:59:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5JIxVjA030461
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 19 Jun 2005 11:59:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5JIxRYd019713;
	Sun, 19 Jun 2005 11:59:28 -0700
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050619173634.GA25768@elte.hu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 19 Jun 2005, Ingo Molnar wrote:
> 
> another assumption is that the number of testsystems is a power of two 
> minus 1. With 2 or more testsystems (and automated testing) you could 
> dissect the search space into 3, 5 or more roughly equal pieces in the 
> first step (2, 4, 8 ... sections are already supported via the bisect 
> flag).

Yeah. I don't think it matters much, though, since the "more testsystems"  
thing will only really end up helping by a fairly small amount, at the
cost of much more complexity. The difference between "log2(N)" and
"log5(N)" isn't _that_ big, and it's even smaller when you just do the
power-of-two thing and use 4 systems instead of 5 (ie now it's "log4(N)"  
vs "log5(N)").

Also, to use multiple test-systems efficiently, they all end up having to
be synchronized (ie the next iteration needs to get the result from all
the test-systems from the previous one), so it's quite a lot of bother for
not a lot of improvement. It also assumes you can partition the problem
space well into <n> roughly equal pieces - which may or may not be true.

More importantly, quite often the nasty problems are the ones that only 
happen for one machine. Trying to make it easy for non-developers to test 
different kernels is what this is about: I started thinking about this 
when we had the "x86-64 SIGSEGV's for me" issue, where bisection was 
fairly easy in the -mm series due to a nice linear series, but even then 
you had to have tools to apply/unapply different patches etc.

		Linus
