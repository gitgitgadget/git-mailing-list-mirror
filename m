Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BBBC1F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 08:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbdBBIuV (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 03:50:21 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32986 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdBBIuU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 03:50:20 -0500
Received: by mail-pg0-f66.google.com with SMTP id 194so1265127pgd.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 00:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fai5nD/Yzq9y8T0AgaKdeDkntgYfPwCqm52rEXki/lQ=;
        b=NEx80uN6iEJed/zSbiE2+G9GMrC6edy0wG7BnNfe82s2AdPYAN4t59NScJLDI0UJlk
         iwtR+6cmUIFX5pSHmEqY7jprYSP8fTmRAMSYWdcUSjEz0n0PcepcnP9qLawkbyDQqpNL
         0G0qgKHbok0dVA4MylAIWLx6k5gTKtbsvwC/J+7H/fONyODIMJrsJe5KAjmYVcXmENfV
         z0ngmFXfCuV+DCdpFRSwf3tQjbUTGGxhCK66/vXHnB3qZaSGLIUN0UZ9EkdUD0fm9aAQ
         62gAeTZLoO5e8Op75wGA4pBxnoaNh42OdUO7f7yyXl5mf2e3JrL420qBiyFrDcXZhbqZ
         ICOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fai5nD/Yzq9y8T0AgaKdeDkntgYfPwCqm52rEXki/lQ=;
        b=C0abvmNvcgOqNjf34doi5naY+kIOyeZvta/HoGJRpLohyUMK+yLdg/y+m1rIRhii46
         ZHuqmBU+twtpJ2bCOUJZC9pQBYPub51cj/mS/i8P9AdVWlctc9Me1LbqAdjjxiSXyVKp
         dW2PWlbCV50CORVfdnhO2z9rpg10p6sZcZvSjy9uy9zALNEs1WQaN4Cs9r7yH8JqM7nQ
         8qWJju/Mg2wH/qRhBXG9kw1mCW//yYAHm3iUj/McH/qMNEq9EZlnbJoaLMMxoGqbUj4S
         buB4Ov4A70fymgb3y06okXJKKmHF7fskevx5xuTlcDnT90tt0LYs+prq13NuAh+H0csx
         LwIg==
X-Gm-Message-State: AIkVDXLr73qg3F5JX/o9xaO4NpObbL+kKnbx2vDm2wJjHw3qN1i5/SdZETLGzCliCYDc5A==
X-Received: by 10.84.173.195 with SMTP id p61mr10811246plb.63.1486025419796;
        Thu, 02 Feb 2017 00:50:19 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id z127sm41482975pgz.29.2017.02.02.00.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 00:50:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 02 Feb 2017 15:50:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/11] worktree.c: zero new 'struct worktree' on allocation
Date:   Thu,  2 Feb 2017 15:49:57 +0700
Message-Id: <20170202085007.21418-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170202085007.21418-1-pclouds@gmail.com>
References: <20170202085007.21418-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This keeps things a bit simpler when we add more fields, knowing that
default values are always zero.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 worktree.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/worktree.c b/worktree.c
index f7869f8d60..f7c1b5e24d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -91,16 +91,11 @@ static struct worktree *get_main_worktree(void)
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
 
-	worktree = xmalloc(sizeof(struct worktree));
+	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
-	worktree->id = NULL;
 	worktree->is_bare = is_bare;
-	worktree->head_ref = NULL;
 	worktree->is_detached = is_detached;
-	worktree->is_current = 0;
 	add_head_info(&head_ref, worktree);
-	worktree->lock_reason = NULL;
-	worktree->lock_reason_valid = 0;
 
 done:
 	strbuf_release(&path);
@@ -138,16 +133,11 @@ static struct worktree *get_linked_worktree(const char *id)
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
 
-	worktree = xmalloc(sizeof(struct worktree));
+	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->id = xstrdup(id);
-	worktree->is_bare = 0;
-	worktree->head_ref = NULL;
 	worktree->is_detached = is_detached;
-	worktree->is_current = 0;
 	add_head_info(&head_ref, worktree);
-	worktree->lock_reason = NULL;
-	worktree->lock_reason_valid = 0;
 
 done:
 	strbuf_release(&path);
-- 
2.11.0.157.gd943d85

