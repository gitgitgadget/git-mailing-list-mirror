Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7598C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243283AbiBOWCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:02:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiBOWCo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:02:44 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C258140A4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:02:33 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z3-20020a170903408300b0014d891103aaso140323plc.0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=UjaBtClQu/gvQmp/ZeT83DIkD/MxHcmTx3WCCGQT03g=;
        b=p0I8WQ0KPh0Rk/dvlEoN9qpuTKDlSX7OtI8Ks6RhSzDwRN3KUohyx6ttgOu+wPYBHX
         Swq/x6yGTdJCGah1tulRVSkKQJKbx3eEMXZ9hDSQ22kBBjec6fGTxSuZEuF9oW68uOCK
         5OtgZ9/o40Q5AhGWu1U4WgyQfDmlE6O5Ba3eRdM8kagumxXZ1+9aCLZ/cMSG+p9zIO5k
         8FpMtumhEgDrwH525H4AnkC8V7TvhV6t/gwbn6MkRCVs4Q/BIqS511DA4pMrpzymDkNY
         byDuGMOA7KwBV0sLTaWfxO2Pl+Pzq1rr7bPMSksIPa46RL24yYNaPTaSd9pDnllD7d61
         hljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=UjaBtClQu/gvQmp/ZeT83DIkD/MxHcmTx3WCCGQT03g=;
        b=qY+IEgfWsRioSdHmMk2TwUaka1Mr1POjbSfCfxaTlurMHE2F6MA+HbRpneMNaTpuWC
         D5tMg1UYFHUkWeCZ8/9dtvJqepJAa1cFka3ZF+Z2yCG+lZDaSH83DYVpIiXUtELWyzfA
         A+zBm+9UStC2gUOh1eJs4AbvwGVv822xvlLG3blVeADlUDb2yIICB9PKu1SNPx5NEKlM
         zP0HkAgtVbdtp9/t8NopPRVq8r3sDF6zDEp2nnAHCnF7ir+MOkmzTNqzrJVg2vc4nlXY
         7b75DB5RKt9XvMLOgSTqVkkmSUPGjiEL/Weh9lR2i1RnjPmHhP3Ttafbdz5/1CqJ6Fg4
         yT2g==
X-Gm-Message-State: AOAM531dqGntmrqBZAhI3vIwFBqoIEF7VIc25bdD4wtREdcKsOXb72So
        sA38U5m1Iw3arNkmPrtrwPy02opbpV29/EBmFj/A
X-Google-Smtp-Source: ABdhPJxYD6LP2KOZFVn+BpxEB3tQgwYcMzV6K6B4mXP/NteJ6kT6yKDHmV1QK62qa9LeIbbfVfxuYPIogrONV4K7RMFL
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:1984:: with SMTP id
 4mr986740pji.197.1644962552801; Tue, 15 Feb 2022 14:02:32 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:02:29 -0800
In-Reply-To: <20220215172318.73533-8-chooglen@google.com>
Message-Id: <20220215220229.1633486-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH v2 7/9] fetch: fetch unpopulated, changed submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patches 4-6 look good.

Glen Choo <chooglen@google.com> writes:
> Teach "git fetch" to fetch cloned, changed submodules regardless of
> whether they are populated (this is in addition to the current behavior
> of fetching populated submodules).

I think add a note that the current behavior is regardless of what is
being fetched. So, maybe something like:

  Teach "git fetch" to fetch cloned, changed submodules regardless of
  whether they are populated. This is in addition to the current behavior
  of fetching populated submodules (which happens regardless of what was
  fetched in the superproject, or even if nothing was fetched in the
  superproject).

> As I mentioned in the cover letter, I'm not entirely happy with the
> name repo_has_absorbed_submodules() - it's not a standardized term AFAIK
> and it's a little clunky.
> 
> "absorbed submodule" is just a stand-in for "submodule in .git/modules",
> so if we have a better term for "submodule in .git/modules", let's use
> that instead.

I think that this is OK if the doc comment is updated. I'll make the
suggestion in the appropriate place below.

> @@ -1248,14 +1261,28 @@ void check_for_new_submodule_commits(struct object_id *oid)
>  	oid_array_append(&ref_tips_after_fetch, oid);
>  }
>  
> +/*
> + * Returns 1 if the repo has absorbed submodule gitdirs, and 0
> + * otherwise. Like submodule_name_to_gitdir(), this checks
> + * $GIT_DIR/modules, not $GIT_COMMON_DIR.
> + */
> +static int repo_has_absorbed_submodules(struct repository *r)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_repo_git_path(&buf, r, "modules/");
> +	return file_exists(buf.buf) && !is_empty_dir(buf.buf);
> +}

