Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24A1C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjECSvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjECSuz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:50:55 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92107EEB
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:50:42 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24deb9c5f8dso2356690a91.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683139842; x=1685731842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oOGiD8U1KFR4q9LXq3E9WQQJhTRM2nr/T7plEyJs5k=;
        b=dawnDHgA4NpA5R1DO1jEkIP4uut/GzAhTvOWNEQhAOVcFSq0U8PmyUGxnJlrfhRgVP
         PQ5Zobq3Hc6CVqYBagsvuACIIdSTraD9RRLd2jew2bl/NzYscD9SnvieBc1O1bryR1++
         vaqpujFHO/UkhbeI3pwS31mH7kLLcGas2CX9FN2OLVK9Wnxf8MLgd5tQn3/IoTkPSF0n
         wnW/LWVtpn0MGmK4QqBkMc/AqiNcw/HYgEvw0Fwj7oa8KhqJg9biG+SrZRhi+JtC38pl
         aLHcQy7YPalAOnOGrwXYY5YJG7NN3FfjO64efHS+iJadUe9uMO3APISD9N8r90owqmwJ
         w+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139842; x=1685731842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oOGiD8U1KFR4q9LXq3E9WQQJhTRM2nr/T7plEyJs5k=;
        b=diQyuu682Lepwt/zq7nbKjHvrpMzSIv6UvKjPIYWRoNY0jjn9xCzEFxYfiK+Z4Yag4
         VVVhWz8A4XnyCxi1sHDGXNuXHzhDCre+djylu4CZEozVE8YDrpHEB7PPMCwYpMvuvhMK
         QylTg2i5mKOHcwLGoEtN2rgDpVwVPKuSKbXPGxQPCMkkdoeuegBRWmihDQADX3lKZqK+
         y0hZHaFGnBygaW/29bFxcwt7IeJZQn40yv8a5y9oua8LTaSqMhsA1zQ8kpTo9CSMzV+B
         BOJFB3pp+cLYtfRGicirWV1jnEcTfGumcNlxBL54RAavJBPKKNHaVcDRTOdjP9CJ2WEQ
         fmtw==
X-Gm-Message-State: AC+VfDyBNHFbFzVVBTwEeqo5Qhid6sL5rCfbG6RA/hY+m1QZ/6uvtt2L
        FFkw8Amb5pdkSl3i6rlaxxvBVc225hyxkjlQ/Njvh3P7WQmuAuiRNY6FwiTHDq6W98wBbbDCuQM
        s6/+asIAUnPBUSOYhCZWF/YyWPl0nbURNCUWRHitYCSHlH1naoyOUweVyvnN59KIUTg==
X-Google-Smtp-Source: ACHHUZ5+wiavG5hctp5m46Fcb4xV90GVoNICXdfHLPADKjDRWpFYJxNB7xvE22j9GdUCZ8MGzMVf/7TkeOXdOyc=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:1c0f:b0:24d:e392:75ce with SMTP
 id s15-20020a17090a1c0f00b0024de39275cemr3678929pjs.2.1683139842048; Wed, 03
 May 2023 11:50:42 -0700 (PDT)
Date:   Wed,  3 May 2023 18:50:28 +0000
In-Reply-To: <20230503184849.1809304-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230503184849.1809304-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230503185031.1810078-4-calvinwan@google.com>
Subject: [PATCH v2 4/7] object-name: move related functions to object-name
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move object-name-related functions from strbuf.[ch] to object-name.[ch]
since paths are not a primitive object that strbuf should directly
interact with.

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

