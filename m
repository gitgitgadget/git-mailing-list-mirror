Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE6C43460
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2BF61581
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhEJMwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343777AbhEJMOY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 08:14:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B90C06175F
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:11:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r5so5802383lfr.5
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e4kgPo04EpFd9dazUurGRMbpwXc1ghRtjBnorloftMc=;
        b=p3ASDn6lIUp5BM1w42sC5GUfYr4PnGRyR35UognbhBIYUF1l0CmV0QFbKOK0xnotvY
         yJetVA/3uUz8GlQUHCmtQxFw33MqUelfxfAie5Mhm1cSF/HhKsMciFb2FPJ+IWVfpJDF
         Br9wAcGXqgi8chJOOb/VlIjohQVROWSGKLDX04J9vXDXFTWzYvaYRRirQ+1CzwBLzpSY
         IzmTL474G/Lir88g+DtUGYskqcl7FAIdLncR3JJ2tRarY4rreLQsfa1n+5Ek+BsOT00H
         VcHJ1p63uL14BhVeZEq7crDA3cxtpwy01lGYOsSBtGF58ZPz/w4fp+27JV41LW2r4KT3
         TXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=e4kgPo04EpFd9dazUurGRMbpwXc1ghRtjBnorloftMc=;
        b=KsGkSmMIufMmn+HcawwRM27cEOUkAOAMQAH5Vt7k7zLa7nNeoSe0sFo2EPmnZDYN19
         wBHvW68zlhg/B63k0BzQpYsuA1qiQ9vg9YDvEO1awAlMlxsaLHE9w2GiPDfysEuGMlZi
         A8usPxX7XK+TEOuHJTDcpe+Oh5UBagodcbp4qI2VvlIO0p8O3htGOJsrAMM01mTrhiaK
         Q8slsOhNrU7qRU+kNpTO0qweKnXkJf1cQwFKNzDE37xV0BWRF0TIHpaaH0yzYL5vcbJv
         4mPGAutsFRaHtT8kNd5pxREG9/u33ldpJc2d+0SLD0LfojptDkr7EfdZ5bT5OaiqckVC
         ULog==
X-Gm-Message-State: AOAM530dURU4+9cxapzbUYnGRHNpzOV0+u+qpenNPcgeVtFbjPDk+hXr
        A4NqjQz+xq0KPL5qrPyEVa4=
X-Google-Smtp-Source: ABdhPJw0bjPTEWy0m+FKR/F1KpyorqUPklEGBLSPgcpz6SNfbOykyrh8eHUeZsQMQRP/DLtWn8oiPA==
X-Received: by 2002:a05:6512:3c8:: with SMTP id w8mr6985563lfp.63.1620648703013;
        Mon, 10 May 2021 05:11:43 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m2sm2243260lfo.23.2021.05.10.05.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:11:42 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
Date:   Mon, 10 May 2021 15:11:41 +0300
In-Reply-To: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        (Alex Henrie's message of "Wed, 28 Apr 2021 19:44:19 -0600")
Message-ID: <87a6p2hjpe.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> I read the following in `man git-log` today:
>
> --diff-merges=separate, --diff-merges=m, -m
>     This makes merge commits show the full diff with respect to each of
>     the parents. Separate log entry and diff is generated for each
>     parent.  -m doesn't produce any output without -p.
>
> --diff-merges=combined, --diff-merges=c, -c
>     With this option, diff output for a merge commit shows the
>     differences from each of the parents to the merge result
>     simultaneously instead of showing pairwise diff between a parent and
>     the result one at a time. Furthermore, it lists only files which
>     were modified from all parents.  -c implies -p.
>
> --diff-merges=dense-combined, --diff-merges=cc, --cc
>     With this option the output produced by --diff-merges=combined is
>     further compressed by omitting uninteresting hunks whose contents
>     in the parents have only two variants and the merge result picks one
>     of them without modification.  --cc implies -p.
>
> Why do -c and -cc imply -p, but -m does not? I tried to use both `git
> log -c` and `git log -m` today and was confused when the latter didn't
> produce any output. Could we change this behavior in a future version
> of Git?

Patches to fix this are almost ready, but I'd like to make a warning
that you'd likely be even more confused by the current output of "-m",
unless you set "log.diffMerges" configuration option to "first-parent".
These diffs with respect to /second/ parent at the end of the output
made me really mad once upon a time.

-- Sergey Organov