I think that if you replace the doc comment with something like:

  Returns 1 if there is at least one submodule gitdir in
  $GIT_DIR/modules, and 0 otherwise. (End users can move submodule
  gitdirs into $GIT_DIR/modules by running "git submodule
  absorbgitdirs".) Like submodule_name_to_gitdir()...

then it would be fine.

> @@ -1338,6 +1366,7 @@ struct submodule_parallel_fetch {
>  	int result;
>  
>  	struct string_list changed_submodule_names;
> +	struct string_list seen_submodule_names;

Could we unify the 2 lists instead of having 2 separate ones?

> @@ -1529,12 +1569,77 @@ get_fetch_task(struct submodule_parallel_fetch *spf,
>  	return NULL;
>  }
>  
> +static struct fetch_task *
> +get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
> +			    const char **default_argv, struct strbuf *err)
> +{
> +	for (; spf->changed_count < spf->changed_submodule_names.nr;
> +	     spf->changed_count++) {
> +		struct string_list_item item =
> +			spf->changed_submodule_names.items[spf->changed_count];
> +		struct changed_submodule_data *cs_data = item.util;
> +		struct fetch_task *task;
> +
> +		/*
> +		 * We might have already considered this submodule
> +		 * because we saw it in the index.
> +		 */
> +		if (string_list_lookup(&spf->seen_submodule_names, item.string))
> +			continue;
> +
> +		task = fetch_task_create(spf->r, cs_data->path,
> +					 cs_data->super_oid);
> +		if (!task)
> +			continue;
> +
> +		switch (get_fetch_recurse_config(task->sub, spf)) {
> +		default:
> +		case RECURSE_SUBMODULES_DEFAULT:
> +		case RECURSE_SUBMODULES_ON_DEMAND:
> +			*default_argv = "on-demand";
> +			break;
> +		case RECURSE_SUBMODULES_ON:
> +			*default_argv = "yes";
> +			break;
> +		case RECURSE_SUBMODULES_OFF:
> +			continue;
> +		}
> +
> +		task->repo = get_submodule_repo_for(spf->r, task->sub->path,
> +						    cs_data->super_oid);
> +		if (!task->repo) {
> +			fetch_task_release(task);
> +			free(task);
> +
> +			strbuf_addf(err, _("Could not access submodule '%s'\n"),
> +				    cs_data->path);
> +			continue;
> +		}
> +		if (!is_tree_submodule_active(spf->r, cs_data->super_oid,
> +					      task->sub->path))
> +			continue;
> +
> +		if (!spf->quiet)
> +			strbuf_addf(err,
> +				    _("Fetching submodule %s%s at commit %s\n"),
> +				    spf->prefix, task->sub->path,
> +				    find_unique_abbrev(cs_data->super_oid,
> +						       DEFAULT_ABBREV));
> +		spf->changed_count++;
> +		return task;
> +	}
> +	return NULL;
> +}

This is very similar to get_fetch_task_from_index(). Both:
 1. loop over something
 2. exit early if the submodule name is seen
 3. create the fetch task
 4. set the "recurse config"
 5. get the submodule repo
 6. if success, increment a counter
 7. if failure, check for some conditions and maybe append to err

Could a function be refactored that does 2-5?

> +test_expect_success "'--recurse-submodules=on-demand' should fetch submodule commits if the submodule is changed but the index has no submodules" '
> +	git -C downstream fetch --recurse-submodules &&

First of all, thanks for updating the test - it is much easier to
understand now.

About this line, we shouldn't use the code being tested to set up (we're
testing "fetch --recurse-submodules", so we shouldn't use the same
command to set up). Also, if we don't have confidence in the starting
state, it may be a sign to write it out more explicitly instead of
relying on a complicated command to do the right thing.

However, in this case, I don't think we need this. All we need is to see
that the test contains a new superproject commit that points to a new
submodule commit (and recursively). So we don't need this line.

> +	# Create new superproject commit with updated submodules
> +	add_upstream_commit &&
> +	(
> +		cd submodule &&
> +		(
> +			cd subdir/deepsubmodule &&
> +			git fetch &&
> +			git checkout -q FETCH_HEAD
> +		) &&
> +		git add subdir/deepsubmodule &&
> +		git commit -m "new deep submodule"
> +	) &&
> +	git add submodule &&
> +	git commit -m "new submodule" &&

I thought add_upstream_commit() would do this, but apparently it just
adds commits to the submodules (which works for the earlier tests that
just tested that the submodules were fetched, but not for this one). I
think that all this should go into its own function.

Also, I understand that "git fetch" is there to pick up the commit we
made in add_upstream_commit, but this indirection is unnecessary in a
test, I think. Can we not use add_upstream_commit and just create our
own in subdir/deepsubmodule? (This might conflict with subsequent tests
that use the old scheme, but I think that it should be fine.)

> +	# Fetch the new superproject commit
> +	(
> +		cd downstream &&
> +		git switch --recurse-submodules no-submodules &&
> +		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
> +	) &&
> +	test_must_be_empty actual.out &&
> +	git rev-parse --short HEAD >superhead &&
> +	git -C submodule rev-parse --short HEAD >subhead &&
> +	git -C deepsubmodule rev-parse --short HEAD >deephead &&

These >superhead lines would not be necessary if we had our own
function.

> +# In downstream, init "submodule2", but do not check it out while
> +# fetching. This lets us assert that unpopulated submodules can be
> +# fetched.

Firstly, "In upstream", I think? You want to fetch from it, so it has to
be upstream.

Secondly, is this test needed? I thought the case in which the worktree
has no submodules would be sufficient to test that unpopulated
submodules can be fetched.

> +test_expect_success "'--recurse-submodules' should fetch submodule commits in changed submodules and the index" '

[snip]

> +	git checkout super &&
> +	(
> +		cd downstream &&
> +		git fetch --recurse-submodules >../actual.out 2>../actual.err
> +	) &&
> +	test_must_be_empty actual.out &&
> +
> +	# Assert that the submodules in the super branch are fetched
> +	git rev-parse --short HEAD >superhead &&
> +	git -C submodule rev-parse --short HEAD >subhead &&
> +	git -C deepsubmodule rev-parse --short HEAD >deephead &&
> +	verify_fetch_result actual.err &&
> +	# grep for the exact line to check that the submodule is read
> +	# from the index, not from a commit
> +	grep "^Fetching submodule submodule\$" actual.err &&

Instead of a grep, I think this should be done by precisely specifying
what to fetch in the "git fetch" invocation, and then checking that the
submodule has commits that it didn't have before.

In addition, I think the following cases also need to be tested:
 - two fetched commits have submodules of the same name but different
   URL
 - a fetched commit and a commit in the index have submodules of the
   same name but different URL
