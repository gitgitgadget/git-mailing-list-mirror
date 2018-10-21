Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF62A1F453
	for <e@80x24.org>; Sun, 21 Oct 2018 08:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeJUQWs (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 12:22:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39123 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbeJUQWs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 12:22:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id p1-v6so34233585ljg.6
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZAQtjldgr3Xllzn97vTv0fiD3FA5oTWY2N6klV3tFrI=;
        b=bh+hT0wkVJQyq0JVf+e9LsSdAjZXxqMvpmuFYhUzx8ca1xAeMU5vYyCTo5zR10n1/N
         xehmCkphZ1NPR71boeuTwf/fJhplNRXiRU2ozUW2XgBD/DEF6d3xkbaevXs12vHU69CN
         I2OR/cXctGYfhM6F8OG0V/SxhGbrKCQ3V2eWbKAPNc67mBUkCL1wwukPt1Zg0qkIOlHl
         aJcsOzSPFubz/TKDbtbH3qXCrveWP9jSLlS4rUtdW2Kvbcuj5ybnZr10tEvQWsrCsJvS
         H8JmWJshXjoI75CNnFYjBmKIjYpnRqJlLcMTuznA5P9LZMJtUsNuwlVko5e7cgvg3+5k
         syFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAQtjldgr3Xllzn97vTv0fiD3FA5oTWY2N6klV3tFrI=;
        b=kafkHG6n+KTnO3i1LsB6KDTLhzlQ4yC7pSXogKKYRPHXt9ppX+1V8rE07HxO2YprXj
         ViaS9eYTFeWdsmmrjk1X6gYC6Ul0joTNgxuDv1/wQv9gAdDqGICK2hTGinVi44CaikEH
         FkvmQEDWz0l3fmIN+cMzVpTOsmIOuDdgqBDOY+Z0P2Z9WyaZj9xbRo1bqRQJj5Is+9pW
         nXPK64qWbHef7EsKL1qP3O8Od9H96/+Ap3SctnN4bVzd1V+TX1WzAdUm+MLGIuIK8ucO
         UnsXySRQInsvWKwW9jZlgc2JkJjYIKWCv9b4xBtb/Vt+zwdigWIQJbJ+mSvFBtfSiZdy
         uYaw==
X-Gm-Message-State: ABuFfoh7BAl2N+nDKCc31B0iP7hZi+4UTXIaRUEdHZ3cU3TSCLqgKNcP
        ROu4SSZd3Aq/ZbCMMB0aehE=
X-Google-Smtp-Source: ACcGV61XAhQFGfJG13H6OCIGaXxk+vQJHQVIEeRbTqDgF0p52Uj3mJykh45znkX+RKSgaxbw0zmHkw==
X-Received: by 2002:a2e:908:: with SMTP id 8-v6mr25886723ljj.1.1540109355197;
        Sun, 21 Oct 2018 01:09:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k9-v6sm6385889lje.51.2018.10.21.01.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 01:09:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: [PATCH v3 7/8] fsck: check HEAD and reflog from other worktrees
Date:   Sun, 21 Oct 2018 10:08:58 +0200
Message-Id: <20181021080859.3203-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181021080859.3203-1-pclouds@gmail.com>
References: <20180929191029.13994-1-pclouds@gmail.com>
 <20181021080859.3203-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fsck is a repo-wide operation and should check all references no
matter which worktree they are associated to.

Reported-by: Jeff King <peff@peff.net>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fsck.c  | 55 ++++++++++++++++++++++++++++++++++---------------
 t/t1450-fsck.sh | 35 +++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0d39462058..3c3e0f06e7 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -19,6 +19,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "run-command.h"
+#include "worktree.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -444,7 +445,11 @@ static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid
 static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
 			      int flag, void *cb_data)
 {
-	for_each_reflog_ent(logname, fsck_handle_reflog_ent, (void *)logname);
+	struct strbuf refname = STRBUF_INIT;
+
+	strbuf_worktree_ref(cb_data, &refname, logname);
+	for_each_reflog_ent(refname.buf, fsck_handle_reflog_ent, refname.buf);
+	strbuf_release(&refname);
 	return 0;
 }
 
