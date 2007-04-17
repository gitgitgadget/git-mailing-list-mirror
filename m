From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 12:54:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704171229360.5473@woody.linux-foundation.org>
References: <200704171041.46176.andyparkins@gmail.com>
 <200704171803.58940.andyparkins@gmail.com> <Pine.LNX.4.64.0704171107510.5473@woody.linux-foundation.org>
 <200704172012.31280.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 21:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdtlU-0004h1-03
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 21:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbXDQTy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 15:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbXDQTy4
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 15:54:56 -0400
Received: from smtp.osdl.org ([65.172.181.24]:60430 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161035AbXDQTy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 15:54:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HJso6q015027
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 12:54:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HJsnBB006153;
	Tue, 17 Apr 2007 12:54:49 -0700
In-Reply-To: <200704172012.31280.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.963 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44813>



On Tue, 17 Apr 2007, Andy Parkins wrote:
> 
> Look, my primary objection to this is the SHOUTING about how impossible 
> it is even though I've tried to address every problem you've thrown at 
> me

No, you haven't. You've "addressed" them by stating they don't matter. It 
doesn't "matter" that a diff won't actually apply to a checked-out tree, 
because you fix it up in another tool.

And it doesn't "matter" that switching branches will just result in the 
wrong keyword expansion, because you don't care about the keywords 
actually being "correct" - they are just random strings, and it apparently 
doesn't really have to "work" as far as you're concerned.

And the "git grep" concern you just dismissed by stating that it should 
use the filesystem copy, never mind that this just means that a clean 
working tree gets different results from doing the same thing based on 
that same revision.

In other words, you simply don't seem to worry about TRUSTING the results. 
It's ok if patches don't apply, or if you get different results on working 
trees than "inside" the revision control.

And the reaon I'm shouting is that "it doesn't matter that it's a bit 
hacky" mentality is what gets you things like CVS in the end. Bit-for-bit 
results actually matter. Guarantees actually matter. And you should not be 
able to see a differece in the working tree just because you happened to 
be on a different branch before.

Those are the kind of nasty surprises that make people go: "I don't know 
what the end result is, because there is an element of 'just how did you 
happen to do that operation' to it".

I want to *trust* the SCM I use.

> I'm finding it really difficult to figure out why you're trying so 
> hard to dissuade me from even _trying_.

You can try, but you are *ignoring* the things that I say. The end result 
will either perform really badly, or you cannot trust it, or *both*. And 
you'll introduce interesting semantics like "diffs won't actually apply to 
the working tree with normal tools".

(And yes, git diffs are extended, but they *do* apply to working trees in 
all cases where normal "patch" can even support the notion in the first 
place.)

And it's not just things like diff and switching branches. If you want 
your keywords to generate things like "last modified by Xyzzy", you 
haven't even explained *how* you'd do that. Yeah, you can do

	git log --pretty=oneline --abbrev-commit -1 -- filename

etc, and you probably think it's instantaneous, but do the timings for a 
big repository with a file that hasn't been modified in months, and then 
imagine doing that for an initial checkout (say, after you set the 
"keyword" attribute for all *.c files).

Whoops. The checkout took an hour. Is that really a path you want to go 
down?

> Keywords are so hated by everyone that I doubt they would ever be 
> accepted into git - it's an intellectual exercise for me at this stage 
> really. 

If that's what it is, fine. But people on the list seem to actually *want* 
it. They must be educated what a *disaster* it would be to actually try to 
really support something like it in real life, and not just as a mental 
exercise.

		Linus
