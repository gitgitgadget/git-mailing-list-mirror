Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054C3ECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 20:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiIAUAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 16:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiIAUAw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 16:00:52 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF0A83F0D
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 13:00:50 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id s129-20020a632c87000000b00411564fe1feso36933pgs.7
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date;
        bh=jHL4fiR6uIrLBOZu+AcPchQapC19DTftmSkNPvgeCvw=;
        b=XKPODoYoxWUs7+5FsMb/4+vPsJ1eB8cECobim++n/RqUvhHGStQ2cXQ3ev+uvdgM+4
         c7e2PFn8oyIPmdGWXQrPBHPdj1UQLRWdXmDt4JpB/61zAIDASnO7pjpt5MBiqdk/3d1E
         BIP9PypfFnezr8B3q1wd+MUbVvCRqIqKF0AVB+tRnjpf3YB9LnErCdPesVGp4/950rru
         YXyLIu0cRkCnDSypR5OeEPoVylqW2iFEEwEVrEoYQGPA2hXXFHQ84+DwagHfl8c4nQ/i
         HQMqfs+Y8vti+cgPjwecq31xLtL8JBtNHJdaaSBGzcl1cxpMC58G80DCtaCuAB7xxyYS
         OLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jHL4fiR6uIrLBOZu+AcPchQapC19DTftmSkNPvgeCvw=;
        b=W9Z/mq9DIx0L1TeqcWBUi2gBRjBQrSw5YkbCiN/XwSTXh7BGZigL+WneyRqMOeYrh7
         Ya9zh+116r2vh1jlXAFiAHeCYbYMPTw5/cmAIdyic9x0ziIT0vMA4FUbwOWS/6HE2Fkp
         BwTUG74SvyrbMd/zLipURIEezr2L0o+rzJ6k1N9QmspHI0B3nOKiNDuae4sKY1xtvtBf
         JBP062Zpt+zf6jf/lwdP+iD6kG+8upgQgO0N23m/+HhZwtDOCdiGZFyOBNCDRz6L9J84
         m16gIX/DeT7TrFfq9xp2GE8PqHiiiheUNW457bhYBdbsgnvzJbZBEKrOqntN5LExjRMk
         6otA==
X-Gm-Message-State: ACgBeo0l21l59HZg1yekbbZi+xD3ZJJF8jzz0tl3YTaS7MasRuL3ebJV
        RE4Z15NwKMqiM3j+PNXOnvPaFy5RaBFshRQlZ9Cf
X-Google-Smtp-Source: AA6agR4CLgDB49SH21eL37XiRoKznqW2HWaDgbWd5bB2HKYpcUgfQ7ONnQdTjGidtU/xOosAWAo9+2y3ITAhGCr3hoNE
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:c945:b0:16d:c318:4480 with
 SMTP id i5-20020a170902c94500b0016dc3184480mr32492125pla.147.1662062450426;
 Thu, 01 Sep 2022 13:00:50 -0700 (PDT)
Date:   Thu,  1 Sep 2022 13:00:47 -0700
In-Reply-To: <6f7f2f9a3f19b6d874d644b7fb7feb3a72fc6227.1661806456.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901200047.515294-1-jonathantanmy@google.com>
Subject: Re: [PATCH 6/6] clone, submodule update: check out branches
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Glen Choo <chooglen@google.com>
> 
> Teach "git submodule update" to update submodules by creating and
> checking out the current superproject branch when
> "submodule.propagateBranches=true".

"git submodule update" already knows how to update submodules; probably
better to say:

  Teach "git submodule update" to create and check out a branch of the
  same name as the current superproject branch when updating a submodule
  if "submodule.propagateBranches=true" is set on the superproject.

> With "submodule.propagateBranches=true", submodules are cloned with
> "--detach" so that they do not contain branches from their upstream.
> This prevents conflicts between branch names from the superproject and
> the branch names from the submodule's upstream. Arguably, "--detach"
> should also be the default for "submodule.propagateBranches=false"
> since it doesn't make sense to create a submodule branch when the
> submodule is always expected to be in detached HEAD.