@@ -482,20 +487,34 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int fsck_head_link(const char **head_points_at,
+static int fsck_head_link(const char *head_ref_name,
+			  const char **head_points_at,
 			  struct object_id *head_oid);
 
 static void get_default_heads(void)
 {
+	struct worktree **worktrees, **p;
 	const char *head_points_at;
 	struct object_id head_oid;
 
-	fsck_head_link(&head_points_at, &head_oid);
-	if (head_points_at && !is_null_oid(&head_oid))
-		fsck_handle_ref("HEAD", &head_oid, 0, NULL);
 	for_each_rawref(fsck_handle_ref, NULL);
-	if (include_reflogs)
-		for_each_reflog(fsck_handle_reflog, NULL);
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+		struct strbuf ref = STRBUF_INIT;
+
+		strbuf_worktree_ref(wt, &ref, "HEAD");
+		fsck_head_link(ref.buf, &head_points_at, &head_oid);
+		if (head_points_at && !is_null_oid(&head_oid))
+			fsck_handle_ref(ref.buf, &head_oid, 0, NULL);
+		strbuf_release(&ref);
+
+		if (include_reflogs)
+			refs_for_each_reflog(get_worktree_ref_store(wt),
+					     fsck_handle_reflog, wt);
+	}
+	free_worktrees(worktrees);
 
 	/*
 	 * Not having any default heads isn't really fatal, but
@@ -584,34 +603,36 @@ static void fsck_object_dir(const char *path)
 	stop_progress(&progress);
 }
 
-static int fsck_head_link(const char **head_points_at,
+static int fsck_head_link(const char *head_ref_name,
+			  const char **head_points_at,
 			  struct object_id *head_oid)
 {
 	int null_is_error = 0;
 
 	if (verbose)
-		fprintf(stderr, "Checking HEAD link\n");
+		fprintf(stderr, "Checking %s link\n", head_ref_name);
 
-	*head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid, NULL);
+	*head_points_at = resolve_ref_unsafe(head_ref_name, 0, head_oid, NULL);
 	if (!*head_points_at) {
 		errors_found |= ERROR_REFS;
-		return error("Invalid HEAD");
+		return error("Invalid %s", head_ref_name);
 	}
-	if (!strcmp(*head_points_at, "HEAD"))
+	if (!strcmp(*head_points_at, head_ref_name))
 		/* detached HEAD */
 		null_is_error = 1;
 	else if (!starts_with(*head_points_at, "refs/heads/")) {
 		errors_found |= ERROR_REFS;
-		return error("HEAD points to something strange (%s)",
-			     *head_points_at);
+		return error("%s points to something strange (%s)",
+			     head_ref_name, *head_points_at);
 	}
 	if (is_null_oid(head_oid)) {
 		if (null_is_error) {
 			errors_found |= ERROR_REFS;
-			return error("HEAD: detached HEAD points at nothing");
+			return error("%s: detached HEAD points at nothing",
+				     head_ref_name);
 		}
-		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-			*head_points_at + 11);
+		fprintf(stderr, "notice: %s points to an unborn branch (%s)\n",
+			head_ref_name, *head_points_at + 11);
 	}
 	return 0;
 }
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 0f2dd26f74..28201677d5 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -101,6 +101,41 @@ test_expect_success 'HEAD link pointing at a funny place' '
 	grep "HEAD points to something strange" out
 '
 
+test_expect_success 'HEAD link pointing at a funny object (from different wt)' '
+	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
+	test_when_finished "rm -rf .git/worktrees wt" &&
+	git worktree add wt &&
+	mv .git/HEAD .git/SAVED_HEAD &&
+	echo $ZERO_OID >.git/HEAD &&
+	# avoid corrupt/broken HEAD from interfering with repo discovery
+	test_must_fail git -C wt fsck 2>out &&
+	grep "main-worktree/HEAD: detached HEAD points" out
+'
+
+test_expect_success 'other worktree HEAD link pointing at a funny object' '
+	test_when_finished "rm -rf .git/worktrees other" &&
+	git worktree add other &&
+	echo $ZERO_OID >.git/worktrees/other/HEAD &&
+	test_must_fail git fsck 2>out &&
+	grep "worktrees/other/HEAD: detached HEAD points" out
+'
+
+test_expect_success 'other worktree HEAD link pointing at missing object' '
+	test_when_finished "rm -rf .git/worktrees other" &&
+	git worktree add other &&
+	echo "Contents missing from repo" | git hash-object --stdin >.git/worktrees/other/HEAD &&
+	test_must_fail git fsck 2>out &&
+	grep "worktrees/other/HEAD: invalid sha1 pointer" out
+'
+
+test_expect_success 'other worktree HEAD link pointing at a funny place' '
+	test_when_finished "rm -rf .git/worktrees other" &&
+	git worktree add other &&
+	echo "ref: refs/funny/place" >.git/worktrees/other/HEAD &&
+	test_must_fail git fsck 2>out &&
+	grep "worktrees/other/HEAD points to something strange" out
+'
+
 test_expect_success 'email without @ is okay' '
 	git cat-file commit HEAD >basis &&
 	sed "s/@/AT/" basis >okay &&
-- 
2.19.1.647.g708186aaf9

