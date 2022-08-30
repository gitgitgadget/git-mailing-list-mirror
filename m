Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7D0ECAAD5
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 04:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiH3EDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 00:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH3EDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 00:03:15 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1A5AB049
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 21:03:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id cb8so7729326qtb.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 21:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=4V7icsrh3wJMEd7fcs8NPXhwvT5kAUL5U72Zric/Vuo=;
        b=o5O9i5PNAUm+tTHS2HvwZ/lU9AIjA8FyJgIujNEDwth565lnzI2YoRu64OgLodQm9p
         khXlzoHOcfsYOBQGppEg0gVfVmbXC1DtgN+48/yka4XBc0EbO1Bhys9iFhH6SYO1de6s
         nwFbjlbZ+ZQ4UMxCjawDfvWzSxxPQ/s4MQXyLszONeLmsuOB0gC+pNyse1zFXhJQ/QvH
         CgYZ7CyI6I4S/FZ5MUGUXMlFM0wST7hcB7Av5ZX2bQuo6uLaUC8BjMNE2Ddrqg1cbGwd
         XnDEAWSKUuRrWYBm5V4blm/fIuLrtXWKll5LK1t3uwKBjbodnLzK8+/WpYs0KZKIA4rM
         UeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=4V7icsrh3wJMEd7fcs8NPXhwvT5kAUL5U72Zric/Vuo=;
        b=vdXFQhMCWvdthLHNK9Yy325ULT2bzJCaJe0OWlJgGfwOwGs+gifw2zOATzO6/9VA4S
         qqXGjeP2TlBmbVFJXDu8E+Yl3UllSM2l6kNSpZQ6QKJmu2FUFBPqR/4tkKbdBMJW+HXo
         WB89JXO0snvkwWpDoEdBg/gByfJk/NIGBd6aqbRDKHp0ySoSWBmA+lKhnObKYVjrpvVv
         IbvhcTbZWZKUk6mqR+pJ6z90VrBBrJLDiKVhkFrm6CH4N9EPOTjMZJT3GNWSc7w1m51j
         JUybQzhUsV6d6r7vNI1PP7IBDp8mB2aUVH8ASl+LAPpLoe9pbsB4eMUbaC9mf+xR/oRF
         i+tw==
X-Gm-Message-State: ACgBeo2JfJ977JWmjCySCUVfHeJHfed6/ztCjwQi7BDCmClOrjGMA5Ox
        Yo2BucDcdx2Ac0elirAr3z8=
X-Google-Smtp-Source: AA6agR703nb/t7T/KnZx7AxfIoq67595Ww6arG6zM9JyQCO+jPvAiUU3WUYex2pDe9kGyFIuJ5HVKw==
X-Received: by 2002:ac8:7d90:0:b0:344:ac48:af55 with SMTP id c16-20020ac87d90000000b00344ac48af55mr13018206qtd.106.1661832192552;
        Mon, 29 Aug 2022 21:03:12 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id z3-20020a05620a260300b006bb024c5021sm6911954qko.25.2022.08.29.21.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 21:03:12 -0700 (PDT)
Subject: Re: [PATCH 6/6] clone, submodule update: check out branches
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
 <6f7f2f9a3f19b6d874d644b7fb7feb3a72fc6227.1661806456.git.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <4e63e180-d275-83c2-d498-47bb0cfd160d@gmail.com>
Date:   Tue, 30 Aug 2022 00:03:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6f7f2f9a3f19b6d874d644b7fb7feb3a72fc6227.1661806456.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2022-08-29 à 16:54, Glen Choo via GitGitGadget a écrit :
> From: Glen Choo <chooglen@google.com>
> 
> Teach "git submodule update" to update submodules by creating and
> checking out the current superproject branch when
> "submodule.propagateBranches=true". "git clone --recurse-submodules"
> also learns this trick because it is implemented with "git submodule
> update --recursive".

