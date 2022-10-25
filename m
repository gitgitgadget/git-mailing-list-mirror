Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A29FA373E
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 17:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiJYR4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiJYR4d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 13:56:33 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6BFDDA0D
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 10:56:32 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q63-20020a632a42000000b0045724b1dfb9so6614746pgq.3
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQsThiuYO2yRpz66AYzdKZikWxn3YIJKgXe2z0qOGgc=;
        b=AAQE8dZsvxfC+RjgJfkHaf047s5OHLXaQZ+5TG5WkueVvFF+GQIfjUMWHJk3QC1IEA
         M9KUze2W0t0HJrqLxd6pmtO/55cbbPnWndKePUMqvK3bPxdANnYXfRclZKqN8B+BR2DQ
         Ba5pwxwfL7Z1bMKzX4hNBSMBTkt9mSbuFIQ1yv0pT9JC7SrzxQi1EAFoutEut749AriV
         bbD9QMaRltW63ifJJ2b45MXoVgLGZudGwoHJr+hLcm5BR8a9699m1DfzUE5wwRR5R9rS
         K/GwnfnT4um8682bUn8iiGXdnomXS6DuDwtMG7NeBX7G/hBefotrYSTVnl9QTOp1oHrq
         W79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQsThiuYO2yRpz66AYzdKZikWxn3YIJKgXe2z0qOGgc=;
        b=AEMIQV9Tq7wxuGs/KQd6o8CjM2WsonhU5l8s1/BFSeUW7li2tC0CHyGQQn0hH8xLv7
         2rcs7RYMWXi8MkNd3S+XhY8gb//eFRw3FxxxNVYqLOsMgYE40ffsUmYUVPmFK92fjvFO
         NUGKZI/b/tzHpgJvosgVPtWSjtZzZut5GqhWP7m7tW6hxBdOHEKa2WWf0nV8bI+QhioO
         PJ4JLfuBCRnnXuOmkF4urivnMZe76vI8/m2APsoF2QEtF8WyqGDMH1V4n3M8YEC0P4ww
         opNTNHpQQxVcQbxh2US9dCY542PLZsoxRVGkaoieF3yfj+H4HxeE+c6vov2Mu2OTbCBL
         k7Xg==
X-Gm-Message-State: ACrzQf13Elts/RzQaZqv6CZzJpOaO2ozZZ5HqgvzBmHLY/NqpLIMRnlX
        aq5TVxW8NcAzPfP9InvXr5NuEXUMmb6AKaaHja/O
X-Google-Smtp-Source: AMsMyM7KbGhYPrPkGObvxy4HQ3sk85Knb9do6iak8IXAVIbkfa3n1+1wmnoXaVxKDqZ0E/ls1IOlIiUqY8jys4uYA6oA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:4811:b0:20a:fee1:8f69 with
 SMTP id a17-20020a17090a481100b0020afee18f69mr4397294pjh.0.1666720591952;
 Tue, 25 Oct 2022 10:56:31 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:56:27 -0700
In-Reply-To: <3f98b0d17397dbce85aa87a9591981c790f8f7a2.1666297239.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221025175628.913542-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 7/7] clone, submodule update: create and check out branches
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
> Teach "git submodule update" to:
> 
> - create the branch with the same name as the current superproject
>   branch when cloning a submodule

Ah, this is when "git submodule update" needs to clone a submodule (as 
opposed to doing something with a submodule that is already cloned). 

> - check out that branch (instead of the commit OID) when updating
>   the submodule worktree

So whenever we run "git submodule update" and a submodule already has a 
branch of the same name as what's currently checked out in the 
superproject, we check out the submodule's branch, ignoring the gitlink 
in the superproject? 

> when submodule branching is enabled (submodule.propagateBranches = true)
> on the superproject and a branch is checked out. 

OK.

> "git clone
> --recurse-submodules" also learns this trick because it is implemented
> with "git submodule update --recursive".

Is this sentence redundant now that you're specifically calling out the 
cloning part above?

> This approach of checking out the branch will not result in a dirty
> worktree for freshly cloned submodules because we can ensure that the
> submodule branch points to the superproject gitlink. 

Makes sense.

> In other cases, it
> does not work as well, but we can handle them incrementally:
> 
> - "git pull --recurse-submodules" merges the superproject tree (without
>   updating the submodule branches), and runs "git submodule update" to
>   update the worktrees, so it is almost guaranteed to result in a dirty
>   worktree.

Is this because when we "git pull", the superproject likely now has a 
different gitlink, but the branch in the submodule hasn't changed? 

