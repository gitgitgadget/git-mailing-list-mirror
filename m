Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A3C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3417923AC0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbhAHUEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbhAHUEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:04:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143AAC0612A8
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q18so10162021wrn.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fX/H5VOu/FRbxYrdaW1abnN3Wn3tasBSLM26Gwzwr5g=;
        b=UI1qfwHkS1wtHMgzCMA7+yNdTFF5yg9ylpI1A/ykk7TxJlcKrzXXdr22HGMxcM2Gll
         uLpf2d+U0b838qXe5IJcrLhhkKyoo2TNsDm4fpH1lOdQuBgk5yBRNktWUFlWEOSAbABW
         I2SIUh0z99RmllHOTexBPGrI1wRGSs0WsB77ZxSlDmguqpjgcqJ+vJkakkF1FCkSqQE6
         pdCYMWInMtMcy5ezGtu6YAoYaiR7nqCXxa5DZdmYpSUmGel7BLh/xXBJF2Bk7bAL2TQX
         Aqzhf7knJ+EykC6splTDcFhKSBH6g6W8lVoNFWGY2RB1djb9FPlgHqbxSN8WUpUzUTI7
         Ls9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fX/H5VOu/FRbxYrdaW1abnN3Wn3tasBSLM26Gwzwr5g=;
        b=EY5r1u4txY9DfFFAyHnCjL/ROUtRU+Cxlx+vwBcA0QjQzoYEDcQdo72z2u07kt/uQ2
         oJn02eDDy49hN2Ly1MAPSBHljBsN4c9s49YpaNTf//X7rohH2j1fCNdS1lzr86wsg0sa
         H69UepA7QLMtI9hxGxRz7wPc+u8IMJT6fIY9Y0JvZI8CB+VNJakVkWpiBv5sFBBZTfd+
         Fp5s0Nq2dP/eo4QBjP2/1AgHvwLJk+Rly13lpvhIr6QYgjzdVbOmuL9GLrm3yTBP1Bwp
         /f3Eeyx15C7gYIY7a0b8tbRzMW3TOhfvpQ4ZAHtGVjwQs5Lu6KyBIev7yevsqK4yZhQr
         dOUw==
X-Gm-Message-State: AOAM530KnY3/bpAghp7bYv7oJlzJIZOkXmjq76PtLwdLspGLwdDIzhfn
        aqWfPC44aCwmEHdd7vAPwKkdH1PIchk=
X-Google-Smtp-Source: ABdhPJxTF2P5w4miAKAy9xriPxyyYctipw/LDi7Y0JwRPC+3vPB01ubdt0aFqAhUhoAtv3AityHOPA==
X-Received: by 2002:adf:a34d:: with SMTP id d13mr5271089wrb.194.1610136190411;
        Fri, 08 Jan 2021 12:03:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm14433682wrt.25.2021.01.08.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:09 -0800 (PST)
Message-Id: <4754a9214ee9900302fc01501c4b15083ed2c2db.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:55 +0000
Subject: [PATCH v3 12/14] update-index: reduce static globals, part 1
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In order to remove index compatibility macros cleanly, we relied upon
static globals 'repo' and 'istate' to be pointers to the_repository and
the_index, respectively. We can now start reducing the need for these
static globals by modifying method prototypes to use them when
necessary.

Remove the 'istate' static global in favor of method parameters. This
adjusts some callers, which either use their own 'istate' parameter or
'repo->index'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 74 +++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1c1cb8f8d4a..9a83603c0db 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -226,9 +226,8 @@ static int test_if_untracked_cache_is_supported(void)
 	return ret;
 }
 
-static struct index_state *istate;
-
-static int mark_ce_flags(const char *path, int flag, int mark)
+static int mark_ce_flags(struct index_state *istate,
+			 const char *path, int flag, int mark)
 {
 	int namelen = strlen(path);
 	int pos = index_name_pos(istate, path, namelen);
@@ -246,7 +245,7 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 	return -1;
 }
 
