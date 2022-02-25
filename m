Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC375C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 00:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiBYAkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 19:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYAkC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 19:40:02 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2F01D8A85
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 16:39:31 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id h14-20020aa79f4e000000b004f3aa388c1fso2155739pfr.6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 16:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=yGjh1yIiR4i0mvYdPZPYxiS7pRCwNa6VwLmeimDukeo=;
        b=oXNdvBwvxf7qQAaL3PysPeyN9eLm55HJxZy/y8PReMjvdOdf+I2g27awo2j2MdWbrE
         TrTecly1ul5hM+oyRPNKfiu8eSM54TjnqWpsW0YqBbL3nb7T2cW2eRHnURg4j8Fl/V4v
         emmYiWKnLf73s8u5On6lEy1cLO7lSssNQ67J6prENI3arz1n0yrMcsWABf6DMMyxIeoE
         oaRiSu7nLrIz6qMjWPSC6l1BJyMKE7iBtzZApKVq0Hzzu6+e7nqKbi0oVxayNYHyA3tv
         aB/vEk/801lzyyT2CUjGmBeee32aPLQb8/7DmZtt3IJXLOw5tAub9z/dz6715OjgdCtJ
         bCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=yGjh1yIiR4i0mvYdPZPYxiS7pRCwNa6VwLmeimDukeo=;
        b=jLcuvlMC7ugOuC9eGx17lKgUd01oOi1W/2KlwlDQ7oldw/RfQkSlkNOdy3Fk6LXqCR
         v0ms7oLG1Y41XnpQJA3G+C0b1Zrf9usxcigaqoCnTMojCHitkM8JVEt5Zgb/hcaHuPiP
         fc0BNvNyAWwKhpWRXdRJCZRz8daIoukVvgbWb3niV5LxBVCggOowgtodcNFZCws1VXXo
         BnhKQmoXEJww0JqOZIgB+IK+aMnZXIl0Y6Rdo63F8QZXbGprCl3i5gTcSkC2tk8Y/E7P
         /9slmi8r4rVx/OCIzabeQ/5wjh66RSk+axibWpKpBHQPlD4/SfnP++qOFGBaRHolzlGw
         Fflw==
X-Gm-Message-State: AOAM532XKD8YGdhHw9dYjkMqYEQoEWbJD4x1adw9+1bfwEteBf+zktY5
        xryjE6iy3Y14P36QSUOctCmqJWao7f3frZX2kgjq
X-Google-Smtp-Source: ABdhPJyVxk+ux/1gStLLHKnGd5DlA1ujLgmZ5xTxn2PvuNgFZ+PhTBXYeJoUykR2ZeKxZNMMDNuJpTZOvBRlZM4s68hP
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:f48f:b0:1bc:2521:fb0a with
 SMTP id bx15-20020a17090af48f00b001bc2521fb0amr681183pjb.48.1645749571109;
 Thu, 24 Feb 2022 16:39:31 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:39:27 -0800
In-Reply-To: <20220224100842.95827-10-chooglen@google.com>
Message-Id: <20220225003928.2891685-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> In the process of writing the new tests [1], I noticed some failures of
> the form:
> 
>   # rm the submodule's working tree directory.
>   $ git rm submodule
>   [...]
> 
>   # Do a fetch that requires running a child process from the submodule.
>   $ git fetch --recurse-submodules same-name-1 
>   [...]
> 
>   # Fatal error tells us that we cannot chdir to the deleted working
>     tree.
>   fatal: cannot chdir to '../../../submodule': No such file or directory
> 
> This happens because submodules set/unset a value for core.worktree when
> they are checked out/"un-checked out" (see submodule_move_head() and
> connect_work_tree_and_git_dir()), but "git rm" doesn't know that
> core.worktree should be updated.
> 
> I've worked around this by passing "--work-tree=." to the child process
> [2], but this feels like a hack, especially because this bug should
> affect all child processes in a "git rm"-ed submodule (this probably
> includes the "git branch" processes in gc/branch-recurse-submodules, but
> I haven't confirmed it yet). 

Ah...that's a tricky bug. Thanks for finding it.

> Some more comprehensive solutions that
> could be future work are:
> 
> - Teach "git [add|rm]" to unset core.worktree (the reverse operation,
>   "git restore", should already do the correct thing). This won't detect
>   submodules removed with "rm -r" though.

This might work with the caveat you mentioned.

> - Teach submodule child processes to ignore stale core.worktree values.

This might work, coupled with Emily Shaffer's work on teaching
submodules to know that they're submodules (so we know when a stale
core.worktree can be safely ignored).

