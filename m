Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A7AC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 03:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiBYDqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 22:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiBYDqd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 22:46:33 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E4956405
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 19:46:02 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id lj14-20020a17090b344e00b001bc8fe30103so2267679pjb.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 19:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LYw+tb/m2NJ8fdEAVK7/xk8pVIPOiOqutNM8dnoFszM=;
        b=mzpyawE+rRUpYS8D8VK2+mnrIUwwF7gxLDYJJUHzI2TQbXWiVXbWEQWKHsTwJOhPq5
         r0mfK5/+nSMuOQ9LorBqM9P2dBt/RnUgeX/rM/pmzj/dzBH5WgHXAfHrFMVcFpbb9tQJ
         eMP+dBp7/vv+aipQ68rhf5Hfm4zjGzobclclUVQ8vCADHHYhCUrJO0o3F/zcSHPZX4yo
         ks4oxlyKXTFPEi3wW5wOOiPcmJNgaaiK71LjEcGmv9OnXkh/rLOy+JX9o4QE5aJxv92J
         lkLB+IPBTFtLkCMY9BYK070Wf0WNw/7ct5fVObEwaV3VXkgo7oV+TCXJZpWku4X9CSqX
         qjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LYw+tb/m2NJ8fdEAVK7/xk8pVIPOiOqutNM8dnoFszM=;
        b=0p/m5dMuyUJbsVHwbQ9U4a33Hp2ggrcMn5Mroo+XEBd38gbaIm7PpkoFXt0LIQytzB
         VRpP8nwbq000Lw02Zw0q6axVi73mGQM8zNVlyU8moorQqVzK4bZKsDjPCyWCDhl30Vl5
         CxQMweas7S1uE9Z86nT8HPCeNzgJXRx9W8S0dTnzVVa2r0YSVuegLI+cTgIi6wD8czpW
         oKtUlVY+Q6h74PhkmIpCuqWqp5A+0WWzSnbbmVFAhKVxNsj7bsIfv8djxtM4xjztsJxK
         49KtnukijNEd6PjRANK1B9bBWfpRANqjGysAufScsPtULuIzbYgNWhzt6aITRG8tma73
         NN6g==
X-Gm-Message-State: AOAM532wDJULbFCnTnWPAdIlqITDKAf7ow62vTWg+tOYu+cGGDca4ZfC
        4h0hZcWW4JI03OZEOHigSI6TLP9qKgfDlg==
X-Google-Smtp-Source: ABdhPJzIlOBkd+jSkZFSkixJyVi+LbaVx3ictwGxlq7c0S18RgDjqIgPrY+LXy5bv+UyAljP9NWie9/ETJjrdQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:7c6:b0:4e1:799:7a2 with SMTP id
 n6-20020a056a0007c600b004e1079907a2mr5819009pfu.25.1645760762197; Thu, 24 Feb
 2022 19:46:02 -0800 (PST)
Date:   Fri, 25 Feb 2022 11:46:00 +0800
In-Reply-To: <20220225003928.2891685-1-jonathantanmy@google.com>
Message-Id: <kl6l5yp34nif.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220225003928.2891685-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> I'm not sure what future work we should pursue, or even if the
>> "--work-tree=." workaround is even good, so I'd appreciate feedback
>> here.
>
> I can't think of better solutions than what you listed, unfortunately. I
> also can't think of a better workaround, but at least it's narrowly
> scoped: we know that we're running on a submodule and that the operation
> is not affected by a worktree (for example, we're fetching, but we know
> we're not fetching with a refspec that updates a currently checked out
> branch). Let's see what others have to say.

Thanks for sharing your thoughts :)

>> @@ -1253,14 +1266,33 @@ void check_for_new_submodule_commits(struct object_id *oid)
>>  	oid_array_append(&ref_tips_after_fetch, oid);
>>  }
>>  
>> +/*
>> + * Returns 1 if there is at least one submodule gitdir in
>> + * $GIT_DIR/modules and 0 otherwise. This follows
>> + * submodule_name_to_gitdir(), which looks for submodules in
>> + * $GIT_DIR/modules, not $GIT_COMMON_DIR.
>> + *
>> + * A submodule can be moved to $GIT_DIR/modules manually by running "git
>> + * submodule absorbgitdirs", or it may be initialized there by "git
>> + * submodule update".
>> + */
>> +static int repo_has_absorbed_submodules(struct repository *r)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +
>> +	strbuf_repo_git_path(&buf, r, "modules/");
>> +	return file_exists(buf.buf) && !is_empty_dir(buf.buf);
>> +}
>
> buf needs to be released?

