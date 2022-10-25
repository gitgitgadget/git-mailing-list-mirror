Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6747BFA373D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 21:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiJYVtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 17:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiJYVtX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 17:49:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CD4CBFDC
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 14:49:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p66-20020a257445000000b006ca0ba7608fso13102746ybc.7
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 14:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUk+p2v27/qSYExrG9qWIJQlpTCYZ15M9ZMNn4qwbxM=;
        b=ERhBqzwRzS17U8n3FVkAqqgtdjM1wWzlXb9XqOncAlXukeWOwG2A/iOt+ReYfalAXJ
         ts0Dki++xWrvAw23I2ltjt33vWgXOe/x7FV35Z1ALi3u+ug76qAS4IWhhbBNBcQLiR47
         rg4aODbkK7h0gPsb+VqIhTHTb2j5MKsYN1uqsYzr52T7mIkT6UcK0PlXlsGOFl3I+Trv
         Gf/XmvXSXsTJhq36pGam8k1ih4vte0uxmukzD2pD3jv0lTAbV5B1hVL7G4vaafrf5aEr
         wQ718NTlhS5XEUZK8L8j8crsBUdM6bUyuInHygAtJtHC2YnPmxAGz9LuGFJQetyNmCzS
         RMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUk+p2v27/qSYExrG9qWIJQlpTCYZ15M9ZMNn4qwbxM=;
        b=SItZJNrvCNfNunGGFj2BGJ3hIf6hUPZxy2bWTj2PjSy6aaX8rf9XKCbSCpM782tc8U
         r7dZZqgqy+dyN6Qv/gmibqHiqk1if/geWkZPVpk/MV5RBD0Cm3l03PWTrFsN/N8NHfko
         nGWyRrcZcUofG/KhsQWQ90qt99sTflKkKDK8j1ZP/NPPnQ2G1++YD6Wg5UyuoUzxiW6G
         B+qPtIVexzEqY5JjCt9UMi3BPbFAOUlaqvMKMYs/GoaCuihQFfQrsljZRgjVGOvFm+01
         4dRNoudrc5z62Uz2/bLb/raZEipJZigFmcvQ51vOf8nOjN7MP6tm6VN1U2fbD6tFf5Ls
         3LxQ==
X-Gm-Message-State: ACrzQf38fJ74w1SUWwavYKpPyahf70zyBqL3aXu724IgD09BHQLnOQ+G
        Q0wTFpKL0WOzpIJV6a3tJABSTCnIlCcVhA==
X-Google-Smtp-Source: AMsMyM7VZxj7CPoA5qK1QUT9EL/7xlsyhdSZ8YybRA14JrLgOVrGehx5mqwB5cQAdwOrLEUKKeM5tB4D/01vTA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:be10:0:b0:36b:9724:3458 with SMTP id
 i16-20020a81be10000000b0036b97243458mr0ywn.25.1666734560596; Tue, 25 Oct 2022
 14:49:20 -0700 (PDT)
Date:   Tue, 25 Oct 2022 14:49:19 -0700
In-Reply-To: <20221025175628.913542-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20221025175628.913542-1-jonathantanmy@google.com>
Message-ID: <kl6ltu3rr2u8.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 7/7] clone, submodule update: create and check out branches
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> Teach "git submodule update" to:
>> 
>> - create the branch with the same name as the current superproject
>>   branch when cloning a submodule

[...]
>> - check out that branch (instead of the commit OID) when updating
>>   the submodule worktree

[...]
>> when submodule branching is enabled (submodule.propagateBranches = true)
>> on the superproject and a branch is checked out. 
>> "git clone
>> --recurse-submodules" also learns this trick because it is implemented
>> with "git submodule update --recursive".
>
> Is this sentence redundant now that you're specifically calling out the 
> cloning part above?

Not quite. The "trick" I'm referring to is "clone, create the
named branch and check it out", which is implemented by "git submodule
update" (and its constituent subprocesses, e.g. "git submodule clone"),
so it is pertinent that "git clone" is implemented by "git submodule
update".

