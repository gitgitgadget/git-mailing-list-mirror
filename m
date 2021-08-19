Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A923C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8706109E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhHSUPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:15:18 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:43748 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhHSUPR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:15:17 -0400
Received: by mail-ej1-f54.google.com with SMTP id b15so15253881ejg.10
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iQKw1IG1942hPRFo64aLUL1wFvXDMRW5YmBCtcwUoU=;
        b=BVg17h5alDjTKODUyAHNXYuZcKisKJpM253Qob14DoVemaLbE1oBmc/RME4gkz19ZJ
         Dcl1bHHkzVZdBMbz9TH9bD2Mrgv+xHvGbT0s/NL4+mPT4OTgQDqDNO9djftWUEO0kpb4
         lMsMU+nSDX3GhyjzK+onPRYkP7ztXtXVQGfvwb+FiVkS35QKoAKMiq/RQmzuzrKgXbFz
         zPbxP0OSWrCWUTlF5QmMZ03kFm1KhFA4d7my3GC4o/Dl4ZECVzuKbybedheR3ENu2Rhc
         C1INO3hCpZveEiEzT6b3foie/u7pQN4cOLd9nseMUfg6mJTZDqX+54fskQhw87m6HOpw
         Xd2Q==
X-Gm-Message-State: AOAM530O42aZNsPNKyNtidrL5Qct9nqDoFonIJb6KaAMu68cRjtrx9qJ
        2Q9DT2XB3LFpz7/lyhXlk1PouhVxofFq9FymOco=
X-Google-Smtp-Source: ABdhPJwUOHsUiDLf7Vfcd9eJR4NgwzGmKL3N2F6vLgF4M6F4CB/oxh7TpctH0qg54slHCcdGzogWSfupy7Yz58AylzI=
X-Received: by 2002:a17:906:2792:: with SMTP id j18mr17488060ejc.168.1629404080172;
 Thu, 19 Aug 2021 13:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
 <CAPig+cT2FfaYBbsRMy7vxXkvsxn4BcFTn4bGJjgvJKznXg1OYg@mail.gmail.com> <xmqqsfz5yzp5.fsf@gitster.g>
In-Reply-To: <xmqqsfz5yzp5.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Aug 2021 16:14:29 -0400
Message-ID: <CAPig+cS-7nT7NHP4ALpoUOsxhwEJgcKgbLhd1BkAZSo=pBvArw@mail.gmail.com>
Subject: Re: [PATCH 0/2] test-lib-functions.sh: keep user's HOME, TERM and
 SHELL for 'test_pause' and 'debug'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 3:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > I also find the test_pause() user-experience suboptimal and appreciate
> > the idea of improving it. However, this approach seems fatally flawed.
> > In particular, setting HOME to the user's real home directory could
> > lead to undesirable results. When I'm using test_pause() to debug a
> > problem with a test, I'm not just inspecting the test state, but I
> > quite often interact with the state using the same Git commands as the
> > test itself would use.
>
> Yes, I do agree with you that it is a valid concern.
>
> I wonder if the developers can configure tools used during debugging
> session with XDG so that HOME can be kept for the "fake user that
> ran the test suite, with the fake user's configuration"?

I haven't studied XDG deeply enough to answer, though it would not
help macOS or Windows users (but that's not an argument against
pursuing an XDG solution -- it might still help some developers).