Ah, thanks.

>> @@ -1333,7 +1365,8 @@ int submodule_touches_in_range(struct repository *r,
>>  }
>>  
>>  struct submodule_parallel_fetch {
>> -	int count;
>> +	int index_count;
>> +	int changed_count;
>>  	struct strvec args;
>>  	struct repository *r;
>>  	const char *prefix;
>
> If we're sticking with these names, probably worth a comment. E.g.
> "index_count" is the number of submodules in <name of field that this is
> an index of> that we have processed, and likewise for "changed_count".
>
>> @@ -1343,6 +1376,7 @@ struct submodule_parallel_fetch {
>>  	int result;
>>  
>>  	struct string_list changed_submodule_names;
>> +	struct string_list seen_submodule_names;
>>  
>>  	/* Pending fetches by OIDs */
>>  	struct fetch_task **oid_fetch_tasks;
>
> Also here - changed is the list that we generated from walking the
> fetched superproject commits, and seen is the list of submodules we've
> processed in <name of function>.

Makes sense.

>> @@ -1539,11 +1582,64 @@ get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
>
> [snip]
>
>> +		/*
>> +		 * NEEDSWORK: A submodule unpopulated by "git rm" will
>> +		 * have core.worktree set, but the actual core.worktree
>> +		 * directory won't exist, causing the child process to
>> +		 * fail. Forcibly set --work-tree until we get smarter
>> +		 * handling for core.worktree in unpopulated submodules.
>> +		 */
>> +		strvec_push(&task->git_args, "--work-tree=.");
>> +		return task;
>> +	}
>> +	return NULL;
>> +}
>
> If we end up sticking to this workaround (which sounds reasonable to
> me), the comment here probably should contain a lot of what was written
> under the "---" in the commit message.

I assume this includes documenting solutions (like your NEEDSWORK
comment on submodule_name_to_gitdir()) and why core.worktree isn't
usually a problem (because checkout et al do the right thing).

>> +test_expect_success "'--recurse-submodules=on-demand' should fetch submodule commits if the submodule is changed but the index has no submodules" '
>
> [snip]
>
>> +# In downstream, init "submodule2", but do not check it out while
>> +# fetching. This lets us assert that unpopulated submodules can be
>> +# fetched.
>> +test_expect_success 'setup downstream branch with other submodule' '
>> +	mkdir submodule2 &&
>> +	(
>> +		cd submodule2 &&
>> +		git init &&
>> +		echo sub2content >sub2file &&
>> +		git add sub2file &&
>> +		git commit -a -m new &&
>> +		git branch -M sub2
>> +	) &&
>> +	git checkout -b super-sub2-only &&
>> +	git submodule add "$pwd/submodule2" submodule2 &&
>> +	git commit -m "add sub2" &&
>> +	git checkout super &&
>> +	(
>> +		cd downstream &&
>> +		git fetch --recurse-submodules origin &&
>> +		git checkout super-sub2-only &&
>> +		# Explicitly run "git submodule update" because sub2 is new
>> +		# and has not been cloned.
>> +		git submodule update --init &&
>> +		git checkout --recurse-submodules super
>> +	)
>> +'
>
> Hmm...what is the difference between this and the original case in which
> the index has no submodules? Both assert that unpopulated submodules
> (submodules that cannot be found by iterating the index, as described in
> your commit message) can be fetched.

