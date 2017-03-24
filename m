Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9928B1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755525AbdCXP2D (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:28:03 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34291 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965901AbdCXP1v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:27:51 -0400
Received: by mail-qt0-f193.google.com with SMTP id x35so841220qtc.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PeTnI6yuu6hjmbOr2eEqDK3Gj3yMMW5uQbIMuE9ryaE=;
        b=tPWRMweNiywN/0nDuQsZI8tzng+pLSEBZUTC9N0zCMOwJ7amx98BJTSTQ6/3CUyt8K
         lyB318R6XK5/OiiGQauCNNOxb4D5xfEtXfKz5DR2pgiqFQyXH0uPnvM6D/PgPZFTFyp9
         Yc9Atjvd/gtGwpMhaNd9q5s6AGr9v6Y5y5jPUKTpCRRhCfKLLeX0DqcI+xGZ6wzbNyNt
         KnFwxtqtrZ+fuHItT2D9vrxV6UKBLkSEn2dALB5EJfDXzXQqm8aENC4nfH8Ii2tczUmW
         B6xUJMGfm78c+YJwIU1s3vfCHvKJ/jIsq5KUXv++nMwDudOL40SPRlVFTEuV2xDsiUOv
         AHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PeTnI6yuu6hjmbOr2eEqDK3Gj3yMMW5uQbIMuE9ryaE=;
        b=eKva39wuorIlRGqObBChFzZJ6JgXw8y0Z8/WryWrwQrUGPwzXvVqxRnxXu37L5WoOI
         RhX8FFyZ01h6x0n+HQV6EEdPnHGC8Xkpwqh/QYmtm4HBO/dQeA/XUSLmtFadkq2y6u0O
         7+0xmiTLoFzeQtsA07k9tf141GdYfVgjwRz8WSmLbiDwHnKST9dlRD1F5eiqdRbsV9IY
         07DEhQ85RB9RH6SOKuDdMye0e16yquMR4OQbiO/lgJWxaro9Y2ShR1sMgoGlnO2Q8lqn
         oXiDE706eF+ilF1kKhPLk5ziU4gppwWUxAnNBrFyDLVKrPiTuRnAa091yQAwCNbwKbO5
         VOTA==
X-Gm-Message-State: AFeK/H14+drdkkT7x6wO1EbGrB3zR/cA5ztlC3Ozm9qnpzroKw1t9WxVAp4dVn+2y9ifEw==
X-Received: by 10.237.44.198 with SMTP id g64mr9328778qtd.87.1490369264741;
        Fri, 24 Mar 2017 08:27:44 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d23sm1717589qta.32.2017.03.24.08.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 08:27:44 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com, David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] difftool: handle modified symlinks in dir-diff mode
Date:   Fri, 24 Mar 2017 11:27:25 -0400
Message-Id: <20170324152726.14632-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.gvfs.1.43.g876ba2a
In-Reply-To: <20170324152726.14632-1-benpeart@microsoft.com>
References: <20170324152726.14632-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Aguilar <davvid@gmail.com>

Detect the null object ID for symlinks in dir-diff so that difftool can
detect when symlinks are modified in the worktree.

Previously, a null symlink object ID would crash difftool.
Handle null object IDs as unknown content that must be read from
the worktree.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/difftool.c  | 51 ++++++++++++++++++++++++++++++++++++++++-----
 t/t7800-difftool.sh | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index d13350ce83..25e54ad3ed 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -254,6 +254,49 @@ static int ensure_leading_directories(char *path)
 	}
 }
 