[1] https://lore.kernel.org/git/20220203215914.683922-1-emilyshaffer@google.com/

> - Do more things in-core instead of using child processes (avoiding the
>   failing chdir() call).

This might not work if the invocation needs to check the worktree (for
example, as far as I know, we won't delete a branch if it's currently
checked out in a worktree).

> I'm not sure what future work we should pursue, or even if the
> "--work-tree=." workaround is even good, so I'd appreciate feedback
> here.

I can't think of better solutions than what you listed, unfortunately. I
also can't think of a better workaround, but at least it's narrowly
scoped: we know that we're running on a submodule and that the operation
is not affected by a worktree (for example, we're fetching, but we know
we're not fetching with a refspec that updates a currently checked out
branch). Let's see what others have to say.

> @@ -865,6 +876,8 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
>  		if (!item->util)
>  			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
>  		cs_data = item->util;
> +		cs_data->super_oid = commit_oid;
> +		cs_data->path = xstrdup(p->two->path);

Junio mentioned the possibility of cs_data->path already being non-NULL
[1].

[1] https://lore.kernel.org/git/xmqqy220j6kf.fsf@gitster.g/

> @@ -1253,14 +1266,33 @@ void check_for_new_submodule_commits(struct object_id *oid)
>  	oid_array_append(&ref_tips_after_fetch, oid);
>  }
>  
> +/*
> + * Returns 1 if there is at least one submodule gitdir in
> + * $GIT_DIR/modules and 0 otherwise. This follows
> + * submodule_name_to_gitdir(), which looks for submodules in
> + * $GIT_DIR/modules, not $GIT_COMMON_DIR.
> + *
> + * A submodule can be moved to $GIT_DIR/modules manually by running "git
> + * submodule absorbgitdirs", or it may be initialized there by "git
> + * submodule update".
> + */
> +static int repo_has_absorbed_submodules(struct repository *r)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_repo_git_path(&buf, r, "modules/");
> +	return file_exists(buf.buf) && !is_empty_dir(buf.buf);
> +}

buf needs to be released?

> @@ -1333,7 +1365,8 @@ int submodule_touches_in_range(struct repository *r,
>  }
>  
>  struct submodule_parallel_fetch {
> -	int count;
> +	int index_count;
> +	int changed_count;
>  	struct strvec args;
>  	struct repository *r;
>  	const char *prefix;

If we're sticking with these names, probably worth a comment. E.g.
"index_count" is the number of submodules in <name of field that this is
an index of> that we have processed, and likewise for "changed_count".

> @@ -1343,6 +1376,7 @@ struct submodule_parallel_fetch {
>  	int result;
>  
>  	struct string_list changed_submodule_names;
> +	struct string_list seen_submodule_names;
>  
>  	/* Pending fetches by OIDs */
>  	struct fetch_task **oid_fetch_tasks;

Also here - changed is the list that we generated from walking the
fetched superproject commits, and seen is the list of submodules we've
processed in <name of function>.

> @@ -1539,11 +1582,64 @@ get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)

[snip]

> +		/*
> +		 * NEEDSWORK: A submodule unpopulated by "git rm" will
> +		 * have core.worktree set, but the actual core.worktree
> +		 * directory won't exist, causing the child process to
> +		 * fail. Forcibly set --work-tree until we get smarter
> +		 * handling for core.worktree in unpopulated submodules.
> +		 */
> +		strvec_push(&task->git_args, "--work-tree=.");
> +		return task;
> +	}
> +	return NULL;
> +}

If we end up sticking to this workaround (which sounds reasonable to
me), the comment here probably should contain a lot of what was written
under the "---" in the commit message.

