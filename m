Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B648CC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 06:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE8F224D4
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 06:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgLWGSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 01:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgLWGSB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 01:18:01 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5CC0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 22:17:20 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id o5so3470032oop.12
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 22:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tL2UocJoFL6L/lUSQXx9r4lTYSUjGAPK1f/DQKiwOPk=;
        b=M1Smj2b8rsPIT3VLSb9XqZnKcWVg4El1g+CJLjZdsG+cqg3uIpE23F81vwU2YY+kFc
         E6Ced7pVFLVqjeNVShB9ggO7OT1U5STwDIejVUc9z9wpxteE8I9TzcHUrhVYpAJYQD2U
         voS6NMH0XjEAb78XkgqlTuK2MChH6ZvY6sHfmvFNBK3eQ8b6v+06waJo5e7rmGz1QQov
         YJP8x9QTG89HFCWScmJkyqyHwMRgu0oxFqB/gkEA0ENCLyaJrNhUkD5ZOcKKlWIfsVei
         Kwo24jZeiWePdr1SK6HaLPSomBo3qbbV+YEUTkjjq82JgKbewhh1NwlwmTwyC8u/BiJS
         dByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tL2UocJoFL6L/lUSQXx9r4lTYSUjGAPK1f/DQKiwOPk=;
        b=tLJNfACi+vqiidqSN8dUCrQ8MZXxlPCrK8WCD6SpBpoTnqBnDkiYUJVzFammVWbf7Q
         SHC76L2v8hOlZy9HGF9Xjw6VPyU/snSm8TDZsAFNjlgIetgo3+gySR5eIR35cXeATQWf
         Tovkuw7Vlf3uDkdDBvxvVJePLocMVaEdJh8bT24qklCmykQCTrQ9YEWWnUsh6pR8/Si6
         un4WVZZA0xYXj+S3LOUllyi2Y1MG4oOHTCXnLpTJc45aVPEgaiHInjPI7YxueKkDskaf
         ARqYg6roJ9Lg6ggxD4oxnDDuIi+0ip7yjd/0uBMGIZaXmOfjMjbKXenr8GQcnjui7dSL
         WBDw==
X-Gm-Message-State: AOAM532hE5Pb96Prx0E3vHwUj3BO+psqcDRekNKD78anBmBFhFhIFeQd
        VEYMIkSXPLnYyViYtDWxZHkRF7+8NqwLOw==
X-Google-Smtp-Source: ABdhPJyCc3srrMO+OwfYnAeSJxusbReRAcSyZ/EiXmBAdb5/JmurX/lpbXYz7Ydml6GJkKA+0VNXvQ==
X-Received: by 2002:a4a:a289:: with SMTP id h9mr17423932ool.86.1608704239898;
        Tue, 22 Dec 2020 22:17:19 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id n22sm4753369oig.32.2020.12.22.22.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 22:17:19 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git@sfconservancy.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        'Junio C Hamano ' <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
Date:   Wed, 23 Dec 2020 00:17:18 -0600
Message-Id: <20201223061718.102779-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A lot of people confuse respect with tolerance, but they are not the
same thing.

This was debated when Cambridge University decided to implement a
freedom of speech policy demanding respect, which caused a huge
backlash, not just within the university.

As many argued; respect cannot be manufactured at will. If you don't
respect an idea (for example that the Earth is flat), then it doesn't
matter how hard you try; you still will not respect it.

In that sense respect is like belief; nobody can force you to believe
the Moon is made of cheese.

You can pretend to believe in something, and you can pretend to
respect something, but you really don't. Any policy that asks people to
pretend is not a good policy.

What should be asked for is tolerance.

Tolerance simply means allowing an idea to exist, and that's what the
Git project should ask from participants within the community.

We don't need to pretend we respect other viewpoints, we just need to
tolerate them.

[1] https://www.theguardian.com/world/2020/dec/09/cambridge-university-rejects-proposal-it-be-respectful-of-all-views

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 CODE_OF_CONDUCT.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
index fc4645d5c0..3324d9f151 100644
--- a/CODE_OF_CONDUCT.md
+++ b/CODE_OF_CONDUCT.md
@@ -22,7 +22,7 @@ Examples of behavior that contributes to creating a positive environment
 include:
 
 * Using welcoming and inclusive language
-* Being respectful of differing viewpoints and experiences
+* Being tolerant of differing viewpoints and experiences
 * Gracefully accepting constructive criticism
 * Focusing on what is best for the community
 * Showing empathy towards other community members
-- 
2.30.0.rc1

