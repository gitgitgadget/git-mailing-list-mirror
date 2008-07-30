From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 20:21:49 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807292002520.3334@nehalem.linux-foundation.org>
References: <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <20080729053108.GH26997@sigill.intra.peff.net> <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain> <20080729125247.GC12069@sigill.intra.peff.net> <Pine.LNX.4.64.0807300430590.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Tim Harper <timcharper@gmail.com>,
	git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 05:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO2Lk-0002kp-PP
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 05:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbYG3DZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 23:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbYG3DZ2
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 23:25:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48545 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484AbYG3DZ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 23:25:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U3Omqa017586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 20:24:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U3OmPx004616;
	Tue, 29 Jul 2008 20:24:48 -0700
In-Reply-To: <Pine.LNX.4.64.0807300430590.6791@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90730>



On Wed, 30 Jul 2008, Roman Zippel wrote:
> 
> For printk.c look for commit 02630a12c7f72fa294981c8d86e38038781c25b7 and 
> try to find it in the graphical outputs.

Umm.

Why would you? Yes, it's there, if you ask for --full-history. And no, I 
don't think --full-history is actually useful to humans - it's very much 
there as a "here's all the data" thing where you could have the tools 
post-process it, where often "post-processing" is actually just searching 
for it.

And no, it's not there if you don't use --full-history.

But now, instead of _complaining_ about this, I would suggest you think 
about why it's a _good_ thing, and why it's so useful?

In other words, you're arriving at all your complaints from the wrong 
angle entirely, and because you have convinced yourself that things have 
to work a certain way, and then you're upset when they don't.

But you should _unconvince_ yourself - and look at whether maybe all your 
initial preconceptions were perhaps totally wrong? Because they were.

The reason that commit 02630a12c7f72fa294981c8d86e38038781c25b7 doesn't 
show up in the normal log when looking at kernel/printk.c is that it 
really doesn't exist as a _relevant_ part of history for the current state 
of that file. It exists only as a a side-branch for the GFS2 quota code 
that first adds a line

	+EXPORT_SYMBOL_GPL(tty_write_message);

(in commit b346671fa196a), and then removes the line not long after (in 
that commit 02630a12c7f). And both of them go away (along with the whole 
side-branch), because they didn't end up mattering for the end result: 
they only ever existed in that side branch, and by the time it was merged 
back into the main branch, all changes had been undone.

In other words, that change - in a VERY REAL WAY - never actually mattered 
for the current state of kernel/printk.c. And the history simplification 
sees that, and avoids showing the whole pointless branch.

This is such an obviously _good_ thing that I really am surprised ay how 
you can continue to argue against it. Especially as the examples you give 
"for" your argument are so wonderful examples _against_ it.

And yes, you can actually force gitk to show the state of that commit and 
thus force it to acknowledge that that state was relevant (although you 
won't necessarily force it to acknowledge that the relevance ties together 
with the final end result). You do that by just telling it that you're not 
just interested in HEAD, but in that commit too.

So I would literally suggest that anybody interested in this subject 
really just do

	gitk kernel/printk.c &
	gitk HEAD 02630a12c7f72fa294981c8d86e38038781c25b7 kernel/printk.c &

in the kernel, and now compare the two side-by-side. Notice where they 
differ (hint: look for the commit a0f1ccfd8d37457a6d8a9e01acebeefcdfcc306e 
- "[PATCH] lockdep: do not recurse in printk" - which is in both, and look 
below it).

Now, which graph is the more relevant and understandable one from the 
standpoint of what the current state of kernel/printk.c is?

Honestly now, Roman.

Because if you were actually willing to see this as a _feature_ (which it 
very much is), you'd admit that it's a damn clever and useful one. But I 
suspect you have dug yourself so deep into a hole that you can't admit 
that even to yourself any more.

				Linus
