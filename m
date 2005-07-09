From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Converting commits to patch files?  HEAD vs HEAD^
Date: Fri, 8 Jul 2005 18:52:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507081846020.17536@g5.osdl.org>
References: <20050709013859.GA11947@buici.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 03:52:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr4Vy-0001NI-NX
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 03:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbVGIBwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 21:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbVGIBwM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 21:52:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263069AbVGIBwL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 21:52:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j691q8jA009576
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 8 Jul 2005 18:52:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j691q72r008992;
	Fri, 8 Jul 2005 18:52:07 -0700
To: Marc Singer <elf@buici.com>
In-Reply-To: <20050709013859.GA11947@buici.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 8 Jul 2005, Marc Singer wrote:
>
>  # git diff HEAD^ HEAD
> 
> This command will produce a diff of the changes I've made.  What is
> the HEAD^?  Does it refer to the commit before the last one made?

Yes. The core tools don't understand this syntax, but most of the helper 
scripts use "git-rev-parse" to parse arguments, and then you have the 
"extended syntax" which allows short SHA1 names and "parenting".

HEAD^ is the "first parent of HEAD". You could also have written it
"HEAD^1", although the number is really only relevant if you have a merge,
and you want to specify the _other_ side, ie "HEAD^2" is the "second
parent of HEAD".

If you want to have the parent of the parent, write HEAD^^.

Now, to confuse things, a "^" at the _beginning_ of the name means 
something else: it means "not", and it used to do ranges.

> If I've made several commits, I'd like to be able to gather several
> together and produce a patch file.  Better still, I'd like to be able
> to pick a set of discontiguous commits an bundle them into a single
> patch.  Ought I be using tags?

You can use tags, but you can just do

	git log

and pick out the commit ID's from there and use those too.

"git-whatchanged -p" is also useful to see what's been going on. And 
"gitk", of course.

> Finally, given that the upstream repository is git, what is the way to
> push commits upstream?

You can do

	git push destination

(which I just added today), which is just the same thing as
"git-send-pack".

BUT NOTE! It only works for destinations that _you_ control, though. You
can't push to others - you can only push to your own repositories, and
then wait for others to pull from them. Ie, the normal reason to use
"git-send-pack" or "git push" is because you do the work on a private
machine, and then you want to push it out to a public one (still yours),
and send an email to people saying "please pull from so-and-so".

		Linus
