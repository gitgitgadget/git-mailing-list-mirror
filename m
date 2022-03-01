Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69654C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 02:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiCAC7v convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 28 Feb 2022 21:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiCAC7u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 21:59:50 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E409D5AEE9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:59:09 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id h17so6786505plc.5
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zwJhaGU7fOIA4KU9NzccXKf/eFbnugwYaD5wnF9cU/Y=;
        b=aqt6sM7QQcyp1M/xYuUxJ23m+SYSLQBrL3LBJ6qq0yjLVuMY7gOsjpOWHFKk6ViZ2p
         iSd7EymX5HGNxv0l2x6tk7NYG5Riv2jC+0IFUjDuZKTZ2AlpQuWdLZq206gEpCfFGWkJ
         FeVo3KLMSsIpLOTkAip/Ly0nMbNNe1y1teHeSpwrphhXeo9l2ZGNX0Xkv7UE5jBZckXb
         Ay/c/HJS8PoCoKb/r1tU4rPrDIt60LPX1segLGjcb8p46wYPHXGZtX8B3tKcPKTrTFec
         5AHGvYm0frLseBocaj0GAkuOTRdGBraNV09qlro+P/E5LMm4mwSqsp5+XGxwf6uT4oGp
         Z5zg==
X-Gm-Message-State: AOAM5315kXmSyBs5t9QJQyv8yvQVPKO84RC9a6hBC9GFHNj923u4jvth
        TH6/KUQj2XrlLpJH2qRINP9qxKYR07Z2MnP+lfkH7hvmng1DUA==
X-Google-Smtp-Source: ABdhPJyuDSQHSJyhRO8WU1qcV+OKs5dH2h4rdHLhi4LV7Ess1SaF6gX+CuShrJ7aXGOrRo1JLDT9qtkkvlgsGQ2yUp4=
X-Received: by 2002:a17:903:2289:b0:151:64c6:20fd with SMTP id
 b9-20020a170903228900b0015164c620fdmr8873889plh.64.1646103549310; Mon, 28 Feb
 2022 18:59:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
 <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com> <d5b18c7949fdea966d31b2b8ca3f8aa8ed3a86b6.1646032466.git.gitgitgadget@gmail.com>
 <220228.86o82r5nzm.gmgdl@evledraar.gmail.com>
In-Reply-To: <220228.86o82r5nzm.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 28 Feb 2022 21:58:58 -0500
Message-ID: <CAPig+cQQ30XZ1zAguZNgEMTFK3P029Ds-miXQq=A-_pd4HGiGQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t3200: tests for new branch.autosetupmerge option "simple"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Tao Klerks <tao@klerks.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 5:54 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Feb 28 2022, Tao Klerks via GitGitGadget wrote:
> > +     test $(git config branch.feature.remote) = otherserver &&
> > +     test $(git config branch.feature.merge) = refs/heads/feature
>
> Use:
>
>     echo otherserver >expect &&
>     git config ... >actual &&
>     test_cmp expect actual
>
> etc., the pattern you're using here will hide git's exit code on
> segfaults, abort() etc., and also makes for less useful debug info on
> failure than test_cmp.

Better yet, use test_cmp_config():

    test_cmp_config otherserver branch.feature.remote &&
