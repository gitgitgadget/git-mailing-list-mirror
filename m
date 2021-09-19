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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8EDC433FE
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25EED61100
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbhISB7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 21:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbhISB7A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 21:59:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524E1C06175F
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:57:35 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d207so5194705qkg.0
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shHH2in1AyjGg1OR3nV0C30/s6g7n+X1cF/rXjKEm1Y=;
        b=UCwWy+v+vZi8ATZj1UWdoYHJewO8FkOi32dtTR/rqhPkuYuKO3Cb9XlDHY8fjf1Ipb
         jbYycyc30ceullo8AU8FJ+rqpBX9duaFqVBxfrvOiBKfA1JSBxSaOqIwIbRPrnFlp2bL
         WyBCgejKcNE6q+o9LaFOE8ubBBZOHA/O/Ine6IYkLdlbKbNx/bSHSGiEEkg/1ShDs1EY
         HLRdn9Cgt8DPejIzDSKwFyP44Oe7ygEY2pRWEh+DWRg8k3vqPphRbGip/JOCn2YX5hLg
         8wYc0Fu2lVOoCVRZd+K6aa2rZkJwAuZT96V8aJlo4H9KiOfRPin6wEh6xSoJewgOMkkD
         Y8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shHH2in1AyjGg1OR3nV0C30/s6g7n+X1cF/rXjKEm1Y=;
        b=n2n3rKP00LybOdeDBkmwuJOfBLikoLL/vqs4qfXjZLdh04gqUH9PV18UfKwVc1Rq9k
         CF8Y/M/mRUyTe5jg8Y1eg+uXDvf9wBkIpYTejkZKtH944zeQGGAWxXXBNk2SWa0jZ+xm
         Ga97f7QYlMYdRVApve+Dc5E5q5OaNc5OP3VUuYUElbUbHDxudWuSYD+8p2hkYbavOJow
         nAFbRchds9aEcItsK2eWqa2oPtT1IL+KG3kwY4zrwAAjBaEuLfa7Kqksh2cMCXty4L0i
         eUVOIcGGJYKKQ/p2Pn3rtbn7z4hNo+ohTOn+osBaDsQyJnd0MZQhGGcM0463H7M/4VxK
         ivRA==
X-Gm-Message-State: AOAM531Bz0pc1lxY3GHonLlo7iiPQ3QAFYPM9tyy7eutMlq3rNPUCLgq
        idkp+o4uobS3zUXQ43L45VY=
X-Google-Smtp-Source: ABdhPJwaxXkNp3X4gaJ7GEidPNF6U6gbo1FekFhhfH+JTG98xs6xcFiPh+v17WRKAL9p1mr9pEwUUA==
X-Received: by 2002:a37:9e11:: with SMTP id h17mr17564255qke.370.1632016654840;
        Sat, 18 Sep 2021 18:57:34 -0700 (PDT)
Received: from sarawiggum.attlocal.net ([2600:1700:5d80:a320:4412:822d:c222:aea8])
        by smtp.gmail.com with ESMTPSA id k10sm6759062qth.44.2021.09.18.18.57.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Sep 2021 18:57:34 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 3/4] difftool: use a strbuf to create the tmpdir path
Date:   Sat, 18 Sep 2021 18:57:28 -0700
Message-Id: <20210919015729.98323-3-davvid@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210919015729.98323-1-davvid@gmail.com>
References: <20210919015729.98323-1-davvid@gmail.com>
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
 builtin/difftool.c  | 32 +++++++++++++++++++-------------
 t/t7800-difftool.sh |  7 +++++++
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4d2e772031..2014a2bb9e 100644
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
@@ -360,11 +359,17 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 
 	/* Setup temp directories */
 	tmp = getenv("TMPDIR");
-	xsnprintf(tmpdir, sizeof(tmpdir), "%s/git-difftool.XXXXXX", tmp ? tmp : "/tmp");
-	if (!mkdtemp(tmpdir))
-		return error("could not create '%s'", tmpdir);
-	strbuf_addf(&ldir, "%s/left/", tmpdir);
-	strbuf_addf(&rdir, "%s/right/", tmpdir);
+	strbuf_add_absolute_path(&tmpdir, tmp ? tmp : "/tmp");
+	/* Remove trailing slashes when $TMPDIR ends in '/'. */
+	while (tmpdir.len > 0 && tmpdir.buf[tmpdir.len - 1] == '/') {
+		strbuf_setlen(&tmpdir, tmpdir.len - 1);
+	}
+	strbuf_addstr(&tmpdir, "/git-difftool.XXXXXX");
+
+	if (!mkdtemp(tmpdir.buf))
+		return error("could not create '%s'", tmpdir.buf);
+	strbuf_addf(&ldir, "%s/left/", tmpdir.buf);
+	strbuf_addf(&rdir, "%s/right/", tmpdir.buf);
 	strbuf_addstr(&wtdir, workdir);
 	if (!wtdir.len || !is_dir_sep(wtdir.buf[wtdir.len - 1]))
 		strbuf_addch(&wtdir, '/');
@@ -612,7 +617,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		if (!indices_loaded) {
 			struct lock_file lock = LOCK_INIT;
 			strbuf_reset(&buf);
-			strbuf_addf(&buf, "%s/wtindex", tmpdir);
+			strbuf_addf(&buf, "%s/wtindex", tmpdir.buf);
 			if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
 			    write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
 				ret = error("could not write %s", buf.buf);
@@ -642,11 +647,11 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
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
@@ -658,6 +663,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
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
2.30.1 (Apple Git-130)

