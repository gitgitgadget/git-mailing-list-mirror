Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCDFC433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 14:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbiBLOnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 09:43:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiBLOno (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 09:43:44 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134C1214
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:43:40 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id fy20so28319798ejc.0
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cugE5WLXbErrWkRzyPoWOgZSPAyyAsXU2TSMZSriVGQ=;
        b=SEfX0NmZNSLSXMBdr4z5vEduAfui8YMoILOay+fMHHEjbecFS7tZMN+QzH4HmgPpYm
         62wLKRpErlo3UQ27qJlH4tWXGmdpepr/6oPeqpPUMxLdO4pc4VD+Ze7u3UEh7YFffdpT
         b5BFmz8ESl8kpBqmdD0J/mI+LASxdScIuEITEel7wPmukj5mzxryhHIfddUdQCvsqBme
         TMMZL5Rhoieitn6NZFoz6P4TCGq7JJlAmAkyplaqhblSkBIoi/F671vVzUFOAK7i2U7r
         iphtLr0winLLjpvnBNTx6ipbsuAMwR0NXi+XEaRzmFkrh7fNDW39kmzWeHpo9deH24h5
         PQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cugE5WLXbErrWkRzyPoWOgZSPAyyAsXU2TSMZSriVGQ=;
        b=lxoELEYzacJnwVcq1Csdo89JrC3BksrCiNhBHnHTwC5yk14sbQpcM3yxeCGcRArZVu
         xXRYalUmV2yhmOjzdIKeyzzHZQmj5GJKfKM4Vz1cg+M2D70fIIRBtsUvaWeCDtCkDTR4
         AgGqd5q8QwUEGmjdGElcf9jPY1sgLMW6T0MBXWu+eys9z/D3gVKkQnqD4YeV3taP0rzi
         U9DtwW7XSwkToy7FMhE0EWlgy2UbfasqY8gbnbleEAKgD20UWTnf5EQh9eTEtfVSubQr
         B0jMHKl4S0AQHT5VAuUsUoZq1e86yYHhFbwkPbKBG01gxvubkziJKlqmHkHI3uFdrX8Y
         QJvw==
X-Gm-Message-State: AOAM532zbjAXkqJkgmrK72kDECM4Scxtzu/aUsa8i3fDqaDtu2BoS8b9
        bRQ0j2QsrnPyixMwCVonqxjfi1KiBm4MYA==
X-Google-Smtp-Source: ABdhPJxz576pP626BwiGTgWU50/P/Z1E47z34R/NFoIdzditVs6jVH08ljYsWNznpkfbJaCJMpHUrA==
X-Received: by 2002:a17:907:96a9:: with SMTP id hd41mr5098995ejc.334.1644677018402;
        Sat, 12 Feb 2022 06:43:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i1sm5448514ejy.138.2022.02.12.06.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 06:43:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nItcf-000S2d-Dt;
        Sat, 12 Feb 2022 15:43:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v7 19/20] fixup! submodule--helper run-update-procedure:
 learn --remote
Date:   Sat, 12 Feb 2022 15:43:22 +0100
References: <20220208083952.35036-1-chooglen@google.com>
 <20220210092833.55360-1-chooglen@google.com>
 <20220210092833.55360-20-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220210092833.55360-20-chooglen@google.com>
Message-ID: <220212.86czjsxi06.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 10 2022, Glen Choo wrote:

> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  builtin/submodule--helper.c | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 98d8910930..5d5302b50b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2516,23 +2516,6 @@ static const char *remote_submodule_branch(const char *path)
>  	return branch;
>  }
>  
> -static int resolve_remote_submodule_branch(int argc, const char **argv,
> -		const char *prefix)
> -{
> -	const char *ret;
> -	struct strbuf sb = STRBUF_INIT;
> -	if (argc != 2)
> -		die("submodule--helper remote-branch takes exactly one arguments, got %d", argc);
> -
> -	ret = remote_submodule_branch(argv[1]);
> -	if (!ret)
> -		die("submodule %s doesn't exist", argv[1]);
> -
> -	printf("%s", ret);
> -	strbuf_release(&sb);
> -	return 0;
> -}
> -
>  static int push_check(int argc, const char **argv, const char *prefix)
>  {
>  	struct remote *remote;
> @@ -3484,8 +3467,6 @@ static struct cmd_struct commands[] = {
>  	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
>  	{"deinit", module_deinit, 0},
>  	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
> -	/* NEEDSWORK: remote-branch is also obsolete */
> -	{"remote-branch", resolve_remote_submodule_branch, 0},
>  	{"push-check", push_check, 0},
>  	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
>  	{"is-active", is_active, 0},

Ditto good fix-up, should squash this into the relevant commit.
