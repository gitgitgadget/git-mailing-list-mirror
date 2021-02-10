Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62646C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 07:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1338764E05
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 07:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhBJHyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 02:54:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58855 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhBJHxw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 02:53:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC859110866;
        Wed, 10 Feb 2021 02:53:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wAsO/QUeESitT7MaeP8PtZE7M2I=; b=upXmCB
        lmh8GBNzY3I4JQ5+ZU2sAyxtLFFU2v0ST0jx5+sczy9BnWZ9vPL7ukzSJoKYunG3
        XCsK9n3lcJASUgPr3e+C5JZ9G7U1c2gBvIAcCqS2AYFvY84bie2FEDGijF6UJTHt
        Q2pVMHznB4OC84UjFQ5NJZGKjMYWjQx9UqZ58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xkgR84FJLwfNvno1jMazGGGvtZECYz96
        nCVIaF8zYCwc4OzyYST990kBLqc6blgKe5z4rZFMmgK32M3ctmf9f1mJjLTP1Y/s
        QFwEc2ELP/Vdu4VHYPFX/nvaTgRGw5xRINf6lxLHsYu1bEI/Ol9ZlFsOPfIrX7dA
        ueG3t6V0cXE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D56FC110865;
        Wed, 10 Feb 2021 02:53:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24111110864;
        Wed, 10 Feb 2021 02:53:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 8/9] stash show: teach --include-untracked and
 --only-untracked
References: <cover.1612258145.git.liu.denton@gmail.com>
        <cover.1612855690.git.liu.denton@gmail.com>
        <88d47912595b5650fbca595a6dd5b7b943a93301.1612855690.git.liu.denton@gmail.com>
Date:   Tue, 09 Feb 2021 23:53:06 -0800
In-Reply-To: <88d47912595b5650fbca595a6dd5b7b943a93301.1612855690.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 8 Feb 2021 23:28:54 -0800")
Message-ID: <xmqqa6sc4avx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03A88416-6B75-11EB-BDCC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Stash entries can be made with untracked files via
> `git stash push --include-untracked`. However, because the untracked
> files are stored in the third parent of the stash entry and not the
> stash entry itself, running `git stash show` does not include the
> untracked files as part of the diff.

> Teach stash the --include-untracked option, which also displays the
> untracked files in a stash entry from the third parent (if it exists).

A few points:

 - "Teach stash the --include-untracked option"?  (some part of)
   "stash" knows --include-untracked already.  Perhaps "Teach 'stash
   show' the '--include-untracked' option"?

 - "which also displays"?  Let's spell it out that untracked paths
   are shown in addition to what.  "With this option, untracked
   paths recorded in the third-parent (if exists) are shown, in
   addition to the paths whose modifications between the stash base
   and the working tree are stashed", or something like that,
   perhaps?

> Do this via something like
>
> 	GIT_INDEX_FILE=... git read-tree stash stash^3
>
> and diffing the resulting tree object against the stash base.

That explains the implementation, but does not make it clear what
the implementation wants to achieve.  So we read the tree from stash
(i.e. working tree) into a temporary index, and then overlay the
tree of stash^3 (i.e. untracked) on top---which means the resulting
"index" has the state of the working tree plus the untracked cruft
in it.  And comparing that with "stash base" (by the way is that a
term well understood?  I borrowed it for the above review comment,
which shows that there certainly is need for such a term) would show
the diff between the "HEAD" and the state that would have result if
you were to do an "git add ." in the working tree.  OK.

> One improvement that this could use for the future is performing the
> action without writing anything to disk as one would expect this to be a
> read-only operation. This can be fixed in the future, however.

Is it so difficult that we have to delay the fix for "the future"?
After reading two trees into an in-core index, without writing it
out to any file, all that remains to be done is just a matter of
running diff-lib.c::do_diff_cache(), no?  I must be missing something.q

> Another limitation of this is that it would be possible to manually
> craft a stash entry where duplicate untracked files in the stash entry
> will mask tracked files. This seems like an instance of "Doctor, it
> hurts when I do this! So don't do that!" so this can be written off.

Well, when you read the second tree into the in-core index to
overlay what you read from the working tree state, you can certainly
report the collision and error it out.

> Also, teach stash the --only-untracked option which only shows the
> untracked files of a stash entry. This is similar to `git show stash^3`
> but it is nice to provide a convenient abstraction for it so that users
> do not have to think about the underlying implementation.

OK.

>  -u::
>  --include-untracked::
> -	This option is only valid for `push` and `save` commands.
> +--no-include-untracked::
> +	When used with the `push` and `save` commands,
> +	all untracked files are also stashed and then cleaned up with
> +	`git clean`.

Back when "--include-untracked" was there and no "--only-untracked"
existed, it made sense for the former to squat on a short-and-sweet
"-u".  Now it comes back to bite us ;-)

>  +
> -All untracked files are also stashed and then cleaned up with
> -`git clean`.
> +When used with the `show` command, show the untracked files in the stash
> +entry as part of the diff.

OK.

> +--only-untracked::
> +	This option is only valid for the `show` command.
> ++
> +Show only the untracked files in the stash entry as part of the diff.

OK.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 6f2b58f6ab..f7220fad56 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -787,6 +787,47 @@ static int git_stash_config(const char *var, const char *value, void *cb)
>  	return git_diff_basic_config(var, value, cb);
>  }
>  
> +static int merge_track_untracked(struct object_id *result, const struct stash_info *info)
> +{
> +	int ret = 0;
> +	struct index_state istate = { NULL };
> +	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
> +
> +	if (!info->has_u) {
> +		oidcpy(result, &info->w_commit);
> +		return 0;
> +	}
> +
> +	/*
> +	 * TODO: is there a way of doing this all in-memory without writing
> +	 * anything to disk?
> +	 */

Of course.  Read and study what read-tree does, which boils down to
a call to unpack_trees() without .merge option.
