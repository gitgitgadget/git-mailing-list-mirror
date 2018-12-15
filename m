Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A7920A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbeLOAKD (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:03 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39627 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbeLOAKD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:03 -0500
Received: by mail-qk1-f201.google.com with SMTP id d196so6698222qkb.6
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YeZ+zUv2zWfAv5Kp5HUo0hvcLk8SERNJaXR2VzZhsLQ=;
        b=TgjF4Er+AI9r8dXIKMVaTJx/LDQX0Y6XQDXPm50/xwhcScGbz4H+AWcR2H3eXQbNTN
         aXevPuQUU2sfNoGx/OSrubJpvVizPTxYjDlyddW4OuCcY1Ycx73NWxqaGabXf5Fq+xVW
         TTLDBLLGZ5i6fU14M/haHHfw070kByqcisNUd8VmBsKXmRxmFU+rAIzrIArlrClIewKi
         qJylVAzyV4VB0NvSg0hV4K3LCz7FP+IF4pX2Yfen9Cqp1bDoD/m6ecS2c9+Sxou4G51O
         JaKjIq5KqrDuBv7uNnTrleQarfRvxzpkcqjiM7MRfkbOXg0Bd06lkNLEfYAu2AyV3xS5
         lhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YeZ+zUv2zWfAv5Kp5HUo0hvcLk8SERNJaXR2VzZhsLQ=;
        b=DGAwU8mL6HmW4tJvQ3ZrgKaBNtRKQMZibr1g8yPv+odkI3dsBJqQSjhkyZyyR0RMi+
         v/mExQ3sfA9Y9HA2UHuaCOELuCeWZ+OzwSrA4YwI4bWKiyZZPkhImqgqw8CjSWPOqPZ6
         s75XBwtHluUWA2Ii6gN9KGD8KkgllwfQr+P5eULN9WUGJoDObTNmkTYSY8HCcBjOYmU0
         qPmZivMuUUKrCSx9M2QIgLj8HnGizmIECIu2xM/+0SxwyrCWk1Au/hvnai+zsWlLrd22
         tBXm2jgU6HpuVu0WJlQTUrmX9cotHVnuS/GMXkBg7B+2xDG9BcpelP/cadk3kbwNeg7t
         ByVA==
X-Gm-Message-State: AA+aEWYIE2AVGu7Wbqg0TMSfu17DTl1IM4I5daDYUYCiAhxUv4jhqWWi
        hHEy7eaq7JT8xfz9LXiYQAtT4IVXrlNdLG5U/lRmd9sWiHaylE7AFQKHap7glpcjepzrglmdCyr
        x3+ghfSujwQnOOfTNDAcPWczMk/t75UIw+D+SvflYLnbOqQv5TYyVKw1KbY3B
X-Google-Smtp-Source: AFSGD/UmgCoXABUW8tQt4PrxTjP+3jUH+twuAL9cQV2vUzBSMHRZJIIpPytsqmC9ztKABX9Kf1lhFxcC+zc4
X-Received: by 2002:ac8:43da:: with SMTP id w26mr4780593qtn.25.1544832602167;
 Fri, 14 Dec 2018 16:10:02 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:26 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-8-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 07/23] commit: allow parse_commit* to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.20.0.405.gbc1bbc6f85-goog

