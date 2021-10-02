Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72385C433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DCD61B3C
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhJBUSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbhJBUSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 16:18:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFB9C061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 13:16:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j10-20020a1c230a000000b0030d523b6693so3751080wmj.2
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nBUC81GvAuCYm9pdrjHU4fDyK5dRTyKUT7qF5DoLNCA=;
        b=KlwSg7Gx/ufejqBLY36r1SUvtJdSyHESbPyL6qFSSJsOus5hlsrUm077xkkqYlU6vd
         mDK4gcKWZpcK+KX7gqPbrAS1TW0zcCE33JLDDLU0GEHYU4ISj2DF1WA3nfoanU3uQMHk
         BHvLZbWTH5ATtW3GovA/MP+GT3TkdiOZbw/y3vWue3uYKrvUcQllYTDos4IFrGkkiEZr
         vmUlJ0rbAUZCTudvfqLRqzA1ZPWEEXMgk65283EHU2nFWcx2847HOKYP6nxJQtS/hC4N
         8n2gSRB5vbFx0v7URAqSkMHf/vyskz4yNh+mZrpNk5+GOYtx/Gbm/dA61IIny7ME5pTi
         Z0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nBUC81GvAuCYm9pdrjHU4fDyK5dRTyKUT7qF5DoLNCA=;
        b=ocg9nYhNOce9hqXoOeoCyGXNtIDJL3kmB321TXH/eQhchauUyQ7hOul82RF1pUqFIB
         k37tCZzmxQeF5OuE/HfHMWL03LHsWEksPVFI7isDJQp+ttjPzswx7m+W26dtF5d+zmgW
         4GlvzJ2LKf9nEOtKGw7pxm5gaZ/JgRsN85m5cKFfUXxHBsxRWzSLOmg1OCmKI4/3qAQ3
         cAFsazm7bjma37jqkH2NtcZp3EYFAcH+6YOtWH6ut+y9q8pN3Uk9D7xjHQIb0Yw7fa6s
         K7BjSI5YCE1M1v+zIzU43xdCCuNJYq+9sP9rhvzMmZifoPLUYNL4KFZH3r2jcfjg4ALe
         ZLrA==
X-Gm-Message-State: AOAM533MuWCgtO5GzwMsKs7Lo0Ph0l+wvaOHx/5csbBcVCaKV7UJPQXm
        qGh+w2cxQnNz5xaNtnuvofi4tcMJkZ5oKA==
X-Google-Smtp-Source: ABdhPJwaRsrLeWLPepvwviA6uz6WO6XsVitm4Re9KqwH8qpgqRIiN+9m2dYfhwupJpEDp5XP3iPZYA==
X-Received: by 2002:a1c:3541:: with SMTP id c62mr10786818wma.68.1633205781582;
        Sat, 02 Oct 2021 13:16:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g2sm9946009wrb.20.2021.10.02.13.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 13:16:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/5] builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
Date:   Sat,  2 Oct 2021 22:16:14 +0200
Message-Id: <patch-v4-2.5-ced1d581f15-20211002T201434Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1380.g193143c62ce
In-Reply-To: <cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com>
References: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com>
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
2.33.0.1380.g193143c62ce

