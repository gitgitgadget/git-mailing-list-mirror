Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B4CC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A295160F48
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhISCfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 22:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhISCfD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 22:35:03 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46553C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 19:33:39 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso18599376otu.0
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 19:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PuTH+BFHFIWQS7z0X3ewp7zn4uCVLj0P4qCEwmRoNTY=;
        b=nSJCdTUQW3dKv5Ks0CdjdMXPHx4kVj6XsRjuk4YNPWJEiVVQ6IfPmHadvXfD9IEy/y
         Aabou24qkdM2/5mgtU7ERbcpBvPKkxi/jhj3jAhaaGaIYNCpeKm5/afxPRvAbS1lsLQ3
         Ns+TpPiBUcJlm/XJh3PHUsIG0f8I9cTgKueQCzxnLkm301nZtuvesogIu5wGz7mql0eh
         M9k3fr8zrCA1WMGwr321yqaCjIGjNPmWTitnQ2RVgshZK8H7j5nwaK+jxqM3xNoB0i4d
         M/MKN1PhejvOD5fQazi+5Iwmv5T0AwrRi9QhMoZ4mm5xaKoLPBUrczOvFZd3ll88yfWQ
         qnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PuTH+BFHFIWQS7z0X3ewp7zn4uCVLj0P4qCEwmRoNTY=;
        b=f1RN6jE76xKQHWspl6WUlTW9LKAPprAVPC2tNSCbYRI9RFu9vtroEyE0/FO6rkJU4Q
         ttRCckBIqr93Nu25UruPADNHchCNjBP/fvqr/yNSkX+cuMNGk/J6UywXxudt7GG7rnKg
         kF66R4U1HHvWY4Ygn1I/a/do8wfAaGv9bI6O5s4PDk0dW5fB5jeyygPZ5G9TeP43RW1M
         7vjDtudCTRaZr4S/DclkVeNTOx+4NKlduJwjaxorXoZiv9+tzj/RtdPLKjd1veZYVmbq
         n5lsBuEoQfZOYCtEKUJzysnZL/SplQdnoXX1LpNb2LYc1CuuiXbjmblqkRFak/5Os3Wb
         U0hg==
X-Gm-Message-State: AOAM532S4FllhHqEjA+a+tOJy/qSesugPf/9lXfvizOgi8J04HnNprLU
        e50VWn5My43aAvSz6d+Aigc=
X-Google-Smtp-Source: ABdhPJwOzslsiMttKMp9ee4yIsbDMxLt/2wJmw4JQnq6FPS8gGQq1fevg6xpsmllgVsAXWzS94Nmaw==
X-Received: by 2002:a9d:60c2:: with SMTP id b2mr12979059otk.27.1632018818523;
        Sat, 18 Sep 2021 19:33:38 -0700 (PDT)
Received: from sarawiggum.attlocal.net ([2600:1700:5d80:a320:4412:822d:c222:aea8])
        by smtp.gmail.com with ESMTPSA id x198sm2564394ooa.43.2021.09.18.19.33.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Sep 2021 19:33:38 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 3/4] difftool: use a strbuf to create the tmpdir path
Date:   Sat, 18 Sep 2021 19:33:29 -0700
Message-Id: <20210919023329.23356-1-davvid@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <YUaduDIYoW8Fo+5s@coredump.intra.peff.net>
References: <YUaduDIYoW8Fo+5s@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a strbuf to create the buffer used for the dir-diff tmpdir.
Strip trailing slashes "/" from the value read from TMPDIR to avoid
double-slashes in the calculated paths.

Add a unit test to ensure that double-slashes are not present.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v1:
- Updated to use strbuf_trim_trailing_dir_sep().

Thanks Peff!

 builtin/difftool.c  | 28 +++++++++++++++-------------
 t/t7800-difftool.sh |  7 +++++++
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4d2e772031..0554ae5fb5 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -252,11 +252,10 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	strbuf_release(&buf);
 }
 
