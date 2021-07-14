Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B484C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F198613C2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhGNW7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbhGNW7x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:59:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E9AC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:57:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ee25so5374550edb.5
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=O5ycaDnzkxoo9UPg+h8Tn/6XprMOQPLOM6wOkZnMzsM=;
        b=Fo7V1krUJXN4iwL2g9D0ssScn45V33LsuGfQpMMeWO3608Jwo8rJKw26Xxu01V1tey
         aTpr8BF/PnfmH0WjJ0FSD/PlSHeT5Zm3El0NizB8TcsPu1YPNQsvfRIQO90oZkOroJjz
         yhVeUgWdXGCwg9SZ8IlekJwGPSZ6/tXKL1a7D4cjD2t2a/bvVpupsAhsLboScmsryM/O
         jF5gK2288WSCxgRgHPHuHN8Yavlu9X1V82wTNTLbhzaKUl2e6g0XSE/Me0BXuEg8HyAR
         MFkUd0bisnCONlEqNi2p4NXgJckzUQlYLObxcFQWy9pK2YBCjVoYexoMNXx+wlmzFBJE
         i5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=O5ycaDnzkxoo9UPg+h8Tn/6XprMOQPLOM6wOkZnMzsM=;
        b=e9zUFb3qQXM360YwcR7gT3z2IJpzLU6fdwbwFXLbyhCl9uA+ZB77mOk6ycUrVS9gCt
         dxhpzWlf+FUSqO+fcL2+VnwkVmKPMJ8idUtup9RMhUnZkutd0jFSuXbpwrHSkTZOCklH
         2H1CNZzRmq3XDan5IcErpOXZGSpD0zPr9lwfqyq4AgBSRWaFH6ASMACDFakynXt5Rmgq
         G8/a3k4SomdbYTuEha1VlGofChjzHKH7LmJYIGgu6khoAM3iEUL7oa58TyNiMyNCCJ64
         s2sMHzOZ74FVepmwN+H/F1qZQsjbuXqzUCwxOmh8sRwfSF+iuMGZHk0BvCPcr1XCcJi5
         h1Gg==
X-Gm-Message-State: AOAM533sN/aZ1VkY4pu2okTICqT/Ti0ne9X8vN1htK8Nywvw8Dp+gPR2
        nKXAIEII9lntWwErCKR/86I=
X-Google-Smtp-Source: ABdhPJyOJRuAMOUGVXNszb5t7cs7xsdb432DKXfhzckMr4uUGt3kYPeB4/r2AfqxUqTK3n3u5BvGYQ==
X-Received: by 2002:aa7:d352:: with SMTP id m18mr958400edr.235.1626303418858;
        Wed, 14 Jul 2021 15:56:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o14sm1621460edw.36.2021.07.14.15.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:56:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/4] SANITIZE tests: fix memory leaks in t13*config*,
 add to whitelist
Date:   Thu, 15 Jul 2021 00:56:21 +0200
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
 <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
Message-ID: <87h7gwzeps.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Andrzej Hunt wrote:

