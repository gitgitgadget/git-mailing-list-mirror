Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7407C5ACC4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 23:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEA52465D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 23:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ufh3KVZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgBSXc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:32:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55633 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSXc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 18:32:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 997F9C685C;
        Wed, 19 Feb 2020 18:32:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cF5iq2/a1TwL7LqfThISQYAf2JU=; b=Ufh3KV
        Z/NW/YtrUuovNwGN5ZNdFKTSQVT1GiPfPc/6t3PDZXaKCbmqxNmsaEOzV0yjqZ0B
        tUA24+fo5AkOveDQYR0NtGVc+NhVkNzx9rgYxKkkJF0n9AwEyBfNvuzdFCjFxAS6
        e6i9TaFknE9Zi028QfSmDtce57x72q43IelSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WhYqPV/aWo3p0ZpNvCdi3iV6qsM3tdlu
        inSDKYpE5myk8wZfaejkQFgVLo0zZezqHCLmx+ib7EvOacJQ7AW1dSbyP52KtcoF
        sGf+wd4/O8yrje1EswA9xWQ6DIEvt68O0hblxhw93pnc1TGZerFjdTx0zN9/ytVF
        2Cu0iOeXWoA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91333C685B;
        Wed, 19 Feb 2020 18:32:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7737C6859;
        Wed, 19 Feb 2020 18:32:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 5/6] unpack-trees: check for missing submodule directory in merged_entry
References: <pull.555.git.1581915186.gitgitgadget@gmail.com>
        <d47740181bf02036a83f3573164c6c650ae75afb.1581915186.git.gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 15:32:52 -0800
In-Reply-To: <d47740181bf02036a83f3573164c6c650ae75afb.1581915186.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Mon, 17 Feb 2020
        04:53:05 +0000")
Message-ID: <xmqqd0aacfvf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27388DFE-5370-11EA-A1BB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Using `git checkout --recurse-submodules` to switch between a
> branch with no submodules and a branch with initialized nested
> submodules currently causes a fatal error:
>
>     $ git checkout --recurse-submodules branch-with-nested-submodules
>     fatal: exec '--super-prefix=submodule/nested/': cd to 'nested'
> failed: No such file or directory
>     error: Submodule 'nested' could not be updated.
>     error: Submodule 'submodule/nested' cannot checkout new HEAD.
>     error: Submodule 'submodule' could not be updated.
>     M	submodule
>     Switched to branch 'branch-with-nested-submodules'
>
> The checkout succeeds but the worktree and index of the first level
> submodule are left empty:
>
>     $ cd submodule
>     $ git -c status.submoduleSummary=1 status
>     HEAD detached at b3ce885
>     Changes to be committed:
>       (use "git restore --staged <file>..." to unstage)
>           deleted:    .gitmodules
>           deleted:    first.t
>           deleted:    nested
>
>     fatal: not a git repository: 'nested/.git'
>     Submodule changes to be committed:
>
>     * nested 1e96f59...0000000:
>
>     $ git ls-files -s
>     $ # empty
>     $ ls -A
>     .git
>
> The reason for the fatal error during the checkout is that a child git
> process tries to cd into the yet unexisting nested submodule directory.
> The sequence is the following:
>
> 1. The main git process (the one running in the superproject) eventually
> reaches write_entry() in entry.c, which creates the first level
> submodule directory and then calls submodule_move_head() in submodule.c,
> which spawns `git read-tree` in the submodule directory.
>
> 2. The first child git process (the one in the submodule of the
> superproject) eventually calls check_submodule_move_head() at
> unpack_trees.c:2021, which calls submodule_move_head in dry-run mode,
> which spawns `git read-tree` in the nested submodule directory.
>
> 3. The second child git process tries to chdir() in the yet unexisting
> nested submodule directory in start_command() at run-command.c:829 and
> dies before exec'ing.
>
> The reason why check_submodule_move_head() is reached in the first child
> and not in the main process is that it is inside an
> if(submodule_from_ce()) construct, and submodule_from_ce() returns a
> valid struct submodule pointer, whereas it returns a null pointer in the
> main git process.
>
> The reason why submodule_from_ce() returns a null pointer in the main
> git process is because the call to cache_lookup_path() in config_from()
> (called from submodule_from_path() in submodule_from_ce()) returns a
> null pointer since the hashmap "for_path" in the submodule_cache of
> the_repository is not yet populated. It is not populated because both
> repo_get_oid(repo, GITMODULES_INDEX, &oid) and repo_get_oid(repo,
> GITMODULES_HEAD, &oid) in config_from_gitmodules() at
> submodule-config.c:639-640 return -1, as at this stage of the operation,
> neither the HEAD of the superproject nor its index contain any
> .gitmodules file.
>
> In contrast, in the first child the hashmap is populated because
> repo_get_oid(repo, GITMODULES_HEAD, &oid) returns 0 as the HEAD of the
> first level submodule, i.e. .git/modules/submodule/HEAD, points to a
> commit where .gitmodules is present and records 'nested' as a submodule.
>
> Fix this bug by checking that the submodule directory exists before
> calling check_submodule_move_head() in merged_entry() in the `if(!old)`
> branch, i.e. if going from a commit with no submodule to a commit with a
> submodule present.
>
> Also protect the other call to check_submodule_move_head() in
> merged_entry() the same way as it is safer, even though the `else if
> (!(old->ce_flags & CE_CONFLICTED))` branch of the code is not at play in
> the present bug.
>
> The other calls to check_submodule_move_head() in other functions in
> unpack_trees.c are all already protected by calls to lstat() somewhere
> in
> the program flow so we don't need additional protection for them.
>
> All commands in the unpack_trees machinery are affected, i.e. checkout,
> reset and read-tree when called with the --recurse-submodules flag.

