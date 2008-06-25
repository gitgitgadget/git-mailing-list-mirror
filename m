From: "David Jeske" <jeske@willowmail.com>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 23:03:02 -0000
Message-ID: <9505.40933195061$1214435222@news.gmane.org>
References: <7viqvxxix0.fsf@gitster.siamese.dyndns.org>
	<willow-jeske-01l6@3PlFEDjCVAh-01l6[3InFEDjC[dy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:06:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBe4d-0002hq-Pn
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbYFYXFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbYFYXFt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:05:49 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60650 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750923AbYFYXFs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:05:48 -0400
Received: (qmail 5775 invoked by uid 90); 25 Jun 2008 23:05:41 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Wed, 25 Jun 2008 23:03:02 -0000
In-Reply-To: <7viqvxxix0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86365>

-- Junio C Hamano wrote:
> >> : "ncvs up" ->
> >> :
> >> : git stash; git pull; git apply;
>
> First of all, if you are in CVS mindset, you may not want to necessarily
> do "git pull", but "git fetch" followed by "git rebase".

I don't want to replicate CVS behavior, just the workflow. I've considered
rebase, but the diagrams on the documentation page look scarry. I want to keep
the dag-nodes made by their local git commit;. At those commits the code worked
and tested in their tree. rebase looks like it tosses those dag-nodes when it
rewrites the diffs -- who knows if the tests actually pass for every point
along that new rebase. That's no good.

I can see the use of rebase when your job is to "author an understandable
public source tree", but I'm working on SCM, where the goal is to be able to
reproduce the state of past successes reliably.

I want someone to be able to checkout what was actually in the user's local
client as they were working. Which means I think I want "fetch and merge" which
is pull. Did I get that wrong?

> I suspect the last one in the above sequence of yours is "git stash pop".
> Definitely not "git apply" without any argument which is a no-op.

I meant to type "git stash apply", but I think you're right, pop is what I
wanted.

> >> : git diff --stat <baseof:current branch> - un-pushed filenames
>
> "git diff [--options] origin..." (three-dots) is often used. This is a
> shorthand for:
>
> git diff [--options] $(git merge-base origin HEAD) HEAD
>
> that is, "show me what I did since I forked from origin".

I'm still a little foggy on the remote referenecs, but remember I have two
remotes (shared) and (personal). Something in the docs led me to believe
'origin' was repository wide, not private to each branch. Is "origin" a magic
name for the current branch's target?

> >> : git-show-branch <current branch> - un-pushed comments
>
> This would be useful if you are using "fetch + rebase", but in any case
>
> git log --graph --pretty=oneline origin..

Ahh, yes, Thanks!. How does this interact with the "pull" I just did?

What I want is "show me the commit messages (and sha1 keys) for changes in my
local branch that are not yet submitted to it's remote tracking location"

Will that command above include the commit lines that came down in my pull
(fetch/merge)? If so, how do I not include them?

> > Question: How do I create a branch on a remote repo when I'm on
> > my local machine, without sshing to it?
>
> I hope that the question is not "How do I do anything on a remote without
> having any network connection to it" as its answer cannot be anything but
> "telepathy".

Funny. I'm asking how I can run a command locally, that during the next "git
push HEAD" will cause a branch to be created on a remote repository, without
assuming that is the same repository that my current branch is pointing to.
Will this do the trick?

git branch --track mynewbranch git://myserver/path/foo.git
# hack hack
git commit
git push HEAD

- David
