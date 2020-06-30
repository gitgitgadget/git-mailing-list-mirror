Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE86C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 17:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C0520768
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 17:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbgF3Rug (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:50:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46663 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388881AbgF3Rug (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 13:50:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id r12so20996144wrj.13
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 10:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSTpj/f78Us+3AIWPDRhR9qlEnKJ/wePceuCb4AjhGI=;
        b=Yi3TJ2n1r4+26lwS2t4w8xNf2OqhUXnZTftsV3eIS1bSk03UXBtD4aC2Qjb5+l7Uo4
         9GbnCPYJGo3ZPkB1qKYRdATWpO7/oz2DvUKyvFqDEFc8L0Io+uvoqwexycaYQD69JKog
         eo29FW9TA6GPENQE4rrV41Xbb/WhO7Xt1yGtoeGpggIIKDcEciWN9vXOov1EN63WM6em
         dnKy8OJbTPS4jID0LKfiMdJu/t5GUt/lqZROPxlK3SYh4ByYIliCO4PuEoo2QrMBsly0
         Kk5gxr/F+p5bREfM72Qfl73tgbPRC+FIEuqzvf3sf2N4YQBLoGu9jm4c8oNx0146nJTV
         eKnQ==
X-Gm-Message-State: AOAM530nuVtac6eFDCun5UCxCnPIYjcs4+1LbL2fSX18rx1j76KdcWEB
        QjqxayfdyZ5z1davGSnjxPjEv55TfZwmtUrUpki2uIW/
X-Google-Smtp-Source: ABdhPJwwCscLIvyHuG9Yn4FkvpuZyXV0IvZXdbKlR0Ona/WhicGd8li+cWYJD1n7bpJTkOiajbbx8fAE8vfj5x4iU9c=
X-Received: by 2002:adf:d1a9:: with SMTP id w9mr16895654wrc.386.1593539434060;
 Tue, 30 Jun 2020 10:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593536481.git.me@ttaylorr.com> <5a20a97658fa8e6c874c9c9cafb2cf49e39f94d6.1593536481.git.me@ttaylorr.com>
In-Reply-To: <5a20a97658fa8e6c874c9c9cafb2cf49e39f94d6.1593536481.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Jun 2020 13:50:22 -0400
Message-ID: <CAPig+cQv3cHe5ci3mDvNKYXbVQt6Rp5icG-woaDCqfAtzZ6SZw@mail.gmail.com>
Subject: Re: [PATCH 2/3] t4216: fix broken '&&'-chain
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 1:17 PM Taylor Blau <me@ttaylorr.com> wrote:
> In a759bfa9ee (t4216: add end to end tests for git log with Bloom
> filters, 2020-04-06), a 'rm' invocation was added without a
> corresponding '&&' chain.
>
> This ends up working fine when the file already exists, in which case
> 'rm' exits cleanly and the rest of the function executes normally. When
> the file does _not_ exist, however, 'rm' returns an unclean exit code,
> causing the function to terminate.

This explanation makes no sense. Since this command was not part of
the &&-chain, its failure would not cause the function to terminate
prematurely nor would it affect the return value of the function. This
explanation would make sense, however, if you're talking about the
behavior _after_ fixing the broken &&-chain.

> Fix this by making the test use an '&&'-chain, and passing '-f' to
> ignore missing files (as can be the case when specifying which tests are
> '--run').

The entire commit message is talking about implementation details and
merely repeats what the subject and patch itself already say quite
clearly; anyone familiar with 'rm' understands implicitly that '-f'
must be added to incorporate it into the &&-chain if the file's
presence is not guaranteed. Thus, you could drop the entire body of
the commit message without losing clarity...

With one minor exception: What is much more interesting for the reader
to know is whether the file being removed is guaranteed to exist (in
which case '-f' is unnecessary) or may be missing (requiring '-f'),
and under what conditions it might be missing. The very last part of
the last sentence of the current commit message gives a good hint
about the latter, thus would be a good bit to retain.

> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> @@ -53,7 +53,7 @@ sane_unset GIT_TRACE2_PERF_BRIEF
>  sane_unset GIT_TRACE2_CONFIG_PARAMS

Not related to this patch, but 'sane_unset' is pointless outside of a
test since there is no &&-chain to maintain. Plain 'unset' would work
just as well and be less misleading.

>  setup () {
> -       rm "$TRASH_DIRECTORY/trace.perf"
> +       rm -f "$TRASH_DIRECTORY/trace.perf" &&
