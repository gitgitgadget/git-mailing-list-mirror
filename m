Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE5C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 04:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989E860F58
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 04:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhINEES (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 00:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhINEER (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 00:04:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A70C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 21:03:00 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id bi4so17128708oib.9
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 21:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zLvVF99JM4wd0gLEF2/QbNY2UFgpEBjIrK/Q4MhG1V4=;
        b=Kxg+3uqvFCf5D0jX8WhVAWI/L5MsjLtTwa2mVKzErWeiGcw5EtWLjVsOufuITGHSvm
         NGZUopOZq9/9UcV/1qIgW75dZpy+txoZRA4Azj15f/ofQIaYQlyfIq0pGMclNnJ0PM4h
         yNiqKJTRyH9Uz0x39WkQ8cfZq+r1JAzhTTof/F/CuLQoFEDAHfXzQ+gbojKgy7UEAP3E
         i/9pm9uZA+WwH4Sxu3xc492D02GX2R4UiPzzng2/AQTvDlYPM7bznnyctTxkZYGEg3hk
         5pvjA2Tm25u/bIqJS3C0H3DvWVtDcXP24Jp6tLjeHGtMzt1fzY5SBnN5V2woa6AJn1K0
         wDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zLvVF99JM4wd0gLEF2/QbNY2UFgpEBjIrK/Q4MhG1V4=;
        b=g2fDZww+V/GZxNT2IkfDijiQhNWLCsVFrIX5slpuH4/pSPIqYmxS7xRBfhWWyrHhNy
         cwLZoFruDzt5XRLoc1t/llG3yMst56LiUjdLw7oYRn8MTVG1dn0wmsrJGcECSUODJGpW
         eovzqFRBlPRqFjVKawtwRRvlSnhb9ATZP3DpztqNr4SNRhqf+dAe1aGFIJvlc1R/lfRF
         pE1IrlyPGmEk72Yf+bksLqh67Gb0xMbqZ59NOyhyqmfr2O0EUR95ywkEpiI8DcF2cn6t
         uVXbYaV6oNzCmF7DFQdJZXVkqH7Tf+t4HbmXHvjfeyQAoIVMMs9ufIMw5T3j8vcjbqJY
         BIxw==
X-Gm-Message-State: AOAM530PWJzxDJZAfinlwCn9meILmXe2E5cFcmsW9lPLuTUHcPIgf3BS
        zv7812WUiFy9Y1WhBmNqf9GWopc2odX7o+178X8=
X-Google-Smtp-Source: ABdhPJxDuiwEmZyJg6qtZvDsETD8b393FZh7oLF6pwrgfsyzVubk1ae2VU29ezGVl6IGGwPQdn5mMzk4bREtdE92Gic=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr10784086oib.39.1631592180101;
 Mon, 13 Sep 2021 21:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com> <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Sep 2021 21:02:48 -0700
Message-ID: <CABPp-BHoJsrnUeRD-Ft7tO5MBhEcacWoMRmrZ6HReNXnjJKHew@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] rebase: dereference tags
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 8:46 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Thanks to =C3=86var and Johannes for their comments.
>
>  * Changed "! test_cmp_rev" to "test_cmp_rev !" (suggested by =C3=86var)
>  * Fixed the quoting for the title of the "rebase --quit" tests.
>  * Reworked the last commit to handle the error case first (suggested by
>    =C3=86var)
>  * Tweaked the commit messages for patches 8 & 11
>  * Rebased onto 31e4a0db03 ("Merge branch 'ab/rebase-fatal-fatal-fix'",
>    2021-09-08) to avoid a merge conflict that upset gitgitgadget
>
> Cover letter for V1:
>
> Aborting a rebase stated with git rebase <upstream> <tag-object> should
> checkout the commit pointed to by . Instead it gives
>
>     error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD': tr=
ying to write non-commit object       710d743b2b9892457fdcc3970f397e6ec0744=
7e0 to branch 'HEAD'
>
>
> The fix for that is in the last patch, the rest of the patches are cleanu=
ps
> to t3407 and builtin/rebase.c

Might make sense to split this into 3 separate series (t3407 cleanups,
builtin/rebase.c cleanups, and the handling of tag objects).  But
anyway, reading over the 11 patches, the only issue I noticed was what
appears to be a simple typo.
