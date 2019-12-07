Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11D5C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 20:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD492206DB
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 20:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFF5tszH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfLGUR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 15:17:28 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34120 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfLGUR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 15:17:28 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so3008721oig.1
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 12:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Fd2inb8ObwyvbmbpgWUeWZ74Jo5voyABp/p0VfdIlM=;
        b=pFF5tszHyvOUcqiNsDazvpBGjULG3v1MCNnkeAlPEPC5MB7peKwoYbNRuSUoxgdyK7
         rnmyws0D2/0IUzR+bOBnQQZ/A3r/FxwPmx1Tlxjz4aTVwgVoMQ/MnNZj3mIJTi03w2pk
         JR052C01lGBbSxYItm2/CPsfmZJxb9OelkOL+vQaC2m/ItvQYJ2HVKHDvAGPhv0xZuNL
         YYVwkYbL7TxvEMgdorLxK7v9CQEqtvvnFisvGqe9j8TuR92NCkAx9CuBr4bBf1zgYuf3
         GPrzQPk4dnREzd0QC47jYJZKD2XEBxD0L1nDMyjPh3Oy9yYNbT72ygEVHyOi5Wo6FlYP
         LIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Fd2inb8ObwyvbmbpgWUeWZ74Jo5voyABp/p0VfdIlM=;
        b=U9R9GIzvrVpGqG9Z2rVii5CbU1VGJDL3w1YJWjpCNtYkvLtG8+vuBgA7d/0Ek2Rc9d
         PggGQhYQdCTqoPbgZ1hUVJKeFReFy6DK5AZo7S2y1PLLPVF0nVUiUXz6nOyBAJOnoFdG
         WAKiAEQV/SAp/MWbJ93LtaNmTLsY+iNi/b3nbU8FC5xyAsYffueg1bvPikJC2Vk6zdOB
         NBopupVWhEjaBrLNt4lWzjZQpwlbOChNFITplpKo6CyNrwH6kWzOrKLPG2cjptId/YHb
         iQeoq10jrYXIzEjswr33hM4x+/u7xOBXJRJb+bEKryCWfm08ayhvhVA2CdTPkmQXSj1c
         4kVA==
X-Gm-Message-State: APjAAAXCMU5FqxCxqWcq5Uc1Of2/lMj3N7DEVRodENPtGF7CvMWmh1IH
        9g7f+eyY1qwFGiuLk5Q1kwI=
X-Google-Smtp-Source: APXvYqzAuL2MSbrvd4NN+gAYE2mJbJzpJObEV56TGgc/qbzsFbwbN/3G8y6O+P9Sxd1A/Oefef1Ldw==
X-Received: by 2002:aca:c5ca:: with SMTP id v193mr14506017oif.77.1575749847489;
        Sat, 07 Dec 2019 12:17:27 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u10sm3794307oic.57.2019.12.07.12.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 12:17:26 -0800 (PST)
Subject: Re: [PATCH] commit: use strbuf_add() to add a length-limited string
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <f4c7d65f-d7bb-c574-fe48-8d2df0c2907a@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5bc19b91-7579-357f-e241-32d3a763d9c5@gmail.com>
Date:   Sat, 7 Dec 2019 15:17:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <f4c7d65f-d7bb-c574-fe48-8d2df0c2907a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2019 6:16 AM, René Scharfe wrote:
> This is shorter and simpler.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 294dc574cd..35a1fb9ad6 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -537,7 +537,7 @@ static void export_one(const char *var, const char *s, const char *e, int hack)
>  	struct strbuf buf = STRBUF_INIT;
>  	if (hack)
>  		strbuf_addch(&buf, hack);
> -	strbuf_addf(&buf, "%.*s", (int)(e - s), s);
> +	strbuf_add(&buf, s, e - s);

I had to look up what "%.*s" does [1, 2] but this looks like
a behavior-equivalent (and possibly faster) way to do it.

-Stolee

[1] https://stackoverflow.com/a/49580164
[2] https://en.cppreference.com/w/c/io/fprintf


