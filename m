From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect is magical
Date: Tue, 10 Jan 2006 13:17:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601101308540.4939@g5.osdl.org>
References: <dpuoqf$3rp$1@sea.gmane.org> <Pine.LNX.4.64.0601091516460.5588@g5.osdl.org>
 <dq11c6$g15$1@sea.gmane.org> <Pine.LNX.4.64.0601101131540.4939@g5.osdl.org>
 <Pine.LNX.4.64.0601101143180.4939@g5.osdl.org> <dq168p$3kt$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 22:17:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwQs8-0004ed-5f
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 22:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWAJVRh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 16:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWAJVRg
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 16:17:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41905 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932321AbWAJVRg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 16:17:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0ALHVDZ001570
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 13:17:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0ALHT3r015482;
	Tue, 10 Jan 2006 13:17:30 -0800
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dq168p$3kt$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14457>



On Tue, 10 Jan 2006, walt wrote:
> 
> Just by stumbling around and trying things at random, I did a
> 'git-checkout origin' which *seemed* to resolve the merge-conflict,
> but left me feeling uneasy because I don't really understand what
> I'm doing.  Can you give a short explanation of the difference
> between 'git reset --hard origin' and 'git-checkout origin'?

"git checkout" actually checks out a different branch (unless, to confuse 
things, you ask it to just check out a specific _file_, in which case it 
stays on the same branch).

So when you say "git checkout origin", it actually _switches_ to the 
origin branch (which is just my state) and checks that out.

When you then do a "git pull", you'll just be pulling my newer state into 
that older content branch, and it will resolve beautifully as a 
fast-forward with no merge at all.

The downside with being in the "origin" branch is that if you now do any 
kind of real development, you've now made "origin" mean something else 
than it traditionally means - now it's no longer a branch tracking the 
origin of your code, now it's an active development branch.

Do "git checkout master" to go back to where you used to be.

In contrast, a "git reset --hard origin" would have reset your _current_ 
branch to the state that the "origin" branch was in (and forced a checkout 
of that exact state too - that's what the "--hard" flag means).

So when you say "git checkout origin", you should read it as "check out 
the origin branch", and thus it makes perfect sense that "origin" now 
becomes your current branch. In contrast, when you say "git reset --hard 
origin", you should mentally read that as "reset the state of my current 
tree to the same state as the origin branch".

The naming does make sense, but you just have to get used to what 
"checkout" means (in its two different guises - checking out a file being 
different from checking out a full tree) and what "reset" means.

> > An even better option is obviously to figure out _why_ that commit broke 
> > for you in the first place, and get it fixed up-stream...
> 
> I'm still waiting for the insulting email from the developer ;o)  How
> long should I wait for a response before I start bugging other people?

Hey, send out the report to linux-kernel, and if it is a serious problem, 
just cc me and Andrew (and whoever else seems to be most relevant for the 
area: networking goes to David Miller, drivers mostly to Greg or Jeff etc 
etc). Regardless, you should always cc at least the people who signed off 
on the commit, since they want to know that they signed off on something 
that turned out to be buggy.

		Linus
