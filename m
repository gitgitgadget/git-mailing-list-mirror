From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Sun, 14 Apr 2013 22:47:35 -0700
Message-ID: <7v8v4k2vm0.fsf@alter.siamese.dyndns.org>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 07:47:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URcGX-0004Ri-UE
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 07:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab3DOFrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 01:47:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab3DOFrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 01:47:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01E7311BEA;
	Mon, 15 Apr 2013 05:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K/DJysBMI9YQ0osOynqKcKPjTD0=; b=cABIuF
	c/BC5dtjQBoyk/OTL5dgvMPRb3gwdYt5h7Z6HTDcPWtuLg6mnrkYOl0jdEioFD70
	r9XGE4Msd9x0LcIiimVixaQGcQ1co6+ZKiZM3IaXOmP41eOt+3TVq9Ar07eqSgT1
	iJ5ZLmq62L232+xfJvFfH4FYporYxmJQMXdvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mPQpd/Uo26r2uVIVVq9B/GwjtMlsxWmF
	ApZP9N6pF+bqfeambldzILAgZ/dSJiRO6BnZ3E2FOWwAUKhDPourh+Zd0FayMvV+
	kD+8CVlKTezyLBpc7hqBmtb0REWdtCFLD5Qz5d3MpGna36lnKtNQBOMcUlXGGzxm
	/hXOk2pAL8c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E93E511BE9;
	Mon, 15 Apr 2013 05:47:37 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B97211BE8; Mon, 15 Apr
 2013 05:47:37 +0000 (UTC)
In-Reply-To: <1365887729-9630-4-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Sun, 14 Apr 2013 02:45:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA3E9C02-A58F-11E2-A5A9-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221193>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, executing a 'git pull' on a dirty worktree gives the
> following annoying message:

s/annoying//;

In general, avoid forcing your value judgement to readers when you
do not have to.  Instead, you can just highlight the source of your
annoyance and let them naturally feel the annoyance themselves,
perhaps like this:

	When the user runs "git pull" with local changes in the
	working tree that interfere with the merge (or any change if
	the user is using --rebase), the user is told that the merge
	or rebase cannot be done _after_ the command spends time to
	download necessary objects.

	The user can then decide not to perform the pull and finish
	what he was in the middle of doing (e.g. by "git checkout -b
	topic" and then finishing the work), before coming back to
	the branch and running "git pull" again, or "git stash" the
	work in progress, run "git pull" and then "git stash pop".

	Introduce a new flag "git pull --autostash" to perform the
	latter automatically. Also add pull.autostash configuration
	to do so without giving the command line flag, whose effect
	can be overriden by the --no-autostash option.

While I understand where this wish comes from, I am not sure if this
is generally a good idea, or if we are solving a wrong problem.

>     Saved working directory and index state WIP on master: 8ea73ed baz
>     HEAD is now at 8ea73ed baz
>
>     ... # The merge/rebase process

I think there is one step missing after "The merge/rebase process"
above, which is

      ... # The 'stash pop' process

>     Dropped refs/stash@{0} (83f47fbfb07a741817633f9191dc4a1530f79249)

If the pull-merge were something that would induce the "annoyance"
that triggered this topic, by definition, the local change overlaps
with the merge, and this internal "stash pop" will touch the paths
the merge touched and it is likely not result in "Dropped" but leave
further conflicts to be resolved.

In the end, simple cases (the canonical example being Linus keeping
a local change to "Name = Unicycling Gorilla" in his Makefile while
running dozens of "git pull" every day) would not be helped with
this feature very much because there is rarely overlap, while in a
complex case the user really needs help to save away his WIP, the
user is forced to resolve the conflict immediately upon the failed
"stash pop" at the end of "git pull".  If the conflict turns out to
be something the user would not want to resolve at that moment, the
user needs to know the way out, something like:

	git reset --hard		;# go back to the result of pull
        git checkout -b wip ORIG_HEAD	;# start from before the pull
        git stash pop			;# recover his wip
	... perhaps work a bit more ...
        git commit -a -m wip		;# save it away for safety
	git checkout -			;# result of pull

so that he can come back tomorrow, check out "wip" branch, and
decide what to do.


The "--autosquash" option (or not adding either the configuration or
the option) would encourage the user to think about the nature of
WIP he has in the working tree before running "git pull".  Is it a
too complex beast that may interfere with what others are doing, or
is it a trivial change that he can stash away and pop it back?  If
the former, he will be far better off doing "checkout -b", keep
working until the local change gets into somewhat a better shape and
"commit", before pulling into the original branch.  If the latter,
he is better off doing either

 - "git pull", after finding it conflicts, run "git stash", "git
   merge FETCH_HEAD" and "git stash pop"; or

 - "git pull --autostash".

And not having "--autostash" would mean he would do the former, and
will do "stash" only when it matters.  "--autostash" is a good to
neutral addition in that sense.  But I suspect that pull.autostash
configuration is not a good addition because it encourages a bad,
pain-inducing workflow.  In simple cases it may not hurt, but when
local changes are complex, it would actively hurt than not having it,
and the configuration robs the incentive to choose.

The equation is somewhat different for "pull-rebase", as "rebase"
insists you to start from a clean working tree, so "download and
then stop" annoyance feels bigger.  I have a suspicion that
loosening that may be a more productive fix to the real problem.

> +stash_required () {
> +	! (git diff-files --quiet --ignore-submodules &&
> +	git diff-index --quiet --cached HEAD --ignore-submodules)
> +}

require_clean_work_tree refreshes the index before running
diff-files to make this check safe, but you do not do that here.  Do
you know the index has been refreshed when this is called?

Even though this is mere two-line logic, the duplication of the
logic look a bit wasteful.  Is it too hard to teach "dry-run, quiet"
mode to require_clean_work_tree helper?  Then the auto-stash
codepath can simply be:

	(require_clean_work_tree --quiet) || git stash

no?

> +if test "$autostash" = true && stash_required
> +then
> +	git stash || die "$(gettext "Cannot autostash")" &&
> +	require_clean_work_tree "pull" "Please commit or stash them." &&
> +	if eval "$eval"
> +	then
> +		git stash pop || die "$(gettext "Cannot pop stash")"

This "cannot pop stash" is really where the user gets in the deep
yoghurt and needs help.

> +	else
> +		exit_code=$?
> +		echo "Please run 'git stash pop' after commiting the conflict resolution."

Given that many people do not read messages carefully, it would be a
better idea to list them in the order the user carries them out,
perhaps

	Please resolve conflicts and commit, and then 'git stash pop'.

or something.
