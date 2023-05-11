Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFF2C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbjEKTtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjEKTtB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:49:01 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443212114
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:33 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1aaf6ef3580so50946465ad.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683834511; x=1686426511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3J/fNsT88vcveyOtPul3skFuP/+j7iQ4q9p0Eb5N+Pc=;
        b=DXmQVt3jsFAG92jtYBwC8O5i+60ZVb32NiDVjzd/PR2GKn9zdMdCBbjaTY01nAHk7E
         iWyffSBaHJpEwZ9YKTCvkERKglbYNGb9xKdt+kZDkruQYkAmfzs28Q3mAJTynej+xer0
         GWb2YX8ndvRA14lhs6dpxwn7Ps9Ck/WH6tj/YeJx7BZACH7xsRTRODSNwin86+z86UjD
         4cgknejTH8E4uwd0Ve9Wdzbeajp+B79Msa+qiwKnYkOFHBZmI3DnPNr9juYM3uo3TcCy
         cDjmaGH8acdtTKp7/huJxcnLCMoXZ0nKiH0cvQD4JRFHU8k+DdAUc6M1jtgKw2wv2Pk8
         /EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834511; x=1686426511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3J/fNsT88vcveyOtPul3skFuP/+j7iQ4q9p0Eb5N+Pc=;
        b=U0y/tEe3dSwwef314o4L5eUah6JX2MZLMNNj6KKYmPy9Omjt2/3gZpW0jgUSyU+j+J
         HAteOn5Q7+sYgRntzpDr0QVSn1MMGSmfyw3nOUwx2ftQTHayEhPI8nILcJYBKYUPYWXh
         0Sw5Ij3+gRxnOUZcmHTnagNLg6xzatoGbTeMAT3DbYIs0hrfFCcEzh7ZjSxEI8KpRmci
         WpqMZSmBA8E+KejjxEU/4MM2nFEmtUzS8UiVlquYLW3HmXTQOQNPPNGNj0SJ0Mtq/cao
         TtcBHxAFE124BIQ6bkBXx5DWwk9IBEegFd9OGnNUP6si1MNITunTvz9iXDWg/Bjrotre
         +ITg==
X-Gm-Message-State: AC+VfDxerfGgR1S6m6oEdb8Pfqe2/cFTcOOCmM5b/a3nYZrt89RP8lVb
        fHiNhNWH+Ikm/S0DLt6lirrqzNJLbSsdSy1Qp8epodOxxu/wk7zYN31vsFtBiZJqDmBBJ53wfPP
        yuiYz+LTtngpXJFu8G5dBIHTdc1kAK4kgMzkLawwWDV0EZqNAwbLb1jqdntDr4sj5fA==
X-Google-Smtp-Source: ACHHUZ4vdq2EUE1vPklMYjpB2GFISFVF7SeS/kVARZN2plAyQDE2EXFCN5S1yp+c5qtaAMGwryekpQLrhLkYIHU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:8682:b0:1ac:921c:87f6 with SMTP
 id g2-20020a170902868200b001ac921c87f6mr3311842plo.8.1683834511288; Thu, 11
 May 2023 12:48:31 -0700 (PDT)
Date:   Thu, 11 May 2023 19:48:19 +0000
In-Reply-To: <20230511194446.1492907-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511194822.1493798-4-calvinwan@google.com>
Subject: [PATCH v5 4/7] object-name: move related functions to object-name
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move object-name-related functions from strbuf.[ch] to object-name.[ch]
so that strbuf is focused on string manipulation routines with minimal
dependencies.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 object-name.c | 15 +++++++++++++++
 object-name.h |  9 +++++++++
 pretty.c      |  1 +
 strbuf.c      | 16 ----------------
 strbuf.h      | 10 ----------
 5 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/object-name.c b/object-name.c
index 538e8a8f62..c2e82aceea 100644
--- a/object-name.c
+++ b/object-name.c
@@ -766,6 +766,21 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 		find_abbrev_len_for_pack(p, mad);
 }
 
+void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
+				   const struct object_id *oid, int abbrev_len)
+{
+	int r;
+	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
+	r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
+	strbuf_setlen(sb, sb->len + r);
+}
+
+void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
+			      int abbrev_len)
+{
+	strbuf_repo_add_unique_abbrev(sb, the_repository, oid, abbrev_len);
+}
+
 int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 			      const struct object_id *oid, int len)
 {
diff --git a/object-name.h b/object-name.h
index 1d63698f42..9ae5223071 100644
--- a/object-name.h
+++ b/object-name.h
@@ -40,6 +40,15 @@ struct object_context {
 const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
 int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
 
+/**
+ * Add the abbreviation, as generated by repo_find_unique_abbrev(), of `sha1` to
+ * the strbuf `sb`.
+ */
+void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
+				   const struct object_id *oid, int abbrev_len);
+void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
+			      int abbrev_len);
+
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
 __attribute__((format (printf, 2, 3)))
 int get_oidf(struct object_id *oid, const char *fmt, ...);
diff --git a/pretty.c b/pretty.c
index 0bb938021b..78bac2d818 100644
--- a/pretty.c
+++ b/pretty.c
@@ -18,6 +18,7 @@
 #include "gpg-interface.h"
 #include "trailer.h"
 #include "run-command.h"
+#include "object-name.h"
 
 /*
  * The limit for formatting directives, which enable the caller to append
diff --git a/strbuf.c b/strbuf.c
index da2693b21f..6533559e95 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -3,7 +3,6 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
 #include "refs.h"
 #include "string-list.h"
 #include "utf8.h"
@@ -1023,21 +1022,6 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 	strbuf_setlen(sb, sb->len + len);
 }
 
-void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
-				   const struct object_id *oid, int abbrev_len)
-{
-	int r;
-	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
-	r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
-	strbuf_setlen(sb, sb->len + r);
-}
-
-void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
-			      int abbrev_len)
-{
-	strbuf_repo_add_unique_abbrev(sb, the_repository, oid, abbrev_len);
-}
-
 /*
  * Returns the length of a line, without trailing spaces.
  *
diff --git a/strbuf.h b/strbuf.h
index 90ad8b8892..b38bfd34af 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -617,16 +617,6 @@ void strbuf_add_separated_string_list(struct strbuf *str,
  */
 void strbuf_list_free(struct strbuf **list);
 
-/**
- * Add the abbreviation, as generated by repo_find_unique_abbrev(), of `sha1` to
- * the strbuf `sb`.
- */
-struct repository;
-void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
-				   const struct object_id *oid, int abbrev_len);
-void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
-			      int abbrev_len);
-
 /*
  * Remove the filename from the provided path string. If the path
  * contains a trailing separator, then the path is considered a directory
-- 
2.40.1.606.ga4b1b128d6-goog

