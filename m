Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54C2C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 17:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbjELRPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 13:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjELRPe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 13:15:34 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EB05BBB
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:33 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6439a13ba1eso9814348b3a.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683911733; x=1686503733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vBc6CX4lCj7XAft09rq2Mf5MxK94Jd4Kb+MDwTO7ZiM=;
        b=X3zKPvstQBzlB1GP6W7p+ZT1nJhYkcDffT+rl1ArMhi4ohVW8Mmheo8HuV/qC7/gek
         ANZEn+hMZunwl483NshL/X4kV5fKNvzFkwwi+o3VgTorYcnu+crGpXvvyf9Uf71sSLTg
         8ZnFsDMqDIHpgLYGcFT5k4ZTiUO6/OCKCbhB9daTCIVMMb3w7Xt5Mx6kIjixfEOFzlGi
         l8OIBmQ6TP0fXTRRNRSZBW2CLV6rMF38eElrFHrLXYIahNHx5B48YSAKFzz+KSi2audA
         UNrIwfdElPNvKVMv7mmNW4mYXHzsIvwRkl4uKA19ImpHq45Tr77b5iyAgeD2yPNHlGj8
         wCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683911733; x=1686503733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBc6CX4lCj7XAft09rq2Mf5MxK94Jd4Kb+MDwTO7ZiM=;
        b=ZdRa1YIzQKtVJ17sywUlwhzHtmZs+h+WW9TjOWvCt1fWrK078ETChGvC+6M8NsMtEJ
         +tf2+aqDYxQ4cW8uMAP3URPT1+u+blHaicqCVjGJKAG+VtUJDOaobREgDsEufJL/uBEU
         baAFdKvC7MNf3DzCGOfwg1sOkBLOE0nBj4QdQbwWXnCutNYS9Hv7t4g1XyQg/yUDmLFe
         TtzBodx7cliXxhjbFQdHCe68xUsWLUHhdey00rRfbQTebctpI5s2XDCART20yOfm4wTr
         9+M2lGgzpJEopF82KbGHTkO9ROthlL5WEeNhkN3uJ27chrp/DNaB8eI2hBaFF9N/nJ9V
         aaBg==
X-Gm-Message-State: AC+VfDyO9thrPl1yvwkkABZgxkcoYuhapNHJXsORcfmRrqRfYq04we81
        UF8ke25gerw3Slz//Q0+gZV1Oy5EH0vK1YHhl3KF1Xp9Lel+LUrRh2rehAaUFCv26B6tDN7zVoY
        0Eq84+o5/l/E0BFKgxccQrZ7XVe/5ZsP22nkQoM438zuL3Z5rJkPwcBMiu9d6VrLtrg==
X-Google-Smtp-Source: ACHHUZ5y8JvSJ8y4TKH1J4YrpwWPa9nUdbmMigqdH6pYorzyCuW9r1XyVSNaMGBM1fMIQhZwLD92cZg7+gEGz0o=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:7c6:b0:643:599b:4db4 with SMTP
 id n6-20020a056a0007c600b00643599b4db4mr6833908pfu.1.1683911732879; Fri, 12
 May 2023 10:15:32 -0700 (PDT)
Date:   Fri, 12 May 2023 17:15:13 +0000
In-Reply-To: <20230512171429.2202982-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230512171429.2202982-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512171516.2203472-4-calvinwan@google.com>
Subject: [PATCH v6 4/7] object-name: move related functions to object-name
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        sunshine@sunshineco.com
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
index 114ad0c024..5d97e27b99 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -616,16 +616,6 @@ void strbuf_add_separated_string_list(struct strbuf *str,
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

