From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git/hg discussion from the memcached mailing list
Date: Sun, 10 Feb 2008 14:05:48 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802101332060.2896@woody.linux-foundation.org>
References: <D6147D3B-2E67-4D33-8EEC-BFCD641A6D52@spy.net> <196C7ED3-67BC-4BF9-8E5B-4E2187D8A93B@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Users List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>,
	Dustin Sallings <dustin@spy.net>, dormando <dormando@rydia.net>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:08:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOKM0-00050t-Lz
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 23:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbYBJWIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 17:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYBJWIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 17:08:16 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36556 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751002AbYBJWIP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 17:08:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1AM5nb9013677
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Feb 2008 14:05:51 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1AM5mU0016265;
	Sun, 10 Feb 2008 14:05:48 -0800
In-Reply-To: <196C7ED3-67BC-4BF9-8E5B-4E2187D8A93B@midwinter.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.725 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73422>



On Sat, 9 Feb 2008, Steven Grimm wrote:
> > 
> > > export:
> > > 
> > > Appears to be git log --pretty=[format] [-p] ?
> > 
> > 	I think it's probably ``git log --pretty=raw -n 1 -p [id]''

No, for a single commit, that would be "git show".

The format, of course, can then be anything, the default is the readable 
and often most useful one, but depending on circumstances people might use 
anything from "--pretty=email" to "--pretty=raw".

> > 	Well here's a summary of the differences in commands so far.  Let's
> > assume I've done a clone of the hypothetical git repo and hg repo.  The
> > following commands would be equivalent based on what I found up here:
> > 
> > Look for incoming changes:
> > 
> > 	hg in
> > 	git fetch && git log [copy and paste in the stuff from the old..new line]

That would be

	git fetch && git log ..origin

No copy-paste required.

And the git approach may look "bigger", but it's actually a hell of a lot 
more flexible, because it now means that in addition to (or in place of) 
that "git log ..origin", you can now use the graphical viewers (ie doing 
"gitk ..origin" or anything else), along with all the cherry-picking 
or rebasing action you want.

If you really want a "git in", you can trivially do so with a simple 
alias.

> > Look for outgoing changes:
> > 
> > 	hg out
> > 	git fetch && git log origin..

Same commentary, except more forceful. You can do a single "git fetch", 
and now you can use

	gitk origin..
	gitk ..origin

depending on whether you want to see the new thing *they* have, or the new 
thing *you* have, or both. In fact, you can do the "symmetric difference" 
(with three dots)

	gitk ...origin

to see both visually at the same time (and since that's a symmetric 
difference, it doesn't matter whether it's '...origin' or 'origin...')

And again, more interestingly, all of this works *exactly*the*same* even 
if you track multiple branches from multiple different remotes, and 
everything works really naturally, ie you can say

	gitk one-developer...other-developer

to see what the difference (symmetric) between two different upstream 
things are.

The "hg in/out" thing is just a very weak special case, and a trivial 
alias if you really feel it is such a _common_ weak special case.

> > Export a single changeset to be moved elsewhere:
> > 
> > 	hg export [change]
> > 	git log --pretty=raw -n 1 -p [change]

"git show" again, but more commonly it would be "git cherry-pick" between 
branches if what you actually want to  move one patch from one place to 
another (which will do things like the proper three-way merging etc, it's 
not just a "move patch around").

> > Import an exported changeset:
> > 
> > 	hg import /some/file
> > 	git ??? /some/file

Git is designed for not just doing a single one, so the normal one would 
be

	"git am [mbox]"

to apply a series of patches from one mailbox. You'd create one of those 
things with "git format-patch" (which can either generate lots of 
individual files, or one mbox to stdout).

> > Send changes as individual email patches:
> > 
> > 	# note: hg requires patchbomb to be enabled in your .hgrc for this
> > 
> > 	hg email -o
> > 	git format-patch origin.. && ??email script?? [0-9]*.patch

The email script would be "git send-email", although I personally would 
suggest not telling people to mailbomb things as a pipeline like that.

What I do personally is that "git format-patch -o dir -n origin.." is a 
separate phase, which allows you to check things out, and perhaps add 
commentary after the "---" line (things that show up in the email, but not 
in the commit message after it's applied), and then do the sending as a 
totally separate phase when you've verified that what you're doing to send 
is ok.

(In fact, I end up actually emailing things individually, so I don't even 
use "git send-email" at all, but that's just because I live in my mail 
reader anyway).

> > Send changes as a single portable patch series:
> > 
> > 	hg out -p
> > 	git fetch origin && git log -p origin..

This is another example of git just handling branches in a more general 
manner. See above.  You can view the differences any which  way you like, 
whether with "git log" or with "git log -p" or with graphical viewers or 
whatever.

> > Share changes via plain http:
> > 
> > 	[hg]#  rsync -va tree/ server:public_html/tree/
> > 	[git]# rsync -va tree/ server:public_html/tree/ && ssh server
> > "??setup-tree??"

Ouch. Hell no. That's crazy talk. And I assume it's crazy talk even for 
hg. You'd use "git push" to export changes.

			Linus
