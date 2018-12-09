Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732E920A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 20:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLIUFC (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 15:05:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36172 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLIUFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 15:05:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id u3so8465857wrs.3
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 12:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D7SOASY12vKEgpfKuattfmL/mEr/8ZnM0iuwElbYewg=;
        b=qUkZbaFZ1YsBKWx1Yo3dbvOV9y7/OJipJyUhrqkZAkEyiJXOoVyJogaRGh4GEQtOLK
         RyBb7GqYVAWjIf5zEKWqbFgWabU+Kp4Qxi7WVnk4el4XI0N4PMEH/bZd8n2JQ9yy8FX2
         PKz6L5Ymgc1+IBt0Qb4KMfOrUXBLeBoDFRQl81RV9PVw8vrl792StkL52u/w6X94dkZK
         MxF8C3f7LMTZJdxWd/FMSVnjbYLrx50huUs+oOPUhaT/fbb1ye8VuBBxVc3EhQfgIpPo
         ET8RseakpEPMb0OdX8lr5p6CtUgrIjU7T3Rs1/Z74fw8JTiJg5CDt9Cc97ErOxrF8suh
         BqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D7SOASY12vKEgpfKuattfmL/mEr/8ZnM0iuwElbYewg=;
        b=Gfp2UAiRFYfH4+wKAp5KdxnnzzCS84vBNXnq0Kf84hMzuJC7UXiccuJ0+QvnU5V0T5
         kfLFylPK1itWZcDvVXqOJP0BUY58TM8aEDuEZHmeUj0JCJ9N38Gf16O6P0pqIcZDXhlM
         TSG/4cAsKm5Q+MrflWGEgxdCi+tsE+eb+rrNFlbkSlXgyaaxW5I4pqI68DihdZ30B3KJ
         gF/VEDyJToVI7LRK6Tba+R/82hreDXSZClhESaiLsmG8aC19TV+uS5T7LO+158g2VD55
         mpMm35ujYP5tshW5OttX+O0StWjezwa9h/xbtS2xlag8H22WRK1P4reR2jZ5aW5Y9pPo
         xeCQ==
X-Gm-Message-State: AA+aEWZQleKlusQDATAGWTEupN+XMcDlpEW56WzX6C1a3+P5LXCcy1gC
        Wz99MJ7VuHyMZiXWkmfNL0JHjILQ
X-Google-Smtp-Source: AFSGD/WD+COqdIlh2203vQpv7XJgqwPOVxyvtlYJuoaU/agGIG27xWnQKABBg/WKBDKMSaOPpOdP/A==
X-Received: by 2002:adf:9591:: with SMTP id p17mr8148219wrp.224.1544385899841;
        Sun, 09 Dec 2018 12:04:59 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id s3sm7897603wmj.23.2018.12.09.12.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 12:04:59 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/8] entry: factor out unlink_entry function
Date:   Sun,  9 Dec 2018 20:04:43 +0000
Message-Id: <20181209200449.16342-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the 'unlink_entry()' function from unpack-trees.c to
entry.c.  It will be used in other places as well in subsequent
steps.

As it's no longer a static function, also move the documentation to
the header file to make it more discoverable.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h        |  5 +++++
 entry.c        | 15 +++++++++++++++
 unpack-trees.c | 19 -------------------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index ca36b44ee0..c1c953e810 100644
--- a/cache.h
+++ b/cache.h
@@ -1542,6 +1542,11 @@ struct checkout {
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
 extern void enable_delayed_checkout(struct checkout *state);
 extern int finish_delayed_checkout(struct checkout *state);
+/*
+ * Unlink the last component and schedule the leading directories for
+ * removal, such that empty directories get removed.
+ */
+extern void unlink_entry(const struct cache_entry *ce);
 
 struct cache_def {
 	struct strbuf path;
diff --git a/entry.c b/entry.c
index 5d136c5d55..3ec148ceee 100644
--- a/entry.c
+++ b/entry.c
@@ -508,3 +508,18 @@ int checkout_entry(struct cache_entry *ce,
 	create_directories(path.buf, path.len, state);
 	return write_entry(ce, path.buf, state, 0);
 }
+
+void unlink_entry(const struct cache_entry *ce)
+{
+	const struct submodule *sub = submodule_from_ce(ce);
+	if (sub) {
+		/* state.force is set at the caller. */
+		submodule_move_head(ce->name, "HEAD", NULL,
+				    SUBMODULE_MOVE_HEAD_FORCE);
+	}
+	if (!check_leading_path(ce->name, ce_namelen(ce)))
+		return;
+	if (remove_or_warn(ce->ce_mode, ce->name))
+		return;
+	schedule_dir_for_removal(ce->name, ce_namelen(ce));
+}
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..e8d1a6ac50 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -300,25 +300,6 @@ static void load_gitmodules_file(struct index_state *index,
 	}
 }
 
-/*
- * Unlink the last component and schedule the leading directories for
- * removal, such that empty directories get removed.
- */
-static void unlink_entry(const struct cache_entry *ce)
-{
-	const struct submodule *sub = submodule_from_ce(ce);
-	if (sub) {
-		/* state.force is set at the caller. */
-		submodule_move_head(ce->name, "HEAD", NULL,
-				    SUBMODULE_MOVE_HEAD_FORCE);
-	}
-	if (!check_leading_path(ce->name, ce_namelen(ce)))
-		return;
-	if (remove_or_warn(ce->ce_mode, ce->name))
-		return;
-	schedule_dir_for_removal(ce->name, ce_namelen(ce));
-}
-
 static struct progress *get_progress(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
-- 
2.20.0.405.gbc1bbc6f85