> On 14/07/2021 19:23, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix a couple of trivial memory leaks introduced in 3efd0bedc6 (config:
>> add conditional include, 2017-03-01) and my own 867ad08a26 (hooks:
>> allow customizing where the hook directory is, 2016-05-04).
>> In the latter case the "fix" is UNLEAK() on the global
>> variable. This
>> allows us to run all t13*config* tests under SANITIZE=3Dleak.
>> With this change we can now run almost the whole set of config.c
>> tests (t13*config) under SANITIZE=3Dleak, so let's do so, with a few
>> exceptions:
>>   * The test added in ce81b1da23 (config: add new way to pass config
>>     via `--config-env`, 2021-01-12), it fails in GitHub CI, but passes
>>     for me locally. Let's just skip it for now.
>>   * Ditto the split_cmdline and "aliases of builtins" tests, the
>> former
>>     required splitting up an existing test, there an issue with the test
>>     that would have also been revealed by skipping it.
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   config.c          | 17 ++++++++++++-----
>>   t/t1300-config.sh | 16 ++++++++++------
>>   t/test-lib.sh     |  1 +
>>   3 files changed, 23 insertions(+), 11 deletions(-)
>> diff --git a/config.c b/config.c
>> index f9c400ad30..38e132c0e2 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -138,8 +138,10 @@ static int handle_path_include(const char *path, st=
ruct config_include_data *inc
>>   		return config_error_nonbool("include.path");
>>     	expanded =3D expand_user_path(path, 0);
>> -	if (!expanded)
>> -		return error(_("could not expand include path '%s'"), path);
>> +	if (!expanded) {
>> +		ret =3D error(_("could not expand include path '%s'"), path);
>> +		goto cleanup;
>> +	}
>>   	path =3D expanded;
>>     	/*
>> @@ -149,8 +151,10 @@ static int handle_path_include(const char *path, st=
ruct config_include_data *inc
>>   	if (!is_absolute_path(path)) {
>>   		char *slash;
>>   -		if (!cf || !cf->path)
>> -			return error(_("relative config includes must come from files"));
>> +		if (!cf || !cf->path) {
>> +			ret =3D error(_("relative config includes must come from files"));
>> +			goto cleanup;
>> +		}
>>     		slash =3D find_last_dir_sep(cf->path);
>>   		if (slash)
>> @@ -168,6 +172,7 @@ static int handle_path_include(const char *path, str=
uct config_include_data *inc
>>   		ret =3D git_config_from_file(git_config_include, path, inc);
>>   		inc->depth--;
>>   	}
>> +cleanup:
>>   	strbuf_release(&buf);
>>   	free(expanded);
>>   	return ret;
>> @@ -1331,8 +1336,10 @@ static int git_default_core_config(const char *va=
r, const char *value, void *cb)
>>   	if (!strcmp(var, "core.attributesfile"))
>>   		return git_config_pathname(&git_attributes_file, var, value);
>>   -	if (!strcmp(var, "core.hookspath"))
>> +	if (!strcmp(var, "core.hookspath")) {
>> +		UNLEAK(git_hooks_path);
>>   		return git_config_pathname(&git_hooks_path, var, value);
>> +	}
>
> Why is the UNLEAK necessary here? We generally want to limit use of
> UNLEAK to cmd_* functions or direct helpers. git_default_core_config()=20
> seems generic enough that it could be called from anywhere, and using
> UNLEAK here means we're potentially masking a real leak?
>
> IIUC the leak here happens because:
> - git_hooks_path is a global variable - hence it's unlikely we'd ever
>   bother cleaning it up.
> - git_default_core_config() gets called a first time with
>   core.hookspath, and we end up allocating new memory into
>   git_hooks_path.
> - git_default_core_config() gets called again with core.hookspath,
>   and we overwrite git_hooks_path with a new string which leaks
>   the string that git_hooks_path used to point to.
>
> So I think the real fix is to free(git_hooks_path) instead of an
> UNLEAK? (Looking at the surrounding code, it looks like the same
> pattern of leak might be repeated for other similar globals - is it
> worth auditing those while we're here?)

Good point, I'll fix that.

I was doing this rather blindly to see if I could get this larg batch of
tests to pass with some a minimal fixes/whitelisting of some "known
bad".

>>     	if (!strcmp(var, "core.bare")) {
>>   		is_bare_repository_cfg =3D git_config_bool(var, value);
>> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>> index 9ff46f3b04..93ad0f4887 100755
>> --- a/t/t1300-config.sh
>> +++ b/t/t1300-config.sh
>> @@ -1050,12 +1050,16 @@ test_expect_success SYMLINKS 'symlink to nonexis=
tent configuration' '
>>   	test_must_fail git config --file=3Dlinktolinktonada --list
>>   '
>>   -test_expect_success 'check split_cmdline return' "
>> -	git config alias.split-cmdline-fix 'echo \"' &&
>> -	test_must_fail git split-cmdline-fix &&
>> +test_expect_success 'setup check split_cmdline return' "
>>   	echo foo > foo &&
>>   	git add foo &&
>> -	git commit -m 'initial commit' &&
>> +	git commit -m 'initial commit'
>> +"
>> +
>> +test_expect_success !SANITIZE_LEAK 'check split_cmdline return' "
>> +	git config alias.split-cmdline-fix 'echo \"' &&
>> +	test_must_fail git split-cmdline-fix &&
>> +
>>   	git config branch.main.mergeoptions 'echo \"' &&
>>   	test_must_fail git merge main
>>   "
>> @@ -1101,7 +1105,7 @@ test_expect_success 'key sanity-checking' '
>>   	git config foo."ba =3Dz".bar false
>>   '
>>   -test_expect_success 'git -c works with aliases of builtins' '
>> +test_expect_success !SANITIZE_LEAK 'git -c works with aliases of builti=
ns' '
>>   	git config alias.checkconfig "-c foo.check=3Dbar config foo.check" &&
>>   	echo bar >expect &&
>>   	git checkconfig >actual &&
>> @@ -1397,7 +1401,7 @@ test_expect_success 'git --config-env with missing=
 value' '
>>   	grep "invalid config format: config" error
>>   '
>>   -test_expect_success 'git --config-env fails with invalid
>> parameters' '
>> +test_expect_success !SANITIZE_LEAK 'git --config-env fails with invalid=
 parameters' '
>>   	test_must_fail git --config-env=3Dfoo.flag config --bool foo.flag 2>e=
rror &&
>>   	test_i18ngrep "invalid config format: foo.flag" error &&
>>   	test_must_fail git --config-env=3Dfoo.flag=3D config --bool foo.flag =
2>error &&
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 9201510e16..98e20950c3 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1370,6 +1370,7 @@ maybe_skip_all_sanitize_leak () {
>>   	add_sanitize_leak_true 't000*'
>>   	add_sanitize_leak_true 't001*'
>>   	add_sanitize_leak_true 't006*'
>> +	add_sanitize_leak_true 't13*config*'
>>     	# Blacklist patterns (overrides whitelist)
>>   	add_sanitize_leak_false 't000[469]*'
>>=20

