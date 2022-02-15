Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E4AC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 06:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiBOGEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 01:04:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiBOGEI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 01:04:08 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12265C4B69
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 22:03:59 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p14so17703607ejf.11
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 22:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhpmQl32NVXu3Bh+/y90Vkr6hqUumudaEYf3Vtz857s=;
        b=bqsy6uurAzNIblhSPU2Tv3XrmtLXgICTjN+YAJW+wXXrMlGGunjJ0+7ZvDtqaQoZYO
         bBjahjCpDnDQYlnJ2tR/NCQ6k2ONVqptrKvO6yIH/4ZFrcqsORCa0+MPOfEV6hd0bBSN
         xxyypJpeuV+jkBB8XEXIUotfJNyQb0zgFWh1ggHWVjBqdkmF4s1BlI0LmiRx0jjNlxFM
         fmg67Sgz6KJKmRowiNalusKjW4+S2cp2NfM2ElRy4OS8xM80xj2m/rxiLuDPx/nvYau9
         N6QfD8djEztulLW7l7dXT2zE7Jddl8hoX0u9b6f+VPj0SRwZAdL45+COSPrBVDEnT8eV
         bfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhpmQl32NVXu3Bh+/y90Vkr6hqUumudaEYf3Vtz857s=;
        b=LGdhE+BFocDKhx4sppiXU8O+/cmqYhEUiTjklkdbynFApuy4tZYryqrsLZDYPjJlp5
         c6cNPXSEg1b4WpzUrXC8dXoMsLlcHNNF/1XGljMB9EEtoGlLAUpmxZ25Gedt/mhT2H+H
         dOGwS/qRjHCG9MoH1plAWhkj8pv6l0Yu91cqji/yFP8Bj5k1gA7c6K/CUnbqQ/isUV7Y
         JGL9G8R1Krfvc83fDxFQ9vfElCtR9vlH8G4IwG+czNShfVO72BRnjYur78uIv8LSx3on
         tIB3lF1XBqTGlL+b+JJdOnwtEoLHk59uhP4ckips6URMQhUYVHvVHECC2fmN8DwxZeNS
         bwtg==
X-Gm-Message-State: AOAM5326/EC1vi5QVO9nmbousOsdluD8PVksrKrLEsTdrWy+iEuqsIgw
        sruKtF0T5XSUOkaqZS/zUXfOAaWu7ee1OB8jQbw=
X-Google-Smtp-Source: ABdhPJzR+ZAnUgnYppKq7ssNdJ+X4hRcGlcp3xC6BUwnG8Xou2RoXDjsTE0rH3sXE6314w2ahKVz6d6WOKheb19L8WM=
X-Received: by 2002:a17:907:7f94:: with SMTP id qk20mr1767863ejc.328.1644905037479;
 Mon, 14 Feb 2022 22:03:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com> <d7b51da94e65db79aa59ca331e178741d3c50bc2.1644698093.git.gitgitgadget@gmail.com>
 <xmqqwnhx2v6i.fsf@gitster.g>
In-Reply-To: <xmqqwnhx2v6i.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Feb 2022 22:03:46 -0800
Message-ID: <CABPp-BHQv-j=Y93WJ8A-y1+0ybOaemByhwe6twZYKEwTTk9bDA@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] merge-tree: implement real merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 9:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +<branch1>.  The result of this second form is is similar to what
>
> I haven't read the rest of the patches, but this like somehow stood
> out in the interdiff.

Are you highlighting the double "is" that I need to correct here?  Or
was there something else that stood out to you?
