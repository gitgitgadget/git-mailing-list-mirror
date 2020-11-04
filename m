Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0E8C4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 19:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8565920709
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 19:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ahONlsob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgKDTb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:31:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56181 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbgKDTbP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 14:31:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 021D586777;
        Wed,  4 Nov 2020 14:31:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pkd5bo5IuSDijkVP72dtInW/Ljk=; b=ahONls
        obd/STd172zEH3jVZko9Sy+8BiZdnJd7msatLdco/pqiJWhD3mVVKWICuc1kjmMK
        Ec+S8YqAER2IDYtTu9U3YWB3mRu8ry6tb2Q8jPVRyFGpXzwG6qd9RiAJcIaR9cdM
        ygDHFYh5Z3R29EHwAYUbvK95RhcRrZDMvgUbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P5I4t1a8md8OttmjqExDW26X/PuuUwWj
        vEJ6P0BqbeaOvbpg9BqtpEk9GFZ4tNWXODQNtBNLS/rcGP/PwStLa1AXdXL5I5e5
        QFTDqEmLq89MHmWHkc8gEFZkb0uIJ4yMrhWtkgDLR1ICu3SrQFo6rwlxQI5Rwrev
        3L33gxK6Lys=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB12486776;
        Wed,  4 Nov 2020 14:31:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88EA986775;
        Wed,  4 Nov 2020 14:31:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Sohom Datta <sohom.datta@learner.manipal.edu>
Subject: Re: [PATCH v2] Avoid segfault and provide fallback when cloning
 invalid branch/tag
References: <pull.906.git.git.1604058401991.gitgitgadget@gmail.com>
        <pull.906.v2.git.git.1604510485432.gitgitgadget@gmail.com>
Date:   Wed, 04 Nov 2020 11:31:05 -0800
In-Reply-To: <pull.906.v2.git.git.1604510485432.gitgitgadget@gmail.com> (Sohom
        Datta via GitGitGadget's message of "Wed, 04 Nov 2020 17:21:25 +0000")
Message-ID: <xmqq7dr0ncli.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49410CDE-1ED4-11EB-87C8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sohom Datta <sohom.datta@learner.manipal.edu>

> Subject: Re: [PATCH v2] Avoid segfault and provide fallback when cloning invalid branch/tag

cf. https://git-scm.com/docs/SubmittingPatches#describe-changes

e.g. Subject: [PATCH v2] clone: do not put a non-commit on branch head

or something like that?

>
> The Git command to clone a specific branch of a git repository always
> assumes that the commit pointed to by the branch are going to valid. It

s/are going to valid/is going to be valid/, or just "is valid".
Probably the latter is preferable.

> thus segfaults and crashes whenever a tag or a branch with a invalid
> commit is specified.
>
> Aborting the operation is not desirable since the user is left with no
> usable git folder to work with despite git having done most of the work

s/folder/repository/; not everything is Windows ;-)

Insert a comma after "work with" before "despite".

> in setting everything up.

The above description is not wrong per-se, but the most expensive
part of discarding the result at this poihnt would be the copying of
contents from the other side, not just setting things up locally,
no?

> This commit is based of David Berardi's commit at
> https://lore.kernel.org/git/20191103180716.GA72007@carpenter.lan/
>
> Make git fallback on creating a unborn master branch when encountering
> a invalid commit.
>
> Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
> ---
>     Fix potential segfault on cloning invalid tag
>     
>     Changes since v1:
>     
>      * Reworked the patch to use the fallback approach based on feedback
>        from Jeff King.

