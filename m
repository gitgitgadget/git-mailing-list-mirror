Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5774C4708D
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 10:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiL2KQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 05:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiL2KNl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 05:13:41 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E14B4E
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 02:07:30 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 78so12097844pgb.8
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 02:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3OxFf6SNF27vlAwBdLWhT6kKXWcHPGLxXLnSiXD1i0=;
        b=Oi8IE3b1/+igIDUjX78QtCdIkRQczPQlXyRaEpVl0nohVWaE8EbkQVW3bTd588XyV/
         VdrQq3zY7FPWCzPfBheayzZO+WtW3eFQK1ZWua+4tQlZG/pzM8OJLhv5SbPIXRWV6DJL
         s/cphX2ugltd5YoaPIDrlP0A1tKSreGV+k/oRsqmp1Hz3iTHWFnzKRkLVlpEsfKk5GWk
         DnWi6+h24gyuJs4b62uSQre60g/jG7xGU2oECx+xFuTpDMCr0XoaZuDNo0zFD+qqbeSa
         xSUB1Gk5dfD9qpu/g8Mu2WhdLG17287/bkfLyGu7ZFMYjPof2FVjOfWNdwHiiE6kQo8b
         XShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F3OxFf6SNF27vlAwBdLWhT6kKXWcHPGLxXLnSiXD1i0=;
        b=v9h36ME78d+Qe8VOSF+OJ+npyYUQS/QWAA/AQj2XBY8B0k/zRCEYKa62qdY0651swU
         eDYe+NiYD+J/domysReshu9nW7qXJLQYnZTVovLbfickkO4Rc85TxrIgBdVAZ+UKsaFb
         EHSh6RkR+ebQI9KChYsIv546SA7GEzd86ET2VBapmtqTJ3lviAenJ9wO7Rk0kNrtLTp3
         QOhrOt4lox+E8n9HjdROj6mwk30ursi0p74bvoE3KI0xfs6AvTThYwFP8d9z6hdPP8rl
         TJAvShZvdn9PviE/CpSDDBgh90mhS1IZqVM0acYCaeZ8yQUT3NxWhUwMn0eOgc7K5KNg
         1OIg==
X-Gm-Message-State: AFqh2krRepj6+Nq5Mnu2jScfERL7akfBWlp8PpY9VkXoUaQMAae8Rout
        ZP8FfRtHr2yLNURpO+7zozA=
X-Google-Smtp-Source: AMrXdXsnmq1Kyl6n/uo+1W0i+qLBjeuUhMCqdsBciNBagkVflTR2D5xqXv6zNVHHfCZ/nl0SxWh9+g==
X-Received: by 2002:aa7:9143:0:b0:580:cfbd:3fd3 with SMTP id 3-20020aa79143000000b00580cfbd3fd3mr20739607pfi.26.1672308449748;
        Thu, 29 Dec 2022 02:07:29 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z189-20020a6265c6000000b0057630286100sm11672376pfb.164.2022.12.29.02.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 02:07:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 2/4] worktree add: refactor opt exclusion tests
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221228061539.13740-1-jacobabel@nullpo.dev>
        <20221228061539.13740-3-jacobabel@nullpo.dev>
        <xmqq5ydvpu1o.fsf@gitster.g> <20221229065142.fmfviwisjmxsey7b@phi>
Date:   Thu, 29 Dec 2022 19:07:28 +0900
In-Reply-To: <20221229065142.fmfviwisjmxsey7b@phi> (Jacob Abel's message of
        "Thu, 29 Dec 2022 06:51:53 +0000")
Message-ID: <xmqqa636mskf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> Yes for these particular tests that should be acceptable. I tried putting an
> alternative together that still provides an avenue for handling quoted
> arguments without the helper [1]. Would this work?
>
> 1. https://lore.kernel.org/git/20221229063823.ij3jjuaar2fsayju@phi/

Do we even need to handle an argument with $IFS whitespaces in it in
these tests?  

If not, using "$@" where we pass the args to the commands we run,
and using "$*" where we merely use it for human readable messages,
would be sufficient.



