Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876C3C4332F
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 11:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354824AbhKYLFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354873AbhKYLDI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 06:03:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40591C061785
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 02:59:00 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so23702665edd.13
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 02:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kvibf2vZLNk8KQmi4P597egd6dBhrnHlGpWgLtn5g+4=;
        b=MClIDNMrlCOXksecpqiejjQYCGyBIi+1caNXkJKIJXxTy77gNL/IFNGNUAt0Xcm0r6
         bpswjwn23hNFZ9AmtgP6VTiAI9FVUx/xgYeEEt0pFHD7jseAcA4/g8QVibOcSz37Yka4
         BF9fdNaKR/VSHOiXQCERyWMcEpKVW5s/CuC2NPP9ZQXZALzPAwWpwd+rayjIIOgZ9UOR
         IV/jQy6z82v6ShcWK6jOJ7BcwaRG7y6x8hjqExMc1U6eLLYoloLc1PDPmW5j9MW53XIq
         ZlZ/6banUOHHfyI9EIgiJlS4ez8k3tE8ZM4z6jiDJ+x/7wHqnB/53hO2Rm012wABmQu4
         FHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kvibf2vZLNk8KQmi4P597egd6dBhrnHlGpWgLtn5g+4=;
        b=UObtEk2OAEwGJ8jmVuRoh19XLS50sF04+DB60ntyjcVNWQE1fWj8TaROcNmFGUY9/r
         QKUCiIVtCrdn319euK3r+1OWO11T8IMoliW5I7z/UxyRy3snho9K4S17/gNmJwwy2erX
         Uje+bQbsRCcywuzVmUZJiqkK+8zNPRdkG4iLRzeED12Iwl8XSYTboGUnBt5MeNKc+Voj
         Pm2tjPTMiagpJVyH9zaZr62YQT4MnFmfO8h+PN3fL0J7ErEOZcIhURpg+1XzpUDiDQ28
         RAacwSKCtbl7zzJ4eXmenVWRq2zV0qscsD80sJ/4O/Nlujeo5E78uZxjGnAq/THZO9oF
         IOrw==
X-Gm-Message-State: AOAM531fWh2+pd6Nk4yyUWPrDgnRnwpw3ZDk/zOCuKAM5kvDAwEMzVS3
        DBQOmIw1f1LIhFm1Jp0mtdIjLYQrgWU=
X-Google-Smtp-Source: ABdhPJynbnlPbhL7CSz9BSI31NnSWx4BAdcOBgS7Pevo5OlkhkqxVkElCFR7ISv73HNtY41RVDuq/Q==
X-Received: by 2002:a17:907:9482:: with SMTP id dm2mr29645398ejc.497.1637837938536;
        Thu, 25 Nov 2021 02:58:58 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cy26sm1644510edb.7.2021.11.25.02.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 02:58:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqCSv-0004kD-Fb;
        Thu, 25 Nov 2021 11:58:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 7/9] stash: do not attempt to remove
 startup_info->original_cwd
Date:   Thu, 25 Nov 2021 11:58:04 +0100
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <edec0894ca2a01c7afbc70590efd5ee8a0d1abde.1637829556.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <edec0894ca2a01c7afbc70590efd5ee8a0d1abde.1637829556.git.gitgitgadget@gmail.com>
Message-ID: <211125.8635nkjyby.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 25 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/stash.c      | 6 +++++-
>  t/t2501-cwd-empty.sh | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index a0ccc8654df..50b4875980c 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1485,8 +1485,12 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  			struct child_process cp = CHILD_PROCESS_INIT;
>  
>  			cp.git_cmd = 1;
> +			if (startup_info->original_cwd &&
> +			    *startup_info->original_cwd &&
> +			    !is_absolute_path(startup_info->original_cwd))
> +				cp.dir = startup_info->original_cwd;
>  			strvec_pushl(&cp.args, "clean", "--force",
> -				     "--quiet", "-d", NULL);
> +				     "--quiet", "-d", ":/", NULL);

I saw you used :/ earlier in 01, and I commented that maybe we can use
".".

Right now I can't remember the difference. I think for tired reviewer
eyes it would really help to amend the commit message to call out what
desired behavior change we're getting to by adding this pathspec.