-static NORETURN void exit_cleanup(const char *tmpdir, int exit_code)
+static NORETURN void exit_cleanup(struct strbuf *buf, int exit_code)
 {
-	struct strbuf buf = STRBUF_INIT;
-	strbuf_addstr(&buf, tmpdir);
-	remove_dir_recursively(&buf, 0);
+	remove_dir_recursively(buf, 0);
+	strbuf_release(buf);
 	if (exit_code)
 		warning(_("failed: %d"), exit_code);
 	exit(exit_code);
@@ -333,11 +332,11 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			struct child_process *child)
 {
-	char tmpdir[PATH_MAX];
 	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
 	struct strbuf rpath = STRBUF_INIT, buf = STRBUF_INIT;
 	struct strbuf ldir = STRBUF_INIT, rdir = STRBUF_INIT;
 	struct strbuf wtdir = STRBUF_INIT;
+	struct strbuf tmpdir = STRBUF_INIT;
 	char *lbase_dir, *rbase_dir;
 	size_t ldir_len, rdir_len, wtdir_len;
 	const char *workdir, *tmp;
@@ -360,11 +359,13 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 
 	/* Setup temp directories */
 	tmp = getenv("TMPDIR");
-	xsnprintf(tmpdir, sizeof(tmpdir), "%s/git-difftool.XXXXXX", tmp ? tmp : "/tmp");
-	if (!mkdtemp(tmpdir))
-		return error("could not create '%s'", tmpdir);
-	strbuf_addf(&ldir, "%s/left/", tmpdir);
-	strbuf_addf(&rdir, "%s/right/", tmpdir);
+	strbuf_add_absolute_path(&tmpdir, tmp ? tmp : "/tmp");
+	strbuf_trim_trailing_dir_sep(&tmpdir);
+	strbuf_addstr(&tmpdir, "/git-difftool.XXXXXX");
+	if (!mkdtemp(tmpdir.buf))
+		return error("could not create '%s'", tmpdir.buf);
+	strbuf_addf(&ldir, "%s/left/", tmpdir.buf);
+	strbuf_addf(&rdir, "%s/right/", tmpdir.buf);
 	strbuf_addstr(&wtdir, workdir);
 	if (!wtdir.len || !is_dir_sep(wtdir.buf[wtdir.len - 1]))
 		strbuf_addch(&wtdir, '/');
@@ -612,7 +613,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		if (!indices_loaded) {
 			struct lock_file lock = LOCK_INIT;
 			strbuf_reset(&buf);
-			strbuf_addf(&buf, "%s/wtindex", tmpdir);
+			strbuf_addf(&buf, "%s/wtindex", tmpdir.buf);
 			if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
 			    write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
 				ret = error("could not write %s", buf.buf);
@@ -642,11 +643,11 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	}
 
 	if (err) {
-		warning(_("temporary files exist in '%s'."), tmpdir);
+		warning(_("temporary files exist in '%s'."), tmpdir.buf);
 		warning(_("you may want to cleanup or recover these."));
 		exit(1);
 	} else
-		exit_cleanup(tmpdir, rc);
+		exit_cleanup(&tmpdir, rc);
 
 finish:
 	if (fp)
@@ -658,6 +659,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	strbuf_release(&rdir);
 	strbuf_release(&wtdir);
 	strbuf_release(&buf);
+	strbuf_release(&tmpdir);
 
 	return ret;
 }
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index a923f193da..3863afcaac 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -454,6 +454,13 @@ run_dir_diff_test 'difftool --dir-diff' '
 	grep "^file$" output
 '
 
+run_dir_diff_test 'difftool --dir-diff avoids double-slashes in TMPDIR' '
+	TMPDIR="${TMPDIR:-/tmp}////" \
+		git difftool --dir-diff $symlinks --extcmd echo branch >output &&
+	grep -v // output >actual &&
+	test_line_count = 1 actual
+'
+
 run_dir_diff_test 'difftool --dir-diff ignores --prompt' '
 	git difftool --dir-diff $symlinks --prompt --extcmd ls branch >output &&
 	grep "^sub$" output &&
-- 
2.33.0.721.ga252b5a140

