Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD7C1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbeHHVUm (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53605 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeHHVUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so3807711wmh.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1JZl71ecLEfIvScHvXiCtsXTRjc2ihH1I4b8qZQY4X0=;
        b=P/8Y1rgB33MNMm0MOtveuVz+kBnHJJpgkuR4XSNuP98v9UYx89eu9rLkfQmPA4S1kY
         fW1jnJMpHyM8i8++LnZ76QKHunbNUfJ0ixOTdrH6uwmZ2l8y3Dj8Y9/4asIlpK9i5XKP
         ejEhSq4DeOiER+834xtifwIQ6ky5RvyxgkDdxoQ9LwR8KrY+EZEJ132Z5SSAqMu/Fo3h
         r+HSsosiN/HeojbWhKkglOl4+pLGG5MS3UO0QK7e+YZ3X6Fe/hWSNoLVaAAkYRRXZQy7
         6eKeljAkIQUW2EDGNoTEwVaMmzJ6aHBg585VH2kns4BwlFuiPVAHTSrBfw/STTTPapV3
         EhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JZl71ecLEfIvScHvXiCtsXTRjc2ihH1I4b8qZQY4X0=;
        b=TqFHWj00OrTEs5FFiqt10/vgI+qB4GOl29qS85g0/jwzI4BkRk1njRc8xJKIsxFo/z
         JUarW0uCFXCVDLRg2j0t39Njv9vmo5J7ypillJpFk80CMPj1NY3YpSbj1kGmMziQISpF
         sbaqIUXqk3N3sFXnEvgWn5oxuncjpGRuzPWyBncvc1AMHGiOGIIuB81WFFq4KcWgAMW5
         t1ijgpuKiAn49epFnMX6y3MasxGePv7t0M8DlMT3UU4VCjOhr//9KZ1Rt4dRcnrVQZRB
         Vf5S+VIYuVZMMwWVg+uhzHS342THUmQFZDiowYGmK4EteA3x1rwk1QhhvnjvSTVc36BY
         OVsA==
X-Gm-Message-State: AOUpUlHFR63yV9TUfNjS6ojueORMJRNkruWq4IDYVZjlVnjFv4s2PBmY
        K6EzYR7UxEXV1Kgkw+m2SsmSS57V
X-Google-Smtp-Source: AA+uWPxcbSxHRE3nTmvhDPqAiYC3iJpM3D6gYC3lumxD+rZNhLy3k1xWhjBAANL373z0c9eUwBhmyA==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr2824300wmd.79.1533754779316;
        Wed, 08 Aug 2018 11:59:39 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:38 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 24/26] stash: optimize `get_untracked_files()` and `check_changes()`
Date:   Wed,  8 Aug 2018 21:59:03 +0300
Message-Id: <9bde85eacb94db54763aab35efe287c5af7c8316.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commits introduces a optimization by avoiding calling the
same functions again. For example, `git stash push -u`
would call at some points the following functions:

 * `check_changes()`
 * `do_create_stash()`, which calls: `check_changes()` and
`get_untracked_files()`

Note that `check_changes()` also calls `get_untracked_files()`.
So, `check_changes()` is called 2 times and `get_untracked_files()`
3 times. By checking at the beginning of the function if we already
performed a check, we can avoid making useless calls.
---
 builtin/stash.c | 50 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 0ef88408a..4d5c0d16e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -819,13 +819,23 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 }
 
 /*
- * `out` will be filled with the names of untracked files. The return value is:
+ * `has_untracked_files` is:
+ * -2 if `get_untracked_files()` hasn't been called
+ * -1 if there were errors
+ *  0 if there are no untracked files
+ *  1 if there are untracked files
+ *
+ * `untracked_files` will be filled with the names of untracked files.
+ * The return value is:
  *
  * = 0 if there are not any untracked files
  * > 0 if there are untracked files
  */
