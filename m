Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2413FC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE87561A7B
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353574AbhJAK3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353572AbhJAK3a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:29:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA25C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:27:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so10837210wmq.1
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ty3rV+mfSy+t26gPkfA+ksR916LTb9lpS4q69E+jbIQ=;
        b=AHsIKrLW+G80QzLJklbQ91BmNvvWXyxf1kEsgYMas74HHfFirgH8KyBSmPlEoZlamk
         9wA0iWKDFCm8gsHCI1nhEFv22d8QAkUf01mLlQ31Pfc1EjzuZVcmNcffUf6lNKnLL+Kn
         peSxYXiE1+NmL1tka81VMqbkFdkpZPkeCmttXd5QmHBiYUzLyL7SZ0/pHtDsyJn+o+Vs
         a7LKpUdUtkKkKpHBGfZ9MuuyKSJEDeD+HcBQZU516qjbU1RMNkpJtpcxfZiNjO8hVqg+
         Jn6awchcTGvO/UFV1QnVhpJO7BUP5n8PoWYVnXmFK37jIz9zF7NRXhoAHp4UO92SxJW6
         Atyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ty3rV+mfSy+t26gPkfA+ksR916LTb9lpS4q69E+jbIQ=;
        b=dFJNFYAkmYUlC/TWtp9Jieoguehv7gevZvxEE5YXSnQWvx9eOsieFUEQiBGJcqvTds
         yxut/9kklB6Jp81tn02sMMSBOZMiPelebIarEE5u88uy4bqxkRARSscsCkj6P5Uvl4LE
         zKyEl3HE1gMhD0hzsrTj+x7WpieXaOf6ihNbWCzR2F1kcUfSHABgq31llzZfJoV8nQbE
         KgcWq/r9K3MnssUdHRObM9sw1Z8lYe392B10C21uQ4hw7QZ0s07ODzIVVUicGkC8R4wQ
         mz0HxaBpKMttM92YoKNSCXU5uJOoA57pOPGJndBJarFYo/ZgteiQJqII0uqQ8bDURfsu
         Qjgw==
X-Gm-Message-State: AOAM530+kWuqzMPWgQ8sEAgwgOzyiBT9TFyT4Fbk+wyjajoCvPH/DPoX
        fuR8q5Col1lAS6fBg6oQ893yTy3Fg7MtIg==
X-Google-Smtp-Source: ABdhPJxeXZ1gqI8hCgcyYVNCxpjcuLDA/JEVvq3FHYzi5Bh1e+58OIBPu9CYt9Z1NQxH1n5hTIorZQ==
X-Received: by 2002:a1c:8056:: with SMTP id b83mr3632039wmd.87.1633084064830;
        Fri, 01 Oct 2021 03:27:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h7sm5398952wrx.14.2021.10.01.03.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:27:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/6] builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
Date:   Fri,  1 Oct 2021 12:27:32 +0200
Message-Id: <patch-v3-2.6-ced1d581f15-20211001T102056Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.gbbd823cc90f
In-Reply-To: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
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
2.33.0.1375.gbbd823cc90f

