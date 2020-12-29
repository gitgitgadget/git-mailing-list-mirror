Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10990C433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 02:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE9620771
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 02:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgL2CD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 21:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2CDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 21:03:25 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35995C061793
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 18:02:45 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id q205so13275780oig.13
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 18:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EW3P3rP7/m323lJ7/FGpY5U/w9GRxcAUcSYipqBkflc=;
        b=XuaFCT44qW9xe69kkIWqQA+V7bmACo26eZxtgHWdNCmkXuU98PnMbmNjjdwMDBVs05
         09LsHwULRSwxrzS+cwP01/mRoaishyGbletxRrNmRCFALEAwkt/o7+bci8V53ZGxb50n
         nOfYEt8Dbcm4/+X3B5yMUNxm+u3c9jxAPndiInzCH3+5QiYKrXvYQbUacYykfpxzpZHs
         Oka4mlOVtoT/vT6J1IFbfuYiwSnItEsSKMvguh3lwZYI6JhpiPkoh5AQ9QASip4LPBIq
         pYiUTN0mlvmgIhYhyTnUkOSfs9+Kl4GT6z7JtZn1ile3NH4GY/k6Te+yWef3SiKWk5Ph
         Mo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EW3P3rP7/m323lJ7/FGpY5U/w9GRxcAUcSYipqBkflc=;
        b=MULs51ZVZWoQ9g+V0OFmDhrLk+3bA4FznjtkhGt+Pk+NW808wERoosk68TPG/vdMzh
         WKBaNVHEuQxrJXPr4xZrq4dSrDFPw8Z/DhyBX6l/1YhFG3GaXFuwkDblkV328CQRdyiv
         YUuxt/TlV7Ewa3+03Cpf9jldYW3bv45H124Xsq72x45htUKsfKs/T99C1NOAGttqIUaS
         +cglCx+ggqHiXvpViISLk2HQAW87hj0hsJY63hPYqrH1sKx2gdbqdpQa5uZ/sIjwRhVG
         Le1ABJ6ylu0mVEY83kVOyxwjvruSsOu6WIKgPm7Y53jdFulK7/YhPBoYbVca1Wv+r/9b
         4oGQ==
X-Gm-Message-State: AOAM533/vfObpRslKZmW2lOjTrn6M6eRnXs3oPcKE/S9TuDCLZAY/70V
        lFB6tIwzIxqGefoa1EX0CIy7uebNjmSoL/2PL/ftc7oK
X-Google-Smtp-Source: ABdhPJxhCDfR26Z9gQD+hyaTRzhiZ4Azp+v5bQxyCrdK6rR+i42zOg0Wt4puIZs3lp6EjY+OTQsKBZ3Fapp/QXSvjg4=
X-Received: by 2002:a05:6808:991:: with SMTP id a17mr1033642oic.167.1609207363991;
 Mon, 28 Dec 2020 18:02:43 -0800 (PST)
MIME-Version: 1.0
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com> <20201228171734.30038-3-avarab@gmail.com>
 <xmqqmtxxedwd.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmtxxedwd.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 28 Dec 2020 18:02:33 -0800
Message-ID: <CABPp-BFH6YmN_sWa5v9AUYEZrir6xRhQ-J5d=5j=XjMmRDx=DA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] CoC: update to version 2.0 + local changes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 28, 2020 at 5:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
> > This change intentionally preserves a warning emitted on "git diff
> > --check". It's better to make it easily diff-able with upstream than
> > to fix whitespace changes in our version while we're at it.
>
> I think there are only two lines that needs to tolerate trailing
> whitespaces, and even if we strip them, it should be still easily
> diff-able with the upstream with --ignore-space-at-eol or whatever
> appropriate option, so I am not sure if it is worth try "keeping"
> these whitespace breakage.
>
> If you still want to do so, we should tweak .gitattributes so that
> "git diff --check" would not trigger.
>
> > 1. https://www.contributor-covenant.org/version/2/0/code_of_conduct/cod=
e_of_conduct.md
>
> Yes, thanks for the full URL.  In 5cdf2301 (add a Code of Conduct
> document, 2019-09-24) we pointed at the HTML version, but if we ship
> MD and they have MD, using theirs as the base makes perfect sense.
>
> Sign-off plus acks need to be collected here.

I like updating to 2.0, and minimizing the differences between our
version and upstream.

Acked-by: Elijah Newren <newren@gmail.com>
