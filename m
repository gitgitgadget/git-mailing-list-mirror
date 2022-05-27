Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3C6C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 10:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiE0KIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 06:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiE0KIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 06:08:16 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15ED1269A9
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 137so3541927pgb.5
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ignwZ4onfsZNln+dp4z93OpZxmkdRdOqh92zpX8t0H0=;
        b=XDljsNRsqHPsSxalhgDDjnc1gYnRBUHtc6xbsLZ81AJmW2Trs37Y/watDUgt/wnCCC
         J9kpMUo9IU7xdQkXvEuK8xJIbU2A55YttcTDnTOZrwNqpj1ZEeD2/Z9N60eU3ZCERTWf
         iOpJfGFeZhqeSb/IL59jmMjZBLDYrgA1slX8SdM2/EucGnY1ANkm9iBAJ56PgbOJzV8M
         Y/Mt4ywJpr1P7czh5pEENrIwWfOMFlAjiAMiNKSIG2n3yRbNXp7RndMSeK/ec5ZzCLm6
         A6OnXzhdOx1HTpqzvDWe5M1OgGU41tQXgYLyoRLrIcMKP3YfIRJVIYGYwzF+k2woALau
         NUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ignwZ4onfsZNln+dp4z93OpZxmkdRdOqh92zpX8t0H0=;
        b=kvHrXQYbRH5SvM2nZYOZk+AdN/2InmloXUnBWPSb9NCefMbnMT3anA0ZKUG1k08Zio
         Q2uA+3RV5Qay4/d89Y5RPJcGPVeLDp8X5gCPT5ixixXy3en0Y96k2Nz9zZJRBiW/9+D5
         kdvsGKscn8yQNGD5Dn8F1PzgiSGb5svJ4ANsKB8wbEFfoNWHgf3Cxqw+HZU8KlpA5UcS
         gOK2Jc8a5zE9yVodAV1FDGAHasRXRxd5mipLzUXOdv1SPEi4/dOdkwzlaMI5gJqSP1DX
         R9OwRevZLgCzDfof2NpoHlcVn7Q2TXKQphzJ9F8qH+xLNLYt0JwBkWiGvWMB9DJPK/x5
         wbHg==
X-Gm-Message-State: AOAM5303LYyt0oyJPqGtht+cOeyrAaT8mX7tqvbEZqP1PZbc4E6neGdT
        AxN1XmbVRlO3jbgD0FmbEqhL7FFmr8hzrA==
X-Google-Smtp-Source: ABdhPJzbXki8hMgxzXQyWxuyf63HUR2CU4pfuo3+dpxTaABAfL0NvlY3JfL2LlJD6lDh/+SD/4hxNg==
X-Received: by 2002:aa7:8149:0:b0:518:f2e:220d with SMTP id d9-20020aa78149000000b005180f2e220dmr42932716pfn.65.1653646093705;
        Fri, 27 May 2022 03:08:13 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.142.42])
        by smtp.gmail.com with ESMTPSA id p26-20020a056a0026da00b005184640c939sm2994262pfw.207.2022.05.27.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:08:13 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        newren@gmail.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [WIP v2 0/5] mv: fix out-of-cone file/directory move logic
Date:   Fri, 27 May 2022 18:07:59 +0800
Message-Id: <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

## Changes since WIP v1 ##

1. Move t7002 tests to the front and turn corresponding tests to 
   test_expect_success along with corresponding commits.

2. Add two tests to t7002.

3. Update check_dir_in_index() and added corresponding documentation.

4. Turn update_mode into enum flags.

5. Use update_sparsity() to replace advise*() function after touching
   sparse contents (this change is INCOMPLETE, NEED FIX).

6. Fix some format issues.

## Limitations ##

This series has not considered moving file from in-cone area to out-of-cone
area *yet*. Moving from in-cone to out-of-cone has not been covered/tested. The
plan is to add the "in-cone to out-of-cone" functionality later, since this 
series is WIP for now.

