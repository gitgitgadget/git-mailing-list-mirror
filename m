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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5AFC433E9
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8596B227BF
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbhAEEoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbhAEEoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:44:30 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EC6C0617A5
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c133so1858128wme.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=grX1ZI10qrCaKi+H6erN9/35HPk41gfsbba08KfVeyI=;
        b=iFZ1iaq+zj7rQdAB2xj/6M9rIz4bZAGETxPKRG86gIKQcpcZkXgtTQC6LtoK3avvS6
         dHtUOxJDpdydRDMJgv/QYhU7rqPwvhYeOAJcpD+XR5G/BVOTdfg1EyeUGEpmRf4fcCPk
         a7LnoDUiDw+lHVIawK8EOPczTRNrRpImpjQYUHpFribGO0wGIf3I3k2IT0ka2eMeLWsc
         irV/eD54bW12XbFCAf7A+E7flgWhlsMCJGQee0y18xKT/+aTUOhIg6dnobMBGTqq6ajl
         vKajgSjtS8Jr1lVZBX+YVp43IABxeztZMpiU0pqth+UT/LQ6Zqyty5BhUmesVPEQ92MI
         NxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=grX1ZI10qrCaKi+H6erN9/35HPk41gfsbba08KfVeyI=;
        b=GjPk0xMSYq2pBJgmKRaKcflJfcAwENg7BInMmhKYYpQU7IjShV8K55SfjOyj9OO627
         2fZ9Q9p1KJonHN58nC/DqoRfh7cLuFiizepHzjO9wcUbjaA2aS26n6bUt9Gma+CAKo7W
         3l1giti5WBGzj0LjxqLTJmWqYuXyIVvKAEImNyhXynnMXZkao3hMVHBJxjAtSYjHRLjm
         OqqEAd5OG3pXK8WKuNcKqly/ukcOZBkz+eOf34DsDCXfL0hCRLQ2k9w4ig940VkF815b
         OiA0/eU8UlO8Il8Wgs56birLI11sd2n4mRoxuT+3vsQeWVf2bv8d4FiSbxrvGomC/FV4
         gK0Q==
X-Gm-Message-State: AOAM532tM62r9sqhbkh5yyPN5oBh1KgUd7Q9izT1FsNVQOoP5nwP9Lun
        ChgezZK35QSrgFeVeY8bXs+lqRZf24U=
X-Google-Smtp-Source: ABdhPJxJzW1miF7zMLEUkra11oyZux26Kdm2Pu3TTJtOr/sMN1YwEPMAotnCXYXE00ztYvY9Z6Ilhg==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr1641855wmg.145.1609821795400;
        Mon, 04 Jan 2021 20:43:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm96346245wrv.97.2021.01.04.20.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:14 -0800 (PST)
Message-Id: <79e267f39ec764e03788ba1ddfe1051156a625fa.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:43:01 +0000
Subject: [PATCH v2 12/14] update-index: reduce static globals, part 1
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

Move these static globals further down in the file so we can identify
which method only need to add a 'struct index_state *istate' parameter.
The only changes included here adjust method prototypes and their call
locations.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 77 ++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 8fc680090be..6b585fb8ede 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -39,9 +39,6 @@ static int ignore_skip_worktree_entries;
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
 
-static struct repository *repo;
-static struct index_state *istate;
-
 /* Untracked cache mode */
 enum uc_mode {
 	UC_UNSPECIFIED = -1,
@@ -229,7 +226,8 @@ static int test_if_untracked_cache_is_supported(void)
 	return ret;
 }
 
-static int mark_ce_flags(const char *path, int flag, int mark)
+static int mark_ce_flags(struct index_state *istate,
+			 const char *path, int flag, int mark)
 {
 	int namelen = strlen(path);
 	int pos = index_name_pos(istate, path, namelen);
@@ -247,7 +245,7 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 	return -1;
 }
 