Thanks.  Other than the nit pointed out above, the log message looks
readable.  Let's take a look at the code.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index a0841923cf..53930f7536 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -711,10 +711,63 @@ static void update_remote_refs(const struct ref *refs,
>  	}
>  }
>  
> -static void update_head(const struct ref *our, const struct ref *remote,
> +static struct commit * commit_lookup_helper (const struct ref *our,
> +					      const struct ref *remote,
> +					      const char *msg,
> +					      int *err)

Style.  Remove SP around commit_lookup_helper on both sides.

foo_helper() is not particularly a meaningful name.  Let's read on
and see if we can come up with a better name.

> +{
> +	const struct object_id *tip = NULL;

This initialization is not strictly needed, no?  I'd rather see us
leave it uninitialized.

> +	struct commit *tip_commit =  NULL;

Excess SP before NULL.


> +	if (our)
> +		tip = &our->old_oid;
> +	else if (remote)
> +		tip = &remote->old_oid;
> +	else {
> +		/*
> +		 * We have no local branch requested with "-b", and the
> +		 * remote HEAD is unborn. There's nothing to update HEAD
> +		 * to, but this state is not an error.
> +		 */
> +		return NULL;
> +	}

OK, so tip points at the location that has the object name of the
object that is planned to be at the tip of the branch that is
checked out to the working tree.

> +	if ( !lookup_object(the_repository, tip)) {

Style. No SP after '(' before the condition.

> +		/**

Why double asterisk here, unlike the early return we saw earlier?
Let's lose the extra one.

> +		 * We have a object id associated with the tip of the branch

s/a object id/an object name/;

> +		 * but the object id doesn't resolve to a object. This will be
> +		 * handled downstream in update_ref().
> +		 */

The design to punt on a non-existing object at this point in the
callflow may be sound, but is !lookup_object() a reliable indication
that the object name refers to a non-existing object?

In other words, I do not see what guarantees that we have already
saw and parsed the named object and placed it in the hashtable
the_repository->parsed_objects->obj_hash[].

Is there a reason we should avoid using parse_object() here instead?

> +		return NULL;
> +	}
> +
> +	tip_commit = lookup_commit_reference_gently(the_repository, tip, 1);
> +	if (!tip_commit) {
> +		/*
> +		 * The given non-commit cannot be checked out,
> +		 * so have a 'master' branch and leave it unborn.
> +		 */

OK, the reasoning here is that we checked if tip refers to
non-existing object before we tried lookup_commit_reference_gently(),
so a failure to find a commit here must mean the object does exist
but is not a committish.  And in such a case, we decided to abort
the calling update_head() and create an unborn branch ourselves.

Perhaps makes sense, I need to think about it a bit more to be
certain, though.

> +		error(_("non-commit branch cannot be checked out."));
> +		create_symref("HEAD", "refs/heads/master" ,msg);

Style.  Wrong placement of a comma before 'msg'.

Post v2.29 codebase should ask what our default first branch name
should be.

> +		*err = -1;
> +		return NULL;

It is customary to use the returned value from error(), like so

		*status = error(_("..."));

that would save you one line.  Taking all the nits above together,
perhaps

	if (!tip_commit) {
		char *ref = xstrfmt("refs/heads/%s", git_default_branch_name());
		create_symref("HEAD", ref, msg);
		*err = error(_("..."));
		free(ref);
		return NULL;
	}

HOWEVER, I think it is much cleaner to lose the "we first check if
the object exists" part and directly see if tip points at a
committish first.  Only when the tip does not point at a committish,
we need to tell the two cases apart.  So after figuring out into
which ref the variable "tip" should point, we'd do something like:


	tip_commit = lookup_commit_refernece_gently(... tip, 1);
	if (tip_commit)
		return tip_commit;

	/*
	 * Now, "tip" is not a committish.  Does it even exist?
	 */
	if (!lookup_object(... tip))
		/* let update_ref() handle this error condition */
		return NULL;

	/*
	 * Give an error, but leave the default initial branch
	 * unborn, instead of failing the whole operation to cause
	 * the directory removed.
	 */
	... do the create_symref() thing ...
	return NULL;

Wouldn't it be cleaner?

> +	}
> +
> +	return tip_commit;
> +}
> +
> +static int update_head(const struct ref *our,
> +			const struct ref *remote,

If you did not do unnecessary rewrapping, the patch noise in the
function definition here would have been avoided, no?

>  			const char *msg)
>  {
>  	const char *head;
> +	int err = 0;
> +	const struct commit * c;

Style.  Lose SP between asterisk and c; in our codebase the asterisk
sticks to the identifier (not type).

Have a blank line here, between the end of decl and the first stmt
in the block.

> +	c = commit_lookup_helper(our, remote, msg, &err);
> +	if (err < 0) {
> +		return -1;
> +	}

Style. No {} around a single stmt.

More importantly, without a name that is more meaningful than
"commit_lookup_helper()" and without any comment near its definition
to describe what the function is supposed to compute and what it
considers an error, the reader of this callsite cannot tell what we
are calling the "helper" for, and under what condition we are told
by the helper to return an error to our callers.

With the analysis and rewrite of that _helper() function, I think a
more descriptive name for the helper should contain words like
"check/ensure" and "commit" in it.  And the "err" variables, both in
the caller and in the helper function, are somewhat misnamed.  It is
a signal from the callee to the caller that updating the branch head
has already been done by the callee, so the caller does not have to 
do anything further.  Perhaps


	int skip_update_ref = 0;
	const struct commit *c;

	c = check_tip_commit(our, remote, msg, &skip_update_ref);
	if (skip_update_ref)
		return -1; /* left a fallback unborn branch */

	... and then "c" is a commit (already peeled) usable for
	... pointing HEAD to at this point.

I'd suggest giving the "c" variable, whose lifespan is now much
longer than in the original code, a more meaningful name, though.

>  	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
>  		/* Local default branch link */
>  		if (create_symref("HEAD", our->name, NULL) < 0)
> @@ -725,8 +778,6 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  			install_branch_config(0, head, remote_name, our->name);
>  		}
>  	} else if (our) {
> -		struct commit *c = lookup_commit_reference(the_repository,
> -							   &our->old_oid);
>  		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
>  		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
>  			   UPDATE_REFS_DIE_ON_ERR);
> @@ -739,6 +790,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  		update_ref(msg, "HEAD", &remote->old_oid, NULL, REF_NO_DEREF,
>  			   UPDATE_REFS_DIE_ON_ERR);