OK. Maybe a more descriptive title would then be:

clone, submodule update: create and check out submodule branches

?

Another thing, 'git pull --recurse-submodules' is also implemented using
'git submodule update --recursive'. But I don't think we want 'git pull'
to start creating new branches in submodules, even with submodule.propagateBranches=true
(though I haven't thought about it very hard). So maybe adding a word about
that would be nice.

> 
> With "submodule.propagateBranches=true", submodules are cloned with
> "--detach" so that they do not contain branches from their upstream.

We usually use the present tense to talk about the current state of the code base,
and then the imperative to order to codebase to improve itself;
here you already used the imperative "teach" in the previous paragraph,
so I'm assuming you are now talking about the new state of the code.
Maybe just adding "now" i.e. "submodules are now cloned" would help
readers ?

> This prevents conflicts between branch names from the superproject and
> the branch names from the submodule's upstream. Arguably, "--detach"
> should also be the default for "submodule.propagateBranches=false"
> since it doesn't make sense to create a submodule branch when the
> submodule is always expected to be in detached HEAD. But, to be
> conservative, this commit does not change the behavior of
> "submodule.propagateBranches=false".

I agree that it would be "cleaner" to make the change also for
"submodule.propagateBranches=false" eventually, but... let's not
change things just to change things :)

> "git submodule update" tries to create the branch as long as it is not
> currently checked out, thus it will fail if the submodule has the
> branch, but it is not checked out. This is fine because the main purpose
> of "git submodule update" is to clone new submodules (which have no
> branches, and will never have this problem). "git checkout" with
> "submodule.propagateBranches" will cover the use case of recursively
> checking out an existing branch.

I guess you mean "in a future series" for the last sentence ? FWIW I still have
your RFC from last Febryary about that [1] in my "unread Git mailing list" folder,
I always seem to lack the time to sit down and read it through, sorry!
Incidentally, I notice you did not link to it in the cover letter, 
any reasoon why?

[1] https://lore.kernel.org/git/20220209065236.36494-1-chooglen@google.com/

Stepping back a bit, you write "thus it will fail if the submodule has the
branch, but it is not checked out." If I read your patch correctly, this is
implicit in that 'git checkout -b super-branch' that is ran by 'run_update_command'
will error out if the branch already exists, right ? 

Is there anything more we should do in that case ? 
Should we remind the user, something like
"you have submodule.propagateBranches set, but the branch 'super-branch' already
exists in submodule 'that-sub'" ? 

I'm trying to think of a scenario in which this could happen...

Say a user:
1. clones a superproject with --recurse-submodules, but without 'submodule.propagateBranches'
2. runs 'git checkout -b topic' in the superproject
3. runs 'git branch topic' in the submodule
4. runs 'git submodule update' with 'submodule.propagateBranches' in the superproject

This fails:

fatal: a branch named 'topic' already exists
fatal: Unable to checkout 'deadbeef' in submodule path 'sub'

Do we need a more specific message ? I'm not sure.

> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  builtin/submodule--helper.c | 28 ++++++++++++++++++++++++++--
>  t/t5617-clone-submodules.sh | 34 ++++++++++++++++++++++++++++++++++
>  t/t7406-submodule-update.sh | 22 ++++++++++++++++++++++
>  3 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index cbf6bda4850..7eb2c45900e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1695,6 +1695,9 @@ static int clone_submodule(struct module_clone_data *clone_data)
>  			strvec_push(&cp.args, clone_data->single_branch ?
>  				    "--single-branch" :
>  				    "--no-single-branch");
> +		if (the_repository->settings.submodule_propagate_branches)
> +			strvec_push(&cp.args, "--detach");
> +
>  
>  		strvec_push(&cp.args, "--");
>  		strvec_push(&cp.args, clone_data->url);
> @@ -1733,6 +1736,9 @@ static int clone_submodule(struct module_clone_data *clone_data)
>  	if (error_strategy)
>  		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
>  				       error_strategy);
> +	if (the_repository->settings.submodule_propagate_branches)
> +		git_config_set_in_file(p, "submodule.propagateBranches",
> +				       "true");

