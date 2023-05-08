Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4D3C7EE24
	for <git@archiver.kernel.org>; Mon,  8 May 2023 16:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjEHQ75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjEHQ7r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:59:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B30E524D
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:59:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-552f2f940edso87884437b3.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683565185; x=1686157185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zkqwa7L1/kR0+Cc4PcW8itO6Z+BruXGvlxCg7pCNvQI=;
        b=fIZ8WlrjsN7QNAVzzFjq7r83q39Z4fNXo2XBYB4ohtZPwDu/x/reV8OUbGAE659pwJ
         28Hh8RY0pifRkOpvDtDJ1mtIM3bM3MfESsLU2LlmsBg3GskSqy+uSvuGcF7v3nprL32D
         qboVZR4ymjYI60TJMJWcXxEe3yQD6v0E1szglzZRP9xBQFR0byGY5gxBkLLgt9gmaOrD
         H872bM3MoVu1sNEmGPBdBVOsyyycWR8cSwKTX9wQVCzbq+v1oiRn898XLo5s3yomr/Tk
         GYCAGmC/UWhV4QFBOO3cY+kQrleyMvxZEtkwmLAwO6nZxPpBp9QYVTTV7yr0i78jdXg7
         zixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565185; x=1686157185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkqwa7L1/kR0+Cc4PcW8itO6Z+BruXGvlxCg7pCNvQI=;
        b=NPBUneiVFZCo81FI5YCWZj339xouCZ7LIxNZ6yLmxtWKONzTG4REH6V/ISoLV0KZUn
         S/rzAVHqp/KeD071Hl32cnF1RSVZJES3wx6JjgFF68cW718RsFICrrNQZefgW0tDSDJO
         iRKozdNKpMZlKGrrn8Sn7GTWgJZc1TDVYrMSb0T2icbkD0gE8M3c//siMk9OLGHPfmE5
         hR16iTZ4FsmIYcN6Ljp0qEEnFQ+6GGUBLX1Yo504eMPSjUKAScX9+I/adoA4jSPSFIN+
         mNDkuly9aJnI9in+CyIyteZ9+6mMZmn8RTSMAl1CNkAlOHmaEN33VZghCDmNaIHydW4g
         f2rA==
X-Gm-Message-State: AC+VfDzzym+QcHvrtSMAAavEWZ7oJMwaloy2b0H8Shn59xrGJ5wB0TEn
        8A9x7/IKuuHSpTG72a0Rc9nggyqm/AzMZCGn3V4jawTVQqDncHLDWcgWTce0DElD3lQTs8KJ3mc
        uojzI8sQFsGM8/Xw1g1dmBVa+Tg/lFBHGHuiMuzz2oZ9EtUdGA9LJx2bIc+jDK/WB8w==
X-Google-Smtp-Source: ACHHUZ5VaZ0wYpxOJG8u6GqbzenojDjXCG3kcyg85fTEYwl8NDnhgahDmMQ/kRM6QwblJSVSFyJX9gfUADv4U7w=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:ca49:0:b0:55d:9484:f153 with SMTP id
 y9-20020a81ca49000000b0055d9484f153mr6604807ywk.7.1683565185369; Mon, 08 May
 2023 09:59:45 -0700 (PDT)
Date:   Mon,  8 May 2023 16:59:05 +0000
In-Reply-To: <20230508165728.525603-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230508165728.525603-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230508165908.526247-4-calvinwan@google.com>
Subject: [PATCH v4 4/7] object-name: move related functions to object-name
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
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
index 9e52fe7706..1bae7e0f47 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -612,16 +612,6 @@ void strbuf_add_separated_string_list(struct strbuf *str,
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
2.40.1.521.gf1e218fcd8-goog

