Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8503C432BE
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85FE60EBC
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhG2OwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbhG2OwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 10:52:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7375C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h14so7266694wrx.10
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4FmGwAHuC6p1ZUMm2KxbrnzsZI0XqDa0wUNb99/XewA=;
        b=WVEsj8aUoy15Krw/7KOxSbas6dxGhQwrOaVWyKY8ckDzPglquu7RwSbCjQFs7ZVr6+
         KaANqQguJn8P2fA00Dawt5k9U+PiLBLmW0GbqtnYSZqtaBErjrQo4/NDdGNjGZh4b3pb
         HcG8mz9iMmACAZbK9Zr23P/Z2rk2DHgvl6IM63poijMwpg2mgwdmASdqFgI1e9eVssqt
         D29d4v0p3gSyjTRSkCiwjtoXm2fj0Qa5vbnNcn/G2GLEEzW4+dZnzvyNOEhEE6ZvDL7C
         tkQd8qmN+idJ8eKnAxjc0YvT7khLpUye4oTlslF0cxA8hPtLc1DIG+QGaLo9VFYVfx40
         jJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4FmGwAHuC6p1ZUMm2KxbrnzsZI0XqDa0wUNb99/XewA=;
        b=CSpSGLE4lIcXo8xuNPzYzFJ7UFveFn8KbXOSY9jY0cnb4zuQLPmnMV5v/y717z2xDR
         nTTTIcp1RZ+/eB+e9Qm4ND+R86Sg+ijqCRXTl1KmaoiZil6a9adjKW82TNVUQSUvBU2X
         Qk+paV0AywlXcTTi35MweN/70OuIoOjc8KmkIat0UDMkaczvjXIb0qcfKtpAnGdVlVwq
         BczKXZN3AUbGIfprZjezH8JigXFvNB8dZNxpMHYqEzjQA+Vayk3WeWZ+FIM+1qoqE4nG
         AFaTN2lWC0z8EQy7huxo8bmGapv0hI87Xxk3D5mQBh/x+0xGf8/6uwnqcyngah5QQTrE
         ZIGA==
X-Gm-Message-State: AOAM531gwlu8nQcA6OBRtNm9MAcMMmo0Tiaimlt3XIqYai3KAgMQuuUF
        40pd2A1mRDcbWoQzi7FTpURP0ujFSqI=
X-Google-Smtp-Source: ABdhPJy0JFdhZqfR+UqVWxZRt/wMMyoSMKNvO37Wmg2QspcVB6XjaZw1UFAvYfOFgAna7241NqGarw==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr5303438wrs.252.1627570332364;
        Thu, 29 Jul 2021 07:52:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm3835557wrt.23.2021.07.29.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 07:52:12 -0700 (PDT)
Message-Id: <adf5b15ac3d44d92e0438451ef36631ed3ee2a63.1627570327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
References: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
        <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 14:52:07 +0000
Subject: [PATCH v3 5/5] add: remove ensure_full_index() with --renormalize
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The --renormalize option updates the EOL conversions for the tracked
files. However, the loop already ignores files marked with the
SKIP_WORKTREE bit, so it will continue to do so with a sparse index
because the sparse directory entries also have this bit set.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index d512ece655b..c49e179abc3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -144,8 +144,6 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 {
 	int i, retval = 0;
 
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
-- 
gitgitgadget
