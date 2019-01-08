Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41F31F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfAHVwh (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:52:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37967 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbfAHVwh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:52:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so5613102wrw.5
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 13:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wn547PCtutIHk8GRaf/KgSJsCyUrDoaCQN7duHBc+kU=;
        b=odaAIgjQ3MyO7uTdg9wfPbJfEvBALLm+xQln7O2DIzfYRjFniCfB2paXDl4SCR43jD
         R/6ovqJ4EHvf1OMOLFxyML6Pv3nz6mRc7C5qlCkXyvlYdVkeY8qNx/qzYATSg96YXW4w
         PxGUjnimgspQKxWVxQNEudQTTv0DluFDzhCuqt/1lONDlG7+CMlrNWt1EOgjpO4JNKxb
         wvIv/I0f3wRwc+EczYIGHwZ5jD2EWBA6CqRdJMgTqqfgyqcFicxqbQSx86d/FZBzejA7
         2GG2MD1B5G71o2JQJWm3zdHwdnqJjA2Et3gaF2Jz6sfRuRxQ4o+ScVlosVDLxwpwx6FL
         FVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wn547PCtutIHk8GRaf/KgSJsCyUrDoaCQN7duHBc+kU=;
        b=dphDnOl+FFL6g4Rgc/8bNKuqGGMF/JcehFLOEx7e+aBuaeVztyKxKxzCl15+ttoZTT
         2ZNTsvX9YkXlpk+ywTnJQ9NpgNJ2R72nf69LmRT9fIZuVOINv7OJCO9NjDFPA7Qjst/m
         nbg+avQIHclecqMAQ2nVivvsskbPtAnYA9Pl+XUzzE1jwn1woRi313maCxWCYAsrL97U
         1yN4IizhWcjImYU1y4cbJ/ZZw/aP6PI1lupetTy9P6W/qOjiy0C1xIZWiGgecdvD5Yyj
         217ojb3nRZ+bGRIBptQyX5x+xdnubnan2ygXm4WNOaaid0g9LTdHDCp7lpIPxP7kLR91
         pFOA==
X-Gm-Message-State: AJcUukfhvc778la0mKW1j0BXwqF7aHl1skW/MCflGFtTftH24aOR858/
        5QJoVZE+REcLIve1h91mhnuZ6l1j
X-Google-Smtp-Source: ALg8bN6d6E8zQP05IcT6XYEzMRIt7NklYMOhk8KKVHvTs4sIabnZlFq1KJnDEQghRMcN8gQTqrJujA==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr2622892wrv.116.1546984355381;
        Tue, 08 Jan 2019 13:52:35 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id f18sm45983412wrs.92.2019.01.08.13.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:52:34 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/8] entry: factor out unlink_entry function
Date:   Tue,  8 Jan 2019 21:52:19 +0000
Message-Id: <20190108215225.3077-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190108215225.3077-1-t.gummerer@gmail.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
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
index 0a3c451f5f..b9eef57117 100644
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
2.20.1.153.gd81d796ee0