-static int remove_one_path(const char *path)
+static int remove_one_path(struct index_state *istate, const char *path)
 {
 	if (!allow_remove)
 		return error("%s: does not exist and --remove not passed", path);
@@ -263,14 +261,17 @@ static int remove_one_path(const char *path)
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
@@ -323,7 +324,8 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
  *  - it doesn't exist at all in the index, but it is a valid
  *    git directory, and it should be *added* as a gitlink.
  */
-static int process_directory(const char *path, int len, struct stat *st)
+static int process_directory(struct index_state *istate,
+			     const char *path, int len, struct stat *st)
 {
 	struct object_id oid;
 	int pos = index_name_pos(istate, path, len);
@@ -337,10 +339,10 @@ static int process_directory(const char *path, int len, struct stat *st)
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
@@ -361,13 +363,14 @@ static int process_directory(const char *path, int len, struct stat *st)
 
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
@@ -395,15 +398,16 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
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
@@ -420,7 +424,8 @@ static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 	return 0;
 }
 
-static void chmod_path(char flip, const char *path)
+static void chmod_path(struct index_state *istate,
+		       char flip, const char *path)
 {
 	int pos;
 	struct cache_entry *ce;
@@ -438,7 +443,7 @@ static void chmod_path(char flip, const char *path)
 	die("git update-index: cannot chmod %cx '%s'", flip, path);
 }
 
-static void update_one(const char *path)
+static void update_one(struct index_state *istate, const char *path)
 {
 	int stat_errno = 0;
 	struct stat st;
@@ -456,17 +461,20 @@ static void update_one(const char *path)
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
@@ -477,12 +485,12 @@ static void update_one(const char *path)
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
@@ -565,7 +573,7 @@ static void read_index_info(int nul_term_line)
 			 * ptr[-41] is at the beginning of sha1
 			 */
 			ptr[-(hexsz + 2)] = ptr[-1] = 0;
-			if (add_cacheinfo(mode, &oid, path_name, stage))
+			if (add_cacheinfo(istate, mode, &oid, path_name, stage))
 				die("git update-index: unable to update %s",
 				    path_name);
 		}
@@ -586,6 +594,9 @@ static const char * const update_index_usage[] = {
 static struct object_id head_oid;
 static struct object_id merge_head_oid;
 
+static struct repository *repo;
+static struct index_state *istate;
+
 static struct cache_entry *read_one_ent(const char *which,
 					struct object_id *ent, const char *path,
 					int namelen, int stage)
@@ -758,7 +769,7 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		save_nr = istate->cache_nr;
 		path = xstrdup(ce->name);
-		update_one(path);
+		update_one(istate, path);
 		free(path);
 		discard_cache_entry(old);
 		if (save_nr != istate->cache_nr)
@@ -854,7 +865,7 @@ static enum parse_opt_result cacheinfo_callback(
 	BUG_ON_OPT_ARG(arg);
 
 	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, &oid, &path)) {
-		if (add_cacheinfo(mode, &oid, path, 0))
+		if (add_cacheinfo(istate, mode, &oid, path, 0))
 			die("git update-index: --cacheinfo cannot add %s", path);
 		ctx->argv++;
 		ctx->argc--;
@@ -864,7 +875,7 @@ static enum parse_opt_result cacheinfo_callback(
 		return error("option 'cacheinfo' expects <mode>,<sha1>,<path>");
 	if (strtoul_ui(*++ctx->argv, 8, &mode) ||
 	    get_oid_hex(*++ctx->argv, &oid) ||
-	    add_cacheinfo(mode, &oid, *++ctx->argv, 0))
+	    add_cacheinfo(istate, mode, &oid, *++ctx->argv, 0))
 		die("git update-index: --cacheinfo cannot add %s", *ctx->argv);
 	ctx->argc -= 3;
 	return 0;
@@ -882,7 +893,7 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
 	allow_add = allow_replace = allow_remove = 1;
-	read_index_info(*nul_term_line);
+	read_index_info(istate, *nul_term_line);
 	return 0;
 }
 
@@ -1108,9 +1119,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
-			update_one(p);
+			update_one(istate, p);
 			if (set_executable_bit)
-				chmod_path(set_executable_bit, p);
+				chmod_path(istate, set_executable_bit, p);
 			free(p);
 			ctx.argc--;
 			ctx.argv++;
@@ -1153,9 +1164,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				strbuf_swap(&buf, &unquoted);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
-			update_one(p);
+			update_one(istate, p);
 			if (set_executable_bit)
-				chmod_path(set_executable_bit, p);
+				chmod_path(istate, set_executable_bit, p);
 			free(p);
 		}
 		strbuf_release(&unquoted);
-- 
gitgitgadget

