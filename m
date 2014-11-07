From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add a few more values for receive.denyCurrentBranch
Date: Fri, 07 Nov 2014 10:49:47 -0800
Message-ID: <xmqqvbmqg81g.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<f82aedcb632571d0b756d62c58479c0aab35b026.1415368490.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 07 19:52:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmoe0-00079e-3p
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 19:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbaKGSwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 13:52:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752709AbaKGSwB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 13:52:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1E7C1BFC8;
	Fri,  7 Nov 2014 13:51:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k57f17cFpPVBm2BOAB2Fse7CVdQ=; b=tAaKss
	VtYfp1yIciStvlR0kkOO4KnNc3LOTvsdCUCoRbXG/F+hLBbCtu8TlbYswundQ7j6
	fpc0EE4IBzCJIxZ3z42V2Z9fs+0UAZ+Xl1q4JSWSVoq8dvW/y2tpXSqO5wZl7IVL
	LIYztsulvXsYz7OT5l/FkuaMAxwm8FEVuFwYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QS3IJcBlB/wuCrmW7AzuJmbcX5jgbq0z
	K8iu7BSg/EemLminSzq0JGIJdb6TBloy/je+UC48PcShunSCokbF8jLaSa/GKGug
	XpcjuXViiAB6Vhe4xYrHK2UsWDAUusqRnm0Eg8YjZiyHNODVjRoxD/jTZC5HaPbf
	oghjiZUPL1o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97FC11BFC7;
	Fri,  7 Nov 2014 13:51:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25AD51BF14;
	Fri,  7 Nov 2014 13:49:49 -0500 (EST)
In-Reply-To: <f82aedcb632571d0b756d62c58479c0aab35b026.1415368490.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 7 Nov 2014 14:58:17 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9C1C2CE-66AE-11E4-8396-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Under certain circumstances, it makes a *lot* of sense to allow pushing
> into the current branch. For example, when two machines with different
> Operating Systems are required for testing, it makes much more sense to
> synchronize between working directories than having to go via a third
> server.

Even if you do not have a third server, each time you decide to do
such a push, you have a single source of truth, i.e. the repository
you are pushing from, so instead of doing that push, all the others
could instead pull from that single source of truth.  In that sense,
even though I wouldn't say it is wrong to use "push" in the opposite
direction for this synchronization, I have to say that the above is
not a very strong argument.  It certainly does not deserve "*lot*"
in bold font ;-)

> Under different circumstances, the working directory needs to be left
> untouched, for example when a bunch of VMs need to be shut down to save
> RAM and one needs to push everything out into the host's non-bare
> repositories quickly.

For this use case, if you assume that the tips of branches in the
repositories on "a bunch of VMs" could be pointing at different
commits (i.e. each of them has acquired more work without
coordination), you are risking lossage by pushing into refs/heads/,
not refs/remotes/vm$n/, aren't you?  When you want to save things
away "quickly", you do not want to be worried about a push from VM1
stomping on what was stored from VM0, and using separate remotes,
i.e. refs/remotes/vm$n/, has been the recommended way to do so.  So
this is not a very strong argument, either.

Doing things only within refs/heads/ without using any refs/remotes/
however is a handy option, especially for those who know what they
are doing, and I do not have problem with an effort to help
improving such a workflow.  It just feels unnecessary, and inviting
mistakes, to try to mix that with checked out branches.

