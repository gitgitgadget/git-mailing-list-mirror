Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076E8C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDDB860EB1
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 20:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhGVUKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhGVUKW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:10:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF84C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 13:50:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o3-20020a05600c5103b029024c0f9e1a5fso2045247wms.4
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gBpfHs4Y+Md4xGoc02GOUtguxt2hddEppC/CS79imwM=;
        b=ezFIBQRta6p62SN4ge1mCwQhUy1eVCt9ukHOuvSpWldVdhlA99c7qR6IgWFfoSk6pu
         lckvVU4kxQ4USMLGRa28XBo0q00lg3053riPOEKIIiKqMjscmVezYEFHjRZ2dGH7uv2p
         1c+s12BfvOSo/jkV/eWy2C2nU3Ev30NJAqjlzHd0ftsBHL2Wo/NVic4oyJi8GKKcCXaA
         93PIiYsqVT7KC4jrUSPbvkp6w6If3gyPbIPG4K8i7Tpv0I2/wGVKohmvbWoWjC3C3Spz
         eckfd52PhFjAsm9xXzm4qDyxC/qpEAnkA+CLTatLw4SD3oc57oCD33ITsLnTb16/RXf0
         Rk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gBpfHs4Y+Md4xGoc02GOUtguxt2hddEppC/CS79imwM=;
        b=QGUta8q+2S7p6GP/WrXcAlguyhFhfg1wD29ofOJ1X6NjgZPVxW2uebCIGqAZtWY0ws
         wNhvapWUOlawozrjI5aYY0tQIWT5pGS0fhfq7Sj3eTBpqiM5qHK0U92W8/XJALCRghUK
         Jcgwo6JxQazUnz4y/ZAMrfEYK7ftWBsUrcCf2F/+PHwppEMpmpQsxJeqiQVDeCwSv/oG
         q74Ta1OyadOWeK1m5rioaqwc8VX9v7l2SQ7mARvZC2uzhuEGinTSV+blexkkJcEgyHG6
         lVTeqifidjmQTcUp2NVEKvGxz3iOZaATadZparIsDPF4UlHFrsartOoD9Krev9TqVlia
         r+GQ==
X-Gm-Message-State: AOAM5308AwfagCsoAysJZ/Htt4yoSbxugGtR3fjLe/iIq2HVfOPJiirz
        I6M01U9o8rIdblR3AEra8zY=
X-Google-Smtp-Source: ABdhPJwy06ZwgCTOvuu0tDzdSuxOCt6XfStaUAGfjpmAop5ZIvj6d+t/UNqE9/wlLp1SFU5m0Df1Qg==
X-Received: by 2002:a05:600c:2104:: with SMTP id u4mr1350722wml.45.1626987055567;
        Thu, 22 Jul 2021 13:50:55 -0700 (PDT)
Received: from [10.10.18.13] ([212.102.57.75])
        by smtp.gmail.com with ESMTPSA id p5sm33928393wrd.25.2021.07.22.13.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 13:50:54 -0700 (PDT)
Subject: Re: [PATCH] setup: only die on invalid .git under RUN_SETUP
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tom Cook <tom.k.cook@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
 <patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <8fbf200c-2d88-dce2-84c3-ead330e975e8@gmail.com>
