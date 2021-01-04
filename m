Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA9EC433E6
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CE9221F9
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbhADQXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbhADQXH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 11:23:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D84C06179E
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 08:22:19 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id g20so37592683ejb.1
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIPaibn7JGfpaKfX5xdKBe0Sk9eCp/Iyw6JnAccoprc=;
        b=E6QuMnwJgj6KJuqwN21LiHaGEP58sRaymnyXcV8+N+MuE6fq1S9whoN1oOGCuXQ7dk
         6LjpsxeWxzrjRvexgdKkxjpxChY6WfeHGQ3f/AfrBSu7VzWMGgDvD14/UqoMF2R2lXqn
         25wSM8ZwdQSUjgzbqesKhB0E7rN5W+g6c0Zvg+jZlDaF0nYkS1tvbtXJf+4xaJOMs0Km
         KGqpkGVm+MQt0OlH22iOLalnHImlp4nbbRWPeuDkQ8bMMuxroXygYljL6akT0EuZkGZw
         LBnSnXJr6xOvsg6tMrtFeZgZYxasKU5Ic4eU112znRCK6/zPIM2HEaXLKuSiJw4LEDC+
         Ecuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIPaibn7JGfpaKfX5xdKBe0Sk9eCp/Iyw6JnAccoprc=;
        b=iKr4p9l/7oKrpR6duq4rqEU4223vjFdjmsC43zr+yQ9i7dNUq9SeYH1e2rL5Scmqlj
         ERZYU9MfhaEJHXJ3mQaJkh05LukA4bfhTGddexsp9TiEnMvCvz6msZQXAiEiH7aFskBC
         hsb9t1TVniSI9nyF5H6Z5wiPsUG+YJuLQVzXWRqweHuMallxfDJ8f4bnWeb2/LYA+NW4
         W2XvIvwXWauzj3+3S/E772q83g6t+67VkQI4HceoM1siwqOoUhpPe7IRZzm1K2z1hlTT
         50PWQOtqeVPmqiphL4qUdw0bnNv1W2gKIqH1qGnh0WZNqkRP/63PGVj50G+K9RcmrVqy
         h8+w==
X-Gm-Message-State: AOAM530XojOnwfoWYIDkkYgg8DJOjBwDGWZEtN79DR3cgcdsh0GQF42r
        fZzIkXGpUA+N+oKkcJ1YGB9pfHn6ASc=
X-Google-Smtp-Source: ABdhPJwUXt3HBwxgdsQ/CCRABN1IZ/6QAAT9OLpclCon7bnGyENW1xgDRW3dXJrAjBal+dL+XVkjsg==
X-Received: by 2002:a17:906:aeda:: with SMTP id me26mr66260054ejb.11.1609777338264;
        Mon, 04 Jan 2021 08:22:18 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.191])
        by smtp.gmail.com with ESMTPSA id bn21sm23931677ejb.47.2021.01.04.08.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 08:22:17 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 3/7] worktree: teach worktree_lock_reason() to gently handle main worktree
Date:   Mon,  4 Jan 2021 17:21:24 +0100
Message-Id: <20210104162128.95281-4-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.391.g469bf2a980
In-Reply-To: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main worktree should not be locked and the worktree_lock_reason() API
is aware of this fact and avoids running the check code for the main
worktree. This checks is done via assert() macro, Therefore the caller
needs to ensure the function is never called, usually by additional code.

We can handle that case more gently by just returning false for the main
worktree and not bother checking if the "locked" file exists. This will
allowed further simplification from the caller as they will not need to
ensure the main worktree is never passed to the API.

Teach worktree_lock_reason() to be more gently and just return false for
the main working tree.

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 worktree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/worktree.c b/worktree.c
index ee14db3ab5..78be83ba16 100644
--- a/worktree.c
+++ b/worktree.c
@@ -225,9 +225,7 @@ int is_main_worktree(const struct worktree *wt)
 
 const char *worktree_lock_reason(struct worktree *wt)
 {
-	assert(!is_main_worktree(wt));
-
-	if (!wt->lock_reason_valid) {
+	if (!is_main_worktree(wt) && !wt->lock_reason_valid) {
 		struct strbuf path = STRBUF_INIT;
 
 		strbuf_addstr(&path, worktree_git_path(wt, "locked"));
-- 
2.30.0.391.g469bf2a980