Greate to see a detailed write-up.  I'll read the surrounding
codepath again later before commenting further.

Thanks.

>
> This bug was first reported in [1].
>
> [1]
> https://lore.kernel.org/git/7437BB59-4605-48EC-B05E-E2BDB2D9DABC@gmail.com/
>
> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Reported-by: Damien Robert <damien.olivier.robert@gmail.com>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  t/lib-submodule-update.sh | 14 ++++++++++++++
>  unpack-trees.c            |  4 ++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 417da3602ae..ab30b2da24f 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -626,6 +626,7 @@ test_submodule_forced_switch () {
>  # New test cases
>  # - Removing a submodule with a git directory absorbs the submodules
>  #   git directory first into the superproject.
> +# - Switching from no submodule to nested submodules
>  
>  # Internal function; use test_submodule_switch_recursing_with_args() or
>  # test_submodule_forced_switch_recursing_with_args() instead.
> @@ -683,6 +684,19 @@ test_submodule_recursing_with_args_common() {
>  			test_submodule_content sub1 origin/replace_directory_with_sub1
>  		)
>  	'
> +	# Switching to a commit with nested submodules recursively checks them out
> +	test_expect_success "$command: nested submodules are checked out" '
> +		prolog &&
> +		reset_work_tree_to_interested no_submodule &&
> +		(
> +			cd submodule_update &&
> +			git branch -t modify_sub1_recursively origin/modify_sub1_recursively &&
> +			$command modify_sub1_recursively &&
> +			test_superproject_content origin/modify_sub1_recursively &&
> +			test_submodule_content sub1 origin/modify_sub1_recursively &&
> +			test_submodule_content -C sub1 sub2 origin/modify_sub1_recursively
> +		)
> +	'
>  
>  	######################## Disappearing submodule #######################
>  	# Removing a submodule removes its work tree ...
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 37eca3ede8b..fc6ba19486d 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2064,7 +2064,7 @@ static int merged_entry(const struct cache_entry *ce,
>  		}
>  		invalidate_ce_path(merge, o);
>  
> -		if (submodule_from_ce(ce)) {
> +		if (submodule_from_ce(ce) && file_exists(ce->name)) {
>  			int ret = check_submodule_move_head(ce, NULL,
>  							    oid_to_hex(&ce->oid),
>  							    o);
> @@ -2093,7 +2093,7 @@ static int merged_entry(const struct cache_entry *ce,
>  			invalidate_ce_path(old, o);
>  		}
>  
> -		if (submodule_from_ce(ce)) {
> +		if (submodule_from_ce(ce) && file_exists(ce->name)) {
>  			int ret = check_submodule_move_head(ce, oid_to_hex(&old->oid),
>  							    oid_to_hex(&ce->oid),
>  							    o);