Date:   Thu, 22 Jul 2021 22:50:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/2021 16:07, Ævar Arnfjörð Bjarmason wrote:
> Change RUN_SETUP_GENTLY to stop dying if e.g. the .git is "not a
> repo". This means that we now recover in cases like:
> 
>      $ echo "gitdir: /foo/bar" > .git
>      $ git ls-remote https://github.com/torvalds/linux
>      [... ls-remote output ...]
> 
> But not (as intended):
> 
>      $ git rev-parse HEAD
>      fatal: not a git repository: /foo/bar
> 
> The relevant setup_git_directory_gently_1() invocation was added in
> 01017dce546 (setup_git_directory_gently_1(): avoid die()ing,
> 2017-03-13), but I could reproduce this as far back as Git v1.8.0. I
> don't know if this ever worked, but it should.
> 
> Let's also use the compiler to check enum arms for us, instead of
> having a "default" fall-though case, this changes code added in
> ce9b8aab5d9 (setup_git_directory_1(): avoid changing global state,
> 2017-03-13).
> 
> Reported-by: Tom Cook <tom.k.cook@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   setup.c            | 27 ++++++++++++++++++++++-----
>   t/t0002-gitfile.sh |  8 ++++++--
>   2 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/setup.c b/setup.c
> index eb9367ca5c..6ff145d58b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1033,7 +1033,8 @@ enum discovery_result {
>   	/* these are errors */
>   	GIT_DIR_HIT_CEILING = -1,
>   	GIT_DIR_HIT_MOUNT_POINT = -2,
> -	GIT_DIR_INVALID_GITFILE = -3
> +	GIT_DIR_INVALID_GITFILE = -3,
> +	GIT_DIR_GITFILE_NOT_A_REPO = -4,
>   };
>   
>   /*
> @@ -1118,8 +1119,11 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>   				/* NEEDSWORK: fail if .git is not file nor dir */
>   				if (is_git_directory(dir->buf))
>   					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
> -			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
> +			} else if (error_code == READ_GITFILE_ERR_NOT_A_REPO) {
> +				return GIT_DIR_GITFILE_NOT_A_REPO;
> +			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED) {
>   				return GIT_DIR_INVALID_GITFILE;
> +			}
>   		}
>   		strbuf_setlen(dir, offset);
>   		if (gitdirenv) {
> @@ -1209,6 +1213,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>   	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT;
>   	const char *prefix = NULL;
>   	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> +	int die_on_error = !nongit_ok;
> +	enum discovery_result discovery;
>   
>   	/*
>   	 * We may have read an incomplete configuration before
> @@ -1231,7 +1237,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
>   		die_errno(_("Unable to read current working directory"));
>   	strbuf_addbuf(&dir, &cwd);
>   
> -	switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
> +	discovery = setup_git_directory_gently_1(&dir, &gitdir, die_on_error);
> +
> +	switch (discovery) {
>   	case GIT_DIR_EXPLICIT:
>   		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, &repo_fmt, nongit_ok);
>   		break;
> @@ -1259,6 +1267,16 @@ const char *setup_git_directory_gently(int *nongit_ok)
>   			    dir.buf);
>   		*nongit_ok = 1;
>   		break;
> +	case GIT_DIR_GITFILE_NOT_A_REPO:
> +		if (!nongit_ok)
> +			die(_("not a git repository: %s"), dir.buf);
> +		*nongit_ok = 1;
> +		break;
> +	case GIT_DIR_INVALID_GITFILE:
> +		if (!nongit_ok)

Variable die_on_error could be used in two `if`s above.

> +			die(_("invalid .git file: %s"), dir.buf);
> +		*nongit_ok = 1;
> +		break;
>   	case GIT_DIR_NONE:
>   		/*
>   		 * As a safeguard against setup_git_directory_gently_1 returning
> @@ -1266,8 +1284,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>   		 * set startup_info->have_repository to 1 when we did nothing to
>   		 * find a repository.
>   		 */
> -	default:
> -		BUG("unhandled setup_git_directory_1() result");
> +		BUG("setup_git_directory_1() should not return GIT_DIR_NONE");
>   	}
>   
>   	/*
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> index 8440e6add1..176dc8c9dc 100755
> --- a/t/t0002-gitfile.sh
> +++ b/t/t0002-gitfile.sh
> @@ -21,13 +21,17 @@ test_expect_success 'initial setup' '
>   test_expect_success 'bad setup: invalid .git file format' '
>   	echo "gitdir $REAL" >.git &&
>   	test_must_fail git rev-parse 2>.err &&
> -	test_i18ngrep "invalid gitfile format" .err
> +	test_i18ngrep "invalid gitfile format" .err &&
> +
> +	git ls-remote "file://$REAL"
>   '
>   
>   test_expect_success 'bad setup: invalid .git file path' '
>   	echo "gitdir: $REAL.not" >.git &&
>   	test_must_fail git rev-parse 2>.err &&
> -	test_i18ngrep "not a git repository" .err
> +	test_i18ngrep "not a git repository" .err &&
> +
> +	git ls-remote "file://$REAL"
>   '
>   
>   test_expect_success 'final setup + check rev-parse --git-dir' '
> 

