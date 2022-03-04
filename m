Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F3FC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 22:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiCDWL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 17:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiCDWL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 17:11:58 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9FCE1B50
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 14:11:08 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d81518795fso83405077b3.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 14:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N23Y76UnK3SvlLNYrINK+P0bSHo8taG8GGhllpzbHBw=;
        b=E0NDU/dwpI2Ow7TGX67G/Ryijy5RFFT5IYAF5n06a3BULo5UxLTgxWn0QQ5Do01tHI
         TEpMu5xUnJyOD5tjX9MuO3TRVMhgzYcSFUNvF0l3ODb7+yMOsIXd3rdaRiXrbupe6SU6
         kXL4GU+PZhEFwl2MFHy2mJUCKm31RgsP/mHjbZEWT2w2xGNyIUEPhGALXEbNabktDICU
         wysdjFeQsFJWdd0SoVNW37Ony0GdHO178XBNwbgb7JxjUlPB33oHO9EKuT/IfAHkQRCP
         LOgBPEz20tD/GWssa4eTc55UsM7tuHna+8R5KhXzT7bL6xQOShSFyKwpZ5tIUcvAtwYe
         Fmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N23Y76UnK3SvlLNYrINK+P0bSHo8taG8GGhllpzbHBw=;
        b=BSEiet0NeWhKQS06nJrIAQrspOnk+BkRlcEvrkyYfUqte0EY1h/2qGlsH++ct7SCch
         S4iPNvp2Vd6ywvl43KeLRiZAdkBzH4agf6PnK3eF88Xen1LCBCAJTAdm3MY3m/TWH4gn
         bePhnT4WmbIt2/fSoUscALn/AttMteAq7JPWQDM57wh6XAQsJ1CFiqzOZPICXJX9OwO6
         hOGcsr+UzyOLv97aGJ+CIPPYObpFSlkpsNSGYEeLDJ8gFrgfbkTZtZNbFmnIJYoKnbdz
         O+aAXyWJBM9ZfSlz/yq5rNiDLyuxglj496qNK49OnwMfCsCom6X7tVqgNh9OwcFE8fK9
         VVZw==
X-Gm-Message-State: AOAM533oifvHVc6Ln0TGmc8jxr9uyNhBl+g1z656QRZXF5k42wnYwLXv
        wutGw5k4H/OokaWM6kpcJL79KuuVdnM1ag==
X-Google-Smtp-Source: ABdhPJzsQzPNHNqkN7mPeE5cno7bzDa5aiscqMUTVwgd+mFh/+nQAvp7HB75qV1SNjh1FNtBKRYxDRv/AftWlg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:24d7:0:b0:628:79dc:1250 with SMTP id
 k206-20020a2524d7000000b0062879dc1250mr578012ybk.153.1646431867350; Fri, 04
 Mar 2022 14:11:07 -0800 (PST)
Date:   Fri, 04 Mar 2022 14:11:05 -0800
In-Reply-To: <xmqqee3i5v4k.fsf@gitster.g>
Message-Id: <kl6l8rtp4bd2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
 <20220304005757.70107-2-chooglen@google.com> <xmqqee3i5v4k.fsf@gitster.g>
Subject: Re: [PATCH v4 01/10] t5526: introduce test helper to assert on fetches
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> +# Verifies that the expected repositories were fetched. This is done by
>> +# concatenating the files expect.err.[super|sub|deep] in the correct
>> +# order and comparing it to the actual stderr.
>> +#
>> +# If a repo should not be fetched in the test, its corresponding
>> +# expect.err file should be rm-ed.
>> +verify_fetch_result() {
>
> I think you updated 02/10 "check_sub () {" but this is leftover.  If
> there aren't too many, I can fix them up locally.  We'll see.

Ugh, sorry about that.. I fixed this somewhere, but at some point I got
my branches confused and must've missed this one.

Since you left comments on other patches (like [02/10]
xmqq8rtq5uue.fsf@gitster.g), I'll just fix it on my end.
