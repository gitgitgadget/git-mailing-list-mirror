Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6E8C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983D961220
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGKJdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 05:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKJdU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 05:33:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA6C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 02:30:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y42so35015737lfa.3
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TmbmoSdD/O3z+GgMC458KWLifpNYC64btfTV10ooiWQ=;
        b=PmDASgSDV5b1/fjO4O+NvjcI58Ya/myutkzmKE+hRTuu4rf1y103jHRtx0qXpXZqdC
         WDIz/xOICEcELs5FYb4b+M2zcHlZd8S44s2fx3TJIwYb+NfsSRtmYLQwFrk7FDfZ6gMh
         Yb0WJBgWcV11Puj8zJsebQv4q63EuWIIxNIX9AbWnikHx0eOPaWMm1KBNuBsLc7SimXN
         FxtC0gVZTlWmmuSYWjBCqRsbg6bmDPHsvor9UOX+dZ3etY4l3UFV/ECXf9U6Pdn64/VY
         n6US95qFuDx8SACg6MGh+Y9wWrhcNj7IA17pQJaLHi4YEIOvSbQ5EncRCTXi0PNOcf7+
         0k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=TmbmoSdD/O3z+GgMC458KWLifpNYC64btfTV10ooiWQ=;
        b=lkZXSjWygJqX6Adtk43DvGXfnINSGrCaMK674EyW7JtMbiWGPdRRTxH9c7PpsAH9mt
         C4iNQp65S4kWhoMxREPcfwwhXOsRuNu8Ik+smazkOsKmx28urlMjfSt/mKxFB1++rtVG
         eVCTBopnOpL6J5KSmxwk6X65Vt29i5Alxuycvs2zXwKXSF2K8zDARLt5wnw+zi4DUoOX
         rnLFcBuCdXg6zt/ZkBhhEcJyTr0/PqcFjgCZ9Y+DmrCxtQFzRkIbwPKU032fXmtqltEW
         Da6FWHAfY3mBUmICI8KiOFl0csu3hvnU97LzDLQ4LyYDXZ1gAPPSQoz0oSHmyVb9C5Im
         A0eA==
X-Gm-Message-State: AOAM532+uhfjQijyRbkfFtIF+hZBHUKuy8tA3r6w44e3ljUigZIImCU6
        U5dVTgAjdyDsmeqitIvfw9EfQzBhxSQ=
X-Google-Smtp-Source: ABdhPJxYnP/mwl2ZG8K/f8paDy2ycKs1Y56zGggsJV5iTUQRY+ldQ64UyHkTQanxLw/eK/TXZajHgg==
X-Received: by 2002:ac2:44dc:: with SMTP id d28mr1075544lfm.618.1625995830747;
        Sun, 11 Jul 2021 02:30:30 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h19sm769754ljj.23.2021.07.11.02.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 02:30:30 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <877di13hhe.fsf@osv.gnss.ru>
        <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
        <60e67389a4adc_306ac1208fd@natae.notmuch>
        <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
        <60e736e72da68_30939020850@natae.notmuch>
        <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
        <60e762243aab1_30a7b02089@natae.notmuch>
        <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
        <60e79c31aaa72_30b8a4208c1@natae.notmuch>
        <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
        <60e874e1c6845_215320861@natae.notmuch>
        <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
        <60e88a4b8592f_16bcb2082b@natae.notmuch>
        <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
        <60e9f8d462bd9_7ef20898@natae.notmuch>
        <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
        <60ea07e3495e8_7ef2081d@natae.notmuch>
        <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
        <60ea2eb562f26_2a69208e8@natae.notmuch>
        <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
Date:   Sun, 11 Jul 2021 12:30:29 +0300
In-Reply-To: <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de> (Martin's
        message of "Sun, 11 Jul 2021 11:10:08 +0200")
Message-ID: <87zgutfb9m.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

>
> As I said, I try to avoid reset, and also there is no "--reset" to match. Only a "reset" command, and it does a wide range of diff things
>
>     -force-new <branch-name> <commit>
>     -N <branch-name> <commit>
>       See the --new option.
>       Allows to [re-]use the name of an existing branch.
>       This may drop commits of that branch.
>
> Or
>       See the --new option.
>       Can use the name of an existing branch.
>       Removing that branch may drop commits.
> If needs must
>       "Removing" => "Resetting"
>
>
> Or even shorter
>       See the --new option.
>       Allows to re-use a branch-name and may drop commits
>       [resetting it].

I'm strongly against "may drop commits". I see what you mean, but "drop"
sounds wrong to me, and we should not be plain wrong in the manuals.

Maybe:

"Allows to reuse <branch-name>. Commits from the former branch may
become unreferenced."

At least this it technically correct and doesn't sound that utterly
fatal.

Thanks,
-- 
Sergey Organov
