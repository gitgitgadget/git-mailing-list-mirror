Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BE2C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 21:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B892073A
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 21:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgDUVQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:16:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:18056 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgDUVQM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 17:16:12 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 496GZd4R0Zz5tlB;
        Tue, 21 Apr 2020 23:16:09 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 457E84855;
        Tue, 21 Apr 2020 23:16:09 +0200 (CEST)
Subject: Re: [PATCH 8/8] t9902: don't use `test_must_fail __git_*`
To:     Denton Liu <liu.denton@gmail.com>
References: <cover.1587372771.git.liu.denton@gmail.com>
 <6cfa2c447e1196d6c4325aff9fac52434d10fda8.1587372771.git.liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <60627dc6-fb9c-549f-d76d-0e110c5b0de2@kdbg.org>
Date:   Tue, 21 Apr 2020 23:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6cfa2c447e1196d6c4325aff9fac52434d10fda8.1587372771.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.04.20 um 10:54 schrieb Denton Liu:
> We should only use test_must_fail() to test git commands. Replace
> `test_must_fail` with `!` so that we don't use test_must_fail() on the
> completion functions.
> 
> This is done because test_must_fail() is used to except git exiting with
> an expected error but it will still return an error if it detects
> unexpected errors such as a segfault. In the case of these completion
> functions, the return codes of the git commands aren't checked and, most
> of the time, they will just explicitly return 1 or have an unrelated
> command return 0. As a result, it doesn't really make sense to use
> `test_must_fail` so use `!` instead.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t9902-completion.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 5505e5aa24..320c755971 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -294,7 +294,7 @@ test_expect_success '__git_find_repo_path - "git -C" while .git directory in par
>  test_expect_success '__git_find_repo_path - non-existing path in "git -C"' '
>  	(
>  		__git_C_args=(-C non-existing) &&
> -		test_must_fail __git_find_repo_path &&
> +		! __git_find_repo_path &&
>  		printf "$__git_repo_path" >"$actual"
>  	) &&
>  	test_must_be_empty "$actual"
> @@ -303,7 +303,7 @@ test_expect_success '__git_find_repo_path - non-existing path in "git -C"' '
>  test_expect_success '__git_find_repo_path - non-existing path in $__git_dir' '
>  	(
>  		__git_dir="non-existing" &&
> -		test_must_fail __git_find_repo_path &&
> +		! __git_find_repo_path &&
>  		printf "$__git_repo_path" >"$actual"
>  	) &&
>  	test_must_be_empty "$actual"
> @@ -313,7 +313,7 @@ test_expect_success '__git_find_repo_path - non-existing $GIT_DIR' '
>  	(
>  		GIT_DIR="$ROOT/non-existing" &&
>  		export GIT_DIR &&
> -		test_must_fail __git_find_repo_path &&
> +		! __git_find_repo_path &&
>  		printf "$__git_repo_path" >"$actual"
>  	) &&
>  	test_must_be_empty "$actual"
> @@ -362,7 +362,7 @@ test_expect_success '__git_find_repo_path - not a git repository' '
>  		cd non-repo &&
>  		GIT_CEILING_DIRECTORIES="$ROOT" &&
>  		export GIT_CEILING_DIRECTORIES &&
> -		test_must_fail __git_find_repo_path &&
> +		! __git_find_repo_path &&
>  		printf "$__git_repo_path" >"$actual"
>  	) &&
>  	test_must_be_empty "$actual"
> @@ -381,7 +381,7 @@ test_expect_success '__gitdir - finds repo' '
>  test_expect_success '__gitdir - returns error when cannot find repo' '
>  	(
>  		__git_dir="non-existing" &&
> -		test_must_fail __gitdir >"$actual"
> +		! __gitdir >"$actual"
>  	) &&
>  	test_must_be_empty "$actual"
>  '
> @@ -608,7 +608,7 @@ test_expect_success '__git_is_configured_remote' '
>  	git remote add remote_2 git://remote_2 &&
>  	(
>  		verbose __git_is_configured_remote remote_2 &&
> -		test_must_fail __git_is_configured_remote non-existent
> +		! __git_is_configured_remote non-existent
>  	)
>  '
>  
> 

I actually think that the use of test_must_fail has some merit in these
cases, because the shell function __git_find_repo_path runs `git
rev-parse` behind the scenes, and it runs it in such a way that
test_must_fail would do the right thing: the function just dispatches
into a handful of simple cases, each basically only with a variable
assignment, two of them in the form

	var=$(git rev-parse ...)

I would suggest to drop this patch.

-- Hannes
