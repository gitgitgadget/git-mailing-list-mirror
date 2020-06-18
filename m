Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D4C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 06:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16D8217A0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 06:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u5fXHzPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgFRGL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:11:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58670 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFRGL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 02:11:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A9E7CCA6D;
        Thu, 18 Jun 2020 02:11:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u4QFTd02wpJwvo7sWKdRWTX8OKw=; b=u5fXHz
        PBJwKv0ydSVCDE0baymQxTlnNmEXKoUpJwU4fPWEn73x4x+TyVBgTtCOKQrqSyCv
        u3bAhniUHe9CaRMh+hHUeCJfPG1LHZ5mL1sGiKjoxLidVYbEjFRK9mnghQc8DT1k
        rKb0BQ16mED7X8wdQBHDCnOmBIFwQZIFuMcnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ipdsf2sk7g0V43TU5RsB3A8sx7lsf2wu
        0cdJcYmUPv/O5yhiXLgyXY8/LWquD0HaHy/VUFxPlqKdO8vHLUlHpq9ybv/ia1Rv
        9TYhUGQ3kQSpE8CgUE3XkuOEjqE9g7ZMoJQojORGo7fwRx27gro5d9uYxxfSzdRM
        koBRRdU2oSA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32794CCA6C;
        Thu, 18 Jun 2020 02:11:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 76459CCA6B;
        Thu, 18 Jun 2020 02:11:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 4/4] lib-submodule-update: use callbacks in test_submodule_switch_common()
References: <cover.1588162842.git.liu.denton@gmail.com>
        <cover.1591897173.git.liu.denton@gmail.com>
        <74e6086da451a4ce2ac52b04a2399ef332d61047.1591897173.git.liu.denton@gmail.com>
Date:   Wed, 17 Jun 2020 23:11:13 -0700
In-Reply-To: <74e6086da451a4ce2ac52b04a2399ef332d61047.1591897173.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 11 Jun 2020 13:41:50 -0400")
Message-ID: <xmqq4kr8rji6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 845321E4-B12A-11EA-BBB6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When we run a test helper function in test_submodule_switch_common(), we
> sometimes specify a whole helper function as the $command. When we do
> this, in some test cases, we just mark the whole function with
> `test_must_fail`. However, it's possible that the helper function might
> fail earlier or later than expected due to an introduced bug. If this
> happens, then the test case will still report as passing but it should
> really be marked as failing since it didn't actually display the
> intended behaviour.
>
> Instead of invoking $command as one monolithic helper function, break it
> up into three parts:
>
> 	1. $command which is always a git command.
> 	2. $before which is a callback function that runs just prior to
> 	   $command.
> 	3. $after which is a callback function that runs just after
> 	   $command.
>
> If the command requires a filename argument, specify it as `\$arg` since
> that variable will be set and the whole $command string will be eval'd.
> Unfortunately, there is no way to get rid of the eval as some of the
> commands are passed (such as the `git pull` tests) require that no
> additional arguments are passed so we must have some mechanism for the
> caller to specify whether or not it wants the filename argument.
>
> The $before and $after callback functions will be passed the filename as
> the first arg. These callback functions are optional and, if missing,
> will be replaced with `true`. Also, in the case where we have a
> `test_must_fail` test, $after will not be executed, similar to how the
> helper functions currently behave when the git command fails and exits
> the &&-chain.
>
> Finally, as an added bonus, `test_must_fail` will only run on $command
> which is guaranteed to be a git command.
>
> An alternate design was considered where the $OVERWRITING_FAIL is set
> from the test_submodule_switch_common() function and passed to the
> helper function. This approach was considered too difficult to
> understand due to the fact that using a signalling magic environment
> variable might be too indirect.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---

Peff, I think the previous round of this had all-caps OVERWRITING_FAIL
but the reversal of the role to feed the actual code that gets run
before and after the tested snippet by the caller was made in
response to your sugestion <20200521182928.GA1308647@coredump.intra.peff.net>.

