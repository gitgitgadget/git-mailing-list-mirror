Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DCBC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 22:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345269AbiBJWvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:51:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345155AbiBJWvl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 17:51:41 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E7FB75
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:51:41 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id h13-20020a17090ac38d00b001b8d61ec280so2232370pjt.1
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=ReIQwhagC9wVx7XWKttziwoRAX3M5nQznQBo7fdMD2Q=;
        b=LSz+lextb2+AQFcwhRpT8xfPr8GMTzCBi9OjrrQ/tXzGQwWiir5LEfXEQe+vrex60T
         yEW1mpwBDMFj5yrlfnfACDM8sDBBZMmMSDtZ+9yboC99mL+Ekh/MH12vzv+/abJoeCQp
         /7ciq4EHUMH1iUFq1xf2sdTn5GoLMKtq5mFkNAk9pmXIFeJzaqCa8yyEA6+mfJWFRaG3
         A1XZBUgHq0Qoy4PRi5WSJ2HNQxWaYhrGmZ7lIYS1ItDi1aDwCi21cWwsY1/De8AktcwZ
         OzMkrPYA9/9n8BuQWlgShWy/74rpeK/hVUj4+/CvWI7e9nODV0sbAJGoZUU2D0B0MfvR
         5llQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=ReIQwhagC9wVx7XWKttziwoRAX3M5nQznQBo7fdMD2Q=;
        b=rMdiTHB87+4QfcK1urZIWnmmo8RxPNidAXtGItSCL/mqpDu6kshr+orROApX828Z6J
         mOW6vR/9/1oUdHUYvBAJyzkRyZ88Eh1xEkhRj3WCTQA47/hiy1bQOVjfJSf3Y9f8Fmug
         5tbSjsuPMVEPOQAkNiNNG2vIdY3Dy5XA6hBqc/yrss8oPEVlWyuc4zWmoRjbvByoRQZd
         J3bm/LWZRueac5akDWjXDe260jAgGKc8eG2Q3OCV0bPeNJFv/lmphi+utqEiwa0lLA4i
         q1vsW2NsESJZUqab0R4lkLRf8JZnTi88UoT1Ix25ZtI0buoC/kT6ls0qG8eku40UEfkY
         Q0qw==
X-Gm-Message-State: AOAM531Q8S5O7ITOR6zLdP5UfPkNsWO67BxvmR7yBhD5XvphDmD71mXa
        C1nJhHh7pxpLVDHrSAaih0RczMGknZjBuLXclYmz
X-Google-Smtp-Source: ABdhPJy+U65dK5o4XbcuRLj318FUOC3f64nB+DTCL1gddj8TxlWry6iov0iTd7nsp43OOgPhBobjuuF6GjIYX2/rh5xq
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:f308:: with SMTP id
 ca8mr5102796pjb.222.1644533501028; Thu, 10 Feb 2022 14:51:41 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:51:37 -0800
In-Reply-To: <20220210044152.78352-8-chooglen@google.com>
Message-Id: <20220210225137.688066-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH 7/8] fetch: fetch unpopulated, changed submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> submodule.c has a seemingly-unrelated change that teaches the "find
> changed submodules" rev walk to call is_repository_shallow(). This fixes
> what I believe is a legitimate bug - the rev walk would fail on a
> shallow repo.
> 
> Our test suite did not catch this prior to this commit because we skip
> the rev walk if .gitmodules is not found, and thus the test suite did
> not attempt the rev walk on a shallow clone. After this commit,
> we always attempt to find changed submodules (regardless of whether
> there is a .gitmodules file), and the test suite noticed the bug.

Is this bug present without the other code introduced in this patch? If
yes, it's better to put the bugfix in a separate patch with a test that
would have failed but now passes.

Some more high-level comments:

