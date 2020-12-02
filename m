Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2200AC64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 07:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E602222C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 07:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgLBHpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 02:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgLBHpW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 02:45:22 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAB4C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 23:44:41 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id b15so595827qvm.10
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 23:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xUlQxe0dzUdR9DxD4SvZxoNJrfK1kEpTHGE6hdZjKx8=;
        b=aIhwk/gJDvNZeKpCNrmg4X4ko0lS61Nv3X7QhdYo3QLf2SSGjQ6EKBLShsx3hdhRIV
         3WHQQEM7gSlrb88fUQBgjg9wYa9nMfBTu/khm0D2K38T/p5LE2bkDr0F7c/83crECyio
         j18KgfXs7v8cJGX22/1wPJnOMug50wk6fZWfwrW6jccyya6rhPCYUKss0Ep2vWqLbxSU
         SB446xJc7fpqU5oiCO13I+Un9gkMVndjAhuZ8EX3G25+r6dwIdn5DZohGyDT4C1h0Am+
         tMyVz+QWvFBNVdwyp/i7RwOQKaARKiqdN8HIasdhG35xoZzm6qD571my5mEgdAS6KhNv
         Ystg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xUlQxe0dzUdR9DxD4SvZxoNJrfK1kEpTHGE6hdZjKx8=;
        b=Sl7uUeEeRkpYUFFWX3DL0eEryw6ZPZ5IfBlpIE+I5SdT9A9coM6bhI1J4eU4M9DMZ6
         L+2FLDYzFvX00AcYtRtZQLuL3gjo1VmNKZzuE8NJi+nKdNJKx22a+zbk0gqapvB5zNP3
         EHerCSpLDbzbkCYykKqDeeGrOuPfpKxsScnYfGGEIrKDQkk5UmmPc3Qm/nKKOOErlbDR
         eSzyLX7SvjSH+tFEKKI3BZdsifKDLbeReSdJCNrka3qr9qiyyYGRem/6lUf0mdSBFCCM
         qF0YwRA0cB2ChvaY5swpLQ/3mSb2wah0v6n5yymDz/Azz2E06eWXgrq1vQCSHKZWZuD0
         s6eQ==
X-Gm-Message-State: AOAM532QSS3CwjxlhpJi21E+JC2HwKNJDlJNV6S6QucTDyqjquQI7j7r
        wbeTxSni5euV/3XhfRYhWR2zEblgQywOTE+AjrwV
X-Google-Smtp-Source: ABdhPJypD8XK29+/iG9ypByj8uknM9vplgEe+nMAdi+wUOr0kSQohylIAHBHiSle1NhxzbK8u+Qyi9DYoebOf14WgMMt
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:ebc5:: with SMTP id
 k5mr1513739qvq.40.1606895081065; Tue, 01 Dec 2020 23:44:41 -0800 (PST)
Date:   Tue,  1 Dec 2020 23:44:39 -0800
In-Reply-To: <1da4fa0fb85fe848aa86987e767b33d296f8f878.1605649533.git.me@ttaylorr.com>
Message-Id: <20201202074439.3478090-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <1da4fa0fb85fe848aa86987e767b33d296f8f878.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 23/24] pack-bitmap-write: relax unique rewalk condition
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> However, there was a (significant) drawback: wide histories with many
> refs had an explosion of memory costs to compute the commit bitmasks
> during the exploration that discovers these intermediate commits. Since
> these wide histories are unlikely to repeat walking objects, the benefit
> of walking objects multiple times was not expensive before. But now, the
> commit walk *before computing bitmaps* is incredibly expensive.

Do you have numbers of how large the commit bitmasks are?

> In an effort to discover a happy medium, this change reduces the walk
> for intermediate commits to only the first-parent history. This focuses
> the walk on how the histories converge, which still has significant
> reduction in repeat object walks. It is still possible to create
> quadratic behavior in this version, but it is probably less likely in
> realistic data shapes.

Would this work? I agree that the width of the commit bitmasks would go
down (and there would also be fewer commit bitmasks generated, further
increasing the memory savings). But intuitively, if there is a commit
that is selected and only accessible through non-1st-parent links, then
any bitmaps generated for it cannot be contributed to its descendants
(since there was no descendant-to-ancestor walk that could reach it in
order to form the reverse edge).

> Here is some data taken on a fresh clone of the kernel:
> 
>              |   runtime (sec)    |   peak heap (GB)   |
>              |                    |                    |
>              |   from  |   with   |   from  |   with   |
>              | scratch | existing | scratch | existing |
>   -----------+---------+----------+---------+-----------
>     original |  64.044 |   83.241 |   2.088 |    2.194 |
>   last patch |  44.811 |   27.828 |   2.289 |    2.358 |
>   this patch | 100.641 |   35.560 |   2.152 |    2.224 |

Hmm...the jump from 44 to 100 seems rather large.