This paragraph made me think of the use case in which we cloned a
submodule-using repo, made a commit in a submodule (thus advancing a
branch) without a corresponding commit in a superproject, and then
recloned our clone, hoping that the state will persist. It would not
persist, but as stated here, the existing behavior is already that
branches in submodules are not cloned, so retaining this existing
behavior is not a problem.

> "git submodule update" tries to create the branch as long as it is not
> currently checked out, thus it will fail if the submodule has the
> branch, but it is not checked out. This is fine because the main purpose
> of "git submodule update" is to clone new submodules (which have no
> branches, and will never have this problem). "git checkout" with
> "submodule.propagateBranches" will cover the use case of recursively
> checking out an existing branch.

In regular usage, the user will, as you say, run "git checkout". So when
"git submodule update" is run, a submodule will either have no branches
(because it was just cloned or because we have never switched to that
branch before in the superproject) or it will have the correct branch
already checked out, so it would already be considered up to date (no
matter whether the commit matches with the superproject's gitlink: only
the name of the branch matters).

I'm concerned about the case in which the user, say, has created a
branch in a submodule for some reason. E.g.:

  (cd sub; git branch my-branch)
  git checkout my-branch

so this would fail because we wouldn't be able to create "my-branch" in
the "sub" submodule. We might need a message explaining what can be done
to fix this situation, but for now, maybe a NEEDSWORK will suffice.

> @@ -2206,6 +2214,8 @@ static int run_update_command(struct update_data *ud, int subforce)
>  		strvec_pushl(&cp.args, "checkout", "-q", NULL);
>  		if (subforce)
>  			strvec_push(&cp.args, "-f");
> +		if (ud->super_branch)
> +			strvec_pushl(&cp.args, "-b", ud->super_branch, NULL);

Here is where the NEEDSWORK would go.

> @@ -106,4 +113,31 @@ test_expect_success '--no-also-filter-submodules overrides clone.filterSubmodule
>  	test_cmp_config -C super_clone3/sub false --default false remote.origin.promisor
>  '
>  
> +test_expect_success 'submodule.propagateBranches checks out branches at correct commits' '
> +	git -C sub checkout -b not-main &&
> +	git -C subsub checkout -b not-main &&
> +	git clone --recurse-submodules \
> +		-c submodule.propagateBranches=true \
> +		"file://$pwd/." super_clone4 &&
> +
> +	# Assert that each repo is pointing to "main"
> +	for REPO in "super_clone4" "super_clone4/sub" "super_clone4/sub/subsub"
> +	do
> +	    HEAD_BRANCH=$(git -C $REPO symbolic-ref HEAD) &&
> +	    test $HEAD_BRANCH = "refs/heads/main" || return 1
> +	done &&
> +
> +	# Assert that the submodule branches are pointing to the right revs
> +	EXPECT_SUB_OID="$(git -C super_clone4 rev-parse :sub)" &&
> +	ACTUAL_SUB_OID="$(git -C super_clone4/sub rev-parse refs/heads/main)" &&
> +	test $EXPECT_SUB_OID = $ACTUAL_SUB_OID &&
> +	EXPECT_SUBSUB_OID="$(git -C super_clone4/sub rev-parse :subsub)" &&
> +	ACTUAL_SUBSUB_OID="$(git -C super_clone4/sub/subsub rev-parse refs/heads/main)" &&
> +	test $EXPECT_SUBSUB_OID = $ACTUAL_SUBSUB_OID &&
> +
> +	# Assert that the submodules do not have branches from their upstream
> +	test_must_fail git -C super_clone4/sub rev-parse not-main &&
> +	test_must_fail git -C super_clone4/sub/subsub rev-parse not-main
> +'

Instead of reusing "main", can we use a branch name that exists in the
superproject but not the submodule? Here, we cannot tell the difference
between git reusing the referent of submodule's "main" versus git using
the gitlink in superproject's "main".

I'll write some more comments on the other patches, but overall this
patch set makes sense to me.