Shaoxuan Yuan (5):
  t7002: add tests for moving out-of-cone file/directory
  mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
  mv: check if <destination> exists in index to handle overwriting
  mv: add check_dir_in_index() and solve general dir check issue
  mv: use update_sparsity() after touching sparse contents

 builtin/mv.c                  | 104 +++++++++++++++++++++++++++++--
 t/t7002-mv-sparse-checkout.sh | 114 ++++++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+), 6 deletions(-)

Range-diff against v1:
4:  1dd2fcb234 ! 1:  485d1e9102 t7002: add tests for moving out-of-cone file/directory
    @@ Commit message
         * 'can move out-of-cone directory with --sparse'
         * 'refuse to move out-of-cone file without --sparse'
         * 'can move out-of-cone file with --sparse'
    +    * 'refuse to move sparse file to existing destination'
    +    * 'move sparse file to existing destination with --force and --sparse'
     
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
      	test_cmp expect stderr
      '
      
    -+test_expect_success 'refuse to move out-of-cone directory without --sparse' '
    ++test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
     +	git sparse-checkout disable &&
     +	git reset --hard &&
     +	mkdir folder1 &&
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
     +	test_cmp expect stderr
     +'
     +
    -+test_expect_success 'can move out-of-cone directory with --sparse' '
    ++test_expect_failure 'can move out-of-cone directory with --sparse' '
     +	git sparse-checkout disable &&
     +	git reset --hard &&
     +	mkdir folder1 &&
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
     +
     +	git mv --sparse folder1 sub 1>actual 2>stderr &&
     +	test_must_be_empty stderr &&
    -+	echo "Please use \"git sparse-checkout reapply\" to reapply the sparsity."\
    -+	>expect &&
    -+	test_cmp actual expect &&
     +
     +	git sparse-checkout reapply &&
     +	test_path_is_dir sub/folder1 &&
     +	test_path_is_file sub/folder1/file1
     +'
     +
    -+test_expect_success 'refuse to move out-of-cone file without --sparse' '
    ++test_expect_failure 'refuse to move out-of-cone file without --sparse' '
     +	git sparse-checkout disable &&
     +	git reset --hard &&
     +	mkdir folder1 &&
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
     +	test_cmp expect stderr
     +'
     +
    -+test_expect_success 'can move out-of-cone file with --sparse' '
    ++test_expect_failure 'can move out-of-cone file with --sparse' '
     +	git sparse-checkout disable &&
     +	git reset --hard &&
     +	mkdir folder1 &&
    @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-s
     +
     +	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
     +	test_must_be_empty stderr &&
    -+	echo "Please use \"git sparse-checkout reapply\" to reapply the sparsity."\
    -+	>expect &&
    -+	test_cmp actual expect &&
     +
     +	git sparse-checkout reapply &&
     +	! test_path_is_dir sub/folder1 &&
     +	test_path_is_file sub/file1
     +'
    ++
    ++test_expect_failure 'refuse to move sparse file to existing destination' '
    ++	git sparse-checkout disable &&
    ++	git reset --hard &&
    ++	mkdir folder1 &&
    ++	touch folder1/file1 &&
    ++	touch sub/file1 &&
    ++	git add folder1 sub/file1 &&
    ++	git sparse-checkout init --cone &&
    ++	git sparse-checkout set sub &&
    ++
    ++	test_must_fail git mv --sparse folder1/file1 sub 2>stderr &&
    ++	echo "fatal: destination exists, source=folder1/file1, destination=sub/file1" >expect &&
    ++	test_cmp expect stderr
    ++'
    ++
    ++test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
    ++	git sparse-checkout disable &&
    ++	git reset --hard &&
    ++	mkdir folder1 &&
    ++	touch folder1/file1 &&
    ++	touch sub/file1 &&
    ++	echo "overwrite" >folder1/file1 &&
    ++	git add folder1 sub/file1 &&
    ++	git sparse-checkout init --cone &&
    ++	git sparse-checkout set sub &&
    ++
    ++	git mv --sparse --force folder1/file1 sub 2>stderr &&
    ++	test_must_be_empty stderr &&
    ++	echo "overwrite" >expect &&
    ++	test_cmp expect sub/file1
    ++'
     +
      test_done
