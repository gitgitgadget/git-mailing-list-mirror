Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B6F1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 09:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeH3NNX (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 09:13:23 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36788 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeH3NNX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 09:13:23 -0400
Received: by mail-qt0-f177.google.com with SMTP id t5-v6so8977085qtn.3
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 02:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVo5f/zgHosHnRUrH7jRR+To8nl+K0rOmaDkWTqnJbE=;
        b=MgwXPJkdywXez3yLhhLSuSbzwgIaRSP8Zy56jIbs3hJ12ziWNbD7CgQpFRWoSZy8ep
         Fh/9B34plFqA3bChg6vYt1Jxvyxn1HpwvOJgIBIJBbY6kwp7RzxkyS4o/54tBgB8swjq
         an2xfpS/C8cELyVOoBUbZVDW3TJmHjGK2E4FXjAqop/3deWAZYcnz7Dao/f3qdbGXZAL
         lu/NNxPjLM3DszlOSJAybKnQ7cNGV1EtsPle3qg9qoNHQ+yEY14EKgFrYy02Hbk94vZ/
         rhSjFUs5n8G8KiPKVI92EmXtZoOXYpNMlInNZ5ebf8tjEGEiT3EDAIFaxlwgoWRulyMp
         JAdA==
X-Gm-Message-State: APzg51BJk53SsZkTlXOU/CQchlW3SR1mSoEt4WdzFzQi/4VV/p3AwKpF
        YEYK9A0/16l8bEKlcqkW3r9MadZasiz+Ysgg7ym7Og==
X-Google-Smtp-Source: ANB0VdZFa6u6j+hzQELCXDtnG5vTgHVdGVmid6cyvjubJyKov7ZVbumIlGTaEGolcl2tMCGSSOKAHpefRUlnWESOUkE=
X-Received: by 2002:a0c:b616:: with SMTP id f22-v6mr10542075qve.184.1535620333223;
 Thu, 30 Aug 2018 02:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180830081202.GA10224@sigill.intra.peff.net>
In-Reply-To: <20180830081202.GA10224@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Aug 2018 05:12:01 -0400
Message-ID: <CAPig+cRm80qBUXiykTtrHMxrMbzMLjYb3TvJB1UwoHNPFNxkkg@mail.gmail.com>
Subject: Re: [PATCH] doc-diff: always use oids inside worktree
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 4:12 AM Jeff King <peff@peff.net> wrote:
> The doc-diff script immediately resolves its two endpoints
> to actual object ids, so that we can reuse cached results
> even if they appear under a different name. But we still use
> the original name the user fed us when running "git
> checkout" in our temporary worktree. This can lead to
> confusing results:
> [...]
>   - we didn't pass --detach, which meant that using a branch
>     name would cause us to actually check out that branch,
>     making it unavailable to other worktrees.

Oof. The initial worktree creation correctly uses --detach, but indeed
the later git-checkout doesn't. I missed that too when reading over
this script.

> We can solve this by feeding the already-resolved object id
> to git-checkout. That naturally forces a detached HEAD, but
> just to make clear our expectation, let's explicitly pass
> --detach.

Specifying --detach explicitly makes a lot of sense, even if it is
implied in this case.

> Signed-off-by: Jeff King <peff@peff.net>
