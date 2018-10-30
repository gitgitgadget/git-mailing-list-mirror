Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EE251F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeJaHEH (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:07 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:49422 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbeJaHEH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:07 -0400
Received: by mail-vs1-f73.google.com with SMTP id r192so3656287vsc.16
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YDTTlB5jX5FvYBozCH4sIUNMVT2HM9jW29X/gDs4ntc=;
        b=QO4Ffo7PQDw5MPKa1N6lL8bp0faKN7UUfO8CziKBmF8fecmKY4MQEbiDXNjEZcoTET
         ke9lejTiXQFAtwBZe2L0/lWUai3+zY7gOMk3GwG6qDyfkmKlniaXLnoeRIocdFI5zmyb
         AvLb+gdDxZ8lK6GW861Z9ELTxoxoZ1vYRMO1thCuay0keU4+vp1DRD+4GqWNtcq2ii49
         8YrQaO9wqh9BfpwdxrL+bdWD8pzGgqu4U6Ux4dxk7NHuZ9+gUALBY6tfsNQcXzjlsvMy
         HDXqFoBj+70lEpLk41oMS/GhxFLnsxFyfqrOhJd4cmEhPtgX531COGzecoe1pHJ1Mkhd
         ZBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YDTTlB5jX5FvYBozCH4sIUNMVT2HM9jW29X/gDs4ntc=;
        b=JX/fWNoZ1H9GyVr21qSjAvRgSx3GSqyGIg7ym5gSV60gVf9qbfo4t0ohXD2ofzrD3Q
         0gxO7RLh1Y2DD2+Xdmv+iODBrbR+f2giPRUhXTdJvOiB8r7HWP/oVhAHd6uoRTKKwRO1
         lKV4iF8GFPCqJTneBfMqseExY1Iec5+pd2Bl5aqxa+vhHyGBt1RpGDih4LHANBaPMde3
         q5/sNbPHYWVoyDGfb6SlSZKxfjDNHXgCVqLFlCjGO27mVnZcv+rj6ONE/VehoWK7M5FL
         kEGpdMj13E1kr0uEZkadhDKkU6QxhYV+rcj57WpqejdzCguRqjV4yc8BQ8txGRpWQxVd
         2dCw==
X-Gm-Message-State: AGRZ1gJ2GcW0YcyHX4KUbwwz1EHNGDkBSWQYKdHUKxVPKujwJd00QBta
        j6SmQEeCz9NlHgX/Gy6H/MWweYzsJ+9sUdG9U4VA4RPsEQY+/mlA5eFQ0/s5nupw2/OXKH/NFkm
        7N6Vk0r0KJOoTOHA98+4mYEerFRbHLY0+9my9CdchwP+oOdmgKG7TVREHnto3
X-Google-Smtp-Source: AJdET5cUAXRsQES/eSZyXm1Y5B9MO/33/ha6VMGs50dSr3GLBAQgEHt/oEVulTsgCOShD/ltE2r5zxRA2Y8h
X-Received: by 2002:a67:3b06:: with SMTP id i6mr511820vsa.42.1540937331732;
 Tue, 30 Oct 2018 15:08:51 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:01 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-9-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 08/24] commit: allow parse_commit* to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>,
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
2.19.1.930.g4563a0d9d0-goog

