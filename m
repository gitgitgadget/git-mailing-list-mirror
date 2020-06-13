Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351DCC433E1
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 07:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F7B207DD
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 07:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rrym7bWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFMHwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 03:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgFMHwa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 03:52:30 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DECC03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 00:52:29 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id x93so7991716ede.9
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 00:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OsFE9CgSstE0OBzSh5ZKxlmEvmlK3YiZ6lPcE8foaQ=;
        b=Rrym7bWE/LZvXrZIXKFW9AEtZiefMr1+UsfIKgbNxmRHqSLKBYKwKkIJQu1od91oRK
         qYiVASJUvykpaD8eaMzA0kumZNDlEd2mG4ZzKesV0wzlTZRyJ+itCqZRdtlRiVpTQJHw
         P1NxZ3PIQGgaQQABCECmXNOcGqWuilstm4owD6BGgqW1K2+2Or/b/a8Jpk35kTVhV40/
         wrfE1UyEh6B84IeataV4ns46N/Q8kXfEXBdgji7c4hynW/VRBOG/M6wt/WCEHEJKcqhS
         nCDVIBoQUWzkKiKsWPKCgaLwUv5GH5XvAbLPSeL8NpPBopgVOSonMudDCzFLNoTSx/be
         +9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OsFE9CgSstE0OBzSh5ZKxlmEvmlK3YiZ6lPcE8foaQ=;
        b=bjdcN9cwemEdcxnqefo5hMxH028DtsS7ON9re3c40moXCwrcklP8pZqBpPm44Q0Kkp
         GgF79XENlQ9wzByT6RjFtwKS4gy7jCBUBBGtUDlBI/KOyTF4Hz8acTbMhN5OSSoYyZTC
         GVTMLQr9Fffz7aBJTZLZkAJfpe92WS/trQuaUvvZJ82/Jpb7ybVvFDWGX7zYvSg/Lu0g
         wiNXVCiNkB72qp+jqqRAWgu+BnftUHhqxMx61Xw0A3js4VDzxWy+gIMBwezdxQphhPR4
         Qs8RPG+vepf4exTF9DHmFnnKphF4TZNjaJND10nIGwziOeURqJJH31FDzJK4eW3ZO+TJ
         Wi+A==
X-Gm-Message-State: AOAM532n3YCajIpj1hWBBATIiXlVcTyr3uhOol8nkZzJBUqyAHOVwr17
        5/yD9PKYmxE4//JlWHXGGR7BCb/dDU00Uh/KCNg=
X-Google-Smtp-Source: ABdhPJyEW/YI9q2aDz1nrmaatA4RX5Oh8I1E2f+6gOq5CvTSCnhI5ArC/X6l/J7ziiNTsSj7/sFWa3qqGFJZVkEV5a0=
X-Received: by 2002:a05:6402:1153:: with SMTP id g19mr14816147edw.127.1592034747545;
 Sat, 13 Jun 2020 00:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200505104849.13602-1-alban.gruin@gmail.com>
In-Reply-To: <20200505104849.13602-1-alban.gruin@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 13 Jun 2020 09:52:15 +0200
Message-ID: <CAP8UFD0bfTEDQaA0rQEBW76niF0T7f_4HS_N1tkRPh-0ZW7-Gw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] stash: drop usage of a second index
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, May 5, 2020 at 12:56 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> The old scripted `git stash' used to create a second index to save
> modified and untracked files, and restore untracked files, without
> affecting the main index.  This behaviour was carried on when it was
> rewritten in C, and here, most operations performed on the second index
> are done by forked commands (ie. `read-tree' instead of reset_tree(),
> etc.).  This works most of the time, except in some edge case with the
> split-index when the split file has expired and is deleted by a forked
> command: the main index may still contain a reference to the now-deleted
> file, and subsequent operations on the index will fail [0].

Thanks for working on this! I agree that it would be nice to fix split
index issues as it could help for sure with huge repositories. Sorry
also that this patch series fell through the cracks.

I am adding Son Luong Ngoc in Cc as he reported the issue that this
series fixes.

> The goal of this series is to modernise (a bit) builtin/stash.c, and to
> fix the aforementionned edge case.
>
> I have to admit that I don't really know how to test this.
> GIT_TEST_SPLIT_INDEX failed on me (gdb showed me that it does not enable
> the split-index at all, at least in `git stash' and its forks),

It should have worked when it was introduced, though maybe not for `git stash`.

> and I'm
> reluctant to add explicits tests on `git stash' about the split-index,
> when nothing in its code explicitly does unusual things with the index
> once this series is applied.  If anyone wants to share opinions about
> this, I would be happy to read them.

I understand. I think the good way forward would be to fix
GIT_TEST_SPLIT_INDEX and find a way to ensure that it keeps working in
the future.

Thanks,
Christian.