> +test_expect_success "'--recurse-submodules=on-demand' should fetch submodule commits if the submodule is changed but the index has no submodules" '

[snip]

> +# In downstream, init "submodule2", but do not check it out while
> +# fetching. This lets us assert that unpopulated submodules can be
> +# fetched.
> +test_expect_success 'setup downstream branch with other submodule' '
> +	mkdir submodule2 &&
> +	(
> +		cd submodule2 &&
> +		git init &&
> +		echo sub2content >sub2file &&
> +		git add sub2file &&
> +		git commit -a -m new &&
> +		git branch -M sub2
> +	) &&
> +	git checkout -b super-sub2-only &&
> +	git submodule add "$pwd/submodule2" submodule2 &&
> +	git commit -m "add sub2" &&
> +	git checkout super &&
> +	(
> +		cd downstream &&
> +		git fetch --recurse-submodules origin &&
> +		git checkout super-sub2-only &&
> +		# Explicitly run "git submodule update" because sub2 is new
> +		# and has not been cloned.
> +		git submodule update --init &&
> +		git checkout --recurse-submodules super
> +	)
> +'

Hmm...what is the difference between this and the original case in which
the index has no submodules? Both assert that unpopulated submodules
(submodules that cannot be found by iterating the index, as described in
your commit message) can be fetched.

> +	# Use test_cmp manually because verify_fetch_result does not
> +	# consider submodule2. All the repos should be fetched, but only
> +	# submodule2 should be read from a commit
> +	cat <<-EOF > expect.err.combined &&
> +	From $pwd/.
> +	   OLD_HEAD..$super_head  super           -> origin/super
> +	   OLD_HEAD..$super_sub2_only_head  super-sub2-only -> origin/super-sub2-only
> +	Fetching submodule submodule
> +	From $pwd/submodule
> +	   OLD_HEAD..$sub_head  sub        -> origin/sub
> +	Fetching submodule submodule/subdir/deepsubmodule
> +	From $pwd/deepsubmodule
> +	   OLD_HEAD..$deep_head  deep       -> origin/deep
> +	Fetching submodule submodule2 at commit $super_sub2_only_head
> +	From $pwd/submodule2
> +	   OLD_HEAD..$sub2_head  sub2       -> origin/sub2
> +	EOF
> +	sed -E "s/[0-9a-f]+\.\./OLD_HEAD\.\./" actual.err >actual.err.cmp &&
> +	test_cmp expect.err.combined actual.err.cmp
> +'

Could verify_fetch_result be modified to consider the new submodule
instead?

> +test_expect_success 'fetch --recurse-submodules updates name-conflicted, populated submodule' '
> +	test_when_finished "git -C same-name-downstream checkout master" &&
> +	(
> +		cd same-name-1 &&
> +		test_commit -C submodule --no-tag b1 &&
> +		git add submodule &&
> +		git commit -m "super-b1"
> +	) &&
> +	(
> +		cd same-name-2 &&
> +		test_commit -C submodule --no-tag b2 &&
> +		git add submodule &&
> +		git commit -m "super-b2"
> +	) &&
> +	(
> +		cd same-name-downstream &&
> +		# even though the .gitmodules is correct, we cannot
> +		# fetch from same-name-2
> +		git checkout same-name-2/master &&
> +		git fetch --recurse-submodules same-name-1 &&
> +		test_must_fail git fetch --recurse-submodules same-name-2

What's the error message printed to the user here? (Just from reading
the code, I would have expected this to succeed, with the submodule
fetch being from same-name-1's submodule since we're fetching submodules
by name, but apparently that is not the case.)

> +	(
> +		cd same-name-downstream/.git/modules/submodule &&
> +		# The submodule has core.worktree pointing to the "git
> +		# rm"-ed directory, overwrite the invalid value.
> +		git --work-tree=. cat-file -e $head1 &&
> +		test_must_fail git --work-tree=. cat-file -e $head2
> +	)

Regarding the worktree workaround, also say "see comment in
get_fetch_task() for more information" or something like that.
