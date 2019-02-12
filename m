Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2CF71F453
	for <e@80x24.org>; Tue, 12 Feb 2019 22:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfBLW1c (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:27:32 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:51067 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbfBLW1b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:27:31 -0500
Received: by mail-qk1-f201.google.com with SMTP id x125so301845qka.17
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hEtMEUXdOKmOos88L8Z0fLTAykiOwtWjobx+9asYnSM=;
        b=fX3wgamf9OfUKifySYqMwpEK6tLNhoYb+2femcABH0QaS70QMblRp6YaEEdoFugQbl
         xW5ZPupdXcoavQnURs9QvV7YlLweEVDL+yAark8bzl/R+x0iwrjM9CtxpYggX/3VJlsJ
         r8QjHGI6tIMaOJ+bg8Lqu4E16GzMforgv5gPyRyM8eheos7sA7cSjPS/2mW1VxpbbgkY
         8hhS3APJUmOClr/9O/dlATAdBnj0Z8WrvsVd0RMwBc8ujhpETQ/60lYjbPDhFrtId4X3
         9s8xNb8sh5k3GhAj6E9X0HSjWza5HvYVHsahFHbAOBg/FkITCFNXIwHBMnfzLYkNZuZc
         1MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hEtMEUXdOKmOos88L8Z0fLTAykiOwtWjobx+9asYnSM=;
        b=WG+s6lpuI+aqnf+4nFAr2Yq+i74QUsoeYctxdBiwgikOtns+8z8qOzSPCW2JhGai/n
         jfXkKDx7tsnJlB/B9/MoxfGaWWVXL/YbPbYicUv9/PNsMJ+mZHDwfbUzmO+d+xwTxg97
         A40a2gEKOiS9JXatFZg9juNlI86PCGTKZgd5Wgj0TpKeF2kMp+3st+SBhbzOpQGZNUFw
         /67c0VsTIqY1AdJIVeXRLPKtKthnHd1Q2hdszF0J8YN8wevjf/258/IKxz5VdLx2cxka
         QslweT/I+FN9EbbcddYQiiERNCi5BG9/CEiIO/JDRIZ1szbmhpMeQ23+wnNUYg2g8Abx
         adNQ==
X-Gm-Message-State: AHQUAubGDLvDE7Xs0errgnLoiTExqRc71ilttNfbc99N0FZU655XyK0f
        GPHdEh7+SlvRVpwuJqZhPfPQUO8riFI2BnR2P1prjaiULr+jNUB4qR6KbMQalSUtTz/TAgntVbv
        h0s++Z/GlzDPODHHQWeAVkyiZuNyWmfPoqnOsSr3sXXpnc3VjFmnq
X-Google-Smtp-Source: AHgI3IY3P3iryVBz1C01mGChtrJWkg/h/4Ym35SFpRNMpxNO/7FC1yC5NqRYIRF4r0wlERcU7eEMySpw
X-Received: by 2002:a37:4989:: with SMTP id w131mr2216158qka.54.1550010450670;
 Tue, 12 Feb 2019 14:27:30 -0800 (PST)
Date:   Tue, 12 Feb 2019 17:27:18 -0500
In-Reply-To: <20190212222722.240676-1-brho@google.com>
Message-Id: <20190212222722.240676-2-brho@google.com>
Mime-Version: 1.0
References: <20190212222722.240676-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v3 1/5] Move init_skiplist() outside of fsck
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

init_skiplist() took a file consisting of SHA-1s and comments and added
the objects to an oidset.  This functionality is useful for other
commands.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 fsck.c                          | 37 +--------------------------------
 oidset.c                        | 35 +++++++++++++++++++++++++++++++
 oidset.h                        |  8 +++++++
 t/t5504-fetch-receive-strict.sh | 14 ++++++-------
 4 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/fsck.c b/fsck.c
index 2260adb71e7a..d45534ad90f5 100644
--- a/fsck.c
+++ b/fsck.c
@@ -181,41 +181,6 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 	return msg_type;
 }
 
-static void init_skiplist(struct fsck_options *options, const char *path)
-{
-	FILE *fp;
-	struct strbuf sb = STRBUF_INIT;
-	struct object_id oid;
-
-	fp = fopen(path, "r");
-	if (!fp)
-		die("Could not open skip list: %s", path);
-	while (!strbuf_getline(&sb, fp)) {
-		const char *p;
-		const char *hash;
-
-		/*
-		 * Allow trailing comments, leading whitespace
-		 * (including before commits), and empty or whitespace
-		 * only lines.
-		 */
-		hash = strchr(sb.buf, '#');
-		if (hash)
-			strbuf_setlen(&sb, hash - sb.buf);
-		strbuf_trim(&sb);
-		if (!sb.len)
-			continue;
-
-		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
-			die("Invalid SHA-1: %s", sb.buf);
-		oidset_insert(&options->skiplist, &oid);
-	}
-	if (ferror(fp))
-		die_errno("Could not read '%s'", path);
-	fclose(fp);
-	strbuf_release(&sb);
-}
-
 static int parse_msg_type(const char *str)
 {
 	if (!strcmp(str, "error"))
@@ -284,7 +249,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			init_skiplist(options, buf + equal + 1);
+			oidset_parse_file(&options->skiplist, buf + equal + 1);
 			buf += len + 1;
 			continue;
 		}
