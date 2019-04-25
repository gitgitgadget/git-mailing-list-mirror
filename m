Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5776E1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 02:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfDYCb4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 22:31:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58182 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387689AbfDYCb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 22:31:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 765C869D30;
        Wed, 24 Apr 2019 22:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zM7r14qP3Spt3OTdcE4sw53BuE8=; b=ZN88EL
        8dLNcKs8GNIWZwO9YGiSPH88MJszpVMilytHEAr16T7ygh14jO1be8wr5LYqi6fY
        Gf9WzPXWAPf/Otl3uCPS8Y6BeBSde0LPpHneSi3YAKrliNBpyQJyXnRvRUwEJW6w
        sibx1MXUn/9DuRCqTE1O2CgMMSYj6ceF5RLI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a9FLfxou7fATWtWAaEX5xUCMjenaLTjc
        aQBOvPnoEy8RZQzHhthIoJTmlqsyrSB2j3kLKmoY4KNW0TlCuz4qo2MFwvyovY18
        wsZdxN4/47QMN3fc+70ehzfZFpzN1pIPj+in7pZfj6mtgMdvo7azH3q56avHjn63
        /ocgvpFDKyQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DE0669D2F;
        Wed, 24 Apr 2019 22:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9D9F669D2E;
        Wed, 24 Apr 2019 22:31:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/6] t7610: unsuppress output
References: <cover.1556009181.git.liu.denton@gmail.com>
        <cover.1556142510.git.liu.denton@gmail.com>
        <9f9922cab341396a846edc2f52342c59d294379a.1556142510.git.liu.denton@gmail.com>
Date:   Thu, 25 Apr 2019 11:31:41 +0900
In-Reply-To: <9f9922cab341396a846edc2f52342c59d294379a.1556142510.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 24 Apr 2019 15:46:57 -0700")
Message-ID: <xmqqftq6zugi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43CD0D24-6702-11E9-AB6C-EE24A11ADF13-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The output for commands used to be suppressed by redirecting both stdout
> and stderr to /dev/null. However, this should not happen since the
> output is useful for debugging and, without the "-v" flag, test scripts
> don't output anyway.
>
> Unsuppress the output by removing the redirections to /dev/null.

Thanks for clearly justifying the clean-up.

I take it that with this there is no behaviour changes (e.g. a
command that may change its behaviour depending on where its
standard output goes does not change the outcome of the tests)?

I am not worried about the invocations of "git mergetool" downstream
of the pipe that is fed by "yes", and the remainder are a handful of
"git merge" invocations, which looked OK to me.

