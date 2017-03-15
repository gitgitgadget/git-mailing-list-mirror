Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32EE420323
	for <e@80x24.org>; Wed, 15 Mar 2017 06:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdCOGyR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 02:54:17 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34155 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdCOGyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 02:54:16 -0400
Received: by mail-pf0-f194.google.com with SMTP id o126so1191320pfb.1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 23:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9H165B8n2NUYOo6s5KxqQGy8YjKmQwQ7dGWICIUlEk8=;
        b=oW+jKyBt8T1Sr/Suwbv+gL+JdqMHuoBESpeL0XKEsLBM8HB9oWKPwBkLRGhVuWElQd
         hY7ZDcc8+BEnhNgyoqWAV6PkU64gKPewDuTlCviKcO1KfU1+lpLMkf3ND2iw1SD231dR
         aQuUAJynXjCJtIPiszyPMoAw+813p/Jc5df/vvBWSE8GRXx7xBW6NE9/0aD5g6GJfYss
         IJJu/8lDM5p2jZ5yJOcKCh9MRBXx8VsFTpLOib5F5qtyZB4AWcL2tobZ6/EBYsb0DTCP
         R7sQJbqrlKscXpg6gRXN5CYsqxF+2lXP5Rax8ll2BgFy9yNkr7Zdvb/0amBFpP6Tk3iV
         YYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9H165B8n2NUYOo6s5KxqQGy8YjKmQwQ7dGWICIUlEk8=;
        b=Hntbx28r7CmNW2vQgWY8rjcZMIJ1mREyQMptKinGJjc45vzpKXGcTlGU4VWozwgMEZ
         ldEzIT4TEEvZSpOL73P1JuDqp90DuRX4IibJ6t08FNHGsPnABvESiPkowcfPmROkWwKp
         ND69+A+qmX11YTFWvsksvXjplRYQp/hj6tFR5d8yZ8TV74JOZdNh8fuQT/lfjtdPxGWB
         BR7x4ZKDatE2glc5Ci+fnDiEZCyCLhR0oeD/1B7AAnUjV83HSHQHBlYeo2Y1nRvO7q2Q
         yfQENW7nv7Uvz7OOEr4/Wka/xjCPT1XQs+MSskN+ILVO6AE7sYSeD/sPRlk10aoV6pYO
         sJUQ==
X-Gm-Message-State: AFeK/H37Fg2PwMDMbTw0/I+UwMpTG5dPpGaVLMsRBJhiX67t76EwO7NzBYjFI87UG2eoaw==
X-Received: by 10.99.167.9 with SMTP id d9mr1891739pgf.19.1489560854902;
        Tue, 14 Mar 2017 23:54:14 -0700 (PDT)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id v9sm1851026pfg.133.2017.03.14.23.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 23:54:13 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Christophe Macabiau <christophemacabiau@gmail.com>
Subject: [PATCH 3/3] difftool: handle modified symlinks in dir-diff mode
Date:   Tue, 14 Mar 2017 23:54:06 -0700
Message-Id: <20170315065406.6739-3-davvid@gmail.com>
X-Mailer: git-send-email 2.12.0.309.gffef9e61c2
In-Reply-To: <20170315065406.6739-1-davvid@gmail.com>
References: <20170315065406.6739-1-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Detect the null object ID for symlinks in dir-diff so that difftool can
detect when symlinks are modified in the worktree.

Previously, a null symlink object ID would crash difftool.
Handle null object IDs as unknown content that must be read from
the worktree.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
This was reworked a bit since the original patch.
The subject line changed, a lot of comments were added,
and the tests were made more extensive.

This implementation is simpler since we now use a get_symlink()
function in one place and simply skip the problematic code path
that does not apply to symlinks.  Existing code handles writing
the symlink content so write_symlink_file() from the original
patch is gone.

 builtin/difftool.c  | 53 +++++++++++++++++++++++++++++++++++++++++-----
 t/t7800-difftool.sh | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index d13350ce83..6aab5cd23a 100644
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
@@ -414,6 +455,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 				oidcpy(&ce->oid, &roid);
 				strcpy(ce->name, dst_path);
 				ce->ce_namelen = dst_path_len;
+
 				if (checkout_entry(ce, &rstate, NULL))
 					return error("could not write '%s'",
 						     dst_path);
@@ -487,6 +529,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 * shows only the link itself, not the contents of the link target.
 	 * This loop replicates that behavior.
 	 */
+
 	hashmap_iter_init(&symlinks2, &iter);
 	while ((entry = hashmap_iter_next(&iter))) {
 		if (*entry->left) {
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
2.12.0.309.gffef9e61c2

