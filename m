Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B564C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 18:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67E761205
	for <git@archiver.kernel.org>; Sun, 30 May 2021 18:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhE3SUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 14:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhE3SUq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 14:20:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9B2C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 11:19:07 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qq22so4888067ejb.9
        for <git@vger.kernel.org>; Sun, 30 May 2021 11:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fgQHN8Pd9InC/XgrQ81/LAtUVATd2OQLaYn6dkCJVZ8=;
        b=C56mKbshf5a4TLHVxILDqUpIkJHai0yqRh11P/AN6Y9GmEGn0m9NFEYO30A1yGTQ/M
         SJOVQrjZFguWC41CS7IGHvPgUnLdUGR83DfCsACySp4iv7Poe59e21q6pu/ywENqlQuX
         JEXUbKNtwZl2byKvtcNZohIgPOu6FAQ+cMWztRnSVpPGyxyZ9maxqKjArsx/EDZrZqFY
         pcxRkl0/ywN+C9Cx27hy1YzOv76McyQz67k28J/W5B8vs2tQ9s0S/FfBx3dQgMQr49uh
         PIOJuD0NVKMN6B2iynpQTYWjDXqvWKtqV4oCh+nXRZ69YnZcHxQZCMe9B8+x9UiZ+cWk
         TYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fgQHN8Pd9InC/XgrQ81/LAtUVATd2OQLaYn6dkCJVZ8=;
        b=GngmS0VFCRNoA6awU6vi8gk3pXgeFMI2GI4YV/ouAm4PKzimUt8E2UYEkbfsBIgBTg
         2V+VRMxUL8WUuFkfCUMhYf2Oq506T3adleAi/qLvUjCbXOyIlWBPa8HSs4Jtb3vOGHKm
         7MXHPJnYlBGMnTZfNKjQHPPd1lR5/xCl9XSAdJWfcvQXjozBz30US6cjqlSY4twKgWVt
         ZMS1iGs7NnGm886fr8VfZJi4EU+fQvZoWkGd77TbShxMUnqwFGt1C0R1QvJoAAzm8eEK
         VNY/zN2s/tXUqJ4i88dcZ04xKJSg5NzfKBPiOTMR1hpp5Kt5WL5QZUUTxT3uFaqUyT17
         lbhw==
X-Gm-Message-State: AOAM533xxKWmu7SWRyCZevfo1YmGKuIBpR9Z8f2rgliosCTow066rfpn
        Pc72F0/H+S6cZy9S/eYZC7s=
X-Google-Smtp-Source: ABdhPJzJBXQDmmqE07It9jtVW592a6Why1oxwX3XLuYaMXwXboF5ZRxW2QGv9wQDYfZCQ0GxnoqnAw==
X-Received: by 2002:a17:906:a017:: with SMTP id p23mr19609369ejy.460.1622398745904;
        Sun, 30 May 2021 11:19:05 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:25d1:fff3:8887:500f? (2a02-8388-e002-8cf0-25d1-fff3-8887-500f.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:25d1:fff3:8887:500f])
        by smtp.googlemail.com with ESMTPSA id c14sm477489ejb.2.2021.05.30.11.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 11:19:05 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
From:   Mathias Kunter <mathiaskunter@gmail.com>
Message-ID: <acfafe6e-b0f3-ba2e-71f0-9bcc09b9d612@gmail.com>
Date:   Sun, 30 May 2021 20:19:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210529071115.1908310-7-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.05.21 um 09:11 schrieb Felipe Contreras:
> Now that the code has been simplified and it's clear what it's
> actually doing, update the documentation to reflect that.
> 
> Namely; the simple mode only barfs when working on a centralized
> workflow, and there's no configured upstream branch with the same name.
> 
> [...]
> 
> +* `simple` - pushes the current branch with the same name on the remote.
> +If you are working on a centralized workflow (pushing to the same repository you
> +pull from, which is typically `origin`), then you need to configure an upstream
> +branch with the same name.

I'd like to remark that I personally find the following description of 
`push.default=simple`, taken from the git push man page [1], easier to 
understand:

> The current branch is pushed to the corresponding upstream branch, but
> as a safety measure, the push is aborted if the upstream branch does not
> have the same name as the local one.

[1] https://git-scm.com/docs/git-push#_description
