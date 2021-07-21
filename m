Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DF2C636C9
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A79610A7
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhGTX3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 19:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhGTX2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 19:28:39 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1205EC061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:09:16 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so498100otq.11
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2m0DzCKPQp5aqA1R+W4dMI6rB1gBLsKp+iPvxKlGjuk=;
        b=vMEhIX5xBqpMv+/vH2/r/zDlsyj5uYOcb1z1GcVHN9WWBHxiFfeXM0RniWV5cADvSr
         OtOLvzvT5fjz+by5+fs1e9swbpsvHC+6yOVg7QPoxMQOh0jBs7620L3iWJ6q28tD8wsq
         oH1q9DkmACYFm9ZUT6umtv7OK8AY3qrhP326u0YkzOB5j/VSfEzztaZRsdJQHRT+OSgM
         mASzGFBgDvT/ac/I8AhW6B+zSAHebH605OZ+5eebUAAAe9pXGXBIKwpcxQ1ERptlME5p
         1U+RCRQpbDsYE/KRMc19i5A29TXGirZNJGdioESR/uwGqZzFTdFy0CVMDPE0oXSfa0Zf
         RX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2m0DzCKPQp5aqA1R+W4dMI6rB1gBLsKp+iPvxKlGjuk=;
        b=UCTdHjYcD4zqhN8hFr+eNWn2jO036R/t3rt9fnoFd8osPnZCkyxt5Quqwt56l5dWNg
         GCpUq3U/SpNhKba9eaZQOI3v52LL7HKwG3wm097CDy813ReHYRpBWYdDPeCsP2qTqtbM
         B4yPIUAYzYtv+tF2pgrm6pdThVDzZb6uoksMcf8/G19b0PIr9ebqFkAh3uz7ypRGuS5O
         vofbX1Oeyfu8R7+kV75TzHSumsofVEuB4G2oRSwWF4yIjqKHHmHXq754GpvC1LdMKCMg
         NxS7UvEE5BBEsr/ThBhr9gpRP/Xtge/n17oSp82EKWTCY15x1YCkY6BDljnjbOXRxuHT
         5A9g==
X-Gm-Message-State: AOAM532VVH2jYczvWuB5bKKY4jnyGcGLZlwq/Fi0NwSF9UmOlN/dATRV
        5zVeViAFrNprdMmGVBWobFM=
X-Google-Smtp-Source: ABdhPJx9RHjPZjecqF3weONmeueOhh3w6XPRTqD4kbab8aqCSFoCPD3Bvtjkbsoh2oKUJPtWXUzPBw==
X-Received: by 2002:a05:6830:204e:: with SMTP id f14mr14869702otp.238.1626826155441;
        Tue, 20 Jul 2021 17:09:15 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id m129sm4656238oif.15.2021.07.20.17.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 17:09:14 -0700 (PDT)
Date:   Tue, 20 Jul 2021 19:09:13 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f765a9c777e_14ef2420835@natae.notmuch>
In-Reply-To: <xmqqpmvcfsol.fsf@gitster.g>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <b379fea097d65a28f1791f7f2f9432b6689a977f.1626536508.git.gitgitgadget@gmail.com>
 <xmqqpmvcfsol.fsf@gitster.g>
Subject: Re: [PATCH 6/9] pull: make --rebase and --no-rebase override
 pull.ff=only
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Elijah Newren <newren@gmail.com>
> >
> > Fix the last few precedence tests failing in t7601 by now implementing
> > the logic to have --[no-]rebase override a pull.ff=only config setting.
> 
> Because we only have opt_rebase and opt_ff, unless we are in a very
> early part of the code, we cannot tell if "opt_rebase >= 0" we see
> came from the command line or from the configuration, and because
> pull.rebase, pull.ff, --rebase=<kind>, and <--ff|--ff-only|--no-ff>
> have intricate interactions among them, we'd probably need to behave
> differently depending on where "opt_rebase >= 0" came from.

Where is that backwards-incompatible change explained in the
documentation?

-- 
Felipe Contreras