diff --git a/oidset.c b/oidset.c
index fe4eb921df81..878a1b56af1c 100644
--- a/oidset.c
+++ b/oidset.c
@@ -35,3 +35,38 @@ void oidset_clear(struct oidset *set)
 	kh_release_oid(&set->set);
 	oidset_init(set, 0);
 }
+
+void oidset_parse_file(struct oidset *set, const char *path)
+{
+	FILE *fp;
+	struct strbuf sb = STRBUF_INIT;
+	struct object_id oid;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		die("Could not open object name list: %s", path);
+	while (!strbuf_getline(&sb, fp)) {
+		const char *p;
+		const char *name;
+
+		/*
+		 * Allow trailing comments, leading whitespace
+		 * (including before commits), and empty or whitespace
+		 * only lines.
+		 */
+		name = strchr(sb.buf, '#');
+		if (name)
+			strbuf_setlen(&sb, name - sb.buf);
+		strbuf_trim(&sb);
+		if (!sb.len)
+			continue;
+
+		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
+			die("Invalid object name: %s", sb.buf);
+		oidset_insert(set, &oid);
+	}
+	if (ferror(fp))
+		die_errno("Could not read '%s'", path);
+	fclose(fp);
+	strbuf_release(&sb);
+}
diff --git a/oidset.h b/oidset.h
index c9d0f6d3cc8b..c4807749df8d 100644
--- a/oidset.h
+++ b/oidset.h
@@ -73,6 +73,14 @@ int oidset_remove(struct oidset *set, const struct object_id *oid);
  */
 void oidset_clear(struct oidset *set);
 
+/**
+ * Add the contents of the file 'path' to an initialized oidset.  Each line is
+ * an unabbreviated object name.  Comments begin with '#', and trailing comments
+ * are allowed.  Leading whitespace and empty or white-space only lines are
+ * ignored.
+ */
+void oidset_parse_file(struct oidset *set, const char *path);
+
 struct oidset_iter {
 	kh_oid_t *set;
 	khiter_t iter;
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 7bc706873c5b..7184f1d07f90 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -164,9 +164,9 @@ test_expect_success 'fsck with unsorted skipList' '
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
 	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
-	test_i18ngrep "Could not open skip list: does-not-exist" err &&
+	test_i18ngrep "Could not open object name list: does-not-exist" err &&
 	test_must_fail git -c fsck.skipList=.git/config -c fsck.missingEmail=ignore fsck 2>err &&
-	test_i18ngrep "Invalid SHA-1: \[core\]" err
+	test_i18ngrep "Invalid object name: \[core\]" err
 '
 
 test_expect_success 'fsck with other accepted skipList input (comments & empty lines)' '
@@ -193,7 +193,7 @@ test_expect_success 'fsck no garbage output from comments & empty lines errors'
 test_expect_success 'fsck with invalid abbreviated skipList input' '
 	echo $commit | test_copy_bytes 20 >SKIP.abbreviated &&
 	test_must_fail git -c fsck.skipList=SKIP.abbreviated fsck 2>err-abbreviated &&
-	test_i18ngrep "^fatal: Invalid SHA-1: " err-abbreviated
+	test_i18ngrep "^fatal: Invalid object name: " err-abbreviated
 '
 
 test_expect_success 'fsck with exhaustive accepted skipList input (various types of comments etc.)' '
@@ -226,10 +226,10 @@ test_expect_success 'push with receive.fsck.skipList' '
 	test_must_fail git push --porcelain dst bogus &&
 	git --git-dir=dst/.git config receive.fsck.skipList does-not-exist &&
 	test_must_fail git push --porcelain dst bogus 2>err &&
-	test_i18ngrep "Could not open skip list: does-not-exist" err &&
+	test_i18ngrep "Could not open object name list: does-not-exist" err &&
 	git --git-dir=dst/.git config receive.fsck.skipList config &&
 	test_must_fail git push --porcelain dst bogus 2>err &&
-	test_i18ngrep "Invalid SHA-1: \[core\]" err &&
+	test_i18ngrep "Invalid object name: \[core\]" err &&
 
 	git --git-dir=dst/.git config receive.fsck.skipList SKIP &&
 	git push --porcelain dst bogus
@@ -255,10 +255,10 @@ test_expect_success 'fetch with fetch.fsck.skipList' '
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
 	git --git-dir=dst/.git config fetch.fsck.skipList does-not-exist &&
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec 2>err &&
-	test_i18ngrep "Could not open skip list: does-not-exist" err &&
+	test_i18ngrep "Could not open object name list: does-not-exist" err &&
 	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/config &&
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec 2>err &&
-	test_i18ngrep "Invalid SHA-1: \[core\]" err &&
+	test_i18ngrep "Invalid object name: \[core\]" err &&
 
 	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/SKIP &&
 	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec
-- 
2.21.0.rc0.258.g878e2cd30e-goog