Thanks.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t7610-mergetool.sh | 122 +++++++++++++++++++++----------------------
>  1 file changed, 61 insertions(+), 61 deletions(-)
>
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index a9fb971615..69711487dd 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -130,14 +130,14 @@ test_expect_success 'custom mergetool' '
>  	test_when_finished "git reset --hard" &&
>  	git checkout -b test$test_count branch1 &&
>  	git submodule update -N &&
> -	test_must_fail git merge master >/dev/null 2>&1 &&
> -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> +	test_must_fail git merge master &&
> +	( yes "" | git mergetool both ) &&
>  	( yes "" | git mergetool file1 file1 ) &&
> -	( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
> -	( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool file2 "spaced name" ) &&
> +	( yes "" | git mergetool subdir/file3 ) &&
> +	( yes "d" | git mergetool file11 ) &&
> +	( yes "d" | git mergetool file12 ) &&
> +	( yes "l" | git mergetool submod ) &&
>  	test "$(cat file1)" = "master updated" &&
>  	test "$(cat file2)" = "master new" &&
>  	test "$(cat subdir/file3)" = "master new sub" &&
> @@ -153,15 +153,15 @@ test_expect_success 'mergetool crlf' '
>  	# test_when_finished is LIFO.)
>  	test_config core.autocrlf true &&
>  	git checkout -b test$test_count branch1 &&
> -	test_must_fail git merge master >/dev/null 2>&1 &&
> -	( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool "spaced name" >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
> -	( yes "r" | git mergetool submod >/dev/null 2>&1 ) &&
> +	test_must_fail git merge master &&
> +	( yes "" | git mergetool file1 ) &&
> +	( yes "" | git mergetool file2 ) &&
> +	( yes "" | git mergetool "spaced name" ) &&
> +	( yes "" | git mergetool both ) &&
> +	( yes "" | git mergetool subdir/file3 ) &&
> +	( yes "d" | git mergetool file11 ) &&
> +	( yes "d" | git mergetool file12 ) &&
> +	( yes "r" | git mergetool submod ) &&
>  	test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
>  	test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
>  	test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
> @@ -176,8 +176,8 @@ test_expect_success 'mergetool in subdir' '
>  	git submodule update -N &&
>  	(
>  		cd subdir &&
> -		test_must_fail git merge master >/dev/null 2>&1 &&
> -		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
> +		test_must_fail git merge master &&
> +		( yes "" | git mergetool file3 ) &&
>  		test "$(cat file3)" = "master new sub"
>  	)
>  '
> @@ -188,14 +188,14 @@ test_expect_success 'mergetool on file in parent dir' '
>  	git submodule update -N &&
>  	(
>  		cd subdir &&
> -		test_must_fail git merge master >/dev/null 2>&1 &&
> -		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
> -		( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
> -		( yes "" | git mergetool ../file2 ../spaced\ name >/dev/null 2>&1 ) &&
> -		( yes "" | git mergetool ../both >/dev/null 2>&1 ) &&
> -		( yes "d" | git mergetool ../file11 >/dev/null 2>&1 ) &&
> -		( yes "d" | git mergetool ../file12 >/dev/null 2>&1 ) &&
> -		( yes "l" | git mergetool ../submod >/dev/null 2>&1 ) &&
> +		test_must_fail git merge master &&
> +		( yes "" | git mergetool file3 ) &&
> +		( yes "" | git mergetool ../file1 ) &&
> +		( yes "" | git mergetool ../file2 ../spaced\ name ) &&
> +		( yes "" | git mergetool ../both ) &&
> +		( yes "d" | git mergetool ../file11 ) &&
> +		( yes "d" | git mergetool ../file12 ) &&
> +		( yes "l" | git mergetool ../submod ) &&
>  		test "$(cat ../file1)" = "master updated" &&
>  		test "$(cat ../file2)" = "master new" &&
>  		test "$(cat ../submod/bar)" = "branch1 submodule" &&
> @@ -209,9 +209,9 @@ test_expect_success 'mergetool skips autoresolved' '
>  	git submodule update -N &&
>  	test_must_fail git merge master &&
>  	test -n "$(git ls-files -u)" &&
> -	( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
> -	( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
> +	( yes "d" | git mergetool file11 ) &&
> +	( yes "d" | git mergetool file12 ) &&
> +	( yes "l" | git mergetool submod ) &&
>  	output="$(git mergetool --no-prompt)" &&
>  	test "$output" = "No files need merging"
>  '
> @@ -259,9 +259,9 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
>  	rm -rf .git/rr-cache &&
>  	git checkout -b test$test_count branch1 &&
>  	git submodule update -N &&
> -	test_must_fail git merge master >/dev/null 2>&1 &&
> -	( yes "l" | git mergetool --no-prompt submod >/dev/null 2>&1 ) &&
> -	( yes "d" "d" | git mergetool --no-prompt >/dev/null 2>&1 ) &&
> +	test_must_fail git merge master &&
> +	( yes "l" | git mergetool --no-prompt submod ) &&
> +	( yes "d" "d" | git mergetool --no-prompt ) &&
>  	git submodule update -N &&
>  	output="$(yes "n" | git mergetool --no-prompt)" &&
>  	test "$output" = "No files need merging"
> @@ -369,9 +369,9 @@ test_expect_success 'deleted vs modified submodule' '
>  	git checkout -b test$test_count.a test$test_count &&
>  	test_must_fail git merge master &&
>  	test -n "$(git ls-files -u)" &&
> -	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
> +	( yes "" | git mergetool both ) &&
> +	( yes "d" | git mergetool file11 file12 ) &&
>  	( yes "r" | git mergetool submod ) &&
>  	rmdir submod && mv submod-movedaside submod &&
>  	test "$(cat submod/bar)" = "branch1 submodule" &&
> @@ -386,9 +386,9 @@ test_expect_success 'deleted vs modified submodule' '
>  	git submodule update -N &&
>  	test_must_fail git merge master &&
>  	test -n "$(git ls-files -u)" &&
> -	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
> +	( yes "" | git mergetool both ) &&
> +	( yes "d" | git mergetool file11 file12 ) &&
>  	( yes "l" | git mergetool submod ) &&
>  	test ! -e submod &&
>  	output="$(git mergetool --no-prompt)" &&
> @@ -400,9 +400,9 @@ test_expect_success 'deleted vs modified submodule' '
>  	git submodule update -N &&
>  	test_must_fail git merge test$test_count &&
>  	test -n "$(git ls-files -u)" &&
> -	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
> +	( yes "" | git mergetool both ) &&
> +	( yes "d" | git mergetool file11 file12 ) &&
>  	( yes "r" | git mergetool submod ) &&
>  	test ! -e submod &&
>  	test -d submod.orig &&
> @@ -416,9 +416,9 @@ test_expect_success 'deleted vs modified submodule' '
>  	git submodule update -N &&
>  	test_must_fail git merge test$test_count &&
>  	test -n "$(git ls-files -u)" &&
> -	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
> +	( yes "" | git mergetool both ) &&
> +	( yes "d" | git mergetool file11 file12 ) &&
>  	( yes "l" | git mergetool submod ) &&
>  	test "$(cat submod/bar)" = "master submodule" &&
>  	git submodule update -N &&
> @@ -440,9 +440,9 @@ test_expect_success 'file vs modified submodule' '
>  	git checkout -b test$test_count.a branch1 &&
>  	test_must_fail git merge master &&
>  	test -n "$(git ls-files -u)" &&
> -	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
> +	( yes "" | git mergetool both ) &&
> +	( yes "d" | git mergetool file11 file12 ) &&
>  	( yes "r" | git mergetool submod ) &&
>  	rmdir submod && mv submod-movedaside submod &&
>  	test "$(cat submod/bar)" = "branch1 submodule" &&
> @@ -456,9 +456,9 @@ test_expect_success 'file vs modified submodule' '
>  	git checkout -b test$test_count.b test$test_count &&
>  	test_must_fail git merge master &&
>  	test -n "$(git ls-files -u)" &&
> -	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
> +	( yes "" | git mergetool both ) &&
> +	( yes "d" | git mergetool file11 file12 ) &&
>  	( yes "l" | git mergetool submod ) &&
>  	git submodule update -N &&
>  	test "$(cat submod)" = "not a submodule" &&
> @@ -472,9 +472,9 @@ test_expect_success 'file vs modified submodule' '
>  	git submodule update -N &&
>  	test_must_fail git merge test$test_count &&
>  	test -n "$(git ls-files -u)" &&
> -	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
> +	( yes "" | git mergetool both ) &&
> +	( yes "d" | git mergetool file11 file12 ) &&
>  	( yes "r" | git mergetool submod ) &&
>  	test -d submod.orig &&
>  	git submodule update -N &&
> @@ -488,9 +488,9 @@ test_expect_success 'file vs modified submodule' '
>  	git submodule update -N &&
>  	test_must_fail git merge test$test_count &&
>  	test -n "$(git ls-files -u)" &&
> -	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool both>/dev/null 2>&1 ) &&
> -	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
> +	( yes "" | git mergetool both ) &&
> +	( yes "d" | git mergetool file11 file12 ) &&
>  	( yes "l" | git mergetool submod ) &&
>  	test "$(cat submod/bar)" = "master submodule" &&
>  	git submodule update -N &&
> @@ -543,7 +543,7 @@ test_expect_success 'submodule in subdirectory' '
>  	git add subdir/subdir_module &&
>  	git commit -m "change submodule in subdirectory on test$test_count.b" &&
>  
> -	test_must_fail git merge test$test_count.a >/dev/null 2>&1 &&
> +	test_must_fail git merge test$test_count.a &&
>  	(
>  		cd subdir &&
>  		( yes "l" | git mergetool subdir_module )
> @@ -554,7 +554,7 @@ test_expect_success 'submodule in subdirectory' '
>  	git reset --hard &&
>  	git submodule update -N &&
>  
> -	test_must_fail git merge test$test_count.a >/dev/null 2>&1 &&
> +	test_must_fail git merge test$test_count.a &&
>  	( yes "r" | git mergetool subdir/subdir_module ) &&
>  	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
>  	git submodule update -N &&
> @@ -641,7 +641,7 @@ test_expect_success 'filenames seen by tools start with ./' '
>  	test_config mergetool.myecho.trustExitCode true &&
>  	test_must_fail git merge master &&
>  	git mergetool --no-prompt --tool myecho -- both >actual &&
> -	grep ^\./both_LOCAL_ actual >/dev/null
> +	grep ^\./both_LOCAL_ actual
>  '
>  
>  test_lazy_prereq MKTEMP '
> @@ -658,8 +658,8 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
>  	test_config mergetool.myecho.trustExitCode true &&
>  	test_must_fail git merge master &&
>  	git mergetool --no-prompt --tool myecho -- both >actual &&
> -	! grep ^\./both_LOCAL_ actual >/dev/null &&
> -	grep /both_LOCAL_ actual >/dev/null
> +	! grep ^\./both_LOCAL_ actual &&
> +	grep /both_LOCAL_ actual
>  '
>  
>  test_expect_success 'diff.orderFile configuration is honored' '
