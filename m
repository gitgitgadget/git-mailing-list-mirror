Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBC9C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5104620759
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgI3VE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:04:56 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:33548 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3VE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 17:04:56 -0400
Received: by mail-ej1-f65.google.com with SMTP id j11so4936957ejk.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 14:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzzGVlbLvMMS7WP5AR7Mq/WjF0l6xwGxBwqiLWut2SE=;
        b=c02c8Fm5NoL8PxoDGUpr7x1G1uOYqoEWU8MzVec2EmvGuKDp8/Mdla2050oy8YX9zq
         4OhZPbeMtt8J/1hCW6E5X0IvdXz6Tn5gQLkKhRDPw8Ff6xMK9AuQ6PO0Azgsqw1XP9DW
         /A9vmhllYPcxY6Ayd82Ve4fvMDpmHIOM+ddoOTvQclAmny2cgrJtBs7yZZBa2NSeKw5F
         RcYMnVE8DIBT+JOHWoBsWafoMu6n+sXAMnUUmjUfWE3keP3Mztq8VbY2jhGQDbcDVSB7
         RfM63FsowPdDoQGaVfbqlq7I2c3gCXhniLUE2WmCXMsGfcLAvEXAHuYiSQWiXVStJw9c
         EIOg==
X-Gm-Message-State: AOAM531rhU5iDL18XwI/iSyPKta8tpXPWm2XIjC9sYgs4GQsZb8zioQL
        G++ga2D859vV6+7eQSw/Hd+I6hELjeQiquA+spegYEOEYD8=
X-Google-Smtp-Source: ABdhPJyFX0Y/qzIeX/v7l78sva9+9waqqAnIWDpdeibvKllpbkgy4DVaK9sXJDaXJY65sg4aM1n902vALO0Z8sywAX0=
X-Received: by 2002:a17:906:f0d3:: with SMTP id dk19mr4727855ejb.202.1601499894348;
 Wed, 30 Sep 2020 14:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200930195052.118199-1-tbodt@google.com> <xmqqzh57f0dh.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh57f0dh.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Sep 2020 17:04:43 -0400
Message-ID: <CAPig+cSoJf-=Po39qocKttH2TQNGW9wVov6cQgb5zbZjZz63Bw@mail.gmail.com>
Subject: Re: [PATCH v2] Propagate --quiet on submodule update to merge/rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Theodore Dubois <tbodt@google.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 4:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> Will queue with the following log message.
>
>     submodule update: silence underlying merge/rebase "--quiet" is given

Probably want to insert "when" in there.

>     Commands such as
>
>         $ git pull --rebase --recurse-submodules --quiet
>
>     produce non-quiet output from the merge or rebase.  Pass the --quiet
>     option down when invoking "rebase" and "merge".
>
>     Also fix the parsing of git submodule update -v.
>
>     When e84c3cf3 (git-submodule.sh: accept verbose flag in cmd_update
>     to be non-quiet, 2018-08-14) taught "git submodule update" to take
>     "--quiet", it apparently did not know how ${GIT_QUIET:+--quiet}
>     works, and reviewers seem to have missed that setting the variable
>     to "0" (instead of "1" which is used when "--quiet" is given) has
>     the same effect to pass "--quiet" to underlying commands.

Perhaps:

    ... to "0", rather than unsetting it, still results in "--quiet"
    being passed to underlying commands.
