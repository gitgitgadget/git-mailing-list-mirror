Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84194C4167B
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 01:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiK3BJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 20:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiK3BJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 20:09:08 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B467D6150C
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 17:09:07 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g10so15142203plo.11
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 17:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBMXcyFTsfpDXiEJ+tf7BMcQjMLVz0uFAcwUJLNhQ54=;
        b=Xac2R0Lp39J+s8yLN2eW+KM3TGPKBrZ31oGgo83VV5qxo14vpr3CTm0DoxZkQqelZd
         D/oTsuY1GhaSszE0GfbO6yHRTPbWMf9KkJdgB8yy81JdpLYdSJopeU9jTHUYjjX59vDE
         zgVUne6DicA+2UTcV/vv7TnnL8hkgX7lyZ7nYViUYcfCyqu1Nc8Wi2B4MqVrYrzO9LpS
         RgscKIp6sjN0AX/Qh2/afAEJuOCCLI1SFxlj8Srw67LdCVZXaJDiivxFREDrkOAz5lE2
         6G84CgSjbThPs8HJjPZHY5fwqWPhXKodyv8ytQkXFzMylK442p38rW3ybLBj/wdAghJ2
         j4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBMXcyFTsfpDXiEJ+tf7BMcQjMLVz0uFAcwUJLNhQ54=;
        b=gZskmnyBAvrnSV06sIfPJhCOEvZmJFnN8/VaFsNxz7qOqks+15Jxy+xxmoGUbAaiyx
         c/wmxXuNlYCQgwOR9g4lwltNCE8K9hgIQcpTAdQgQTTZvmw2yWIFd26ZX3cjj7neXfyu
         1uXj/qETPSqZn5m3qQzw65jZr8xThA3+YN++UJb8J6JaF/MDPqGtKWbrMO0ISVjhdB0k
         pSI4z8eqbFvSv7P7UbDUUGa9mZbrzoXkbWmMJGNTXjzjdYm/AxwsKwrL/ZnIsy+RPxgG
         l1rJyeH+F5if4ev07szdmqsRnTfdFVp4EZNdCCMzgnbOSYqn+Ham8r+T5nAo92yhvbVc
         TI6w==
X-Gm-Message-State: ANoB5plXmPFXWIu5PbBfsYePQk0jaRfxJGxs+wlmubTw3C/u5zAMVbxA
        UgNfvvANTKR6AADXpeKUDNNqN2qBFAuG0A==
X-Google-Smtp-Source: AA0mqf6JOo6BNHiKE0Ubzww08hGCwxviYUaLVh+ILBbhwNPk9vfLT8k45DltKgZEefbPIJ1QhjRRcQ==
X-Received: by 2002:a17:90b:3809:b0:20a:c64c:ae80 with SMTP id mq9-20020a17090b380900b0020ac64cae80mr52186617pjb.12.1669770547097;
        Tue, 29 Nov 2022 17:09:07 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u64-20020a626043000000b005751f455e0esm98848pfb.120.2022.11.29.17.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 17:09:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] pack-objects: fix handling of multiple --filter
 options
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
        <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
        <6c7ef5fb-59b5-df16-036d-9a9a3d987cb0@web.de>
Date:   Wed, 30 Nov 2022 10:09:05 +0900
In-Reply-To: <6c7ef5fb-59b5-df16-036d-9a9a3d987cb0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 29 Nov 2022 13:23:53 +0100")
Message-ID: <xmqq7czd2qq6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Since 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't
> leak, 2022-03-28) --filter options given to git pack-objects overrule
> earlier ones, letting only the leftmost win and leaking the memory
> allocated for earlier ones.  Fix that by only initializing the rev_info
> struct once.

I think "leftmost" -> "rightmost", if your command line goes from
left to right?  Or "leftmost" -> "last" (e.g. "last one wins" over
"earlier ones")?

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/pack-objects.c                 | 3 ++-
>  t/t5317-pack-objects-filter-objects.sh | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 573d0b20b7..c702c09dd4 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4158,7 +4158,8 @@ static struct list_objects_filter_options *po_filter_revs_init(void *value)
>  {
>  	struct po_filter_data *data = value;
>
> -	repo_init_revisions(the_repository, &data->revs, NULL);
> +	if (!data->have_revs)
> +		repo_init_revisions(the_repository, &data->revs, NULL);
>  	data->have_revs = 1;
>
>  	return &data->revs.filter;
> diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
> index 25faebaada..5b707d911b 100755
> --- a/t/t5317-pack-objects-filter-objects.sh
> +++ b/t/t5317-pack-objects-filter-objects.sh
> @@ -265,7 +265,7 @@ test_expect_success 'verify normal and blob:limit packfiles have same commits/tr
>  	test_cmp expected observed
>  '
>
> -test_expect_failure 'verify small limit and big limit results in small limit' '
> +test_expect_success 'verify small limit and big limit results in small limit' '
>  	git -C r2 ls-files -s large.1000 >ls_files_result &&
>  	test_parse_ls_files_stage_oids <ls_files_result |
>  	sort >expected &&
> --
> 2.38.1
