From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-applymbox broken?
Date: Mon, 12 Jun 2006 12:10:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606121204220.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606111535310.5498@g5.osdl.org>
 <m1wtbn468o.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0606111735440.5498@g5.osdl.org>
 <m13bea6w13.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 21:10:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpro6-0006dT-6X
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 21:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWFLTKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 15:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbWFLTKe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 15:10:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51843 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752191AbWFLTKd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 15:10:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CJASgt027697
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 12:10:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CJARYu032215;
	Mon, 12 Jun 2006 12:10:27 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m13bea6w13.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21729>



On Mon, 12 Jun 2006, Eric W. Biederman wrote:
> 
> Below is an example of the kind of patch that inspired me to relax the
> rules on parsing in body headers (this comes from Andi Kleen quilt tree).

And this is wrong.

We should _not_ accept crappy patches, and then start guessing at what the 
person meant.

>From the very beginning of git, I tried to make it extremely clear that 
there is never any guessing going on. We don't use "heuristics" except as 
a pure optimization: ie a heuristic can have a _performance_ impact, but 
it must never EVER have semantic impact.

SCM's are not about guessing. They are about saving the _exact_ state that 
the user asked for. No "let's try to be nice", no gray areas.

If the new git-applymbox just takes random lines from the body of the 
email, and decides that they may be authorship information, then that is a 
BUG. The "From: " line in the middle of an email may well be about 
somebody having _discovered_ the bug, and we're quoting him as part of the 
explanation. It does NOT mean that it's about authorship.

So we should ONLY check for "From:" (and perhaps "Subject:" and "Date:") 
at the very top of the email body. NOWHERE ELSE.

The fact that somebody has a crappy quilt tree, and the fact that quilt is 
very much a "anything goes" kind of laissez faire system does not mean, 
and should NEVER mean that git becomes the same kind of mess of "let's do 
a best effort and try to guess what somebody means" kind of thing.

I check and edit my emails before I apply them, and I try to teach the 
people who send them manners and what the rules are. THAT is the way to 
handle this, not by having the tool itself become unreliable and random

		Linus