>> In other cases, it
>> does not work as well, but we can handle them incrementally:
>> 
>> - "git pull --recurse-submodules" merges the superproject tree (without
>>   updating the submodule branches), and runs "git submodule update" to
>>   update the worktrees, so it is almost guaranteed to result in a dirty
>>   worktree.
>
> Is this because when we "git pull", the superproject likely now has a 
> different gitlink, but the branch in the submodule hasn't changed? 

Yes. That sounds like a clarification I should make in v3.

>>   The implementation of "git pull --recurse-submodules" is likely to
>>   change drastically as submodule.propagateBranches work progresses
>>   (e.g. "git merge" learns to recurse in to submodules), and we may be
>>   able to replace the "git submodule update" invocation, or teach it new
>>   tricks that make the update behave well.
>> 
>> - The user might make changes to the submodule branch without committing
>>   them back to superproject. This is primarily affects "git checkout
>>   --recurse-submodules", since that is the primary way of switching away
>>   from a branch and leaving behind WIP (as opposed to "git submodule
>>   update", which is run post-checkout).
>
> Makes sense - so in summary, there are (at least) two ways of the 
> superproject's gitlink and the submodule's branch can go out of sync: 
> the user changing the submodule branch (here) or the user changing the 
> superproject's gitlink (above). 

Yes. I didn't mention modifying the superproject's gitlink (outside of
"git pull"), but I imagine that it would use the same guardrail I
mentioned here. I could add mention of it if that seems useful.

>  
>>   In a future series, "git checkout --recurse-submodules" will learn to
>>   consider submodule branches. We can introduce appropriate guardrails
>>   then, e.g. requiring that the superproject working tree is not dirty
>>   before switching away.
>> 
>> Signed-off-by: Glen Choo <chooglen@google.com>
>
> [snip]
>
>> @@ -2521,6 +2532,7 @@ static int update_submodule(struct update_data *update_data)
>>  {
>>  	int submodule_up_to_date;
>>  	int ret;
>> +	const char *submodule_head = "HEAD";
>
> I think it's clearer if this is initialized to NULL. I don't think the 
> submodule head is detached in all code paths when this is HEAD.  

Ok, I'll initialize to NULL since refs_resolve_ref_unsafe() can return
NULL. I'm quite convinced that it only returns NULL in the error case
though (and we need to handle that explicitly), otherwise detached HEAD
always results in HEAD.

>
>>  	ret = determine_submodule_update_strategy(the_repository,
>>  						  update_data->just_cloned,
>> @@ -2533,7 +2545,7 @@ static int update_submodule(struct update_data *update_data)
>>  	if (update_data->just_cloned)
>>  		oidcpy(&update_data->suboid, null_oid());
>>  	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
>> -				     &update_data->suboid, NULL))
>> +				     &update_data->suboid, &submodule_head))
>>  		return die_message(_("Unable to find current revision in submodule path '%s'"),
>>  				   update_data->displaypath);
>>  
>> @@ -2568,7 +2580,14 @@ static int update_submodule(struct update_data *update_data)
>>  		free(remote_ref);
>>  	}
>>  
>> -	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
>> +	if (!update_data->super_branch)
>> +		submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
>> +	else if (skip_prefix(submodule_head, "refs/heads/", &submodule_head))
>> +		submodule_up_to_date = !strcmp(update_data->super_branch, submodule_head);
>> +	/* submodule_branch is "HEAD"; the submodule is in detached HEAD */
>> +	else
>> +		submodule_up_to_date = 0;
>
> I think there needs to be a better comment here. It doesn't matter that 
> the submodule is in detached HEAD; what matters is that the submodule 
> doesn't have the superproject's branch checked out. So maybe something 
> like: 
>
>   if (update_data->super_branch) {
>     /* (format this appropriately) We also need to check that the 
>        submodule's HEAD points to super_branch. */ 
>     const char *submodule_head;
>     submodule_up_to_date = skip_prefix(...) && !strcmp(...)
>   } else {
>     submodule_up_to_date = oideq(...)
>   }
>

I see, thanks for the suggestion.