Why do we need to set that in the config of the submodule ? I'm guessing this 
is so that the new code also works for nested submodules, right ? 

I'm thinking about a user that would alternate between 'submodule.propagateBranches=true' and 'false'.
Maybe they sometimes have to work on the superproject and the submodule(s), sometimes 
only in the superproject. If they want to deactivate submodule.propagateBranches, would they have to
remember to also deactivate it in all submodules, in case of nested submodules ?...  if so,
this is a little unfortunate. But I _think_ they wouldn't have to, because as long as 
it's false in the superproject config, then we won't get into the new code at all when running
in the top level superproject...

>  	free(sm_alternate);
>  	free(error_strategy);
> @@ -1792,6 +1798,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	memset(&filter_options, 0, sizeof(filter_options));
>  	argc = parse_options(argc, argv, prefix, module_clone_options,
>  			     git_submodule_helper_usage, 0);
> +	prepare_repo_settings(the_repository);
>  
>  	clone_data.dissociate = !!dissociate;
>  	clone_data.quiet = !!quiet;
> @@ -1872,6 +1879,7 @@ struct submodule_update_clone {
>  struct update_data {
>  	const char *prefix;
>  	const char *displaypath;
> +	const char *super_branch;
>  	enum submodule_update_type update_default;
>  	struct object_id suboid;
>  	struct string_list references;
> @@ -2206,6 +2214,8 @@ static int run_update_command(struct update_data *ud, int subforce)
>  		strvec_pushl(&cp.args, "checkout", "-q", NULL);
>  		if (subforce)
>  			strvec_push(&cp.args, "-f");
> +		if (ud->super_branch)
> +			strvec_pushl(&cp.args, "-b", ud->super_branch, NULL);
>  		break;
>  	case SM_UPDATE_REBASE:
>  		cp.git_cmd = 1;
> @@ -2456,6 +2466,7 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
>  static int update_submodule(struct update_data *update_data)
>  {
>  	int submodule_up_to_date;
> +	const char *submodule_head = NULL;
>  
>  	ensure_core_worktree(update_data->sm_path);
>  
> @@ -2469,7 +2480,7 @@ static int update_submodule(struct update_data *update_data)
>  	if (update_data->just_cloned)
>  		oidcpy(&update_data->suboid, null_oid());
>  	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
> -				     &update_data->suboid, NULL))
> +				     &update_data->suboid, &submodule_head))
>  		die(_("Unable to find current revision in submodule path '%s'"),
>  			update_data->displaypath);
>  
> @@ -2493,7 +2504,13 @@ static int update_submodule(struct update_data *update_data)
>  		free(remote_ref);
>  	}
>  
> -	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
> +	if (update_data->super_branch &&
> +	    submodule_head &&
> +	    !skip_prefix(submodule_head, "refs/heads/", &submodule_head))
> +		submodule_up_to_date = !strcmp(update_data->super_branch, submodule_head);

I'm not sure I understand this logic. We want to change the 'submodule_up_to_date' boolean,
so that we compare branch names instead of oid's, and we do that only if:

