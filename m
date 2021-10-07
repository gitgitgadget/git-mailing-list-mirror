Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C48C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 02:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D366105A
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 02:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhJGCKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 22:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhJGCKI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 22:10:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14403C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 19:08:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v18so16955667edc.11
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 19:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nQ8OG8r/skIMMCcEgtpMz3KQuyhxLsiM2sRQvLoAkpE=;
        b=AZTH89NL8kn4EV4tx4KLp6M6vUgGxvqCswtvzgZJWadEF4sApOeEYxnUl5twTghlu6
         qEsebOAiKnDCAVDxpVXgMtlxDUCIR1hqyUIQTWqI9tcwHJiurcIz+EuGUnoGtUH34y6w
         qQb/4anTG0GUiA/1usuQFLb5RaA1rIvv2gQkRI4q0yiaSnRjWbCTqWEOt8K9VP4OvGO+
         b8qAH2XmfG/+L1Ejqyd2FZD8/CgyBcEyjrrwbQhSeFHFmmD2vcwSOGmHAoUMDumVPUr1
         QNVw+RKqf8e+TwMn963fFxxeoYUaFaEHF9nrn8sAqcySo6dAfEd5Y2wPAIT+lIMMU2FQ
         ckOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nQ8OG8r/skIMMCcEgtpMz3KQuyhxLsiM2sRQvLoAkpE=;
        b=UHCf3OqGLiwnQ5SPOMZNGjifTYTT4GYJCRwmEoj2bahDU/1KqgVGvMdILwy7ogE43/
         CEYLNXQT5PGFINU+RloOsHLyWqDje/BKGS33vvryDawFY46zrTD47Hms8eTg7kgOHLf2
         9sG2mUxtutXc8+JacilMX8jsN9hrE6baM5wlgaOmVWOeykqTFMrWsnqaMdpI1TJ+YOiC
         xI/6mhS2uH1Nm6jy6vEQhvMw7O59lp8zbMePvdg9cWrwyqHqq4wkFturFE8cOFwJdh9c
         MBMGwiVWprfFPH7qqhu74Zb77Vst3GvvrjfYVjTpb0i9aAjfsYCCagLvMuMoZFM/FNAe
         40dQ==
X-Gm-Message-State: AOAM533ZCszoxS/id6O+ibuha3dce7qOJw6vvBHJYzOfvDhqnGco4kNb
        p3b12FYLBKSnsyztAaHW9hAI+vW8fcJVUw==
X-Google-Smtp-Source: ABdhPJxsuZ9EVomBPqiPUZrSxIGQZQpVFBehGTTFY1EmTOwNxRoWn3Q/NwqFD0WEDQNXdKj5tcIL2A==
X-Received: by 2002:a17:906:5808:: with SMTP id m8mr2220101ejq.195.1633572493597;
        Wed, 06 Oct 2021 19:08:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ee13sm8595627edb.14.2021.10.06.19.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 19:08:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: ab/make-sparse-for-real
Date:   Thu, 07 Oct 2021 04:01:41 +0200
References: <xmqqfstdr8b5.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqfstdr8b5.fsf@gitster.g>
Message-ID: <871r4xio37.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 06 2021, Junio C Hamano wrote:

> * ab/make-sparse-for-real (2021-09-22) 1 commit
>   (merged to 'next' on 2021-10-06 at 10e3c31d6a)
>  + Makefile: make the "sparse" target non-.PHONY
>
>  Prevent "make sparse" from running for the source files that
>  haven't been modified.
>
>  Will merge to 'master'.

I see you merged down the v2 of this[1], not the v3[2], thanks!

I'm personally happier with the v2, but the v3 is just as useful for my
purposes, and I understood that you/Ramsey had some flows/finger memory
depending on the semantics of the existing "sparse" target.

If it was a mistake I'm happy to submit a version of the v3 on top
(since it's in "next" already), or if it was intended I'm happy to leave
it be. Just checking.

1. https://lore.kernel.org/git/patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com/
2. https://lore.kernel.org/git/patch-v3-1.1-b6ba99ca4cc-20210928T011319Z-avarab@gmail.com/
