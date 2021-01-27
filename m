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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BE3C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CF72073C
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhA0IMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhA0IEr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 03:04:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D1FC061574
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:03:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 7so922801wrz.0
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Sn1LywvgTB3toZxLoD6Grunjry4v4oJNcGLIL0l3Ik=;
        b=NdozWRItqCvu15sAHk4hKxbguhVzN7wuG/plXe753p/NKRNmg01+tdg2uPlSkNY+9o
         9KyWyEGRhZju1drvNrBOKu6CpQCn11VOpBR2axT1SA+bAwpdpvoQlrLIzlkJW6TgxaIH
         mYkTz0aJQxWul/lGR4wXLeqPE3MjZ8X3SklaYvi9Qm56lcqTkuUPJYdwwaXuB7Vn27tU
         /52TvG6NKv+T4LjCtPjvPIJlnSBr2KlhQLMTUcphpBHzMC/u0EnCGOGRW5eBgLYZB8nG
         RFiVAc4dDF33sDtz0gXzR4RA9Oog/MMnwt82by+Pc2DlRnS/wtQ/qVGBgH8pn/y8bzaE
         dxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Sn1LywvgTB3toZxLoD6Grunjry4v4oJNcGLIL0l3Ik=;
        b=Qqi+AINDQ1qLgD8u+BA36ce8pkBNoHSSEPbbl9XmEgG2W5ac+o7R2Cc0OLgddpoXX1
         6TJ1cxF0/CjQruHpwjTY5KlN3tsLIZezdP1g178ZbyNy2OmefSKOmPA8pP5zK7Ip8sdQ
         jVtHKvcKY9mXWl5nuboK1yDjzQl4HFG168RlaLT+yWrSIJLN8V3yl5diMNAOITycQU8x
         rgK2QO56re3yodSpqwTptWU0MvaZp5KPSTpE67CCnGwVB5j0ca/I1OaRKKWEgs5vPUAh
         zSYao3vgK+GCRD7g50LtAkAmnJuNijvNP7iQzv1uZq4GY7MTOC8/z4PM9x98b1/EWVSI
         LcLg==
X-Gm-Message-State: AOAM531ukhub9gth8JxOPXtl7lDHlFosJCbB/jOR3qiBj60yI2zb3IBx
        Sb9Hwy1RXJQXx37OYG20qJ/lDZJvRYP66IMP
X-Google-Smtp-Source: ABdhPJzLskYEGh61Q1bmzT66+EJ5tonPXX6P2XUQsxQ+vahlSzMfqykV9JNJtrjrJQu6DgrU5WM1zw==
X-Received: by 2002:adf:cd10:: with SMTP id w16mr9869379wrm.90.1611734638143;
        Wed, 27 Jan 2021 00:03:58 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.116])
        by smtp.gmail.com with ESMTPSA id m8sm1850237wrv.37.2021.01.27.00.03.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:03:57 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v4 3/7] worktree: teach worktree_lock_reason() to gently handle main worktree
Date:   Wed, 27 Jan 2021 09:03:06 +0100
Message-Id: <20210127080310.89639-4-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.395.g7821b4e95a
In-Reply-To: <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
References: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

worktree_lock_reason() aborts with an assertion failure when called on
the main worktree since locking the main worktree is nonsensical. Not
only is this behavior undocumented, thus callers might not even be aware
that the call could potentially crash the program, but it also forces
clients to be extra careful:

    if (!is_main_worktree(wt) && worktree_locked_reason(...))
        ...

Since we know that locking makes no sense in the context of the main
worktree, we can simply return false for the main worktree, thus making
client code less complex by eliminating the need for the callers to have
inside knowledge about the implementation:

    if (worktree_lock_reason(...))
        ...

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 builtin/worktree.c | 2 +-
 worktree.c         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index dd886d5029..df90a5acca 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -604,7 +604,7 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 			strbuf_addstr(&sb, "(error)");
 	}
 
-	if (!is_main_worktree(wt) && worktree_lock_reason(wt))
+	if (worktree_lock_reason(wt))
 		strbuf_addstr(&sb, " locked");
 
 	printf("%s\n", sb.buf);
diff --git a/worktree.c b/worktree.c
index fb3e286996..e00858540e 100644
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
2.30.0.373.geade8fefe8