-static int remove_one_path(const char *path)
+static int remove_one_path(struct index_state *istate, const char *path)
 {
 	if (!allow_remove)
 		return error("%s: does not exist and --remove not passed", path);
@@ -262,14 +261,17 @@ static int remove_one_path(const char *path)
  *    succeeds.
  *  - permission error. That's never ok.
  */
-static int process_lstat_error(const char *path, int err)
+static int process_lstat_error(struct index_state *istate,
+			       const char *path, int err)
 {
 	if (is_missing_file_error(err))
-		return remove_one_path(path);
+		return remove_one_path(istate, path);
 	return error("lstat(\"%s\"): %s", path, strerror(err));
 }
 
-static int add_one_path(const struct cache_entry *old, const char *path, int len, struct stat *st)
+static int add_one_path(struct index_state *istate,
+			const struct cache_entry *old,
+			const char *path, int len, struct stat *st)
 {
 	int option;
 	struct cache_entry *ce;
@@ -322,7 +324,8 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
  *  - it doesn't exist at all in the index, but it is a valid
  *    git directory, and it should be *added* as a gitlink.
  */
-static int process_directory(const char *path, int len, struct stat *st)
+static int process_directory(struct index_state *istate,
+			     const char *path, int len, struct stat *st)
 {
 	struct object_id oid;
 	int pos = index_name_pos(istate, path, len);
@@ -336,10 +339,10 @@ static int process_directory(const char *path, int len, struct stat *st)
 			if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
 				return 0;
 
-			return add_one_path(ce, path, len, st);
+			return add_one_path(istate, ce, path, len, st);
 		}
 		/* Should this be an unconditional error? */
-		return remove_one_path(path);
+		return remove_one_path(istate, path);
 	}
 
 	/* Inexact match: is there perhaps a subdirectory match? */
@@ -360,13 +363,14 @@ static int process_directory(const char *path, int len, struct stat *st)
 
 	/* No match - should we add it as a gitlink? */
 	if (!resolve_gitlink_ref(path, "HEAD", &oid))
-		return add_one_path(NULL, path, len, st);
+		return add_one_path(istate, NULL, path, len, st);
 
 	/* Error out. */
 	return error("%s: is a directory - add files inside instead", path);
 }
 
-static int process_path(const char *path, struct stat *st, int stat_errno)
+static int process_path(struct index_state *istate,
+			const char *path, struct stat *st, int stat_errno)
 {
 	int pos, len;
 	const struct cache_entry *ce;
@@ -394,15 +398,16 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 	 * what to do about the pathname!
 	 */
 	if (stat_errno)
-		return process_lstat_error(path, stat_errno);
+		return process_lstat_error(istate, path, stat_errno);
 
 	if (S_ISDIR(st->st_mode))
-		return process_directory(path, len, st);
+		return process_directory(istate, path, len, st);
 
-	return add_one_path(ce, path, len, st);
+	return add_one_path(istate, ce, path, len, st);
 }
 
-static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
+static int add_cacheinfo(struct index_state *istate,
+			 unsigned int mode, const struct object_id *oid,
 			 const char *path, int stage)
 {
 	int res;
@@ -419,7 +424,8 @@ static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 	return 0;
 }
 
-static void chmod_path(char flip, const char *path)
+static void chmod_path(struct index_state *istate,
+		       char flip, const char *path)
 {
 	int pos;
 	struct cache_entry *ce;
@@ -437,7 +443,7 @@ static void chmod_path(char flip, const char *path)
 	die("git update-index: cannot chmod %cx '%s'", flip, path);
 }
 
-static void update_one(const char *path)
+static void update_one(struct index_state *istate, const char *path)
 {
 	int stat_errno = 0;
 	struct stat st;
@@ -455,17 +461,20 @@ static void update_one(const char *path)
 		return;
 	}
 	if (mark_valid_only) {
-		if (mark_ce_flags(path, CE_VALID, mark_valid_only == MARK_FLAG))
+		if (mark_ce_flags(istate, path, CE_VALID,
+				  mark_valid_only == MARK_FLAG))
 			die("Unable to mark file %s", path);
 		return;
 	}
 	if (mark_skip_worktree_only) {
-		if (mark_ce_flags(path, CE_SKIP_WORKTREE, mark_skip_worktree_only == MARK_FLAG))
+		if (mark_ce_flags(istate, path, CE_SKIP_WORKTREE,
+				  mark_skip_worktree_only == MARK_FLAG))
 			die("Unable to mark file %s", path);
 		return;
 	}
 	if (mark_fsmonitor_only) {
-		if (mark_ce_flags(path, CE_FSMONITOR_VALID, mark_fsmonitor_only == MARK_FLAG))
+		if (mark_ce_flags(istate, path, CE_FSMONITOR_VALID,
+				  mark_fsmonitor_only == MARK_FLAG))
 			die("Unable to mark file %s", path);
 		return;
 	}
