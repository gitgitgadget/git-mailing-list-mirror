Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54DEC32771
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 10:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF2C206DA
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 10:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbgALKvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 05:51:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55108 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732628AbgALKvK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 05:51:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so6507289wmj.4
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 02:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ko4Bn3fgn6ZX7LtEXFX63OaHUD2/rQgrXBKctJ3e7dI=;
        b=de1UtWNgQJ8VHZFMcSmfCDTjklOv14XhKTchWDUFZAk1yOz1QO27I0q9xWY/HPcCRT
         L8tWH1NBfCOHGv7bLBSr+cXHQ4R8n9a6UYzI0CF7A7dd8ONSxrtNcP34f7lE8SM0Qnwg
         GafUOt9jMpUYLb+6+rfvzwarNHNUB35RYhknzD5kDmoePEAh0Do3jIiuVV1M1eeAveA5
         qflNqNC1gOn5Jy/CZhrCJ14yZicouVj/VOT3MU/0O/fEh8c6rkajoDcIHKjBw/HXBG4q
         Ghly8N0J3hBL3XYBG0jPjhJG9KbYsadBayYebH4xySh2k2rEpqVlA4p2tkW+BODLbI6l
         1poQ==
X-Gm-Message-State: APjAAAW4imW7D5RqU2YFWdVaYcqAmPZciwlrTtDEkf/td+nRiUO0JF7Q
        oiY4DZW5nynQkeaM137G32mGMMAlRPYYqQoGpmE=
X-Google-Smtp-Source: APXvYqzLeQ1rOtCLdO9V62eVwPkyCKGfHjupoCKm/H5TrlIS+eA9aqevHBb5cAYQNtRq9OJAMJLYlzsTITPhvvgm48U=
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr14497602wml.43.1578826268232;
 Sun, 12 Jan 2020 02:51:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
 <587e53053f02ad0867dc903688c8887602950bd3.1578372682.git.liu.denton@gmail.com>
In-Reply-To: <587e53053f02ad0867dc903688c8887602950bd3.1578372682.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 12 Jan 2020 05:50:57 -0500
Message-ID: <CAPig+cSoDFVonhn=xoWasHcN_hJHVoTiMT7=aU9ujiW93qk8kg@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] t2018: use test_expect_code for failing git commands
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 6, 2020 at 11:53 PM Denton Liu <liu.denton@gmail.com> wrote:
> t2018: use test_expect_code for failing git commands
>
> When we are expecting `git diff` to fail, we negate its status with
> `!`. However, if git ever exits unexpectedly, say due to a segfault, we
> would not be able to tell the difference between that and a controlled
> failure. Use `test_expect_code 1 git diff` instead so that if an
> unexpected failure occurs, we can catch it.
>
> We have some instances of `test_must_fail test_dirty_{un,}mergable`.
> However, `test_must_fail` should only be used on git commands. Convert
> these instances to use the `test_dirty_{un,}mergeable_discards_changes`
> helper functions so that we remove the double-negation.

I had to read all of this several times to understand what it was
trying to say. I think what made it difficult was a combination of
talking about using test_expect_code() for "failing git commands",
coupled with the use "we" in "When we are ... we negate..." which (to
me) sounds as if you are describing the _desired_ way of coding this,
not the incorrect way. A possible rewrite:

    t2018: be more discerning when checking for expected exit codes

    Functions test_dirty_unmergeable() and test_dirty_mergeable()
    expect git-diff to exit with the specific code 1. However, rather
    than checking for that value explicitly, they instead negate the
    exit code. Unfortunately, this negation makes it impossible to
    distinguish the expected code from some other unexpected non-zero
    code, for instance, from a segmentation fault. Therefore, be more
    discerning by checking the exit code explicitly using
    test_expect_code().

    Furthermore, some callers of those functions want to negate the
    result again, and do so with test_must_fail(). However,
    test_must_fail() should only be used with git commands. Address
    this by introducing a couple new tiny helper functions which test
    the exact condition expected (without the unnecessarily confusing
    double-negation).

> While we're at it, remove redirections to /dev/null since output is
> silenced when running without `-v` anyway.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
