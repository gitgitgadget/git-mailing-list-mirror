Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EFEC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F298961050
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhHBQdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhHBQdc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:33:32 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1303C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:33:21 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so18002721ota.11
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Br7J/bX4tYIiIy3kb3YAencUXV5zs1gug1IOiBHWjv8=;
        b=TV2Qsyq6SUCBfTVPUeTRcd6BdfqsXTr44HFt1hUA9D5HhtXw8mGWYy94wUTWY/DNkM
         +53eMc/U8uCTcyKU64XPb6xH47vkFWtEER6mDh7rW+TjMIW/iMneh1apPipmuNoS7sbh
         q4bgQ2FE0/S1Z/rbY/ToP7xacOjwE0M0xXRpuL2bxTBeDDUX+dJuJpoJyuZoaA/npTqo
         Z8Uu+4KAitLiQso4T7QpvGYdvgsaGCpOl0MKt/V5Y18zBhUriWXHzLaMAxQS6PqXPQM7
         s8T9a82VYPfTyf9LmJe/r6Po2MTAbvz67snfhREt9MAjX6BhaM8y6MC78+TWp2vw2+44
         XPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Br7J/bX4tYIiIy3kb3YAencUXV5zs1gug1IOiBHWjv8=;
        b=lOajmpHfe1c1rkLREtXDOvZtBzYZEND9ViBNtS86/AmxTWJ3JQu/LeIGKbwQBJd2D3
         wY0I8Fy3igFzSprowmfwbfeQGe98j/HuTnd1EcwyqdStHmWDcT07Y3D7h5nDxdR3UuVl
         huoPtCW4sSKR7eRAWVs04+UGG5cUezCSAD4h/bPrcs2ih/04t0GQnPzGFvtr2KbpQ9WY
         bKKJwKhdCBzBec/Q9LcLg0HwhtB6xXKeIzY6eqSJFqOQD77fordFh9Vo0xAFlhFcWrPq
         XK5oCP0zLD0YHM7BzVmDPmqIvOC0wdkMcllCMnpPN/AEP97sRs9D99Pcc6h9okS+MXeW
         O5Lw==
X-Gm-Message-State: AOAM531TIYZrbxF3hS7SZsDxnWLxr0zg3rcErWQXKGUlmsz8vxcWL/Ic
        bMTO5XwuClkzRyxLNj7BGD8v8wfChR8UwA032v0=
X-Google-Smtp-Source: ABdhPJwpZEFDImvRn99OoD934wPZIMUmzD2flkafZL/hQ1GICwVHotyOeqWu/zU4CtSWtcIT+dTicXMtNTtTbkCZEBE=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr12039064ots.162.1627922001139;
 Mon, 02 Aug 2021 09:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
 <8f6af8d494e0924aef4ae6963b8dca2228dad9b1.1627776462.git.gitgitgadget@gmail.com>
 <87h7g7on6q.fsf@evledraar.gmail.com>
In-Reply-To: <87h7g7on6q.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 2 Aug 2021 10:33:10 -0600
Message-ID: <CABPp-BFD4wMyaWwcfjWAUQSV2fTwCKRviengSRsf=LV5u39anw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Change default merge backend from recursive to ort
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 2, 2021 at 9:56 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Sun, Aug 01 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> > [...]
> > @@ -3968,7 +3968,7 @@ static int do_merge(struct repository *r,
> >       o.branch2 =3D ref_name.buf;
> >       o.buffer_output =3D 2;
> >
> > -     if (opts->strategy && !strcmp(opts->strategy, "ort")) {
> > +     if (!opts->strategy || strcmp(opts->strategy, "recursive")) {
> >               /*
> >                * TODO: Should use merge_incore_recursive() and
> >                * merge_switch_to_result(), skipping the call to
>
> I might spot more tiny issues, but it looks like our error messaging
> needs updating for 14c4586c2df (merge,rebase,revert: select ort or
> recursive by config or environment, 2020-11-02).
>
> I.e. we die on "Unknown option for merge-recursive", presumably that
> should be updated to indicate that we might call one of
> merge_recursive() or merge_ort_recursive() now.

Ooh, good catch.  I think I'd prefer to reword this to "Unknown
strategy option: -X%s"

> And perhaps this in sequencer.c:
>
>     that represents the "current" state for merge-recursive[...]

Yeah, it's just a comment but it should still be updated.  I'll
s/merge-recursive/the merge machinery/ for this one.

I tried to look for other error messages or comments similar to these
two but didn't find anything.  I might have missed something, though.

I'll get these fixed up with the next submission.
