Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899D9C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682826100B
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhGNTAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:00:44 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:56956 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhGNTAo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 15:00:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 22450E4A;
        Wed, 14 Jul 2021 20:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1626289069; x=1628103470; bh=rvErS8iRILyrWpF6ep0
        rFxvvkvFJ93b7hydcfK54JaU=; b=QNhj5PdcdZDelacy8ET3ZvhRUkhEbFMSK6J
        zC537ZXvEN72g66oOI3IL55y+6PqtrSlYkKkTJRfbmMuHrNJUs56QuOY+y0DKZKb
        7nzMBXr9etJ1exTCvxapy522sj91rP7nRnvEMlZQxieDFZlxSgMA2hpqhNe7y98a
        pCt4LUOmk1grpsHsYp4QS/0UUx7rGDbTNm1V6kGjM1028UjSchLKCm7stB1PaQCZ
        wZjzE4nUW1HCqrJOAdjIg04d/TT9e0XCJri8fozBMnF5Bzz0SFKX5UOcT3dN7eqt
        ZDWBj4NTuQlYcvG3LeVVYBFE2OOemwbqO6nXyFVBX2Lub23nQESKWiYEFCWLwICp
        eYWbAHfN97jPyikYBKSXw/4UQr7LRia9ll4tWiIbZkHDKyyREGOIumyglJ5v1ll9
        b5R6r8w7MPcJPW30V1+m3u23S065uN0EsGwAhwXNv6ZmVuSTG/lVxkwHYbwKurTS
        8u2tjS2Hnhs3xs7aBF3iqLzrt6Ddx62L+6VmydDVJuYReMzCGSoUsF2pXWHmd4mL
        T2dEH8Erfk9ZPcIOcHNmYcFdiEu4yOqOTjycqp+AiYLLBBtijbjXvLbn1XlubCc0
        aQeUCYICO1pSEElnE6CDSxpJQPfv41zq09v4TWjlQANZiNMPSngd5FzO1ZIm5WtF
        MD20xbjg=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wVU4ld8zhPPI; Wed, 14 Jul 2021 20:57:49 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id E7E8DBCD;
        Wed, 14 Jul 2021 20:57:47 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id A750443FA;
        Wed, 14 Jul 2021 20:57:40 +0200 (CEST)
