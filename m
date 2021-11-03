Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB584C433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 19:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB5B60FC2
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 19:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhKCTa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 15:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCTa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 15:30:26 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1AEC061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 12:27:49 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id t127so8863340ybf.13
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6+4ONhYv/xYT2tlB061iTH6QMbmpjv9f/CH9cC1YLk=;
        b=n2la40DgUIfULbJDhwV5POv2dVSe7Cfgx9D6aftthbULEbWQ8FsMLOI+2+co/lugyG
         pkOV1RI0z8bFrnnYSXn+SCeLHVGlpYuP7AtoNqCubGWOcDOOtRocVwm3xHJ32Kmlh1d6
         2rLnGzhC6U4ppQpEFNsb6GaLT7c/zlBGg8jNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6+4ONhYv/xYT2tlB061iTH6QMbmpjv9f/CH9cC1YLk=;
        b=oIYEfImX1T4WKWwCcd8jY9hJJQbSk49U7AA9hSb63SJH3bpUQxE05Q0A3EtKZpMTJH
         8g91CjH43jvZhcJWwSzTxsRPiGpU3vSp5HOMdJbMxJ9rAEfkmEDIvz28cqI59wD11VWP
         e1enBx+qt+n7aELkjmUvOGc04P0hy7Pi059iKoSHRHyoCPUDdCi4JRsbvZK0rZgxilAA
         qZnf4T/9fclPg3X7tNJeUK0KUka6XjwjiBZt99t3BZ9bIL9ZAHYpmFGiCFoUbsbAyslH
         baQTcLB06NpFwZUEiqo8aGfKUfGXUHv9rB8PAXQXlf296NHjLhih9WYWSR1E50HXZUOW
         yRXw==
X-Gm-Message-State: AOAM532Ib7Nso/qkxAjf7O7gPcDUZ1WJFKyc+wofww+vA+eoOO+Vp25f
        BtTwkrOi4iFjZj9Bbiog6CssuAwXZ+apL6umURWJKA==
X-Google-Smtp-Source: ABdhPJywb8TnhDzocQsfQf5WWN2MXy1tuiEH1sunyBaeoy0d6RICz8cMU4piiI/w6LnshXR2im9qp7R0YelLe9eONRo=
X-Received: by 2002:a25:d114:: with SMTP id i20mr45888456ybg.323.1635967668533;
 Wed, 03 Nov 2021 12:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211027080616.619956-1-fs@gigacodes.de>
In-Reply-To: <20211027080616.619956-1-fs@gigacodes.de>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Wed, 3 Nov 2021 19:27:20 +0000
Message-ID: <CA+kUOakzQ5aEQf81rQULiz6FRdmCLnbhspt9e6behPS3sbZT8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] ssh signing: verify key lifetime
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Oct 2021 at 09:06, Fabian Stelzer <fs@gigacodes.de> wrote:
> This series adds key lifetime validity checks by parsing commit/tag
> dates from the paylod and passing them to the ssh-keygen operations.
>
> changes since v1:
>  - struct signature_check is now used to input payload data into
>    check_function
>  - payload metadata parsing is completely internal to check_signature.
>    the caller only need to set the payload type in the sigc struct
>  - small nits and readability fixes
>  - removed payload_signer parameter. since we now use the struct we can extend
>    this later.
>
> Since the last 3 patches now only contain a minimal code change and the
> tests for the seperate callers we could merge them together. I don't
> mind either way.
>
> Fabian Stelzer (6):
>   ssh signing: use sigc struct to pass payload
>   ssh signing: add key lifetime test prereqs
>   ssh signing: make verify-commit consider key lifetime
>   ssh signing: make git log verify key lifetime
>   ssh signing: make verify-tag consider key lifetime
>   ssh signing: make fmt-merge-msg consider key lifetime
>
>  Documentation/config/gpg.txt     |  5 ++
>  builtin/receive-pack.c           |  6 ++-
>  commit.c                         |  6 ++-
>  fmt-merge-msg.c                  |  5 +-
>  gpg-interface.c                  | 87 ++++++++++++++++++++++++--------
>  gpg-interface.h                  | 15 ++++--
>  log-tree.c                       | 10 ++--
>  t/lib-gpg.sh                     | 19 ++++++-
>  t/t4202-log.sh                   | 43 ++++++++++++++++
>  t/t6200-fmt-merge-msg.sh         | 54 ++++++++++++++++++++
>  t/t7031-verify-tag-signed-ssh.sh | 42 +++++++++++++++
>  t/t7528-signed-commit-ssh.sh     | 42 +++++++++++++++
>  tag.c                            |  5 +-
>  13 files changed, 303 insertions(+), 36 deletions(-)
>
>
> base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9

As part of testing v2.34-rc0 on Cygwin, I've found this patch series
is breaking t4202, t5534, and t6200.

Specifically, bisecting points to f265f2d630 (ssh signing: tests for
logs, tags & push certs, 2021-09-10) as breaking t4202 and t5534,
while responsibility for t6200 seems to be 9d12546de9 (ssh signing:
fmt-merge-msg tests & config parse, 2021-10-12).

I've not yet done any investigation into the specifics of these
failures, but I wanted to report them early so other folks could get
on with investigating as appropriate.
