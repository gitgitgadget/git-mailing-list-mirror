Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A152BC433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7155E206E3
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbhAQXso (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 18:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730778AbhAQXob (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 18:44:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E69EC061757
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:50 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h16so15604006edt.7
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yLwuadH5G7SVc/8uS27TTwjzds3Qilkin/Yl4nAl6fA=;
        b=aUwagn+J3thSNJ6dEjcN23IlktN+7X0jKu4DTPK5RDZRZlMRoWAZUnz3vnxZQkOpDo
         lSDupms5yE596NGrfZ+JqY/5/7lSIgETAhfXS49zcAg8AGDCrs+m1y6ZWKROBMyf/q9C
         9rlM2+1vh4jg9TA441CQWuO0R4XWx+Nhr+UdxqI1Yd/pOvbChnP8T4g6KCALCiLNZd/f
         ybyj5lqejDQgxTohob4hacvNnzX4rlcG+jJ8AHmzZ4h7vOVHes68tZodJyuptzgvWzZ8
         VcwLAWujQA5/2gzqNVXyHNePpmP/4ZWEH4vKaFA9v6BRCEEz/dj8ySj+jfEcHNiNe57b
         9nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yLwuadH5G7SVc/8uS27TTwjzds3Qilkin/Yl4nAl6fA=;
        b=iSxNBUB/aYqqC5BiYtpm66NOie2nXEtIA54iVcMkLgQ0wXereGk4Ac6DFBelldd/QI
         uYR6SpXys9yUt3XZ+V1HVWZpqKiMfUXgKWr3Uu6uGxw3r8p+shYbF9Lc5YlPVzhC1FNj
         5StUT+f3J3ZMd0cTUl7imbyM354koqiKSRhmVPFH3gG3pQ393ojUDeLZX9q69Dyi3fad
         e8nB7r5kUdTKrcwHdajQf182ME+xMc4ZfA5NxvyQLO6dFP+2JKe/u+8UIn3N3QxU2XK+
         QeShPWK6pGHwhuQsYgJgCQWrc/f3yxa3Xvh3ZzUFHzajprivIHXgFnZnS5t3IQFjEMdC
         qB2Q==
X-Gm-Message-State: AOAM532KLWz1tjCCSSRA/qjP4BittBntQBgh2elTVkR7hwAt2YVkvhHk
        fX1mgt+4Yclo/IUFKs3w1JfmQfzY9Kk=
X-Google-Smtp-Source: ABdhPJwHOGPjuc0ZeleR5vtMDxHYsOE/xwjJoHsq4In1OQB9z7wCsbnULOyCVfwsefbqZ154Jqihgg==
X-Received: by 2002:a05:6402:1751:: with SMTP id v17mr4414667edx.289.1610927028981;
        Sun, 17 Jan 2021 15:43:48 -0800 (PST)
Received: from localhost.localdomain ([79.140.114.246])
        by smtp.gmail.com with ESMTPSA id f13sm8639932ejf.42.2021.01.17.15.43.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 15:43:48 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 3/6] worktree: teach worktree_lock_reason() to gently handle main worktree
Date:   Mon, 18 Jan 2021 00:42:41 +0100
Message-Id: <20210117234244.95106-4-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.372.gbc7e965391
In-Reply-To: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

worktree_lock_reason() aborts with an assertion failure when called on
the main worktree since locking the main worktree is nonsensical. Not
only is this behaviour undocumented, thus callers might not even be aware
that the call could potentially crash the program, but it also forces
clients to be extra careful:

    if (!is_main_worktree(wt) && worktree_locked_reason(...))
        ...

Since we know that locking makes no sense in the context of the main
worktree, we can simpliy return false for the main worktree, thus making
client code less complex by eliminating the need for the callers to have
inside knowledge about the implementation:

    if (worktree_lock_reason(...))
        ...

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 worktree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index 474ed46562..39495b261b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -225,7 +225,8 @@ int is_main_worktree(const struct worktree *wt)
 
 const char *worktree_lock_reason(struct worktree *wt)
 {
-	assert(!is_main_worktree(wt));
+	if (is_main_worktree(wt))
+		return NULL;
 
 	if (!wt->lock_reason_valid) {
 		struct strbuf path = STRBUF_INIT;
-- 
2.30.0.372.gbc7e965391

