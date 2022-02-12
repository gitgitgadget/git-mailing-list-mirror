Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A138C433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 14:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiBLOgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 09:36:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiBLOgP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 09:36:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3709AB0B
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:36:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y17so18588908edd.10
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=yLK15Em11uoBOe+7NosjN4h8TNdNblQEMoeaQ5AYLw8=;
        b=B9j2SXQ2BY4Kg1BbvuoW4S2ZXX0YHsf4NybfoDFgSs+fMu32aEP5BlZtc4qHYWnywp
         zFSA6VPDbwFeMDNaNxTPZuQ1iirKXjhx2Yk9mrN/WUPsSO6Q780FScjTk293iIilJzOd
         /plztv7URcVQ50ywNDK8cc1x3QWZEZWZ/RTBuKGnklo8p+aubkBqBIfDIDkuJ2civqct
         XV/PMfojN1OfpdqnHp2Yxk0TEj3YIx54E0owJAuEA0B/r6GeoLi2zctwfn/c6CTM/zL3
         ihcQVGsveS26XrMqhgJlVH6Vis6bB139AbGzmNMK8wBU79qn3E3FhS3NUS+8PI0PAbj1
         FDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=yLK15Em11uoBOe+7NosjN4h8TNdNblQEMoeaQ5AYLw8=;
        b=OMLQPNMi+qJvGpWlvN3cDfvcPWzC5RpTd1n2YnovTcbXiJsyO6dAJYSLnOQY/t3zpl
         VwnFYnUGmZdgcQUlEA//JJUAfUmpFmKjF/pp/KvHqGgL6Hhc6PPsjklicyAXu7HtNTo1
         Ybj5rJm2INx9KJJgFvvxrJyLGvnOp9wL56HQ+QiuLFQVHIIoG8EGt73rghXXCm3w6LAx
         JQKor9QNGORVabyViIzY2nONZPa4Q+xuI0obU0TMzi3XA3mayjsKaKpR68CFfzLpDG5J
         56XeShWDxuYIjrlbcJrgCmrVkT4eYLV8zAZSuk/reyKxoHrFQxEYsX6KQbLzD+IbDUct
         REkQ==
X-Gm-Message-State: AOAM533XzGb7hW+4y8E1C65FuZLLzaDDBmSIA5x7YD/boU8+K+rxqteG
        28vKPpUO1S/Aw8p7b1w6++GXoEXrSVfmIQ==
X-Google-Smtp-Source: ABdhPJxCPP0Ky5a2jy7+s4dkyc9u56qZoGiRHr5ztDjvzi1r0zW+nmWH+tX9pE73ri5FnhUcH8M1Bg==
X-Received: by 2002:a05:6402:5203:: with SMTP id s3mr6793067edd.389.1644676570410;
        Sat, 12 Feb 2022 06:36:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n2sm9209653ejl.55.2022.02.12.06.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 06:36:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nItVR-000RfZ-EG;
        Sat, 12 Feb 2022 15:36:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v7 09/20] submodule--helper: remove update-module-mode
Date:   Sat, 12 Feb 2022 15:35:12 +0100
References: <20220208083952.35036-1-chooglen@google.com>
 <20220210092833.55360-1-chooglen@google.com>
 <20220210092833.55360-10-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220210092833.55360-10-chooglen@google.com>
Message-ID: <220212.86tud4xicm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 10 2022, Glen Choo wrote:

> This is dead code - it has not been used since c51f8f94e5
> (submodule--helper: run update procedures from C, 2021-08-24).
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  builtin/submodule--helper.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 4a0890954e..e0cc1c1b79 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1965,29 +1965,6 @@ static void determine_submodule_update_strategy(struct repository *r,
>  	free(key);
>  }
>  
> -static int module_update_module_mode(int argc, const char **argv, const char *prefix)
> -{
> -	const char *path, *update = NULL;
> -	int just_cloned;
> -	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
> -
> -	if (argc < 3 || argc > 4)
> -		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
> -
> -	just_cloned = git_config_int("just_cloned", argv[1]);
> -	path = argv[2];
> -
> -	if (argc == 4)
> -		update = argv[3];
> -
> -	determine_submodule_update_strategy(the_repository,
> -					    just_cloned, path, update,
> -					    &update_strategy);
> -	fputs(submodule_strategy_to_string(&update_strategy), stdout);
> -
> -	return 0;
> -}
> -
>  struct update_clone_data {
>  	const struct submodule *sub;
>  	struct object_id oid;
> @@ -3388,7 +3365,6 @@ static struct cmd_struct commands[] = {
>  	{"name", module_name, 0},
>  	{"clone", module_clone, 0},
>  	{"add", module_add, SUPPORT_SUPER_PREFIX},
> -	{"update-module-mode", module_update_module_mode, 0},
>  	{"update-clone", update_clone, 0},
>  	{"run-update-procedure", run_update_procedure, 0},
>  	{"ensure-core-worktree", ensure_core_worktree, 0},

Nice catch!

Re my comment on 04/20 in <220212.86y22gxig0.gmgdl@evledraar.gmail.com>
at least 04..09/20 could be split into such a "trivial refactors for
later changes" series, and it would make sense to lead with this (and
any other deletions of already-dead code).