For example, if these VMs are mostly for building and making fix-up
commits, I would imagine another possible flow might be:

 * Each repository on these bochs would have refs/heads/* but not
   refs/remotes/* and is on detached HEAD.

 * Pushing into these repositories will trigger a hook that performs
   a checkout of the commit at the tip of the updated branch to the
   detached HEAD, and use of "git checkout" in that hook will
   prevent lossage of local changes automatically.

 * After making fix-up commits on one VMs repository, you would
   first locally push HEAD:$branch to update the refs/heads/$branch
   and propagate that to others by pushing $branch.

Now, with "updateInstead", you can keep the target branch checked
out, instead of detaching HEAD at the tip of it and having a hook to
run "git checkout", and automatically update the working tree.  The
workflow would become:

 * Each repository on these bochs would have refs/heads/* but not
   refs/remotes/*.  Each have a branch checked out and some or all
   may be on the same branch.

 * Pushing into these repositories will trigger updateInstead to
   update the working tree in a safe way.

 * After making fix-up commits on one VMs repository, propagate that
   change to other VMs by pushing the branch out.

which is a definite improvement.

Explained in that way, I would say "updateInstead" is a welcome
addition.  The documentation would probably need to explain an
expected use (something like what I gave above), so that this can be
useful not only by those who know what they are doing, though.

I do not think of a good justification of detachInstead offhand, but
you must have thought things through a lot more than I did, so you
can come up with a work flow description that is more usable by mere
mortals to justify that mode.  Without such a description to justify
why detachInstead makes sense, for example, I cannot even answer
this simple question:

    Would it make sense to have a third mode, "check out if the
    working tree is clean, detach otherwise"?

> This change supports both workflows by offering two new values for the
> denyCurrentBranch setting:
>
> 'updateInstead':
> 	Update the working tree accordingly, but refuse to do so if there
> 	are any uncommitted changes.
>
> 'detachInstead':
> 	Detach the HEAD, thereby keeping currently checked-out revision,
> 	index and working directory unchanged.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/config.txt |  5 +++++
>  builtin/receive-pack.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++++--
>  t/t5516-fetch-push.sh    | 36 ++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e8dd76d..6fc0d6d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2129,6 +2129,11 @@ receive.denyCurrentBranch::
>  	print a warning of such a push to stderr, but allow the push to
>  	proceed. If set to false or "ignore", allow such pushes with no
>  	message. Defaults to "refuse".
> ++
> +There are two more options: "updateInstead" which will update the working
> +directory (must be clean) if pushing into the current branch, and
> +"detachInstead" which will leave the working directory untouched, detaching
> +the HEAD so it does not need to change.
>  
>  receive.denyNonFastForwards::
>  	If set to true, git-receive-pack will deny a ref update which is
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 32fc540..be4172f 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -26,7 +26,9 @@ enum deny_action {
>  	DENY_UNCONFIGURED,
>  	DENY_IGNORE,
>  	DENY_WARN,
> -	DENY_REFUSE
> +	DENY_REFUSE,
> +	DENY_UPDATE_INSTEAD,
> +	DENY_DETACH_INSTEAD,

Don't add trailing comma after the last element of enum.

> @@ -730,6 +737,44 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
>  	return 0;
>  }
>  
> +static void merge_worktree(unsigned char *sha1)
> +{
> +	const char *update_refresh[] = {
> +		"update-index", "--refresh", NULL
> +	};
> +	const char *read_tree[] = {
> +		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
> +	};
> +	struct child_process child;
> +	struct strbuf git_env = STRBUF_INIT;
> +	const char *env[2];
> +
> +	if (is_bare_repository())
> +		die ("denyCurrentBranch = updateInstead needs a worktree");

Why have extra SP only after "die" but not other function names?

> +	strbuf_addf(&git_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
> +	env[0] = git_env.buf;
> +	env[1] = NULL;

Doesn't child.env have managed argv_array these days?

> +	memset(&child, 0, sizeof(child));
> +	child.argv = update_refresh;
> +	child.env = env;
> +	child.dir = git_work_tree_cfg ? git_work_tree_cfg : "..";
> +	child.stdout_to_stderr = 1;
> +	child.git_cmd = 1;
> +	if (run_command(&child))
> +		die ("Could not refresh the index");
> +
> +	child.argv = read_tree;
> +	child.no_stdin = 1;
> +	child.no_stdout = 1;
> +	child.stdout_to_stderr = 0;
> +	if (run_command(&child))
> +		die ("Could not merge working tree with new HEAD.  Good luck.");

Drop "Good luck." and replace it with a more useful info.  At least,
tell the user what state you left her repository in by this botched
attempt, so that she can manually recover.

I am guessing that you have already updated HEAD, you are not
telling her what commit the index and the working tree is originally
based on (which would be very useful to know for manual recovery
from this state), but you haven't touched either the index or the
working tree at this point in the code.

Other than that, I like what this "updateInstead" code path does.

Thanks.
