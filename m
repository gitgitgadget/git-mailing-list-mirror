Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05119C433E0
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F1064F20
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578447AbhCBPYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381169AbhCBEVy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 23:21:54 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DE3C061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 20:21:13 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 2so942274pgo.0
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 20:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Yo3S+22pfMkx96jgAR7kidD2NYWgcwARQ87qQxjYYoU=;
        b=Eywh33rYd45hYVnAMIa31Gm6wCbQzuSj4gocR9osBcPtbIMS063Cmm7iTzeaIrlsvW
         Gin13Bq0TWXwg8S7i5NqiI7FVXaTPV4M0uSj9rQ5Mj0DMJCvPdbSAbbJgxmV/BbM1+1r
         1A8cALVOUI5l9AoxqGhH5eLMHkU3EiOpOprB5Om2nO4qKyAaAzdqxfWS2LvaMNL0EKdy
         ez680G6epseRcFuEjScOwZrd4Royea7jGDtMUXiKVlv2Qe+BX2t/C9fTEKge9iL/GGHW
         PkPKtdMUN42AP05DHuGyj/Ji7kmo35cLTl04EX+BFbk/LalDbLuaJ+48moERc4KGDCWl
         xAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yo3S+22pfMkx96jgAR7kidD2NYWgcwARQ87qQxjYYoU=;
        b=JBr+4UuQ9Bb4aRlpxDnoO0qmWimJKrYVPdjeJgNyYV304oDWLL9etq33dIxpSaTsHB
         uoo/z1LRJ3zso27NgnLpfmc3g7j/AVQhje8v+W7WRkk1/peto+0RGGdgIO6pG4igM+29
         9LLek2U5Gib5+F/+9DybQxbKlvBEUEjFnM7TlYHBHXbFcUO9VNevQlFBdOMliv5I5cL0
         bxBGPhhpiVyUAdhrd/MADcVJn2Lda0EPA6fTYnwt9M/a/Keeg8vcxY5z8vhv2htuj4gJ
         +gt2py9JUQnULLMzn3qMmGQ6Nnj5MnoDQl1WxKtugtPGTQHt+TTbA+qg0lQDupth8wEK
         7obg==
X-Gm-Message-State: AOAM533zo7BMmiTg8IDTlzMCwAWi5HT5+KAOsDx5uojdjwaQLP8nnQsD
        f9mUrh0fEo4l6UUixsvQS+ddUOeoSc5U5AsDKWlV
X-Google-Smtp-Source: ABdhPJxmG91j6xQ0RmEcQDHqfC/hcaebicaoTonrXbwaiOSPQxfGEt/BYiO99DwceUjFtCNLqj0hrLwQi4eE2rI2YVub
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:3716:: with SMTP id
 mg22mr2293838pjb.157.1614658873511; Mon, 01 Mar 2021 20:21:13 -0800 (PST)
Date:   Mon,  1 Mar 2021 20:21:11 -0800
In-Reply-To: <404d730498938da034d860d894ddbb7d6dffc27d.1614193703.git.me@ttaylorr.com>
Message-Id: <20210302042111.4038479-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <404d730498938da034d860d894ddbb7d6dffc27d.1614193703.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v2 12/15] Documentation/technical: describe multi-pack
 reverse indexes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +== multi-pack-index reverse indexes
> +
> +Similar to the pack-based reverse index, the multi-pack index can also
> +be used to generate a reverse index.
> +
> +Instead of mapping between offset, pack-, and index position, this
> +reverse index maps between an object's position within the MIDX, and
> +that object's position within a pseudo-pack that the MIDX describes.
> +
> +To clarify these three orderings

The paragraph seems to only describe 2 orderings - object's position
within the MIDX and object's position within the pseudo-pack. (Is the
third one the offset within the MIDX - which is, I believe, trivially
computable from the position within the MIDX?)

Also, which are stored in the .rev file?

The previous patches look good to me, and I'll review the remaining
patches hopefully tomorrow.