@@ -476,12 +485,12 @@ static void update_one(const char *path)
 		report("remove '%s'", path);
 		return;
 	}
-	if (process_path(path, &st, stat_errno))
+	if (process_path(istate, path, &st, stat_errno))
 		die("Unable to process path %s", path);
 	report("add '%s'", path);
 }
 
-static void read_index_info(int nul_term_line)
+static void read_index_info(struct index_state *istate, int nul_term_line)
 {
 	const int hexsz = the_hash_algo->hexsz;
 	struct strbuf buf = STRBUF_INIT;
@@ -564,7 +573,7 @@ static void read_index_info(int nul_term_line)
 			 * ptr[-41] is at the beginning of sha1
 			 */
 			ptr[-(hexsz + 2)] = ptr[-1] = 0;
-			if (add_cacheinfo(mode, &oid, path_name, stage))
+			if (add_cacheinfo(istate, mode, &oid, path_name, stage))
 				die("git update-index: unable to update %s",
 				    path_name);
 		}
@@ -758,7 +767,7 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		save_nr = repo->index->cache_nr;
 		path = xstrdup(ce->name);
-		update_one(path);
+		update_one(repo->index, path);
 		free(path);
 		discard_cache_entry(old);
 		if (save_nr != repo->index->cache_nr)
@@ -854,7 +863,7 @@ static enum parse_opt_result cacheinfo_callback(
 	BUG_ON_OPT_ARG(arg);
 
 	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, &oid, &path)) {
-		if (add_cacheinfo(mode, &oid, path, 0))
+		if (add_cacheinfo(repo->index, mode, &oid, path, 0))
 			die("git update-index: --cacheinfo cannot add %s", path);
 		ctx->argv++;
 		ctx->argc--;
@@ -864,7 +873,7 @@ static enum parse_opt_result cacheinfo_callback(
 		return error("option 'cacheinfo' expects <mode>,<sha1>,<path>");
 	if (strtoul_ui(*++ctx->argv, 8, &mode) ||
 	    get_oid_hex(*++ctx->argv, &oid) ||
-	    add_cacheinfo(mode, &oid, *++ctx->argv, 0))
+	    add_cacheinfo(repo->index, mode, &oid, *++ctx->argv, 0))
 		die("git update-index: --cacheinfo cannot add %s", *ctx->argv);
 	ctx->argc -= 3;
 	return 0;
@@ -882,7 +891,7 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
 	allow_add = allow_replace = allow_remove = 1;
-	read_index_info(*nul_term_line);
+	read_index_info(repo->index, *nul_term_line);
 	return 0;
 }
 
@@ -1079,7 +1088,6 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (entries < 0)
 		die("cache corrupted");
 
-	istate = repo->index;
 	repo->index->updated_skipworktree = 1;
 
 	/*
@@ -1108,9 +1116,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
-			update_one(p);
+			update_one(repo->index, p);
 			if (set_executable_bit)
-				chmod_path(set_executable_bit, p);
+				chmod_path(repo->index, set_executable_bit, p);
 			free(p);
 			ctx.argc--;
 			ctx.argv++;
@@ -1153,9 +1161,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				strbuf_swap(&buf, &unquoted);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
-			update_one(p);
+			update_one(repo->index, p);
 			if (set_executable_bit)
-				chmod_path(set_executable_bit, p);
+				chmod_path(repo->index, set_executable_bit, p);
 			free(p);
 		}
 		strbuf_release(&unquoted);
-- 
gitgitgadget

