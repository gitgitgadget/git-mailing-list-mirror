Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D48711F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbeKNKOd (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:33 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:55532 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKNKOc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:32 -0500
Received: by mail-io1-f74.google.com with SMTP id y14-v6so14170613ioa.22
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ECmjKTbfHCMgEIfWVFX+LBSDVRiz5doRtWK7UIw84qM=;
        b=YOfqFJhKw1tt5ER7Upri6wQwwPFJ/C4eVe/p+qDP+TPQDkHZRpKrDnbq1Y0aRmBIy0
         tNNThHeOrqQKyDM4+QbcO+QcsSFe6TN2KWndiGJY89r6yoWa09uihh4RT19XsDWv5zKU
         D/wlpwoKPjJVfvFuN5WYulQQePWtY1xYNtm6nlk8E1z5o2mr0Uhj2ePs13AE5/igOc0G
         W0MlP0CRI5rC3tGM218t6vQGVtqNltkjo7xzVwvAAiWhyP5bFWxNey9zP+8DoibwKcKS
         aUT96Pm8sz6HVlHBoNcN2Qp3Vpv47lEJXNW1ivFq3CIqfxy4nEz4M8OL9k+wiUeVuYP9
         mcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ECmjKTbfHCMgEIfWVFX+LBSDVRiz5doRtWK7UIw84qM=;
        b=NUmwkz4r6uDVqLcUpZyJizsqDR5CxqhFEdXy+MN8U5JxaxnICyoSqB4qkFymsB/td4
         GeZQrjWW8YxlP/8reNOz4xTzrIs4jw8hH1dHtE9RFFiIaRUiijhUxW7FUd+o+qP36Knu
         Y87Nd6VKwGSKR86tiKEl02S65UZiFZBXlqaMxaiu81R7nwmU4vMiOHksY2lTlJAQp8vK
         pslYWsCkcvFR/I3PkOeLIDd3PROw1+bt2TidNDmV4k560Af8lTOXwz8QdZqU9se0AztT
         xGSGQiitkNUqzZ2DHiVjavVHB73jcZkgR4MUTcLdsZuULOcgNrO/SIOWQNrWdVqiTwJQ
         GWbw==
X-Gm-Message-State: AA+aEWbQ6oTTxmi+TEEytAcvlMtg+oAFR3On1EOoFsdFFzXIdYAMAbV7
        9nqFVnw2Mno96h73KyLXlDTQyW3TWQMP
X-Google-Smtp-Source: AJdET5dMgtDuO4FGPT27Mq4q2FuqMujQwWnFNuru+fbdHF445jT1rFwg3NgCc5j4hnnUKpCFe1xjUKDaaJqo
X-Received: by 2002:a24:1882:: with SMTP id 124mr86669itr.0.1542154429449;
 Tue, 13 Nov 2018 16:13:49 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:50 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-8-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 07/23] commit: allow parse_commit* to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like the previous commit, parse_commit and friends are used a lot
and are found in new patches, so we cannot change their signature easily.

Re-introduce these function prefixed with 'repo_' that take a repository
argument and keep the original as a shallow macro.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c                                      | 18 ++++++++------
 commit.h                                      | 17 +++++++++----
 .../coccinelle/the_repository.pending.cocci   | 24 +++++++++++++++++++
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index dc8a39d52a..7a931d7fd4 100644
--- a/commit.c
+++ b/commit.c
@@ -443,7 +443,10 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	return 0;
 }
 
-int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_commit_graph)
+int repo_parse_commit_internal(struct repository *r,
+			       struct commit *item,
+			       int quiet_on_missing,
+			       int use_commit_graph)
 {
 	enum object_type type;
 	void *buffer;
@@ -454,9 +457,9 @@ int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_com
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (use_commit_graph && parse_commit_in_graph(the_repository, item))
+	if (use_commit_graph && parse_commit_in_graph(r, item))
 		return 0;
-	buffer = read_object_file(&item->object.oid, &type, &size);
+	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
@@ -467,18 +470,19 @@ int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_com
 			     oid_to_hex(&item->object.oid));
 	}
 
-	ret = parse_commit_buffer(the_repository, item, buffer, size, 0);
+	ret = parse_commit_buffer(r, item, buffer, size, 0);
 	if (save_commit_buffer && !ret) {
-		set_commit_buffer(the_repository, item, buffer, size);
+		set_commit_buffer(r, item, buffer, size);
 		return 0;
 	}
 	free(buffer);
 	return ret;
 }
 
-int parse_commit_gently(struct commit *item, int quiet_on_missing)
+int repo_parse_commit_gently(struct repository *r,
+			     struct commit *item, int quiet_on_missing)
 {
-	return parse_commit_internal(item, quiet_on_missing, 1);
+	return repo_parse_commit_internal(r, item, quiet_on_missing, 1);
 }
 
 void parse_commit_or_die(struct commit *item)
diff --git a/commit.h b/commit.h
index 1d260d62f5..08935f9a19 100644
--- a/commit.h
+++ b/commit.h
@@ -79,12 +79,21 @@ struct commit *lookup_commit_reference_by_name(const char *name);
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
 int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size, int check_graph);
-int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_commit_graph);
-int parse_commit_gently(struct commit *item, int quiet_on_missing);
-static inline int parse_commit(struct commit *item)
+int repo_parse_commit_internal(struct repository *r, struct commit *item,
+			       int quiet_on_missing, int use_commit_graph);
+int repo_parse_commit_gently(struct repository *r,
+			     struct commit *item,
+			     int quiet_on_missing);
+static inline int repo_parse_commit(struct repository *r, struct commit *item)
 {
-	return parse_commit_gently(item, 0);
+	return repo_parse_commit_gently(r, item, 0);
 }
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define parse_commit_internal(item, quiet, use) repo_parse_commit_internal(the_repository, item, quiet, use)
+#define parse_commit_gently(item, quiet) repo_parse_commit_gently(the_repository, item, quiet)
+#define parse_commit(item) repo_parse_commit(the_repository, item)
+#endif
+
 void parse_commit_or_die(struct commit *item);
 
 struct buffer_slab;
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 46f3a1b23a..b185fe0a1d 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -40,3 +40,27 @@ expression F;
 - has_object_file_with_flags(
 + repo_has_object_file_with_flags(the_repository,
   E)
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- parse_commit_internal(
++ repo_parse_commit_internal(the_repository,
+  E, F, G)
+
+@@
+expression E;
+expression F;
+@@
+- parse_commit_gently(
++ repo_parse_commit_gently(the_repository,
+  E, F)
+
+@@
+expression E;
+@@
+- parse_commit(
++ repo_parse_commit(the_repository,
+  E)
-- 
2.19.1.1215.g8438c0b245-goog

