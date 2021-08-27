Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E119C4320A
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 06:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6680B6023F
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 06:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244238AbhH0GFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 02:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbhH0GFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 02:05:09 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3BDC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 23:04:21 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id x6so2845592uai.11
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 23:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hBpv20nq9dNs38K6dIRK2KAMbgY0b8zHk2nODUSM8Q=;
        b=Hs1MZtdXPkmGv5IHJfgSH6izowgotZxH+CIiE+bH3W4A1VXr0m1NIw4OX1A4y4r7/U
         x3TaEUYX1G0pIqpHEuGw6afjc2eAP2DyI6Co0vGC2YMvNDEMhrzTlnktXF+PVl4yVo/U
         puo/1gtxduGEG6n9qO4U45X75MfY4qHJ70ipoLdGRUm5IBpuZMqQNQtfPU+WFaznxCgY
         kMaJp1tKFzE9121hZkdhum7kIukE6KhhGXWekbodX5sGAkA/lFvgEKqWK0mRroO4Tcx9
         JDxbIjZcXyJNa8qJQhtACVdFJrDYQRF6jpZKSjEmU6FrHCOUw5I5JR2ZlYjJmTWqPEUT
         gDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hBpv20nq9dNs38K6dIRK2KAMbgY0b8zHk2nODUSM8Q=;
        b=dXeTPdvd9Us5+rvwlvTf9GtsSdQC8NbAr9EBE3iHW0bFE9/28xfuM7L7hPiMj36HZX
         Ijq6Tf5pe7FRC6Z2xrpRCzHcqVyqXCd7oohknb+lywXxvPoTrgWRbms0778uc3J0zGR0
         UJ6DvUq78nqvqUeCimsk+ssTK2O3q+icVXQhJdUKUdsyj0P0nGrugFdFA3113OWJd0NP
         bc0hLDA3a24w8zlmDzs2VN0rFGMKz++kZS0Z6wvTE/durt5cQKhG0/1EmHxVOlj31ZB/
         KlwDCLqDp0JduHUejKvtpq36Lcxv0/W0Sq69eocVNZHAlK7W+xpXFMX5fS0CJxxKtNlJ
         yqNw==
X-Gm-Message-State: AOAM533WdrWoPx7Y9BJEHxtgFKeZnFg3pxI4o7O4xOkb7riQeOntULMH
        4Xj085Didjhm2hmMey7G3+ptlnf/gJq7w33pEhM=
X-Google-Smtp-Source: ABdhPJyJGXwURMRzSTANariD58MdwmBVmH4tjNzpvJg5U66OSu/0I8uYJKkSK8r5Ayv7R/hHi5MAP8/Y13Qa99InIDs=
X-Received: by 2002:ab0:3418:: with SMTP id z24mr5347471uap.96.1630044260392;
 Thu, 26 Aug 2021 23:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210809063004.73736-1-carenas@gmail.com> <42dce285-9599-4c7c-d351-44c1e338337e@jeffhostetler.com>
 <xmqqpmumftry.fsf@gitster.g> <b554c82a-4da1-9676-4d93-b769ab6bbcbd@jeffhostetler.com>
 <xmqqsfyvbg8m.fsf@gitster.g>
In-Reply-To: <xmqqsfyvbg8m.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 26 Aug 2021 23:04:09 -0700
Message-ID: <CAPUEsphe0N6w_qCTAp46YPH7vBj2dkJa9kOm2HaixkFkVuk3GA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fsmonitor: fixup to avoid warnings from pedantic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        jeffhost@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 10:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> Here is what I had to do to work around
>
>  https://github.com/git/git/runs/3438543601?check_suite_focus=true#step:5:136

correct; that was 1/2 of the fixups I proposed and were waiting for the reroll.

interesting that the job was able to build without 2/2[1] but it might
be because clang is even more pedantic.

Carlo

[1] https://lore.kernel.org/git/20210809063004.73736-3-carenas@gmail.com/