>> diff --git a/t/t5617-clone-submodules.sh b/t/t5617-clone-submodules.sh
>
> [snip]
>
>> @@ -107,4 +114,31 @@ test_expect_success '--no-also-filter-submodules overrides clone.filterSubmodule
>>  	test_cmp_config -C super_clone3/sub false --default false remote.origin.promisor
>>  '
>>  
>> +test_expect_success 'submodule.propagateBranches checks out branches at correct commits' '
>> +	git -C sub checkout -b not-main &&
>> +	git -C subsub checkout -b not-main &&
>> +	git clone --recurse-submodules \
>> +		-c submodule.propagateBranches=true \
>> +		"file://$pwd/." super_clone4 &&
>> +
>> +	# Assert that each repo is pointing to "main"
>> +	for REPO in "super_clone4" "super_clone4/sub" "super_clone4/sub/subsub"
>> +	do
>> +	    HEAD_BRANCH=$(git -C $REPO symbolic-ref HEAD) &&
>> +	    test $HEAD_BRANCH = "refs/heads/main" || return 1
>> +	done &&
>
> As I said in my earlier review [1], could we use a branch name that is 
> not  "main"? That way, we also check that the clone *creates* the 
> branches,  not just reuses something already there. 
>
> [1] https://lore.kernel.org/git/20220901200047.515294-1-jonathantanmy@google.com/

Ah I missed that, thanks.

>
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>
> [snip]
>
>> +test_expect_success 'submodule.propagateBranches - detached HEAD' '
>> +	test_when_finished "rm -fr branch-super-cloned" &&
>> +	cp -r branch-super-clean branch-super-cloned &&
>> +
>> +	git -C branch-super-cloned checkout --detach &&
>> +	git -C branch-super-cloned pull origin main &&
>
> If the behavior of "pull" is going to change soon (as stated in the 
> commit message), can we avoid using it in tests here? 

Here I've omitted "--recurse-submodules", so this is a shorthand for
"update the superproject's HEAD to the remote's main". This behavior
isn't going to change, but perhaps I shouldn't rely on such subtleties
in test code (where readability is paramount).

>
>> +	git -C branch-super-cloned submodule update &&
>> +
>> +	# sub2 should be in detached HEAD
>> +	git -C branch-super-cloned/sub2 rev-parse --verify HEAD &&
>> +	test_must_fail git -C branch-super-cloned/sub2 symbolic-ref HEAD
>> +'
>> +
>> +test_expect_success 'submodule.propagateBranches - branch checked out' '
>> +	test_when_finished "rm -fr branch-super-cloned" &&
>> +	cp -r branch-super-clean branch-super-cloned &&
>> +
>> +	git -C branch-super-cloned branch --recurse-submodules new-branch &&
>> +	git -C branch-super-cloned checkout --recurse-submodules new-branch &&
>> +	git -C branch-super-cloned pull origin main &&
>> +	git -C branch-super-cloned submodule update &&
>> +
>> +	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
>> +	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
>> +	HEAD_BRANCH2=$(git -C branch-super-cloned/sub2 symbolic-ref HEAD) &&
>> +	test $HEAD_BRANCH2 = "refs/heads/new-branch"
>
> I'm not sure of the behavior of "pull" here, so I didn't look too  
> closely into what these tests test, but I think that you should cover 
> these situations: 
>  - submodule has correct OID and correct branch checked out
>  - submodule has correct OID, but wrong branch checked out, and correct 
>    branch doesn't exist 
>  - submodule has correct OID, but wrong branch checked out, and correct 
>    branch exists at correct OID 
>  - submodule has correct OID, but wrong branch checked out, and correct 
>    branch exists at wrong OID 
>  - submodule has incorrect OID but correct branch checked out (if this 
>    currently doesn't work, maybe add a test_must_fail with a NEEDSWORK) 
>
> There are other combinations but I think these are the most important 
> ones. 
>
> Also, if there is a situation where you ignore the superproject's 
> gitlink in favor of the submodule's branch, you should check the OIDs 
> in all cases too, not just what the HEAD symbolic ref points to. 

Makes sense. Thanks for the thorough review :)
