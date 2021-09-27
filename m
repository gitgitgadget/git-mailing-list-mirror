Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F01C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24756113A
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhI0AzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhI0AzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:55:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790F8C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t8so47370923wri.1
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YEOg4jG1XTxObl/c3+f3Fvsn3dLUVPfQUMMjsDovzMI=;
        b=AdRhH0uQNtN0+cvm8T9tfB5WlG6DoCNQcG9xpjQFugJELk/N/rRNjNJW+Zb6k7/dh3
         UVHDFUzEGDKgiKjqpduO4Za5DSHQzRKQ1CTHh3Qs7+3bq0NpdNoHI3keFTY3zw4yeOIy
         SJ5nHimILnf8yRTpmG69iSNQrABrilafQaRlJuJtVVWlcQh+hvnmPncDw+iHu973Qlay
         BZ4Sijs8mABRbL+7IJGq/KjzxlO2rGmUlCWzThrKgD1Z7c78dfFKW9d5s9nMC16cMlma
         a86kYYH940444keJOh6Auj0XoKB/JAydOar1KC3RORyuceJdWHJd94BheXWbYEqBxG+s
         zCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEOg4jG1XTxObl/c3+f3Fvsn3dLUVPfQUMMjsDovzMI=;
        b=8Eum6jtPkEP5Gla38GAb1tZfb6uMAg/IMZFc2P3jz+hfnSN+6rWV66R+bAxxfTc+X0
         4otRNv7sJ01Z0HfrAV5tTqRWViQsBd98T6ZifqUjUva10Fto1PL/e3LRApaptawaB8QV
         0eLz3v7VVYRUAWb05qtVL5gZnOs7FEnNLleWmJ+uTfcmAZVgJKdDZ4aeriaU6s3ht96B
         /5sxipEFsEaQrhbckPENyxOLAL54r5yWwyBtsxACZEt4BRAr0DRV7iUB4hDVXpPO7nfS
         yBBUgrMvfIAxZKW3TNYr+aXmLl+ktsIPQBlhCoOEh3dwpASiduIWsUoYeH6rdCK1Gs3i
         /iOw==
X-Gm-Message-State: AOAM533V0qpi+4cfhW5TuhAiD/PYWDnK6xWZbUWP357mcfSnDSyw817T
        TCbTbV5VKePe77T8kxjL4Cgwje70RZrqqA==
X-Google-Smtp-Source: ABdhPJw+j323vn6bP8b/QOqQYV4TQGeqcGZumY2IGdN7Q6iq/oaA7ZKjOVVTfQMgL6fqLpCmM623jg==
X-Received: by 2002:adf:f8cc:: with SMTP id f12mr23873535wrq.195.1632704003904;
        Sun, 26 Sep 2021 17:53:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm14749745wrq.78.2021.09.26.17.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:53:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
Date:   Mon, 27 Sep 2021 02:53:16 +0200
Message-Id: <patch-2.6-65c5295c1ac-20210927T004920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the commit_info_init() function addded in ea02ffa3857 (mailmap:
simplify map_user() interface, 2013-01-05) and instead initialize the
"struct commit_info" with a macro.

This is the more idiomatic pattern in the codebase, and doesn't leave
us wondering when we see the *_init() function if this struct needs
more complex initialization than a macro can provide.

The get_commit_info() function is only called by the three callers
being changed here immediately after initializing the struct with the
macros, so by moving the initialization to the callers we don't need
to do it in get_commit_info() anymore.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9af..1c31a996403 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -101,6 +101,16 @@ struct commit_info {
 	struct strbuf summary;
 };
 
+#define COMMIT_INFO_INIT { \
+	.author = STRBUF_INIT, \
+	.author_mail = STRBUF_INIT, \
+	.author_tz = STRBUF_INIT, \
+	.committer = STRBUF_INIT, \
+	.committer_mail = STRBUF_INIT, \
+	.committer_tz = STRBUF_INIT, \
+	.summary = STRBUF_INIT, \
+}
+
 /*
  * Parse author/committer line in the commit object buffer
  */
@@ -160,18 +170,6 @@ static void get_ac_line(const char *inbuf, const char *what,
 	strbuf_add(name, namebuf, namelen);
 }
 
-static void commit_info_init(struct commit_info *ci)
-{
-
-	strbuf_init(&ci->author, 0);
-	strbuf_init(&ci->author_mail, 0);
-	strbuf_init(&ci->author_tz, 0);
-	strbuf_init(&ci->committer, 0);
-	strbuf_init(&ci->committer_mail, 0);
-	strbuf_init(&ci->committer_tz, 0);
-	strbuf_init(&ci->summary, 0);
-}
-
 static void commit_info_destroy(struct commit_info *ci)
 {
 
@@ -192,8 +190,6 @@ static void get_commit_info(struct commit *commit,
 	const char *subject, *encoding;
 	const char *message;
 
-	commit_info_init(ret);
-
 	encoding = get_log_output_encoding();
 	message = logmsg_reencode(commit, NULL, encoding);
 	get_ac_line(message, "\nauthor ",
@@ -246,7 +242,7 @@ static void write_filename_info(struct blame_origin *suspect)
  */
 static int emit_one_suspect_detail(struct blame_origin *suspect, int repeat)
 {
-	struct commit_info ci;
+	struct commit_info ci = COMMIT_INFO_INIT;
 
 	if (!repeat && (suspect->commit->object.flags & METAINFO_SHOWN))
 		return 0;
@@ -440,7 +436,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	int cnt;
 	const char *cp;
 	struct blame_origin *suspect = ent->suspect;
-	struct commit_info ci;
+	struct commit_info ci = COMMIT_INFO_INIT;
 	char hex[GIT_MAX_HEXSZ + 1];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
 	const char *default_color = NULL, *color = NULL, *reset = NULL;
@@ -630,7 +626,7 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 		if (longest_file < num)
 			longest_file = num;
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
-			struct commit_info ci;
+			struct commit_info ci = COMMIT_INFO_INIT;
 			suspect->commit->object.flags |= METAINFO_SHOWN;
 			get_commit_info(suspect->commit, &ci, 1);
 			if (*option & OUTPUT_SHOW_EMAIL)
-- 
2.33.0.1316.gb2e9b3ba3ae

