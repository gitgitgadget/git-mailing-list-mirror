Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7391F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeJQH26 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:28:58 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:37529 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH25 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:28:57 -0400
Received: by mail-it1-f202.google.com with SMTP id y73-v6so234060ita.2
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uez/GsuUMk6OTEc5V/EcmHFoQf8X5QynWGKks7S2L9E=;
        b=FKUPrOKvx2yu7LdFR+t4E+ojthPrZMkBA9ObXQtr1TEIeN/1yASVDcq5Lc7XZRwojw
         yipQRm769LHs9Z7wKsM7Oedjcjk8V/I5FUws+In5o0gRFMaVQ/r0nMXT0KrnhacdfDzc
         uYNWjCowV72d/zEGzRIp2t1S9qVikhS5KRTR7NSLeP6Q+zYVX44LXUjHMDnplA0ltHEj
         Q57qfkjmM3BbD3vtopNEvaOufXJBdh7kjRvIvbYEHh0DW5ufZ+dM880yW6FqJXlm5LtT
         t6A+3idHbRykK618jqutujSCJaBOpo/T23gfXGbTIgO4iYgiD1EVNrRIiRcg3yPHwynS
         UavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uez/GsuUMk6OTEc5V/EcmHFoQf8X5QynWGKks7S2L9E=;
        b=IZcewM/oSIXeqsV22hk06I1s+zvcjqQ+lz2BICoXir/fjW2oY01oNpK8K/tpxdIRu4
         JQvRA+L7GsrEliCJ45SiqKZFWyvefdDHRmwrG4oVejiYERPZ0zFFlvfc51nCWuNVEVuA
         j28wAZwSPBRGI4MnWEOZLKcmrzhfLclZceVqXrmAxb/1JTwUf2nzzC8zIT+f1xEnuEq3
         INMHGJIwVuRK8TjeQQgupacJC44FYUdl55XSklXba+U2RE0s01IuSC+8bYP47eh7SceE
         etGdVLlTwBKZfFovxeDUT5blRbRPtebMOUSNUgIjWSdfRbmiZN/ImTQ1DsWtYkFTYF4b
         sRsw==
X-Gm-Message-State: ABuFfoh8KAWqXVpKse2gQyh1UE9XO0VZmYvj9CQPyxUAS3L9m6dm0hjL
        jJxrvcHpoGzXl8tjFwGfuA+LkUgjRtmB9LG9IXdm6e1b4NZaWOSN8eL3+w7aKlTceOZMIEB50gM
        zk/xYkRXo52R1LRsZRyqLZHpERVCqME7B5QBsNEZ6WeRT5Jo2dj+KVpr2FkVD
X-Google-Smtp-Source: ACcGV60Krfje9OSRbLxxlJewlyjEAinFZrxW0tHr+/jlCBhZ0P/RGZfHAPH8G+PTGjiAX9o5SPkgt0N3Sg/E
X-Received: by 2002:a24:fe01:: with SMTP id w1-v6mr200481ith.0.1539732972258;
 Tue, 16 Oct 2018 16:36:12 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:38 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-8-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 07/19] commit: allow parse_commit* to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
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
 commit.c                                | 18 +++++++++++-------
 commit.h                                | 17 +++++++++++++----
 contrib/coccinelle/the_repository.cocci | 24 ++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index 5781f9bc67..fe942754e2 100644
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
index e2c99d9b04..58a0c5409b 100644
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
index 46f3a1b23a..b185fe0a1d 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
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
2.19.0