1. we are running with 'propagateBranches=true' (so update_data->super_branch will be set to the superproject's branch)
2. a ref is checked out in the submodule (so submodule_head will hold its name)
3. it's not a branch (so skip_prefix will return 0, and !skip_prefix will be 1). 
   In that case it must be simply "HEAD", i.e. the submodule's HEAD is detached.

Why do we need (2. + 3.) ? 

If branch 'foo' is currently checked out in the superproject, and
branch 'bar' is currently checked out in the submodule, and someone
runs 'git -c propagateBranches=true submodule update', wouldn't they expect
that 'bar' be checked out in the submodule ? Maybe not, but the commit message
and the tests should be more explicit about the expected behaviour in this case, I think.

And thinking about it more, won't this:

    submodule_up_to_date = !strcmp(update_data->super_branch, submodule_head);

always be false, since we already know that submodule_head is "HEAD" ?... 
Unless I'm confused...
 
> +	else
> +		submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
> +
>  	if (!submodule_up_to_date || update_data->force)
>  		if (run_update_procedure(update_data))
>  			return 1;
> @@ -2551,6 +2568,12 @@ static int update_submodules(struct update_data *update_data)
>  		goto cleanup;
>  	}
>  
> +	if (the_repository->settings.submodule_propagate_branches) {
> +		struct branch *current_branch = branch_get(NULL);
> +		if (current_branch)
> +			update_data->super_branch = current_branch->name;

OK, so this condition means that super_branch won't get set if we are not
currently on a branch, i.e. we are in detached HEAD. This makes sense as there
would be no branch to propagate. Do we need a test for this ? maybe a case where
we clone with '--recurse-submodules --branch some-tag' ?

> +	}
> +
>  	for (i = 0; i < suc.update_clone_nr; i++) {
>  		struct update_clone_data ucd = suc.update_clone[i];
>  
> @@ -2634,6 +2657,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
>  	memset(&filter_options, 0, sizeof(filter_options));
>  	argc = parse_options(argc, argv, prefix, module_update_options,
>  			     git_submodule_helper_usage, 0);
> +	prepare_repo_settings(the_repository);
>  
>  	if (opt.require_init)
>  		opt.init = 1;
> diff --git a/t/t5617-clone-submodules.sh b/t/t5617-clone-submodules.sh
> index b5c66cb18cb..215fb02e9fb 100755
> --- a/t/t5617-clone-submodules.sh
> +++ b/t/t5617-clone-submodules.sh
> @@ -12,10 +12,17 @@ pwd=$(pwd)
>  test_expect_success 'setup' '
>  	git checkout -b main &&
>  	test_commit commit1 &&
> +	mkdir subsub &&
> +	(
> +		cd subsub &&
> +		git init &&
> +		test_commit subsubcommit1
> +	) &&
>  	mkdir sub &&
>  	(
>  		cd sub &&
>  		git init &&
> +		git submodule add "file://$pwd/subsub" subsub &&
>  		test_commit subcommit1 &&
>  		git tag sub_when_added_to_super &&
>  		git branch other
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
> +
>  test_done
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 6cc07460dd2..00a6fec8912 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -1178,4 +1178,26 @@ test_expect_success 'submodule update --recursive skip submodules with strategy=
>  	test_cmp expect.err actual.err
>  '
>  
> +test_expect_success 'submodule update with submodule.propagateBranches checks out branches' '
> +	test_when_finished "rm -fr top-cloned" &&
> +	cp -r top-clean top-cloned &&
> +
> +	# Create a new upstream submodule
> +	git init middle2 &&
> +	test_commit -C middle2 "middle2" &&
> +	git -C top submodule add ../middle2 middle2 &&
> +	git -C top commit -m "add middle2" &&
> +
> +	git -C top-cloned checkout -b "new-branch" &&
> +	git -C top-cloned pull origin main &&
> +	test_config -C top-cloned submodule.propagateBranches true &&
> +	git -C top-cloned submodule update --recursive &&
> +
> +	for REPO in "top-cloned/middle2" "top-cloned/middle" "top-cloned/middle/bottom"
> +	do
> +	    HEAD_BRANCH=$(git -C $REPO symbolic-ref HEAD) &&
> +	    test $HEAD_BRANCH = "refs/heads/new-branch" || return 1
> +	done
> +'
> +
>  test_done
> 

These tests look good, but maybe more tests would be needed in 
the light of my comments above... 

Thanks again for working on improving submodules!

Cheers,

Philippe.

