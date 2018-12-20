Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D684B1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 13:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbeLTNsm (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 08:48:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34274 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732995AbeLTNsk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 08:48:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so11985937wmd.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 05:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h77oKCQ8aNZjyekGC8nHKz7/gnMi2Z32N1oSeauuuEw=;
        b=WBeJX9p7teB5q70y+k68YdAEcxyCZUc0zokDKHpJ0Rz7PtNBOHHsnqXOEG48YjEslc
         rJhj/PbGmtG9BNCKoX6PPQOoANJTeMahOy57afCgeDWOF7ix8wrHbkKpZfafUfmbMJdy
         J90v+aqTNKR/U+vhpohwdT1NhHKPWHQwuem3dqY3W7k0OMteJsH3S7hIdKytnkPdYoYZ
         7OV/kQz6/ymfrX0jSz+keFH/KiYlp2OApImLDjjqknq8jcg31UYp3MBO/e4aBcfSLZq/
         Z+JI3hISeXf/aNbtNFhJ+Msje2aDiVoboudz3i6dsukmGHGbXJh+oee6TvDbZ7J6rv/m
         kTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h77oKCQ8aNZjyekGC8nHKz7/gnMi2Z32N1oSeauuuEw=;
        b=oSx3uRBQChd/Vnmrp3SbjtHaiHheTz8GE/iL9NjaNhJItZRLhmHtCpPsCyD1MTolTy
         4rvVNkKNhrO0nfXLtTg8ezhAaOLGZNdP4/0CzkHIRgVe67hqxdYu2LmVimbo0BS8Tb/Q
         1f7D3rUosOGBwuKrSGW+I1Ydv/lmdFitRF8exAJHsG3QoTET37xOi+VSLFxYhqZJf8JR
         nR2CIMwWzSNXt8H38WPoyzXZn8Tp6ai4UFfO+DxvI9vVcMTKt/ArXxh3FXOMNZ68BzNW
         jsmmBYg2k+u/+r45X9UrCRKij8yeJEks9TH4j5455KCU6zVqgnxM+i7XwvttuHNUoM4H
         JDKA==
X-Gm-Message-State: AA+aEWYpjpPRoEZiQ1u4q00Fsq6bgIKFZj3VQprNIJrc1s9MF4UdmJvM
        3ZBTymC9HrEIAahc1PAyWPzm6DfgcCo=
X-Google-Smtp-Source: AFSGD/UhgVKt5F6kPjr6+CIxHbvLmx1en5qvGKZWaYu1WLcFMeyV7e1A78LR5TJkcHfUUS/Jn55I8w==
X-Received: by 2002:a1c:e484:: with SMTP id b126mr11061848wmh.119.1545313717671;
        Thu, 20 Dec 2018 05:48:37 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id x3sm10127572wrd.19.2018.12.20.05.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 05:48:36 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/8] entry: factor out unlink_entry function
Date:   Thu, 20 Dec 2018 13:48:14 +0000
Message-Id: <20181220134820.21810-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <20181220134820.21810-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181220134820.21810-1-t.gummerer@gmail.com>
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
2.20.1.415.g653613c723