+static struct strbuf untracked_files = STRBUF_INIT;
+static int has_untracked_files = -2;
+
 static int get_untracked_files(const char **argv, const char *prefix,
-			       int include_untracked, struct strbuf *out)
+			       int include_untracked)
 {
 	int max_len;
 	int i;
@@ -833,6 +843,9 @@ static int get_untracked_files(const char **argv, const char *prefix,
 	struct dir_struct dir;
 	struct pathspec pathspec;
 
+	if (has_untracked_files != -2)
+		return has_untracked_files;
+
 	memset(&dir, 0, sizeof(dir));
 	if (include_untracked != 2)
 		setup_standard_excludes(&dir);
@@ -849,7 +862,7 @@ static int get_untracked_files(const char **argv, const char *prefix,
 			free(ent);
 			continue;
 		}
-		strbuf_addf(out, "%s\n", ent->name);
+		strbuf_addf(&untracked_files, "%s\n", ent->name);
 		free(ent);
 	}
 
@@ -857,16 +870,25 @@ static int get_untracked_files(const char **argv, const char *prefix,
 	free(dir.ignored);
 	clear_directory(&dir);
 	free(seen);
-	return out->len;
+	has_untracked_files = untracked_files.len;
+	return untracked_files.len;
 }
 
 /*
+ * `changes` is:
+ * -2 if `check_changes()` hasn't been called
+ * -1 if there were any errors
+ *  0 if there are no changes
+ *  1 if there are changes
+ *
  * The return value of `check_changes()` can be:
  *
  * < 0 if there was an error
  * = 0 if there are no changes.
  * > 0 if there are changes.
  */
+static int changes = -2;
+
 static int check_changes(const char **argv, int include_untracked,
 			 const char *prefix)
 {
@@ -874,9 +896,11 @@ static int check_changes(const char **argv, int include_untracked,
 	int ret = 0;
 	struct rev_info rev;
 	struct object_id dummy;
-	struct strbuf out = STRBUF_INIT;
 	struct argv_array args = ARGV_ARRAY_INIT;
 
+	if (changes != -2)
+		return changes;
+
 	init_revisions(&rev, prefix);
 	parse_pathspec(&rev.prune_data, 0, PATHSPEC_PREFER_FULL,
 		       prefix, argv);
@@ -912,17 +936,16 @@ static int check_changes(const char **argv, int include_untracked,
 	}
 
 	if (include_untracked && get_untracked_files(argv, prefix,
-						     include_untracked, &out))
+						     include_untracked))
 		ret = 1;
 
 done:
-	strbuf_release(&out);
+	changes = ret;
 	argv_array_clear(&args);
 	return ret;
 }
 
-static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
-				struct strbuf *out)
+static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
 {
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
@@ -937,7 +960,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 			 stash_index_path.buf);
 
 	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
-	if (pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0)) {
+	if (pipe_command(&cp, untracked_files.buf, untracked_files.len,
+			 NULL, 0, NULL, 0)) {
 		ret = -1;
 		goto done;
 	}
@@ -1116,7 +1140,6 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
 	struct commit_list *parents = NULL;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf commit_tree_label = STRBUF_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct strbuf final_stash_msg = STRBUF_INIT;
 
 	read_cache_preload(NULL);
@@ -1158,8 +1181,8 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
 	}
 
 	if (include_untracked && get_untracked_files(argv, prefix,
-						     include_untracked, &out)) {
-		if (save_untracked_files(info, &msg, &out)) {
+						     include_untracked)) {
+		if (save_untracked_files(info, &msg)) {
 			if (!quiet)
 				printf_ln("Cannot save the untracked files");
 			ret = -1;
@@ -1213,7 +1236,6 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
 done:
 	strbuf_release(&commit_tree_label);
 	strbuf_release(&msg);
-	strbuf_release(&out);
 	strbuf_release(&final_stash_msg);
 	return ret;
 }
-- 
2.18.0.573.g56500d98f