>   The implementation of "git pull --recurse-submodules" is likely to
>   change drastically as submodule.propagateBranches work progresses
>   (e.g. "git merge" learns to recurse in to submodules), and we may be
>   able to replace the "git submodule update" invocation, or teach it new
>   tricks that make the update behave well.
> 
> - The user might make changes to the submodule branch without committing
>   them back to superproject. This is primarily affects "git checkout
>   --recurse-submodules", since that is the primary way of switching away
>   from a branch and leaving behind WIP (as opposed to "git submodule
>   update", which is run post-checkout).

Makes sense - so in summary, there are (at least) two ways of the 
superproject's gitlink and the submodule's branch can go out of sync: 
the user changing the submodule branch (here) or the user changing the 
superproject's gitlink (above). 
 
>   In a future series, "git checkout --recurse-submodules" will learn to
>   consider submodule branches. We can introduce appropriate guardrails
>   then, e.g. requiring that the superproject working tree is not dirty
>   before switching away.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>

[snip]

> @@ -2521,6 +2532,7 @@ static int update_submodule(struct update_data *update_data)
>  {
>  	int submodule_up_to_date;
>  	int ret;
> +	const char *submodule_head = "HEAD";

I think it's clearer if this is initialized to NULL. I don't think the 
submodule head is detached in all code paths when this is HEAD.  

>  	ret = determine_submodule_update_strategy(the_repository,
>  						  update_data->just_cloned,
> @@ -2533,7 +2545,7 @@ static int update_submodule(struct update_data *update_data)
>  	if (update_data->just_cloned)
>  		oidcpy(&update_data->suboid, null_oid());
>  	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
> -				     &update_data->suboid, NULL))
> +				     &update_data->suboid, &submodule_head))
>  		return die_message(_("Unable to find current revision in submodule path '%s'"),
>  				   update_data->displaypath);
>  
> @@ -2568,7 +2580,14 @@ static int update_submodule(struct update_data *update_data)
>  		free(remote_ref);
>  	}
>  
> -	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
> +	if (!update_data->super_branch)
> +		submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
> +	else if (skip_prefix(submodule_head, "refs/heads/", &submodule_head))
> +		submodule_up_to_date = !strcmp(update_data->super_branch, submodule_head);
> +	/* submodule_branch is "HEAD"; the submodule is in detached HEAD */
> +	else
> +		submodule_up_to_date = 0;

I think there needs to be a better comment here. It doesn't matter that 
the submodule is in detached HEAD; what matters is that the submodule 
doesn't have the superproject's branch checked out. So maybe something 
like: 

  if (update_data->super_branch) {
    /* (format this appropriately) We also need to check that the 
       submodule's HEAD points to super_branch. */ 
    const char *submodule_head;
    submodule_up_to_date = skip_prefix(...) && !strcmp(...)
  } else {
    submodule_up_to_date = oideq(...)
  }

> diff --git a/t/t5617-clone-submodules.sh b/t/t5617-clone-submodules.sh

[snip]

> @@ -107,4 +114,31 @@ test_expect_success '--no-also-filter-submodules overrides clone.filterSubmodule
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

As I said in my earlier review [1], could we use a branch name that is 
not  "main"? That way, we also check that the clone *creates* the 
branches,  not just reuses something already there. 

[1] https://lore.kernel.org/git/20220901200047.515294-1-jonathantanmy@google.com/

> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh

[snip]

> +test_expect_success 'submodule.propagateBranches - detached HEAD' '
> +	test_when_finished "rm -fr branch-super-cloned" &&
> +	cp -r branch-super-clean branch-super-cloned &&
> +
> +	git -C branch-super-cloned checkout --detach &&
> +	git -C branch-super-cloned pull origin main &&

If the behavior of "pull" is going to change soon (as stated in the 
commit message), can we avoid using it in tests here? 

> +	git -C branch-super-cloned submodule update &&
> +
> +	# sub2 should be in detached HEAD
> +	git -C branch-super-cloned/sub2 rev-parse --verify HEAD &&
> +	test_must_fail git -C branch-super-cloned/sub2 symbolic-ref HEAD
> +'
> +
> +test_expect_success 'submodule.propagateBranches - branch checked out' '
> +	test_when_finished "rm -fr branch-super-cloned" &&
> +	cp -r branch-super-clean branch-super-cloned &&
> +
> +	git -C branch-super-cloned branch --recurse-submodules new-branch &&
> +	git -C branch-super-cloned checkout --recurse-submodules new-branch &&
> +	git -C branch-super-cloned pull origin main &&
> +	git -C branch-super-cloned submodule update &&
> +
> +	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
> +	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
> +	HEAD_BRANCH2=$(git -C branch-super-cloned/sub2 symbolic-ref HEAD) &&
> +	test $HEAD_BRANCH2 = "refs/heads/new-branch"

I'm not sure of the behavior of "pull" here, so I didn't look too  
closely into what these tests test, but I think that you should cover 
these situations: 
 - submodule has correct OID and correct branch checked out
 - submodule has correct OID, but wrong branch checked out, and correct 
   branch doesn't exist 
 - submodule has correct OID, but wrong branch checked out, and correct 
   branch exists at correct OID 
 - submodule has correct OID, but wrong branch checked out, and correct 
   branch exists at wrong OID 
 - submodule has incorrect OID but correct branch checked out (if this 
   currently doesn't work, maybe add a test_must_fail with a NEEDSWORK) 

There are other combinations but I think these are the most important 
ones. 

Also, if there is a situation where you ignore the superproject's 
gitlink in favor of the submodule's branch, you should check the OIDs 
in all cases too, not just what the HEAD symbolic ref points to. 