+/*
+ * Unconditional writing of a plain regular file is what
+ * "git difftool --dir-diff" wants to do for symlinks.  We are preparing two
+ * temporary directories to be fed to a Git-unaware tool that knows how to
+ * show a diff of two directories (e.g. "diff -r A B").
+ *
+ * Because the tool is Git-unaware, if a symbolic link appears in either of
+ * these temporary directories, it will try to dereference and show the
+ * difference of the target of the symbolic link, which is not what we want,
+ * as the goal of the dir-diff mode is to produce an output that is logically
+ * equivalent to what "git diff" produces.
+ *
+ * Most importantly, we want to get textual comparison of the result of the
+ * readlink(2).  get_symlink() provides that---it returns the contents of
+ * the symlink that gets written to a regular file to force the external tool
+ * to compare the readlink(2) result as text, even on a filesystem that is
+ * capable of doing a symbolic link.
+ */
+static char *get_symlink(const struct object_id *oid, const char *path)
+{
+	char *data;
+	if (is_null_oid(oid)) {
+		/* The symlink is unknown to Git so read from the filesystem */
+		struct strbuf link = STRBUF_INIT;
+		if (has_symlinks) {
+			if (strbuf_readlink(&link, path, strlen(path)))
+				die(_("could not read symlink %s"), path);
+		} else if (strbuf_read_file(&link, path, 128))
+			die(_("could not read symlink file %s"), path);
+
+		data = strbuf_detach(&link, NULL);
+	} else {
+		enum object_type type;
+		unsigned long size;
+		data = read_sha1_file(oid->hash, &type, &size);
+		if (!data)
+			die(_("could not read object %s for symlink %s"),
+				oid_to_hex(oid), path);
+	}
+
+	return data;
+}
+
 static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			int argc, const char **argv)
 {
@@ -270,8 +313,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct hashmap working_tree_dups, submodules, symlinks2;
 	struct hashmap_iter iter;
 	struct pair_entry *entry;
-	enum object_type type;
-	unsigned long size;
 	struct index_state wtindex;
 	struct checkout lstate, rstate;
 	int rc, flags = RUN_GIT_CMD, err = 0;
@@ -377,13 +418,13 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		}
 
 		if (S_ISLNK(lmode)) {
-			char *content = read_sha1_file(loid.hash, &type, &size);
+			char *content = get_symlink(&loid, src_path);
 			add_left_or_right(&symlinks2, src_path, content, 0);
 			free(content);
 		}
 
 		if (S_ISLNK(rmode)) {
-			char *content = read_sha1_file(roid.hash, &type, &size);
+			char *content = get_symlink(&roid, dst_path);
 			add_left_or_right(&symlinks2, dst_path, content, 1);
 			free(content);
 		}
@@ -397,7 +438,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 				return error("could not write '%s'", src_path);
 		}
 
-		if (rmode) {
+		if (rmode && !S_ISLNK(rmode)) {
 			struct working_tree_entry *entry;
 
 			/* Avoid duplicate working_tree entries */
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index e0e65df8de..0e7f30db2d 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -626,4 +626,64 @@ test_expect_success SYMLINKS 'difftool --dir-diff symlinked directories' '
 	)
 '
 
+test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
+	test_when_finished git reset --hard &&
+	touch b &&
+	ln -s b c &&
+	git add b c &&
+	test_tick &&
+	git commit -m initial &&
+	touch d &&
+	rm c &&
+	ln -s d c &&
+	cat >expect <<-EOF &&
+		b
+		c
+
+		c
+	EOF
+	git difftool --symlinks --dir-diff --extcmd ls >output &&
+	grep -v ^/ output >actual &&
+	test_cmp expect actual &&
+
+	git difftool --no-symlinks --dir-diff --extcmd ls >output &&
+	grep -v ^/ output >actual &&
+	test_cmp expect actual &&
+
+	# The left side contains symlink "c" that points to "b"
+	test_config difftool.cat.cmd "cat \$LOCAL/c" &&
+	printf "%s\n" b >expect &&
+
+	git difftool --symlinks --dir-diff --tool cat >actual &&
+	test_cmp expect actual &&
+
+	git difftool --symlinks --no-symlinks --dir-diff --tool cat >actual &&
+	test_cmp expect actual &&
+
+	# The right side contains symlink "c" that points to "d"
+	test_config difftool.cat.cmd "cat \$REMOTE/c" &&
+	printf "%s\n" d >expect &&
+
+	git difftool --symlinks --dir-diff --tool cat >actual &&
+	test_cmp expect actual &&
+
+	git difftool --no-symlinks --dir-diff --tool cat >actual &&
+	test_cmp expect actual &&
+
+	# Deleted symlinks
+	rm -f c &&
+	cat >expect <<-EOF &&
+		b
+		c
+
+	EOF
+	git difftool --symlinks --dir-diff --extcmd ls >output &&
+	grep -v ^/ output >actual &&
+	test_cmp expect actual &&
+
+	git difftool --no-symlinks --dir-diff --extcmd ls >output &&
+	grep -v ^/ output >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.12.0.gvfs.1.43.g876ba2a