1:  5cf6b860e3 ! 2:  c99df4fc1a mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      				bad = _("bad source");
      		} else if (!strncmp(src, dst, length) &&
      				(dst[length] == 0 || dst[length] == '/')) {
    +
    + ## t/t7002-mv-sparse-checkout.sh ##
    +@@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'can move out-of-cone directory with --sparse' '
    + 	test_path_is_file sub/folder1/file1
    + '
    + 
    +-test_expect_failure 'refuse to move out-of-cone file without --sparse' '
    ++test_expect_success 'refuse to move out-of-cone file without --sparse' '
    + 	git sparse-checkout disable &&
    + 	git reset --hard &&
    + 	mkdir folder1 &&
    +@@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'refuse to move out-of-cone file without --sparse' '
    + 	test_cmp expect stderr
    + '
    + 
    +-test_expect_failure 'can move out-of-cone file with --sparse' '
    ++test_expect_success 'can move out-of-cone file with --sparse' '
    + 	git sparse-checkout disable &&
    + 	git reset --hard &&
    + 	mkdir folder1 &&
-:  ---------- > 3:  8f1193188b mv: check if <destination> exists in index to handle overwriting
2:  7b3c931f3f ! 4:  e195bfbc73 mv: add check_dir_in_index() and solve general dir check issue
    @@ Commit message
         errors out with "bad source".
     
         Add a helper check_dir_in_index() function to see if a directory
    -    name exists in the index. Also add a SPARSE_DIRECTORY bit to mark
    +    name exists in the index. Also add a SKIP_WORKTREE_DIR bit to mark
         such directories.
     
         Change the checking logic, so that such <source> directory makes
    @@ Commit message
         instead of "bad source"; also user now can supply a "--sparse" flag so
         this operation can be carried out successfully.
     
    +    Also, as suggested by Derrick [1],
    +    move the in-line definition of "enum update_mode" to the top
    +    of the file and make it use "flags" mode (each state is a different
    +    bit in the word).
    +
    +    [1] https://lore.kernel.org/git/22aadea2-9330-aa9e-7b6a-834585189144@github.com/
    +
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/mv.c ##
    +@@ builtin/mv.c: static const char * const builtin_mv_usage[] = {
    + 	NULL
    + };
    + 
    ++enum update_mode {
    ++	BOTH = 0,
    ++	WORKING_DIRECTORY = (1 << 1),
    ++	INDEX = (1 << 2),
    ++	SPARSE = (1 << 3),
    ++	SKIP_WORKTREE_DIR = (1 << 4),
    ++};
    ++
    + #define DUP_BASENAME 1
    + #define KEEP_TRAILING_SLASH 2
    + 
     @@ builtin/mv.c: static int index_range_of_same_dir(const char *src, int length,
      	return last - first;
      }
      
    -+static int check_dir_in_index(const char *dir)
    ++/*
    ++ * Check if an out-of-cone directory should be in the index. Imagine this case
    ++ * that all the files under a directory are marked with 'CE_SKIP_WORKTREE' bit
    ++ * and thus the directory is sparsified.
    ++ *
    ++ * Return 0 if such directory exist (i.e. with any of its contained files not
    ++ * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
    ++ * Return 1 otherwise.
    ++ */
    ++static int check_dir_in_index(const char *name, int namelen)
     +{
    -+	int ret = 0;
    -+	int length = sizeof(dir) + 1;
    -+	char *substr = malloc(length);
    ++	int ret = 1;
    ++	const char *with_slash = add_slash(name);
    ++	int length = namelen + 1;
     +
    -+	for (int i = 0; i < the_index.cache_nr; i++) {
    -+		memcpy(substr, the_index.cache[i]->name, length);
    -+		memset(substr + length - 1, 0, 1);
    ++	int pos = cache_name_pos(with_slash, length);
    ++	const struct cache_entry *ce;
     +
    -+		if (strcmp(dir, substr) == 0) {
    -+			ret = 1;
    ++	if (pos < 0) {
    ++		pos = -pos - 1;
    ++		if (pos >= the_index.cache_nr)
     +			return ret;
    -+		}
    ++		ce = active_cache[pos];
    ++		if (strncmp(with_slash, ce->name, length))
    ++			return ret;
    ++		if (ce_skip_worktree(ce))
    ++			return ret = 0;
     +	}
    -+	free(substr);
     +	return ret;
     +}
     +
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      	};
      	const char **source, **destination, **dest_path, **submodule_gitfile;
     -	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
    -+	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE,
    -+	SPARSE_DIRECTORY } *modes;
    ++	enum update_mode *modes;
      	struct stat st;
      	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
      	struct lock_file lock_file = LOCK_INIT;
     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
    - 			 */
    + 		if (lstat(src, &st) < 0) {
      
      			int pos = cache_name_pos(src, length);
     +			const char *src_w_slash = add_slash(src);
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      				else
      					bad = _("bad source");
      			}
    -+			else if (check_dir_in_index(src_w_slash) &&
    -+			!path_in_sparse_checkout(src_w_slash, &the_index)) {
    -+				modes[i] = SPARSE_DIRECTORY;
    ++			else if (!check_dir_in_index(src, length) &&
    ++					 !path_in_sparse_checkout(src_w_slash, &the_index)) {
    ++				modes[i] = SKIP_WORKTREE_DIR;
     +				goto dir_check;
     +			}
      			/* only error if existence is expected. */
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      
     -				modes[i] = WORKING_DIRECTORY;
     +				if (!modes[i])
    -+					modes[i] = WORKING_DIRECTORY;
    ++					modes[i] |= WORKING_DIRECTORY;
      				n = argc + last - first;
      				REALLOC_ARRAY(source, n);
      				REALLOC_ARRAY(destination, n);
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      		if (show_only)
      			continue;
     -		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
    -+		if (mode != INDEX && mode != SPARSE && mode != SPARSE_DIRECTORY &&
    -+		 rename(src, dst) < 0) {
    ++		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
    ++		 	rename(src, dst) < 0) {
      			if (ignore_errors)
      				continue;
      			die_errno(_("renaming '%s' failed"), src);
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      		}
      
     -		if (mode == WORKING_DIRECTORY)
    -+		if (mode == WORKING_DIRECTORY || mode == SPARSE_DIRECTORY)
    ++		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
      			continue;
      
      		pos = cache_name_pos(src, strlen(src));
    +
    + ## t/t7002-mv-sparse-checkout.sh ##
    +@@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
    + 	test_cmp expect stderr
    + '
    + 
    +-test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
    ++test_expect_success 'refuse to move out-of-cone directory without --sparse' '
    + 	git sparse-checkout disable &&
    + 	git reset --hard &&
    + 	mkdir folder1 &&
    +@@ t/t7002-mv-sparse-checkout.sh: test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
    + 	test_cmp expect stderr
    + '
    + 
    +-test_expect_failure 'can move out-of-cone directory with --sparse' '
    ++test_expect_success 'can move out-of-cone directory with --sparse' '
    + 	git sparse-checkout disable &&
    + 	git reset --hard &&
    + 	mkdir folder1 &&
3:  4be4c4f34d < -:  ---------- mv: add advise_to_reapply hint for moving file into cone
-:  ---------- > 5:  aa82ba56b0 mv: use update_sparsity() after touching sparse contents
-- 
2.35.1

