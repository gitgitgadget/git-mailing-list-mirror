Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FACC433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ABBE61050
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 17:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbhIRR3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 13:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbhIRR3x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 13:29:53 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD762C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 10:28:29 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id p24so12603153vsg.0
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gha3cnmIsDAca5XKLKjSMO/qBRXV88P+i5GiitrGPLA=;
        b=JZ4KgrPtKfjP9G6eToAyH9LbqH7t6rUrik1aPU3pZ0h3FuD52eW/j/WL5iSnz5zEUK
         +UKdx008TTy0mJptRXpnMPt2IgNk5h5nWVjBGpQpTrEq6lHQW6DT8GE0pDEGBy7+Dn0H
         bK1OPR3mgIiYxZmTPdCmp3GZ3Ppugeu8+dp9GPdwfi6OSGmi6HBNTqG3dar2VgCoKI1N
         6aZpxuNoueNs/CysobVzufvkRRyjvjabc/pHh/KkrUcU/DoB99fOtv5OZ7Y0IwxY1Cnp
         qhSbfHAD7TjTSTLG5VGcm2mTe2tciNx345wH6KdVtwf1Pl3vcp7Euxkyp8jiKTstPxy0
         vGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gha3cnmIsDAca5XKLKjSMO/qBRXV88P+i5GiitrGPLA=;
        b=VumxjUrcoqFfLRlXE0M2LPujlqE4BRRTgEuO2FPNbvsjTDvk5cHdaxntcGKqIqHgBH
         l+CoxPH6nigQEPR7mqeC6KA0J/6MpUiDpyu5deU+xawwZ2LgpY/l9Ptj3SNdBBcZKyts
         307uma/X4o8ncvFV0bw8WmftKFdUIUB0YOQlyjTWYB/5xHmQ8PFofXOY/QkzL+UJJTqO
         j80HWrNETi96RI0ZkttFf7AbUHRIyurZp45GHkFjq/UDryCqBiWEISPvOxxGoJKbxSlN
         4bBKwWYiv37TDvFjC3+aXMAvtM8x/dFSSnwnXt2/Ez69Zj/Bq+PnDxzmlY1GE/Lh8Xhh
         HdZw==
X-Gm-Message-State: AOAM532IVoQzAETX4egQWssXCqi5LP98qkbx5VJLjCAzKn2XbG6E3UzU
        YiGQuWUmBsx5K5lnc8y6h6om4pXhbl3rXTUrxv7G+GqCZzo=
X-Google-Smtp-Source: ABdhPJxlcF1Bm83sITDd+5UTUqc036I2Vm7PARah44Cobl0i6htQc/OdQ/lR6UOZ6Rsy6wcgdDU/FnYR1Hqt5tJRZ2g=
X-Received: by 2002:a05:6102:1d4:: with SMTP id s20mr12320888vsq.3.1631986108703;
 Sat, 18 Sep 2021 10:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
In-Reply-To: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 18 Sep 2021 10:28:17 -0700
Message-ID: <CAPUEspjjBAr07VB7XqGFVXDcKWkkX4OUTCxUf+VJaEAX8KTAyw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Squash leaks in t0000
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 18, 2021 at 6:49 AM Andrzej Hunt via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Carlo points out that t0000 currently doesn't pass with leak-checking
> enabled in:
> https://public-inbox.org/git/CAPUEsphMUNYRACmK-nksotP1RrMn09mNGFdEHLLuNEW=
H4AcU7Q@mail.gmail.com/T/#m7e40220195d98aee4be7e8593d30094b88a6ee71

Did you figure out why it doesn't trigger on maint even if the code
seems to be mostly the same?
At least seems to trigger consistently in master, next and seen.

> Here's a series that I've sat on for a while, which adds some UNLEAK's to
> "fix" this situation - see the individual patches for a justification of =
why
> an UNLEAK seems appropriate.

While I see that UNLEAK in this specific case, might be an ok "fix", I
have to admit that not finding a repo_clear_revisions() (or equivalent
function) that could be used to clear revs seems like a problem worth
fixing as well for the future.

Will reply with my WIP so we can see if it could work either as an
alternative to this, or at least lay some foundations so that a long
running process that needs to use a `struct revision` or some of this
logic can in the future without having to deal with leaks.

Thanks and "Reviewed-by: Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com>" if needed.

Carlo
