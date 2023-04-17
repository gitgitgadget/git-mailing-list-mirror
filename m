Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C2BC77B7A
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 16:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDQQzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjDQQzD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 12:55:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD8A9
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:54:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s6-20020a17090a698600b00247a7794e78so2466594pjj.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681750496; x=1684342496;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYsxbvKrYfWFnDJvVeE3e7p2U5w4w+KCCuEgmg3/mXA=;
        b=XPKU8qIrB4f/q0AJ9vMRSyxYpsJrF5RhX4C9zh3QMokBya7udDtAh8XhsHPT0XUbcR
         88o5WOh5Ir1GBKRLyPFo5FMfTfCiCs8VMeDGBbBpKwvEvN0Kelq+bQwFSq52L5xIzeX+
         B/t3XEyGqC6hBVihZULmDzzQLyhcE+XidS5NNV6EXQasfXGX1wP1HYhkaGvtNza0fZUo
         HO6VxiVs3awV08BBVo9k426Mmb29+PWGNDZZfHUOwB/kMCvgC096DkhxQKmqyLbpKMdm
         /Q3XlW2aa1n/77NOV8p8t3xmPPik0UV+E0HrnLueui3L1UhfZN2+RyieumTKSeliVpXf
         8pIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681750496; x=1684342496;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xYsxbvKrYfWFnDJvVeE3e7p2U5w4w+KCCuEgmg3/mXA=;
        b=YyRe5V7cm52Hpg0WLLoKD2gFTbVv5f+lUNLSoZLmwG5JdiEab/THP/hcFQbjwDTyIo
         z8FLxKLaTjce7KIMPrF2yIMixBbfFdzOxq9FUtKP8RGDzsE8EwEzTRngMT5UOQWUeblP
         V4bj1lQVnt2wao35nlTXWX77IIQFc6oVieXVu2kqF5FIMQHwzTvm1y1vFeJK+WvMppEi
         E6CZyBlZhAhHj/e1hTpvx6cvR9iSo5fRAF3QINAGUe94f+VwHJKx7DMg35+Mj2AGYzYp
         lCBjtjUMQcmbKcV2UsH4QYQ8u7f+U23m270CpeRU36XvE3Kpl3IzjjnFHfsxB1R1Q2EK
         WD0Q==
X-Gm-Message-State: AAQBX9fiI6bcpNU3+OfRwoUABNkWjDZS5sG67l226A/Mshzbupv9AItg
        OLe9vQYP+e1c3/BWz7W6t5zeAoinG5g=
X-Google-Smtp-Source: AKy350ZR7w1jgdOVnoJuXziEmoZisRt4ls6dIysEKivAG7p8qPDIJEYnjLkBrUCxrVhoAavTrRQmrA==
X-Received: by 2002:a17:902:e74c:b0:1a6:6b9c:48ae with SMTP id p12-20020a170902e74c00b001a66b9c48aemr16465082plf.52.1681750496129;
        Mon, 17 Apr 2023 09:54:56 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id bj7-20020a17090b088700b00247a8ef11d8sm1341757pjb.24.2023.04.17.09.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:54:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     avarab@gmail.com, Lars Kellogg-Stedman <lars@oddbit.com>
Cc:     git@vger.kernel.org
Subject: Re: Regression introduced in 03267e86
References: <bt4342bdip3nzlikjsv6wozszmcbsc2av6cyo3z2lra4jhx3ii@ut2sl5h4f5xn>
Date:   Mon, 17 Apr 2023 09:54:55 -0700
In-Reply-To: <bt4342bdip3nzlikjsv6wozszmcbsc2av6cyo3z2lra4jhx3ii@ut2sl5h4f5xn>
        (Lars Kellogg-Stedman's message of "Sun, 16 Apr 2023 13:20:20 -0400")
Message-ID: <xmqqttxemotc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Kellogg-Stedman <lars@oddbit.com> writes:

> [This behavior was originally reported in
> https://stackoverflow.com/q/76022720/147356.]
>
> Prior to commit 03267e8656, the following sequence would result in an
> empty commit:
>
>     git init testrepo
>     date > testrepo/testfile
>     git -C testrepo add testfile
>     git -C testrepo commit -m test --allow-empty --only
>
> After commit 03267e8656, the same sequence creates a commit that
> contains "testfile". I believe the original behavior was correct,
> based on the documentation for the `--only` option:

It looks like a convoluted way (aka use of an obscure option) to
create something useless (aka an empty root commit), but it should
be allowed and the last step should do what you expected.

> And while that passes all the tests, I'm not sure if its correct; the
> change in 03267e8656 was correcting a memory leak and I'm not sure I
> completely understand the details.

Yeah, figuring out how 03267e86 (commit: discard partial cache
before (re-)reading it, 2022-11-08) broke the behaviour is a good
first step.

Thanks for reporting.