I think I've already said that the helper function in the early part
can be vastly simplified but in any case the calling sideprobably
has become somewhat easier to follow (but not all that much, I am
afraid).  

Is there anything else we missed?

Thanks.

>  t/lib-submodule-update.sh   | 95 +++++++++++++++++++++++++++++--------
>  t/t3426-rebase-submodule.sh | 10 ++--
>  t/t3513-revert-submodule.sh | 10 ++--
>  t/t3906-stash-submodule.sh  | 10 ++--
>  t/t4137-apply-submodule.sh  | 12 ++---
>  t/t4255-am-submodule.sh     | 12 ++---
>  t/t5572-pull-submodule.sh   | 28 ++---------
>  t/t6041-bisect-submodule.sh | 10 ++--
>  8 files changed, 108 insertions(+), 79 deletions(-)
>
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 7c3ba1be00..988d85bd7d 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -310,7 +310,20 @@ test_submodule_content () {
>  # Internal function; use test_submodule_switch_func(), test_submodule_switch(),
>  # or test_submodule_forced_switch() instead.
>  test_submodule_switch_common () {
> -	command="$1"
> +	command="$1" # should be a git command
> +	before="$2"
> +	after="$3"
> +
> +	if test -z "$before"
> +	then
> +		before=true
> +	fi
> +
> +	if test -z "$after"
> +	then
> +		after=true
> +	fi
> +
>  	######################### Appearing submodule #########################
>  	# Switching to a commit letting a submodule appear creates empty dir ...
>  	if test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
> @@ -326,7 +339,10 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			git branch -t add_sub1 origin/add_sub1 &&
> -			$command add_sub1 &&
> +			arg=add_sub1 &&
> +			$before "$arg" &&
> +			eval $command &&
> +			$after "$arg" &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_dir_is_empty sub1 &&
>  			git submodule update --init --recursive &&
> @@ -341,7 +357,10 @@ test_submodule_switch_common () {
>  			cd submodule_update &&
>  			mkdir sub1 &&
>  			git branch -t add_sub1 origin/add_sub1 &&
> -			$command add_sub1 &&
> +			arg=add_sub1 &&
> +			$before "$arg" &&
> +			eval $command &&
> +			$after "$arg" &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_dir_is_empty sub1 &&
>  			git submodule update --init --recursive &&
> @@ -356,7 +375,10 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
> -			$command replace_file_with_sub1 &&
> +			arg=replace_file_with_sub1 &&
> +			$before "$arg" &&
> +			eval $command &&
> +			$after "$arg" &&
>  			test_superproject_content origin/replace_file_with_sub1 &&
>  			test_dir_is_empty sub1 &&
>  			git submodule update --init --recursive &&
> @@ -380,7 +402,10 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
> -			$command replace_directory_with_sub1 &&
> +			arg=replace_directory_with_sub1  &&
> +			$before "$arg" &&
> +			eval $command &&
> +			$after "$arg" &&
>  			test_superproject_content origin/replace_directory_with_sub1 &&
>  			test_dir_is_empty sub1 &&
>  			git submodule update --init --recursive &&
> @@ -402,7 +427,10 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			git branch -t remove_sub1 origin/remove_sub1 &&
> -			$command remove_sub1 &&
> +			arg=remove_sub1 &&
> +			$before "$arg" &&
> +			eval $command &&
> +			$after "$arg" &&
>  			test_superproject_content origin/remove_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
>  		)
> @@ -415,7 +443,10 @@ test_submodule_switch_common () {
>  			cd submodule_update &&
>  			git branch -t remove_sub1 origin/remove_sub1 &&
>  			replace_gitfile_with_git_dir sub1 &&
> -			$command remove_sub1 &&
> +			arg=remove_sub1 &&
> +			$before "$arg" &&
> +			eval $command &&
> +			$after "$arg" &&
>  			test_superproject_content origin/remove_sub1 &&
>  			test_git_directory_is_unchanged sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
> @@ -443,7 +474,9 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
> -			test_must_fail $command replace_sub1_with_directory &&
> +			arg=replace_sub1_with_directory &&
> +			$before "$arg" &&
> +			eval test_must_fail $command &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
>  		)
> @@ -456,7 +489,9 @@ test_submodule_switch_common () {
>  			cd submodule_update &&
>  			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
>  			replace_gitfile_with_git_dir sub1 &&
> -			test_must_fail $command replace_sub1_with_directory &&
> +			arg=replace_sub1_with_directory &&
> +			$before "$arg" &&
> +			eval test_must_fail $command &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_git_directory_is_unchanged sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
> @@ -470,7 +505,9 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
> -			test_must_fail $command replace_sub1_with_file &&
> +			arg=replace_sub1_with_file &&
> +			$before "$arg" &&
> +			eval test_must_fail $command &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
>  		)
> @@ -484,7 +521,9 @@ test_submodule_switch_common () {
>  			cd submodule_update &&
>  			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
>  			replace_gitfile_with_git_dir sub1 &&
> -			test_must_fail $command replace_sub1_with_file &&
> +			arg=replace_sub1_with_file &&
> +			$before "$arg" &&
> +			eval test_must_fail $command &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_git_directory_is_unchanged sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
> @@ -508,7 +547,10 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			git branch -t modify_sub1 origin/modify_sub1 &&
> -			$command modify_sub1 &&
> +			arg=modify_sub1 &&
> +			$before "$arg" &&
> +			eval $command &&
> +			$after "$arg" &&
>  			test_superproject_content origin/modify_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1 &&
>  			git submodule update &&
> @@ -523,7 +565,10 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			git branch -t invalid_sub1 origin/invalid_sub1 &&
> -			$command invalid_sub1 &&
> +			arg=invalid_sub1 &&
> +			$before "$arg" &&
> +			eval $command &&
> +			$after "$arg" &&
>  			test_superproject_content origin/invalid_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1 &&
>  			test_must_fail git submodule update &&
> @@ -538,7 +583,10 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			git branch -t valid_sub1 origin/valid_sub1 &&
> -			$command valid_sub1 &&
> +			arg=valid_sub1 &&
> +			$before "$arg" &&
> +			eval $command &&
> +			$after "$arg" &&
>  			test_superproject_content origin/valid_sub1 &&
>  			test_dir_is_empty sub1 &&
>  			git submodule update --init --recursive &&
> @@ -568,8 +616,10 @@ test_submodule_switch_common () {
>  # }
>  # test_submodule_switch_func "my_func"
>  test_submodule_switch_func () {
> -	command="$1"
> -	test_submodule_switch_common "$command"
> +	command="git $1"
> +	before="$2"
> +	after="$3"
> +	test_submodule_switch_common "$command" "$before" "$after"
>  
>  	# An empty directory does not prevent the creation of a submodule of
>  	# the same name, but a file does.
> @@ -580,7 +630,9 @@ test_submodule_switch_func () {
>  			cd submodule_update &&
>  			git branch -t add_sub1 origin/add_sub1 &&
>  			>sub1 &&
> -			test_must_fail $command add_sub1 &&
> +			arg=add_sub1 &&
> +			$before "$arg" &&
> +			eval test_must_fail $command &&
>  			test_superproject_content origin/no_submodule &&
>  			test_must_be_empty sub1
>  		)
> @@ -588,15 +640,15 @@ test_submodule_switch_func () {
>  }
>  
>  test_submodule_switch () {
> -	test_submodule_switch_func "git $1"
> +	test_submodule_switch_func "$1 \$arg"
>  }
>  
>  # Same as test_submodule_switch(), except that throwing away local changes in
>  # the superproject is allowed.
>  test_submodule_forced_switch () {
> -	command="$1"
> +	command="git $1 \$arg"
>  	KNOWN_FAILURE_FORCED_SWITCH_TESTS=1
> -	test_submodule_switch_common "git $command"
> +	test_submodule_switch_common "$command"
>  
>  	# When forced, a file in the superproject does not prevent creating a
>  	# submodule of the same name.
> @@ -607,7 +659,8 @@ test_submodule_forced_switch () {
>  			cd submodule_update &&
>  			git branch -t add_sub1 origin/add_sub1 &&
>  			>sub1 &&
> -			$command add_sub1 &&
> +			arg=add_sub1 &&
> +			eval $command &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_dir_is_empty sub1
>  		)
> diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
> index 788605ccc0..d31e6487bd 100755
> --- a/t/t3426-rebase-submodule.sh
> +++ b/t/t3426-rebase-submodule.sh
> @@ -16,11 +16,10 @@ git_rebase () {
>  	git revert HEAD &&
>  	git status -su >actual &&
>  	ls -1pR * >>actual &&
> -	test_cmp expect actual &&
> -	git rebase "$1"
> +	test_cmp expect actual
>  }
>  
> -test_submodule_switch_func "git_rebase"
> +test_submodule_switch_func "rebase \$arg" "git_rebase"
>  
>  git_rebase_interactive () {
>  	git status -su >expect &&
> @@ -34,11 +33,10 @@ git_rebase_interactive () {
>  	ls -1pR * >>actual &&
>  	test_cmp expect actual &&
>  	set_fake_editor &&
> -	echo "fake-editor.sh" >.git/info/exclude &&
> -	git rebase -i "$1"
> +	echo "fake-editor.sh" >.git/info/exclude
>  }
>  
> -test_submodule_switch_func "git_rebase_interactive"
> +test_submodule_switch_func "rebase -i \$arg" "git_rebase_interactive"
>  
>  test_expect_success 'rebase interactive ignores modified submodules' '
>  	test_when_finished "rm -rf super sub" &&
> diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
> index 95a7f64471..994cdc40f0 100755
> --- a/t/t3513-revert-submodule.sh
> +++ b/t/t3513-revert-submodule.sh
> @@ -11,11 +11,13 @@ test_description='revert can handle submodules'
>  # first so we can restore the work tree test setup after doing the checkout
>  # and revert.  We test here that the restored work tree content is identical
>  # to that at the beginning. The last revert is then tested by the framework.
> -git_revert () {
> +git_revert_before () {
>  	git status -su >expect &&
>  	ls -1pR * >>expect &&
> -	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
> -	git checkout "$1" &&
> +	tar cf "$TRASH_DIRECTORY/tmp.tar" *
> +}
> +
> +git_revert_after () {
>  	git revert HEAD &&
>  	rm -rf * &&
>  	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
> @@ -26,6 +28,6 @@ git_revert () {
>  }
>  
>  KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
> -test_submodule_switch_func "git_revert"
> +test_submodule_switch_func "checkout \$arg" "git_revert_before" "git_revert_after"
>  
>  test_done
> diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
> index 6a7e801ca0..358a625124 100755
> --- a/t/t3906-stash-submodule.sh
> +++ b/t/t3906-stash-submodule.sh
> @@ -5,10 +5,12 @@ test_description='stash can handle submodules'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-submodule-update.sh
>  
> -git_stash () {
> +git_stash_before () {
>  	git status -su >expect &&
> -	ls -1pR * >>expect &&
> -	git read-tree -u -m "$1" &&
> +	ls -1pR * >>expect
> +}
> +
> +git_stash_after () {
>  	git stash &&
>  	git status -su >actual &&
>  	ls -1pR * >>actual &&
> @@ -19,7 +21,7 @@ git_stash () {
>  KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES=1
>  KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
>  KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
> -test_submodule_switch_func "git_stash"
> +test_submodule_switch_func "read-tree -u -m \$arg" "git_stash_before" "git_stash_after"
>  
>  setup_basic () {
>  	test_when_finished "rm -rf main sub" &&
> diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
> index b645e303a0..fe5ebeaa41 100755
> --- a/t/t4137-apply-submodule.sh
> +++ b/t/t4137-apply-submodule.sh
> @@ -5,16 +5,12 @@ test_description='git apply handling submodules'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-submodule-update.sh
>  
> -apply_index () {
> -	git diff --ignore-submodules=dirty "..$1" | git apply --index -
> +create_diff () {
> +	git diff --ignore-submodules=dirty "..$1" >diff
>  }
>  
> -test_submodule_switch_func "apply_index"
> +test_submodule_switch_func "apply --index diff" "create_diff"
>  
> -apply_3way () {
> -	git diff --ignore-submodules=dirty "..$1" | git apply --3way -
> -}
> -
> -test_submodule_switch_func "apply_3way"
> +test_submodule_switch_func "apply --3way diff" "create_diff"
>  
>  test_done
> diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
> index 1b179d5f45..5305280dfd 100755
> --- a/t/t4255-am-submodule.sh
> +++ b/t/t4255-am-submodule.sh
> @@ -5,18 +5,14 @@ test_description='git am handling submodules'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-submodule-update.sh
>  
> -am () {
> -	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am -
> +create_patch () {
> +	git format-patch --stdout --ignore-submodules=dirty "..$1" >patch
>  }
>  
> -test_submodule_switch_func "am"
> -
> -am_3way () {
> -	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am --3way -
> -}
> +test_submodule_switch_func "am patch" "create_patch"
>  
>  KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
> -test_submodule_switch_func "am_3way"
> +test_submodule_switch_func "am --3way patch" "create_patch"
>  
>  test_expect_success 'setup diff.submodule' '
>  	test_commit one &&
> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> index f911bf631e..3b37853537 100755
> --- a/t/t5572-pull-submodule.sh
> +++ b/t/t5572-pull-submodule.sh
> @@ -11,36 +11,16 @@ reset_branch_to_HEAD () {
>  	git branch --set-upstream-to="origin/$1" "$1"
>  }
>  
> -git_pull () {
> -	reset_branch_to_HEAD "$1" &&
> -	git pull
> -}
> -
>  # pulls without conflicts
> -test_submodule_switch_func "git_pull"
> +test_submodule_switch_func "pull" "reset_branch_to_HEAD"
>  
> -git_pull_ff () {
> -	reset_branch_to_HEAD "$1" &&
> -	git pull --ff
> -}
> +test_submodule_switch_func "pull --ff" "reset_branch_to_HEAD"
>  
> -test_submodule_switch_func "git_pull_ff"
> -
> -git_pull_ff_only () {
> -	reset_branch_to_HEAD "$1" &&
> -	git pull --ff-only
> -}
> -
> -test_submodule_switch_func "git_pull_ff_only"
> -
> -git_pull_noff () {
> -	reset_branch_to_HEAD "$1" &&
> -	git pull --no-ff
> -}
> +test_submodule_switch_func "pull --ff-only" "reset_branch_to_HEAD"
>  
>  KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
>  KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
> -test_submodule_switch_func "git_pull_noff"
> +test_submodule_switch_func "pull --no-ff" "reset_branch_to_HEAD"
>  
>  test_expect_success 'pull --recurse-submodule setup' '
>  	test_create_repo child &&
> diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
> index 0e0cdf638d..b99e81d55d 100755
> --- a/t/t6041-bisect-submodule.sh
> +++ b/t/t6041-bisect-submodule.sh
> @@ -5,12 +5,14 @@ test_description='bisect can handle submodules'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-submodule-update.sh
>  
> -git_bisect () {
> +git_bisect_before () {
>  	git status -su >expect &&
>  	ls -1pR * >>expect &&
>  	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
> -	GOOD=$(git rev-parse --verify HEAD) &&
> -	git checkout "$1" &&
> +	GOOD=$(git rev-parse --verify HEAD)
> +}
> +
> +git_bisect_after () {
>  	echo "foo" >bar &&
>  	git add bar &&
>  	git commit -m "bisect bad" &&
> @@ -27,6 +29,6 @@ git_bisect () {
>  	git bisect bad $BAD
>  }
>  
> -test_submodule_switch_func "git_bisect"
> +test_submodule_switch_func "checkout \$arg" "git_bisect_before" "git_bisect_after"
>  
>  test_done
