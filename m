Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MISSING_SUBJECT,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E317C2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BB660FF1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFWB7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 21:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFWB7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 21:59:18 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D284C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:57:02 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so430117oti.2
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5RgvASD41SBFLfa2bI+gUsaF89ON1h4hq1K1CG/zKhM=;
        b=LRRQk/VWsnpnxpw4CFGrRI/+g0zitQ116tYadJiYYnpcb0arvQmkEYng+liD2aI63d
         Dja8GXT4UNcvqMaDkf9Gsj46gJRXKIhsKv+PomSroPLDe4h2awZ+83FKpaF0hfAQ9Xxy
         i0a11rvv7GEzj05ecqXoCI/ADMoaSxuTLA2xsraCwujtVizaKo6VdovEBAHrMjxHLxPx
         kkUzHwoUHoeqGhxc4qnm9l81kXu/OuPz35S3KW/gbPMh9QK+P7lRH2sMkFa1Ez6wiLAs
         2ZzUvjfptJUmXqzYWluu8oVp0wN+zLK1ImCVV2xqNXu+92QNqX6FR12+NwpX2dGjaAfn
         p4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RgvASD41SBFLfa2bI+gUsaF89ON1h4hq1K1CG/zKhM=;
        b=Z5XC74FKJWfVnaf8bTqm9mnZdYaYgNDW7zt+aLfhCbLzpY5jd49fKzkUdjk1ijtG1I
         Yjpq1Ns6GwcdT69RhbcQ28sr0Euoc59IoSfvIAXKMn+BWdIu769kz1zUB24My6LGOZTs
         niDHX1xRaEqQXY/959cWq0ylfBK+5PDG9Roo+JYVONNOaiv9kpDht3q7t3o/oE0rkZWY
         Yf5WjcyXpnGxYKOfWyhraXHt+8NuVMPk0vEYXtvjUb0rT59rivPEOWw8pKBMnbQuHelV
         1aLhZ5PR/wZRy+sLWrv3ZKbZMOK6W3xGstLwdcaTIu4UEZjRv3T0UbBRWYDMmlOFUxMC
         bRKQ==
X-Gm-Message-State: AOAM530XimhUQCGzie8CtXj4YONl+y0jkscY0WjeT9qWTeHklaNYqWxZ
        wKratoMylpoMCk2MXEyE6VI=
X-Google-Smtp-Source: ABdhPJyuutzf29jvozQP9coWHFvGAegm5Fxjd+4B+18CSqG0x6vrJKx0qtm0vGQC+eAH9D3wquGEfw==
X-Received: by 2002:a05:6830:545:: with SMTP id l5mr5482494otb.270.1624413421456;
        Tue, 22 Jun 2021 18:57:01 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id n35sm266357otn.9.2021.06.22.18.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 18:57:00 -0700 (PDT)
Date:   Tue, 22 Jun 2021 20:56:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Avishay Matayev <me@avishay.dev>, git@vger.kernel.org
Cc:     gitster@pobox.com, Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <60d294eb984ba_3122081@natae.notmuch>
In-Reply-To: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avishay Matayev wrote:

> Some git commands use a pager, which is usually a program that needs a
> pty to function properly (`less`, for example). Fugitive can't really
> use a pty for the pager as vim runs its subprocesses without a pty.
> Therefore Fugitive just creates its own pager (which is a simple
> window in vim) and pastes the git command output there.

That's not necessarily true; vim uses a bunch of convoluted logic to
sometimes use a pty, but that depends on the mode used (graphical vs.
console), and a bunch of other things.

Even more complicated when you throw nvim into the mix.

But yeah, for the sake of simplication let's say that's true.

> I started discussing this on an issue in Fugitive's github page[2] and
> Tim Pope (the creator and maintainer of Fugitive, thank you!)
> explained that `git` doesn't use a pager if there is no pty so it's
> impossible to override its behavior.

That is true.

> We had some ideas how to make this feasible (as you can read on the
> thread) but for brevity's sake I'll present the best (IMO) idea:
> Essentially, at `pager.c`, don't short-circuit in `git_pager` (or
> `setup_pager`?) due to pty absence if a new environment variable is
> present, perhaps something like `GIT_PAGER_FORCE` which will override
> the `PAGER` and `GIT_PAGER` variables. This will allow Fugitive to
> apply custom logic through to pager to know if one exists and present
> the window in vim.

Seems like a completely sensible request to me, except I would do it a
slightly different place:

--- a/pager.c
+++ b/pager.c
@@ -101,7 +101,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
-       const char *pager = git_pager(isatty(1));
+       const char *pager = git_pager(git_env_bool("GIT_PAGER_FORCE", isatty(1)));
 
        if (!pager)
                return;

I'm Cc'ing Jonathan Nieder who seems to have toched these lines.

Cheers.

-- 
Felipe Contreras
