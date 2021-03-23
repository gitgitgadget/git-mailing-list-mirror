Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53270C433E0
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 11:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17981619B9
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 11:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCWLlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCWLk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 07:40:27 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0038C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 04:40:26 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c6so14630489qtc.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L1dmtwWGz9mJVRPGc6IRRUi7Metp15I3nSkwKr8xWH8=;
        b=lla/kFA6ZmQiTti4XFLAyXcQPC/n8TvEsblr2LdxGxe4ogpttz/OCEbRzlLDyvjNuA
         7az4goA+4C6g+5UhRYnjxcPelq2BXDPpwgY5/SK2xivTBTk54yRhwmnpGqyRAt7+9O84
         BRANbGSmo+Bf41Z9r420N5O26AL8ZMNhVRQuSDaXZJEdGvgcIGPUC9mqnbo2BpTKJ0W5
         WqhUlIAnMRMAQ79vpS3+/YpaiHzFLx+Op89wbe8zbJFxFIDgRtwIWpJiFrkK10VfOfbF
         UcTrGRFXCbtPOi5424VfPglHHr4ibu/xMiY4gP1YwsiDTYiELFDDkdGYCqz6PDXXDdbQ
         626g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L1dmtwWGz9mJVRPGc6IRRUi7Metp15I3nSkwKr8xWH8=;
        b=fvZhUqsLOV1EDo7aAbm5NMMXfLcG8AnJmJwtKgOeXr72w4aCZ+DO0GGq07Ia43GX3C
         u/kMO7FNPU+SJRG1vcZ/H3lhh2dxvn78UVDSOTKI7q4ubunuzEJlschaPBVPKO39hugw
         CyVNJum6P2EDdiJjv93wJLRfcrG49IuMVxrgdYO457/IDtk91f29z1k3NBGhw3dE+GtC
         EeA6DhjmrkFi9uFf3/4a4GqdioyXGdo2Id/NhFZiZ1pFykUOFMyw91pMeqfaMMgD/veV
         Q3Z6WL2Whwi1/qwiAmAzoTxK+zyPdn4h7yf7v46miw43AS9hrlDjKbIZunYyK/iVrJ2v
         aflQ==
X-Gm-Message-State: AOAM532AXWWie8zDFjJF7lRzbEjttaIYfstFeat7EUjojV5okiwdiZOH
        i6uXRbs6gnCxG0UZPCUiEG0=
X-Google-Smtp-Source: ABdhPJy+Yt6aM5A6L/l2hWVn/TQd5sZ1SVK2q9XbH6GlKGMJY+C/6BFnHw53Y/DPHM5qTo3NPcUNRA==
X-Received: by 2002:ac8:7d42:: with SMTP id h2mr3972808qtb.182.1616499626101;
        Tue, 23 Mar 2021 04:40:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:19be:10a5:ec17:ace3? ([2600:1700:e72:80a0:19be:10a5:ec17:ace3])
        by smtp.gmail.com with ESMTPSA id v7sm12995648qkv.86.2021.03.23.04.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 04:40:24 -0700 (PDT)
Subject: Re: [PATCH v5 13/15] Reftable support for git-core
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
 <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <bdb19af22cc7c4f3383f03f42cb4906c3ec5c5f3.1615580397.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e754900a-1d5d-d4cc-aba6-737b37d66f74@gmail.com>
Date:   Tue, 23 Mar 2021 07:40:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bdb19af22cc7c4f3383f03f42cb4906c3ec5c5f3.1615580397.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/12/2021 3:19 PM, Han-Wen Nienhuys via GitGitGadget wrote:
> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> index 4e23d73cdcad..82c5940f1434 100644
> --- a/Documentation/config/extensions.txt
> +++ b/Documentation/config/extensions.txt
> @@ -6,3 +6,12 @@ extensions.objectFormat::
>  Note that this setting should only be set by linkgit:git-init[1] or
>  linkgit:git-clone[1].  Trying to change it after initialization will not
>  work and will produce hard-to-diagnose issues.
> ++

I noticed while resolving conflicts with my series, which also edits this
file, that the "+" line above should be removed. That likely munges the
fact that the config entry below should be its own list item, not a
continuation of the previous one.

> +extensions.refStorage::
> +	Specify the ref storage mechanism to use.  The acceptable values are `files` and
> +	`reftable`.  If not specified, `files` is assumed.  It is an error to specify
> +	this key unless `core.repositoryFormatVersion` is 1.
> ++
> +Note that this setting should only be set by linkgit:git-init[1] or
> +linkgit:git-clone[1].  Trying to change it after initialization will not
> +work and will produce hard-to-diagnose issues.

The only other conflict is that we are trying to write at the end of
the file. extensions.sparseIndex should go after this option.

Thanks,
-Stolee
