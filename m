Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A90C433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 14:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiBLOkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 09:40:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiBLOj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 09:39:59 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D57320F
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:39:56 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id d10so28422235eje.10
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=v+7B50t1Aoi9n5uUBUvX3bshoAbdBhdYupPIIIsd1VA=;
        b=eF+QnQFZ8P/SwDDvEdTELeLhp+pVEWAcX6pEkMelY3ZjRXU1amoZMz5aoRpUeypiMU
         Gq6rEpj178+yVfhE4T09QWQw6J5ZzhQ9Pr5XQGWLC+i2FMijZj7QpXyFfcCZPMTjjjBX
         S0wZKJ/5TVunJXXhkCDHaatcehUnRwK9csmZsNCHEL+zNH+C2sSfLNHJpPXP8lEVQQrs
         TBYBMXEv5eisDqUQO5LFRZ6PV2cfNYJ8QORGMxqb75qa71nZ3FEoTBHemb12QbQv6qjo
         /aotz04bmvO7C/t5gcLgQMjSrJj4A0ZCRqB0Q+kA9TeG+gmWiwbctGzBww55Vu6MNrX7
         v/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=v+7B50t1Aoi9n5uUBUvX3bshoAbdBhdYupPIIIsd1VA=;
        b=o02IqmBvpI1/OqXXGeZLuCj9Bw62V1MFhpiapyd+cLA/8HUpPvJVZsFoVqkHwVf3Zq
         SLK5YuRS/g2GymFV+NorVvZ4IDkCKTw+paFsEZ8r0SJ9QhUAje/0kaEpkTGZv5VPn6NU
         1HI+JzzA1r4Ew3ikSFqbLhkyGdc5hj4JY+JDMflXo/fXStnFGTRPyfhQgSNLcP20f9mg
         1HLFTXfn9rUZmdwGRYWOKSNdpzVZirurKtZoXlXkTdCdqffkC+cyQhsh2DVdFwbnyMQN
         gBNfrchKvA0QDyTy2EPr/kmcWVVeYKBT/y2CBrLs32jj2rQlJiISxw7yl8qPB7OJD5k8
         MtWw==
X-Gm-Message-State: AOAM531a4r3FD3NMT6dxshewcq/+1zOBll5Af0AEGUvRMNOiIj6vILK+
        huLAmQdDX/4UUbate6aEJscxSGlJy6eJOA==
X-Google-Smtp-Source: ABdhPJwPFqQATzZSo9UOVX1lAzDCiZvp9t8nX+vl1uSKboA1uIqbnHRQm19p2MeQRDh0gsX8MGubGA==
X-Received: by 2002:a17:907:d0f:: with SMTP id gn15mr5220852ejc.195.1644676794251;
        Sat, 12 Feb 2022 06:39:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h1sm8708437ejt.122.2022.02.12.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 06:39:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nItZ3-000RqR-9b;
        Sat, 12 Feb 2022 15:39:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v7 12/20] submodule--helper run-update-procedure: learn
 --remote
Date:   Sat, 12 Feb 2022 15:38:23 +0100
References: <20220208083952.35036-1-chooglen@google.com>
 <20220210092833.55360-1-chooglen@google.com>
 <20220210092833.55360-13-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220210092833.55360-13-chooglen@google.com>
Message-ID: <220212.86pmnsxi6e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 10 2022, Glen Choo wrote:

>  #define UPDATE_DATA_INIT { \
>  	.update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT, \
> @@ -2585,6 +2571,8 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
>  		OPT_CALLBACK_F(0, "oid", &opt.oid, N_("sha1"),
>  			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
>  			       parse_opt_object_id),
> +		OPT_BOOL(0, "remote", &opt.remote,
> +			 N_("use SHA-1 of submodule's remote tracking branch")),

For some things the references to SHA-1 are faithfully copying existing
test, but for new things let's use "object" instead.
