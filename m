From: "David Jeske" <jeske@google.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 06:35:16 -0000
Message-ID: <30722.0091614456$1214290702@news.gmane.org>
References: <32541b130806232220r292d691cn5bf5f9976126aa29@mail.gmail.com>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5gtQ7FEDjCWCC>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 08:58:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB2Tk-0005E7-P1
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 08:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbYFXG5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 02:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbYFXG5R
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 02:57:17 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60033 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750936AbYFXG5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 02:57:16 -0400
Received: (qmail 9263 invoked by uid 90); 24 Jun 2008 06:56:54 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Tue, 24 Jun 2008 06:35:16 -0000
In-Reply-To: <32541b130806232220r292d691cn5bf5f9976126aa29@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86000>

Thanks for all the helpful responses...

-- Avery Pennarun wrote:
> git's philosophy is different. Branches are really just "temporary
> tags". A merge operation doesn't just copy data from one branch to
> another: it actually joins the two histories together, so you can then
> trace back through the exact history of the merged branches, commit by
> commit. "git log" will show each checkin to *either* branch
> individually, instead of just one big "merge" checkin.

If branches are "temporary tags" how do I see the actual code they had working
in their branch before they merged it?

I'm reading about rebase, and it sounds like something I would want to forever
disallow on my git repository, because it looks like it rewrites history and
makes it impossible to get to the state of the tree they actually had working
before the merge. However, something you say below both clarifies and confuses
this.

Am I understanding this wrong?

> The end result is that even if you delete the source branch after
> doing a merge, nothing is actually lost.

..and what if you never merge? That branch-pointer points to useful information
about a development attempt, but it was never merged. (imagine a different
development path was taken) They never created a tag because it's not clear
when that work was "done" (unlike a release, which is much more well
understood). What prevents someone from deleting the branch-pointer or moving
it to a different part of the tree, causing that set of changes to be a
dangling ref lost in a sea of refs. Later when someone goes back looking for
it, how would they ever find it in a sea of tens of thousands of checkins?

> Thus, there's no reason for git to try to make branches impossible
> to lose, as they are in svn.

Before I set the GC times to "100 years", there was a HUGE reason for git to
make those branch-pointers impossible to lose, because by default if you lose
them git actually garbage collects them and throws the diffs away after 90
days!

> Another way to think of it is that svn's concept of a "branch" is
> actually the "reflog" in git. (svn records which data a particular
> branch name points to over time, just like git's reflog does.) git
> branches are something else entirely; a git branch always points at
> only a single commit, and has no history of its own.

That's sort of helpful, and sort of confusing. I think of git's branches as
"branch pointers to the head of a linked-list of states of the tree".

As long as you keep those refs without deleting them, and you keep that branch
pointer to the head, you can walk back through the history of that branch. If
multiple developers are working in the branch (and not using rebase, and not
garbage collecting), can't you even go track down the working state of their
local clients while they were working before they merged?

If I'm understanding all that right, it's exactly the kind of functionality I
want -- the ability to reproduce the state of all working history, exactly as
it was when the code was actually working in someone's client a long time ago,
before they merged it to the mainline. Except the standard model seems to be to
let the system "garbage collect" all that history, and toss it away as
unimportant -- and in some cases it seems to even provide developers with ways
to more aggressively assure garbage collection makes it disappear.

Am I expecting too much out of git? It doesn't really feel like a source
control system for an organization that wants to save everything, forever, even
when those people and trees and home directories disappear. It feels like a
distributed patch manager that is much more automatic than sending around
diffs, but isn't overly concerned with providing access to old history. (which,
duh, is no surprise given that's what I expect it's doing for linux kernel)
