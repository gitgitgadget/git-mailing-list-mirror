From: Junio C Hamano <gitster@pobox.com>
Subject: Random thoughts on "upstream"
Date: Thu, 16 May 2013 10:55:52 -0700
Message-ID: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 19:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud2PI-0003Qo-CI
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 19:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab3EPRz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 13:55:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab3EPRzz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 13:55:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C077D1F280;
	Thu, 16 May 2013 17:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=K
	gwTYS6F/UOPrz80fJso8rxDC68=; b=CxgeQGV0DooU+uNG61axNjBqBZE3T3g5/
	aYMDSYPLPS+GhayTUxC8vpul0butrg1ypkejybHwXwWIHRzhe/Xr1wTPXH1zneWb
	tCeQbdAMvTJIau9H+F2Un48VsNRhaOhudTqDiEZ1jUTUrno7IBBqNLFDKd29Z3+w
	JAfwuPn1Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Kacue8JtjoLoZQ77WG/YW7K7g5O3j1g3BgZOEsJHs4HHNaMZc2iuwzin
	fIKOHmZAPGo7qnoBt1k1MA638cn/bwVu+lLS3Dy3tOp9tCopMtTHSgzBDeiWvmxU
	HJorcqpMwrIg//OeOBUzWN875BFg3MDYiAfzG2XFMVuearnPKuQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3FE11F27F;
	Thu, 16 May 2013 17:55:54 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E03B61F27B;
	Thu, 16 May 2013 17:55:53 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA56A24C-BE51-11E2-8D45-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224604>

I do agree that separating

 - where to push to, and
 - where to fetch for integrating with

is a necessary step for supporting triangular workflow better.

The "upstream" is that on top of which you build your work.  You
clone from there to bootstrap yourself, you add your work (which may
include integrating the work of your contributors, if you are a
mid-tier maintainer/integrator aka a lieutenant) on top of it, and
arrange the result to reach the "upstream" in some way.

For the simplest (and still widely used) workflow that employs a
central shared repository, the way to make the result to reach the
"upstream" is by directly pushing into it yourself.  In that sense,
the word "upstream" and the traditional behaviour of "git push" that
pushes back to the 'origin' (or branch.$name.remote) to update your
"upstream" (or branch.$name.merge at 'origin') both make perfect
sense.

Also, if you are rebasing, @{u} refers to that place you integrate
with, i.e. your "upstream", in the central shared repository
workflow.

But in a triangular workflow, the way to make the result reach the
"upstream" is *not* by pushing there yourself.  For developers at
the leaf level, it is to push to their own repository (often on
GitHub), which is different from where they (initially) clone from
in order to bootstrap themselves, and (subsequently) pull from in
order to keep them up-to-date.  And then they request the published
work to be pulled by the "upstream".

Note that even in a triangular workflow, @{u} should still refer to
the place you integrate with, i.e. your "upstream", not to the place
you push to publish the result of your work.

There is an interesting twist.  For a maintainer/integrator (either
a mid-tier one who has "upstream" somebody else controls, or the
top-level one whose conceptual "upstream" is himself), "git pull"
does not necessarily always go to the "upstream".  You also respond
to pull requests made to you, by those who consider you as their
"upstream".  As the antonym of "upstream", "downstream" would be a
good word to refer to them (and that is why calling the place you
push to "downstream" is not a good idea).  The integrator responds
to such a pull request by running "git pull" against his
"downstream".

Because an integrator will pull from more than one "downstream" by
definition (otherwise he is merely a relay or a gatekeeper), a pull
request typically carries the full URL and the branch name to be
pulled from, and there is not much need for an integrator to have a
short-hand mechanism to allow "git pull" (without other arguments on
the command line) to go to a "downstream".

But for an integrator, the place they consider their "upstream" is
not the place they push to publish.  A mid-tier integrator aka
lieutenant has exactly the same issue as leaf developers do on the
"push" side.

In a triangular workflow, "git push" that goes to 'origin' does not
make sense, and remote.pushdefault (and branch.$name.pushremote)
solves a half of the problem by allowing them to name the repository
they publish their work as the destination of a push.

The other half of the issue is that there is no good way to say "The
result of my work on this branch should go to that branch in the
repository I publish to; they are not named the same".

The value "upstream" for push.default does not make sense in the
context of a triangular workflow, as you may well base your work on
'master' from the upstream, which is a branch with a very generic
purpose (e.g. "to advance the state of the overall project"), but
your work may have a more specific purpose (e.g. "to improve frotz
feature") that deserves to be on a branch named after that specific
purpose in the repository you publish your work on.  That is, after
working on your 'frotz' branch this way:

    git checkout -t -b frotz origin/master
    work work work, commit commit commit

you do not want to push the result as 'master'; you want to call it
'frotz' in the published repository.

The value "current" for push.default dictates that the work you did
on your branch 'frotz' must be published as the same name 'frotz',
which may be good enough.

For those who do not find it good enough, a possible improvement is
to introduce another mechanism that tweaks the remote.publish.push
refspec.  I am thinking aloud here, but imagine that you are working
on your 'frotz' branch with this configuration:

    [remote "origin"]
    	url = ... this is where your upstream is ...
        fetch = +refs/heads/*:refs/remotes/origin/*
    [remote "publish"]
        url = ... this is where you push to ...
        ;; push = +refs/heads/*:refs/heads/topics/*
    [remote]
        pushdefault = publish
    [push]
        default = single

    ; the remainder is per-branch
    [branch "frotz"]
        remote = origin
        merge = refs/heads/master

and you eventually want to push the result to topics/frotz branch
there.

In a triangular workflow, when you need to depend on some feature
that is only available in the updated upstream, you would rebase
your work on your upstream, e.g.

    git pull --rebase

which would go to branch.frotz.remote (= origin) and rebase your
work on top of their master.  Before such a rebase, you could

    git fetch
    git log ..@{u}

to see what new stuff you could exploit if you did rebase now.

Up to this point, there was no need to change anything; the current
Git does the above perfectly fine.  But then you try to push:

    git push

Thanks to the recent introduction of remote.pushdefault, this push
will no longer go to 'origin' but goes to 'publish'.  But not
necessarily to the desired branch.

With 'upstream', it may try to go to 'master' (as branch.frotz.merge
is set there), and with 'current', it may go to 'frotz'.

Uncommenting

    [remote "publish"]
        push = +refs/heads/*:refs/heads/topics/*

will let "git push publish" (or "git push") push 'frotz' to update
'topics/frotz' branch over there, which is what we want in this
example, but it will also push other branches at the same time,
which is not what we want.

Now I have a curious value "single" in the above configuration that
is not understood by current Git.  It is to trigger a new rule to
modify the way remote.publish.push refspec is used:

    When on branch 'frotz', where pushremote_get() would return
    'publish', find where refs/heads/frotz would be pushed with the
    refspec for that remote (i.e. refs/heads/*:refs/heads/topics/*
    maps refs/heads/frotz to refs/heads/topics/frotz) and push only
    that, i.e. update refs/heads/topics/frotz over there with the
    tip of 'frotz' we are pushing.

That may be a solution for those who do not find 'current' good
enough.
