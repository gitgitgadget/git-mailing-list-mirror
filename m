Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9255F1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJLErR (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:17 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:33161 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:17 -0400
Received: by mail-yw1-f73.google.com with SMTP id f66-v6so5948276ywa.0
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iJcZMy+50JNMtgZH1blblTTpqWu/hOpcr38q8O7pAPI=;
        b=hkQGyxMUQ+S+Ykynw22AElByOxUT3/AoupVaoB1c90Ey42awCUmzGOhD3GKtZnXoan
         sPbwY1RuDykXVsNYRiPc6IkSjbscPm7dbXUGvDTT5W2zfw5Ufho4f1n+jLay+8VfMBYH
         M+zrOmtKTd6Jt8gjHTNiUkmKNkmIyIHhJZc5g8sihWJ4Aw9diID2dnYfkfnFOjAMfl7u
         E8ElKWS1LghpGETSAyT1afvFDz2k+HXXSvxb5LUafibsz+oSYvdv2aPcm7KJHJ7tSW9z
         Efhau1cOAvIufa0kfdX4TGhMtpvRh3UWjizpMWvGLJTyTaMWnfyiRqMNNSpsmKRjzhGC
         ZGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iJcZMy+50JNMtgZH1blblTTpqWu/hOpcr38q8O7pAPI=;
        b=QzTa2/ovoMKuiqqbH/KuSxn7bsthmm52FsgJg3hHSaIFs0kp7h0lnOk8YnsfX1RXPz
         wW9ndiLheQF+fXgJXxSgalYorIJ1TbYh46KLk4ByZenPmacpKr7MzCeVKcCc8Dz59Bu9
         HVujcL2jRaokv6h8RZvxfQvolGxc+vzXpJ0rV2q4rNROLz2gAbfHgQkMQtYT63K3mmOO
         YzOWMLqQUwy+jMGneaaXW0wxT6K4/NECyb5TZTSSuB4XfM2mo8RQouoa3BYJueUjm2Jd
         zROjSsbM0db/B5WYqSrfTCBi29L8CIDu3i7zFPrSiMYAl81TRoe/IyEB3AltgCQLgyps
         mrlg==
X-Gm-Message-State: ABuFfog1sjBcFXPmUNnlRUlTT1WCm3jLa6J4kTlkcvfT8Ewx1gEQZWxN
        TilH+kqaJvELVvMCX81SEsnxg617hSX0LPQ5u6adImphoI1dU8pd3qLImTsqPjs3i8fhpt4tFps
        KK1sep34/82qSyLWOytfwd9UvXtNpfMvmeg1nRMz91/2HphOFFMBmV/c6A5Ih
X-Google-Smtp-Source: ACcGV62ubtSfmLnHuXtjN9PRufQTPluI9uyyDFnDoorzvJLURVVsmCGAbUwSbm7A/nCoX1lzCfLWug8wpZlN
X-Received: by 2002:a25:dbd1:: with SMTP id g200-v6mr1789104ybf.90.1539292692310;
 Thu, 11 Oct 2018 14:18:12 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:41 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-7-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 06/19] commit: allow parse_commit* to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
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
 commit.c                                | 18 +++++++++++-------
 commit.h                                | 17 +++++++++++++----
 contrib/coccinelle/the_repository.cocci | 24 ++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index 449c1f4920..c6aeedc3d8 100644
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
index da0db36eba..b8d1f6728f 100644
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
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 3c7fa70502..7189a7293a 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -11,3 +11,27 @@ expression G;
 + repo_read_object_file(the_repository,
   E, F, G)
 
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
+
-- 
2.19.0

