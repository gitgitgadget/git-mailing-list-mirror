Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF7C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CA520721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEjoWp4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgKWXvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgKWXvy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:51:54 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E406C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:51:54 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so20495101wrc.8
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkcPjx4B8kRwBuP+VST5rGBK/0dnOxYpVQ751eAuiSA=;
        b=WEjoWp4o0S6tFxv5h+h7s68D0B5CcxHexUlKie/VhIAToDIE797q5sHOotJGlV+v0Y
         puAQw+mByo6EVdVn9mPWPevx1jLi1vcxbDJf8fD2W3w8EWcMFMh0YRyH8+hb1T1I7Zvs
         o6Qy4l0qu69oCTci7HHAc08TtN81SWE0BylJrZYt/ZnAK7O0/WRFKq8TGgVLEAkMdQpU
         9h24QIBen36Tvbizqmq5EL2Y96NaJH2YSzPJPD66X6tYULXTiTDirrBo8ERqJ1R3tNBy
         3zjVLAQPSoRWzKCPVS8DjaO1/JI11vEJR/du6lDbbTtWlPUnaTgNmAJcw0pUYDv+CXXk
         cNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkcPjx4B8kRwBuP+VST5rGBK/0dnOxYpVQ751eAuiSA=;
        b=ed3Jp+Dw6QeKzPGUAgVofndMk00FwRKyiKHxdCc42qTy/OWwNDXUpnx/d2D8bT5hFq
         6243Jdl0qTAHeJ3mRHZNkA3Yzk4FB1GTPNSlMUtGAXlCzzFC7HPpgPsGmFGN8+K6HkAX
         uoB5Tn91r6yiMk9K8dKXCGqvK2sELlqzRQS3EiWoc1f1gy9vmsptsgl8BG7OAPpA9a1N
         wIk0NyvZ1xDs8ANA3e/T202K/A1LoEVvxCjrpzdyqMrmpw8TssmuMzNLxzLUVAVJJHOu
         oLddyze3FFmjsr3u98vA43UE5A9pr5cIepQfKUAn/DP8W8jxX+5dy5hDGQYwCvpUFsaP
         d/ZA==
X-Gm-Message-State: AOAM533a5XDaKF7hoNiBWWpwAOgxJHpvKe9poCWfbNz3b7epfCQSgCSi
        6+Faci92DVORA+/ckvF0+kqK64Xno7V7WpWCGMM=
X-Google-Smtp-Source: ABdhPJy03hg2bbQ9nJLzTSRnk78214j7NUEOD4+ceYaQnmjGWG681Dq2jpK0WcL741bal9alBznhkWgmDiWzSovXj20=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr2041242wrr.319.1606175512899;
 Mon, 23 Nov 2020 15:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20201123224621.2573159-1-felipe.contreras@gmail.com>
 <20201123224621.2573159-2-felipe.contreras@gmail.com> <CAMP44s2FRZUvUy+F3banxd9MEdL=RMqEdJL3JLYEGDQkOz3vNA@mail.gmail.com>
 <CAMMLpeR8_fshsaqSF6idOY-KyFw2+AK_5683a-7wDXhsO=iFVQ@mail.gmail.com> <xmqqim9vlkdn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqim9vlkdn.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 23 Nov 2020 17:51:42 -0600
Message-ID: <CAMP44s3Y3BEbPM_69uxmQWiBq2CqwBo4w13M43WvU4nUQZha8g@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] pull: add ff-only option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Git <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Andreas Krey <a.krey@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 5:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > On Mon, Nov 23, 2020 at 3:46 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> >>
> >> This patch leaves everything in place to enable this new mode, but it
> >> only gets enabled if the user specifically configures it;
> >>
> >>   pull.rebase = ff-only.
> >
> > Why not use the existing pull.ff=only option instead of adding a new one?
>
> If you have pull.rebase=false, "git -c pull.ff=only pull" would fail
> as desired upon a non-fast-forward.  But if you have
> pull.rebase=true, does it fail the same way (not a rhetorical
> question; I didn't try)?  If so, I agree we do not need a new one.

No. It attempts the rebase, because whatever is set in pull.ff affects
only the merge mode. Also, I don't think there's any way to tell git
rebase to fail if it's not fast-forward (not that we should attempt
the rebase anyway).

> On the other hand, it looks quite funny for that single variable
> that controls the way how pull works, whether rebase or merge is
> used, is pull.REBASE.

Which is precisely why I wanted to rename it to pull.mode.

In my option git pull should have three main modes:

1. fast-forward only
2. merge
3. rebase

The fast-forward only mode can be considered a merge, or a rebase,
doesn't matter.

Cheers.

-- 
Felipe Contreras