> @@ -1273,10 +1277,6 @@ static void calculate_changed_submodule_paths(struct repository *r,
>  	struct strvec argv = STRVEC_INIT;
>  	struct string_list_item *name;
>  
> -	/* No need to check if there are no submodules configured */
> -	if (!submodule_from_path(r, NULL, NULL))
> -		return;

I think this is removed because "no submodules configured" here actually
means "no submodules configured in the index", but submodules may be
configured in the superproject commits we're fetching.

I wonder if this should be mentioned in the commit message, but I'm OK
either way.

>  struct submodule_parallel_fetch {
> -	int count;
> +	int index_count;
> +	int changed_count;

Here (and elsewhere) we're checking both the index and the superproject
commits for .gitmodules. Do we still need to check the index?

> @@ -1495,6 +1499,15 @@ get_fetch_task(struct submodule_parallel_fetch *spf,
>  		if (!task)
>  			continue;
>  
> +		/*
> +		 * We might have already considered this submodule
> +		 * because we saw it when iterating the changed
> +		 * submodule names.
> +		 */
> +		if (string_list_lookup(&spf->seen_submodule_names,
> +				       task->sub->name))
> +			continue;

[snip]
> +		/*
> +		 * We might have already considered this submodule
> +		 * because we saw it in the index.
> +		 */
> +		if (string_list_lookup(&spf->seen_submodule_names, item.string))
> +			continue;

Hmm...it's odd that the checks happen in both places, when theoretically
we would do one after the other, so this check would only need to be in
one place. Maybe this is because of how we had to implement it (looping
over everything every time when we get the next fetch task) but if it's
easy to avoid, that would be great.

> +# Cleans up after tests that checkout branches other than the main ones
> +# in the tests.
> +checkout_main_branches() {
> +	git -C downstream checkout --recurse-submodules super &&
> +	git -C downstream/submodule checkout --recurse-submodules sub &&
> +	git -C downstream/submodule/subdir/deepsubmodule checkout --recurse-submodules deep
> +}

If we need to clean up in this way, I think it's better if we store a
pristine copy somewhere (e.g. pristine-downstream), delete downstream,
and copy it over when we need to.

> +# Test that we can fetch submodules in other branches by running fetch
> +# in a branch that has no submodules.
> +test_expect_success 'setup downstream branch without submodules' '
> +	(
> +		cd downstream &&
> +		git checkout --recurse-submodules -b no-submodules &&
> +		rm .gitmodules &&
> +		git rm submodule &&
> +		git add .gitmodules &&
> +		git commit -m "no submodules" &&
> +		git checkout --recurse-submodules super
> +	)
> +'

The tip of the branch indeed doesn't have any submodules, but when
fetching this branch, we might end up fetching some of the tip's
ancestors (depending on the repo we're fetching into), which do have
submodules. If we need a branch without submodules, I think that all
ancestors should not have submodules too.

That might be an argument for creating our own downstream and upstream
repos instead of reusing the existing ones.

> +test_expect_success "'--recurse-submodules=on-demand' should fetch submodule commits if the submodule is changed but the index has no submodules" '
> +	test_when_finished "checkout_main_branches" &&
> +	git -C downstream fetch --recurse-submodules &&
> +	# Create new superproject commit with updated submodules
> +	add_upstream_commit &&
> +	(
> +		cd submodule &&
> +		(
> +			cd subdir/deepsubmodule &&
> +			git fetch &&

Hmm...I thought submodule/subdir/deepsubmodule is upstream. Why is it
fetching?

> +	# Fetch the new superproject commit
> +	(
> +		cd downstream &&
> +		git switch --recurse-submodules no-submodules &&
> +		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err &&
> +		git checkout --recurse-submodules origin/super 2>../actual-checkout.err

This patch set is about fetching, so the checkout here seems odd. To
verify that the fetch happened successfully, I think that we should
obtain the hashes of the commits that we expect to be fetched from
upstream, and then verify that they are present downstream.

> +	# Assert that we can checkout the superproject commit with --recurse-submodules
> +	! grep -E "error: Submodule .+ could not be updated" actual-checkout.err

Negative greps are error-prone, since they will also appear to work if
the message was just misspelled. We should probably check that the
expected commit is present instead.

> +# Test that we properly fetch the submodules in the index as well as
> +# submodules in other branches.
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

I couldn't see the submodule in the index to be fetched; maybe it's
there somewhere but it's not obvious to me. Also, why do we
need to run "git submodule update"? This patch set concerns itself with
fetching existing submodules, not cloning new ones.

> +test_expect_success "'--recurse-submodules' should fetch submodule commits in changed submodules and the index" '

Same comment about where in the index is the submodule to be fetched.