Can't this cause discrepancy when the helper picked remote->old_oid
as the "tip" there?  We called lookup_commit_reference_gently() on
that oid, and decided to check out the resulting commit and point
HEAD at it, so we are certain that your "c" is a commit object, but
remote->old_oid may name an annotated tag that points at the commit
object.  Don't we want to use &c->object.old here as well?

If that is the case (you need to think about it yourself---I didn't
spend more than 5 minutes on this particular point myself and the
above might be total nonsense), this part would become

	if (our && our is in our local branch namespace) {
		... do the local thing ...
	} else if (our || remote) {
		update_ref(msg, "HEAD", &c->object.oid, NULL, ...);
	}

as the body for 'our' and 'remote' are the same.

>  	}
> +
> +	return 0;
>  }
>  
>  static int git_sparse_checkout_init(const char *repo)
> @@ -1346,7 +1399,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			   branch_top.buf, reflog_msg.buf, transport,
>  			   !is_local);
>  
> -	update_head(our_head_points_at, remote_head, reflog_msg.buf);
> +	err = update_head(our_head_points_at, remote_head, reflog_msg.buf);
>  
>  	/*
>  	 * We want to show progress for recursive submodule clones iff
> @@ -1365,7 +1418,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	junk_mode = JUNK_LEAVE_REPO;
> -	err = checkout(submodule_progress);
> +	if ( err == 0 ) {
> +		/*
> +		 * Only try to checkout if we successfully updated HEAD; otherwise
> +		 * HEAD isn't pointing to the thing the user wanted.
> +		 */
> +		err = checkout(submodule_progress);
> +	}

The logic looks OK.  We avoid checking out an unborn if we left HEAD
unborn because there is no better choice.  And by not calling
checkout() and overwriting the err variable, we make sure that the
entire command still reports a failure.

I am not absolutely sure if reusing 'err' like the above two hunks
is the best thing to do, or the code becomes easier to follow if we
introduced another variable to receive the returned value from
update_head().  Perhaps what we have above is good enough.  I dunno.

> diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
> index 6e7a7be052..a589db9aa0 100755
> --- a/t/t5609-clone-branch.sh
> +++ b/t/t5609-clone-branch.sh
> @@ -20,6 +20,9 @@ test_expect_success 'setup' '
>  	 echo one >file && git add file && git commit -m one &&
>  	 git checkout -b two &&
>  	 echo two >file && git add file && git commit -m two &&
> +	 blob=$(git rev-parse HEAD:file) &&
> +	 echo $blob > .git/refs/heads/broken-tag &&
> +	 echo $blob > .git/refs/heads/broken-head &&

Style.  Do not leave SP between redirection operator and its target,
i.e.

	echo $blob >.git/refs/heads/...

Didn't you mean to use refs/tags/broken-tag for the first one, though?
Otherwise, I do not see how anybody would expect the two tests check
different things.

Thanks.


> +test_expect_success 'cloning -b for invalid tag must fail and fallback on remote head' '
> +	test_must_fail git clone -b broken-tag parent broken-tag 2>error &&
> +	test_i18ngrep "non-commit branch cannot be checked out." error &&
> +	(cd broken-tag && check_HEAD master)
> +'
> +
> +test_expect_success 'cloning -b for broken head must fail and fallback on remote head' '
> +	test_must_fail git clone -b broken-head parent broken-head &&
> +	test_i18ngrep "non-commit branch cannot be checked out." error &&
> +	(cd broken-head && check_HEAD master)
> +'
> +
>  test_done
>
> base-commit: 7f7ebe054af6d831b999d6c2241b9227c4e4e08d
