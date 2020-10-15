Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7948FC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFFB22240
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh8/qJaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbgJOQbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389825AbgJOQbS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:31:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AE0C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 09:31:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x7so4316907wrl.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=nD/GfeBRsxdkqMkje/kYwmdKm9C1eixZ+Oba+ddQH7I=;
        b=Eh8/qJaEIxCQg9IJcn45gJyxommWPlumu9My9wjXFUJ16M1CXPoEF2qas/GwjCVyJ3
         GdXV5997wCnsbQJCOtC3CTcboACAc0o8r561c9+P6VgSfaecwYVmK5vvM+h4r8ZawEgC
         +sRNevTjn5EGGFSgiIIJsmQK2eOq0c4qNwNPtYG7EQso2WNKohFDdGMEmxXND7UU/GXC
         CbTf3E6E3/tcxThob84hbdHzfCBxHggvH7+j7bDJZ2sEbyWdshlSm0WK/bJ+VfABeH2c
         q8uKODxfAIY+JewM5IMw0WyCCuYY/WtI6SFEw2LqnRhK1HPqXKL6uJDV6P67J48CLNLN
         6naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=nD/GfeBRsxdkqMkje/kYwmdKm9C1eixZ+Oba+ddQH7I=;
        b=N52QWH8YIfqknoqhVgGy/lrD5u05trwslaQJmUcv9cqbbw1HJArO2dyq2MYo7gt6jN
         0mTbOFFnhmfcUOOBdWf4QRFcocxQyb79litAmilmy7TWR42oI+YHZZ5l6SDmWveX+fiA
         qRw1mVFkeclerl6UG2kqKl8ZmhbRR4H9D2zt/UuG8/cjRf/RBI/C/1ockXYnvQGFLthU
         WJQldDjyGSTgCFcIdEQHI9w4uz71OubwXzRUSz7s2soW4X6lBNfTAPlK38SBBMBs0ep+
         eSqSsf39SSJJzymqdQlNSNL4tMhbnz0gjKbR9oKxK6X8VbmOZzTED9sxEoeVyas41QSK
         UVbw==
X-Gm-Message-State: AOAM530XRLbpSAOwcsmIfMbY2RRd7jOcnyHisINFI+kYez9a5qDmFSvM
        sh7QVBPfBPY6qxE7USgjIXmek38W7Ko=
X-Google-Smtp-Source: ABdhPJyZ52I/qDrnG4LNE1T2Z2bR4uCYg/NjUoCJw9RhcOzAMyEHnJrQIkFvH9/xu1YwdkdDKA1k7A==
X-Received: by 2002:a5d:490a:: with SMTP id x10mr5021596wrq.289.1602779477231;
        Thu, 15 Oct 2020 09:31:17 -0700 (PDT)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id j101sm6197625wrj.9.2020.10.15.09.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 09:31:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 1/8] doc: propose hooks managed by the config
References: <20201014232447.3050579-1-emilyshaffer@google.com> <20201014232447.3050579-2-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201014232447.3050579-2-emilyshaffer@google.com>
Date:   Thu, 15 Oct 2020 18:31:15 +0200
Message-ID: <87d01jih7w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 15 2020, Emily Shaffer wrote:

> Notes:
>     Since v4, addressed comments from Jonathan Tan about wording.

I had some extensive comments on the v4 here:
https://lore.kernel.org/git/87mu0ygzk1.fsf@evledraar.gmail.com/

Your CL & this patch don't mention it. I'd be interested in
collaborating on this depending on if/how our goals/wants align, but I'd
lke to get your thoughts on that feedback first.