Subject: Re: [PATCH v2 2/4] SANITIZE tests: fix memory leaks in t13*config*,
 add to whitelist
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
Date:   Wed, 14 Jul 2021 20:57:37 +0200
MIME-Version: 1.0
In-Reply-To: <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/07/2021 19:23, Ævar Arnfjörð Bjarmason wrote:
> Fix a couple of trivial memory leaks introduced in 3efd0bedc6 (config:
> add conditional include, 2017-03-01) and my own 867ad08a26 (hooks:
> allow customizing where the hook directory is, 2016-05-04).
> 
> In the latter case the "fix" is UNLEAK() on the global variable. This
> allows us to run all t13*config* tests under SANITIZE=leak.
> 
> With this change we can now run almost the whole set of config.c
> tests (t13*config) under SANITIZE=leak, so let's do so, with a few
> exceptions:
> 
>   * The test added in ce81b1da23 (config: add new way to pass config
>     via `--config-env`, 2021-01-12), it fails in GitHub CI, but passes
>     for me locally. Let's just skip it for now.
> 
>   * Ditto the split_cmdline and "aliases of builtins" tests, the former
>     required splitting up an existing test, there an issue with the test
>     that would have also been revealed by skipping it.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   config.c          | 17 ++++++++++++-----
>   t/t1300-config.sh | 16 ++++++++++------
>   t/test-lib.sh     |  1 +
>   3 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/config.c b/config.c
> index f9c400ad30..38e132c0e2 100644
> --- a/config.c
> +++ b/config.c
> @@ -138,8 +138,10 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>   		return config_error_nonbool("include.path");
>   
>   	expanded = expand_user_path(path, 0);
> -	if (!expanded)
> -		return error(_("could not expand include path '%s'"), path);
> +	if (!expanded) {
> +		ret = error(_("could not expand include path '%s'"), path);
> +		goto cleanup;
> +	}
>   	path = expanded;
>   
>   	/*
> @@ -149,8 +151,10 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>   	if (!is_absolute_path(path)) {
>   		char *slash;
>   
> -		if (!cf || !cf->path)
> -			return error(_("relative config includes must come from files"));
> +		if (!cf || !cf->path) {
> +			ret = error(_("relative config includes must come from files"));
> +			goto cleanup;
> +		}
>   
>   		slash = find_last_dir_sep(cf->path);
>   		if (slash)
> @@ -168,6 +172,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>   		ret = git_config_from_file(git_config_include, path, inc);
>   		inc->depth--;
>   	}
> +cleanup:
>   	strbuf_release(&buf);
>   	free(expanded);
>   	return ret;
> @@ -1331,8 +1336,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>   	if (!strcmp(var, "core.attributesfile"))
>   		return git_config_pathname(&git_attributes_file, var, value);
>   
> -	if (!strcmp(var, "core.hookspath"))
> +	if (!strcmp(var, "core.hookspath")) {
> +		UNLEAK(git_hooks_path);
>   		return git_config_pathname(&git_hooks_path, var, value);
> +	}

Why is the UNLEAK necessary here? We generally want to limit use of 
UNLEAK to cmd_* functions or direct helpers. git_default_core_config() 
seems generic enough that it could be called from anywhere, and using 
UNLEAK here means we're potentially masking a real leak?

IIUC the leak here happens because:
- git_hooks_path is a global variable - hence it's unlikely we'd ever
   bother cleaning it up.
- git_default_core_config() gets called a first time with
   core.hookspath, and we end up allocating new memory into
   git_hooks_path.
- git_default_core_config() gets called again with core.hookspath,
   and we overwrite git_hooks_path with a new string which leaks
   the string that git_hooks_path used to point to.

So I think the real fix is to free(git_hooks_path) instead of an UNLEAK? 
(Looking at the surrounding code, it looks like the same pattern of leak 
might be repeated for other similar globals - is it worth auditing those 
while we're here?)

>   
>   	if (!strcmp(var, "core.bare")) {
>   		is_bare_repository_cfg = git_config_bool(var, value);
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 9ff46f3b04..93ad0f4887 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1050,12 +1050,16 @@ test_expect_success SYMLINKS 'symlink to nonexistent configuration' '
>   	test_must_fail git config --file=linktolinktonada --list
>   '
>   
> -test_expect_success 'check split_cmdline return' "
> -	git config alias.split-cmdline-fix 'echo \"' &&
> -	test_must_fail git split-cmdline-fix &&
> +test_expect_success 'setup check split_cmdline return' "
>   	echo foo > foo &&
>   	git add foo &&
> -	git commit -m 'initial commit' &&
> +	git commit -m 'initial commit'
> +"
> +
> +test_expect_success !SANITIZE_LEAK 'check split_cmdline return' "
> +	git config alias.split-cmdline-fix 'echo \"' &&
> +	test_must_fail git split-cmdline-fix &&
> +
>   	git config branch.main.mergeoptions 'echo \"' &&
>   	test_must_fail git merge main
>   "
> @@ -1101,7 +1105,7 @@ test_expect_success 'key sanity-checking' '
>   	git config foo."ba =z".bar false
>   '
>   
> -test_expect_success 'git -c works with aliases of builtins' '
> +test_expect_success !SANITIZE_LEAK 'git -c works with aliases of builtins' '
>   	git config alias.checkconfig "-c foo.check=bar config foo.check" &&
>   	echo bar >expect &&
>   	git checkconfig >actual &&
> @@ -1397,7 +1401,7 @@ test_expect_success 'git --config-env with missing value' '
>   	grep "invalid config format: config" error
>   '
>   
> -test_expect_success 'git --config-env fails with invalid parameters' '
> +test_expect_success !SANITIZE_LEAK 'git --config-env fails with invalid parameters' '
>   	test_must_fail git --config-env=foo.flag config --bool foo.flag 2>error &&
>   	test_i18ngrep "invalid config format: foo.flag" error &&
>   	test_must_fail git --config-env=foo.flag= config --bool foo.flag 2>error &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9201510e16..98e20950c3 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1370,6 +1370,7 @@ maybe_skip_all_sanitize_leak () {
>   	add_sanitize_leak_true 't000*'
>   	add_sanitize_leak_true 't001*'
>   	add_sanitize_leak_true 't006*'
> +	add_sanitize_leak_true 't13*config*'
>   
>   	# Blacklist patterns (overrides whitelist)
>   	add_sanitize_leak_false 't000[469]*'
> 
