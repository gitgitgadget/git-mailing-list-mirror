From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Enhancement Idea.
Date: Wed, 23 Sep 2009 13:08:16 -0700
Message-ID: <7vab0lh1an.fsf@alter.siamese.dyndns.org>
References: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Deon George <deon.george@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqY92-0007bP-F5
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 22:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbZIWUIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 16:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbZIWUIW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 16:08:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbZIWUIV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 16:08:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A492B5CD79;
	Wed, 23 Sep 2009 16:08:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q++g6mCdiJWHpaUgTkSBwNqbp8A=; b=eU7ChM
	xeQKJKS9QrMVPoAsz8HlXMrC/DCGxYAgfslDdila2nFwy6lK8UUX8kq/L4O8ui3K
	lZcqh26g4sCCxl/82BXuA5D5aqDkB3AfVtpWsA3nVsraO+l0/gHavpvuR+AjczlF
	SOYgMMHZ+ZqJUCu/AkEzsapAzCe18eqo61/pI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=js/820mRy8GriBKkwYam+KQ/TOlgJli8
	xOdv9he9JbRutluamgjGhWnpRJ3ywCoC6a/UMXKmDaLUL3PwicuMwTfAowEkm3W5
	vS/i4OEHUjAGRDKSxh2oI1lGHE0eWqvsu8RtRzgB5Zced+yaE4lvaq2E7vol2dWM
	CavSYewY9S0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 86E565CD78;
	Wed, 23 Sep 2009 16:08:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC0AF5CD77; Wed, 23 Sep 2009
 16:08:17 -0400 (EDT)
In-Reply-To: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>
 (Deon George's message of "Wed\, 23 Sep 2009 16\:17\:58 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7A569E6-A87C-11DE-887D-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128993>

Deon George <deon.george@gmail.com> writes:

> Like I mentioned, I can achieve some of this by the use of branches
> already, however, where it comes complicated, is when:
> * I commit a change to the wrong branch (and thus upstream will never
> see my enhancements),
> * I want to identify changes to one layer (that I went to send to
> upstream for review), without including the other layers (because it
> probably isnt relevant)
> * I want to work on more than one layer (I need to be diligent about
> pulling and merging)

I think you are getting ahead of yourself by coming up with "layers" as a
solution, without really spelling out and then thinking through what
problem you are trying to solve.

I think the primary scenario your itch comes from is (I am writing this
down to make sure I understand where you are trying to go):

 - you would want to build your changes on top of somebody else's code;

 - while doing so it is often more convenient if you do not have to think
   about which pieces of changes should go to upstream, and which other
   pieces of changes should stay local;

 - git allows you to do this with topic branch workflow, with selective
   adding with "add -p", stashing and branch switching.

 - You can however misidentify which bits should go to upstream and commit
   to a wrong branch.  You want to reduce the chance of this mistake.

Am I following you Ok so far?

Now, how does "layers" (I understand by this word you mean the concept of
"layering a worktree from one branch on top of layering a worktree from
another") solve that problem?  If you come up with a nice way to identify,
and have the tool help you identify, "these bits belong to that layer",
wouldn't that approach also apply to existing topic branch workflow by
having the same logic of that magic tool to help you say "these bits
should go to that topic branch"?

When the granularity of the change is per-file (your "autonomous" case),
"git checkout" to switch back to your topic would already solve half of
that issue.

Suppose you have mainline (origin/master) and your customization topic
(custom), and file F is something that does not and will never exist in
the mainline.  You use your master branch as your integration testing
branch.  With traditional topic branch workflow, you would

    $ git checkout custom
    ... work on F and other files, test the changes to your satisfaction
    $ git commit -m 'I am satisfied on my custom work'
    $ git checkout master
    $ git rebase origin/master ;# keep up with the upstream
    $ git cherry-pick ... ;# some commits in custom that should go to upstream
    $ git merge custom ;# test merge to be thrown away!

    ... now you are on the integrated result in 'master'.
    ... test, notice breakages in F, and edit it to improve it
    ... the changes to F belongs to 'custom', not for upstream!
    $ git checkout custom ;# this will take the changes to F with you
    $ git commit -m 'I should have done this to F instead' F

    ... go back to do more work
    $ git checkout master
    ... loop forever ;-)

and after you are satisfied, you would reset the merge from custom away
and offer the master that is combination of what was in the origin/master
plus the "upstream worthy" bits you cherry-picked ones from your custom
branch.

When the granularity is sub-file, "checkout -m custom" or "stash, checkout
custom, then unstash" would help carrying the changes across branches.
You would need to identify which changes you would want to commit to
"custom" and which changes you would want to give to upstream by making a
commit on "master" when you go back there again.  The middle part of the
above workflow will be slightly modified for a file G that is shared
between origin/master and custom branches, perhaps something like:

    ... now you are on the integrated result in 'master'.
    ... test, notice breakages in G, and edit it to improve it
    ... the changes to G belongs to 'custom', not for upstream!
    $ git checkout -m custom ;# this will take the changes to G with you
    $ git add -p G ;# pick changes that only belong to custom
    $ git commit -m 'I should have done this to G instead'

If the "layers" logic somehow can help you automate the process of sifting
your changes into these two categories (perhaps it may scan the file and
knows which function belongs to "custom" alone, I dunno and care about the
details at this level of discussion), wouldn't that same logic help you
the same way?

Past attempts that made into the toolchest are "add -p" (and "stash -p"
that uses the same mechanism) which is interactive and not automated.
Maybe you can build some logic to automate it further (e.g. "changes to
this function should automatically be excluded from "git add" while on
'master', but should automatically be included in "git add" while on
'custom'), and it may turn out be a good addition to the toolchest.

It also may make a good addition to the toolchest to have a tool to
further simplify the branch switching explicitly initiated by the end user
in the above illustrations.  In some cases, such as the "autonomous" case
above, you do not _have_ to go back to custom branch from the work-flow
point of view (you would be committing a totally untested work to custom
branch, but as long as you will revisit and retest the changes in its
context, it is not a major crime at all).  It would be useful if you can
say, while still on 'master' branch, "I just made this fix to file F that
belongs to 'custom'; commit that change alone to 'custom' branch".
Written as a shell script, roughly, it would look something like:

    #!/bin/sh
    target_branch="$1"
    base=$(git rev-parse --verify "$target_branch") || exit
    shift ;# all others are paths
    GIT_INDEX_FILE=.git/temp
    export GIT_INDEX_FILE
    git read-tree -m "$1"
    git add "$@"
    c=$(echo "side commit" | git commit-tree $(git write-tree) -p "$base")
    git update-ref "refs/heads/$target_branch" "$c"

But I do not see how the concept of "layering a worktree from one branch
on top of layering a worktree from another", which is the implication I
get from the word "git layers", helps any of that.  It seems an orthogonal
concept that we can do without to solve the problem you are describing.
