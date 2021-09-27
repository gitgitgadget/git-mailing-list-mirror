Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E90AC433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444EE6058D
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhI0NAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbhI0NA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 09:00:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3538AC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:58:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w29so51671070wra.8
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YEOg4jG1XTxObl/c3+f3Fvsn3dLUVPfQUMMjsDovzMI=;
        b=IX9p0stwj95+q+z2LjJ0mRFXGQVMHL2ZRBCW/4VsH28jhE/87/uf8fyksMvJC2d4HA
         4PlweBkZKKgzAfMcUTIoC5LDtjLmYm9MBpKRju9cS5A0OFfx7baEllkqahWC1nqXxJsW
         lvxPxQJAK4Pq/nAQ0yCb4jLjtqRuMBghGM8lBC0DY5hjMDkirkAzHtm/RF3HqKoZisM/
         v33fOb8vxONQlSV8R8KpUJBw9u7mUHiErsyo+oSN/LuKXdHv98SdxB49GqhtHAeqw3ar
         XY0ViP7E+4JE5aRppV0FSz8FSkYNOuiqGAQnATVJiQdSnKdbhQJEOHxv92Mo7t20vZNk
         nKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEOg4jG1XTxObl/c3+f3Fvsn3dLUVPfQUMMjsDovzMI=;
        b=umFkXC2nSH7ICb9hfpsZ808oPkwIp62A42/2c6vC2iTAeuO2ts+Qser7A/Q48mexfu
         ylyDWYj+VBr3Y+FEcl1iG1JHdBYxNXMaEUHWWAV9RSqRbci7bVRPE6qIIwyFWKtvcs9a
         vCd/dnk7grhjMUDRG+a3A2lVARAeYAH+JoZobLln1FDBUTuNyAqhYFGGHnqMWyVRsOjc
         39FQLj3FANIsYTYuIj5bkpJR1CiH2nmzZOJ9XeSNcUeRZrt7K0WuAmJYa7fERu/x7W0+
         qhK8+nKFMkWlSe7UUFu05bvfmV9Q02hvEbNUh2hZ6LsXQ4MgQ9O1TjAdoPu4mtJslvpO
         N4Vw==
X-Gm-Message-State: AOAM531sqty89U7sZeccj9HMxcXhOMivDJ99gj4hMsu0PKMO+atSys/e
        lgAjtuj9Hv8TkbnpbEJz08YpJXQrPooaYg==
X-Google-Smtp-Source: ABdhPJwaQX9IiZ2I9AFbca7MlQ7jWfLmVwv0/dPDEvbd8XPFXj91XUHkfuYQitOOEA4SiYkvtylocA==
X-Received: by 2002:adf:f648:: with SMTP id x8mr10101805wrp.119.1632747529563;
        Mon, 27 Sep 2021 05:58:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j21sm17562179wmj.40.2021.09.27.05.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:58:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
Date:   Mon, 27 Sep 2021 14:58:42 +0200
Message-Id: <patch-v2-2.5-65c5295c1ac-20210927T125715Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
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