In the previous test, the index has no submodules (it's completely empty
in fact, so we don't iterate the index at all), but in this test, it
does. This lets us check that there aren't any buggy interactions when
both changed and index submodules are present.

I think such mistakes are pretty easy to introduce on accident - I made
one pre-v1 where I reused .count between both iterators (instead
of having .index_count and .changed_count). It passed the previous test
because we didn't care about the index, but it obviously wouldn't pass
this one.

>> +	# Use test_cmp manually because verify_fetch_result does not
>> +	# consider submodule2. All the repos should be fetched, but only
>> +	# submodule2 should be read from a commit
>> +	cat <<-EOF > expect.err.combined &&
>> +	From $pwd/.
>> +	   OLD_HEAD..$super_head  super           -> origin/super
>> +	   OLD_HEAD..$super_sub2_only_head  super-sub2-only -> origin/super-sub2-only
>> +	Fetching submodule submodule
>> +	From $pwd/submodule
>> +	   OLD_HEAD..$sub_head  sub        -> origin/sub
>> +	Fetching submodule submodule/subdir/deepsubmodule
>> +	From $pwd/deepsubmodule
>> +	   OLD_HEAD..$deep_head  deep       -> origin/deep
>> +	Fetching submodule submodule2 at commit $super_sub2_only_head
>> +	From $pwd/submodule2
>> +	   OLD_HEAD..$sub2_head  sub2       -> origin/sub2
>> +	EOF
>> +	sed -E "s/[0-9a-f]+\.\./OLD_HEAD\.\./" actual.err >actual.err.cmp &&
>> +	test_cmp expect.err.combined actual.err.cmp
>> +'
>
> Could verify_fetch_result be modified to consider the new submodule
> instead?

Since submodule2 is on the end of the file, I could modify
verify_fetch_result() to concatenate extra text on the end. But if it
weren't in the middle, we'd need to insert arbitrary text in the middle
of the file.

I can't think of a good way to do this without compromising test
readability, so I'll just do concatenation for now.

>> +test_expect_success 'fetch --recurse-submodules updates name-conflicted, populated submodule' '
>> +	test_when_finished "git -C same-name-downstream checkout master" &&
>> +	(
>> +		cd same-name-1 &&
>> +		test_commit -C submodule --no-tag b1 &&
>> +		git add submodule &&
>> +		git commit -m "super-b1"
>> +	) &&
>> +	(
>> +		cd same-name-2 &&
>> +		test_commit -C submodule --no-tag b2 &&
>> +		git add submodule &&
>> +		git commit -m "super-b2"
>> +	) &&
>> +	(
>> +		cd same-name-downstream &&
>> +		# even though the .gitmodules is correct, we cannot
>> +		# fetch from same-name-2
>> +		git checkout same-name-2/master &&
>> +		git fetch --recurse-submodules same-name-1 &&
>> +		test_must_fail git fetch --recurse-submodules same-name-2
>
> What's the error message printed to the user here? (Just from reading
> the code, I would have expected this to succeed, with the submodule
> fetch being from same-name-1's submodule since we're fetching submodules
> by name, but apparently that is not the case.)

Yeah, I think this might trip up some readers. The message is:

  From ../same-name-2
    b7ebb59..944b5ac  master     -> same-name-2/master
  Fetching submodule submodule
  fatal: git upload-pack: not our ref 7ff6874077503acb9d0a52e280aaed9748276319
  fatal: remote error: upload-pack: not our ref 7ff6874077503acb9d0a52e280aaed9748276319
  Errors during submodule fetch:
          submodule

Which, I believe, comes from how we fetch commits by oid:

  static int get_next_submodule(struct child_process *cp, struct strbuf *err,
              void *data, void **task_cb)
  [...]
    oid_array_for_each_unique(task->commits,
          append_oid_to_argv, &cp->args);

When the following is true:

- the submodule is found in the index
- we are fetching submodules unconditionally (--recurse-submodules=yes")
- no superproject commit "changes" the submodule

task->commits is empty, and we just fetch the from the submodule's
remote by name. But as long as any superproject commit "changes" the
submodule, we try to fetch by oid, which, as this test demonstrates, may
fail.

>
>> +	(
>> +		cd same-name-downstream/.git/modules/submodule &&
>> +		# The submodule has core.worktree pointing to the "git
>> +		# rm"-ed directory, overwrite the invalid value.
>> +		git --work-tree=. cat-file -e $head1 &&
>> +		test_must_fail git --work-tree=. cat-file -e $head2
>> +	)
>
> Regarding the worktree workaround, also say "see comment in
> get_fetch_task() for more information" or something like that.

Makes sense.
