Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12FEC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEC86190A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhEKSfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEKSfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:35:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B2C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 4-20020a05600c26c4b0290146e1feccd8so1762953wmv.1
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2qYo1MGJF1dUqkWZBS2ODIBkbWMEa+jO4Gr7FJ3cZJ4=;
        b=dvuVYGvxf6RtNWkwFSS3SRk5jAi6Pm07JrJsRo8XGhochK+GzUJqNQ0AR2MT16SAu8
         AdUBvHOXn+OWEK4aYzhTH7OVcSiXh6jErTn20yTOD+uUOM90qfMOC/IifUwRZL5GWXqc
         Ji2PuzE37P3kwsFnaboJsvofI/G6UnWKkQUFnuVbao7JdSfESuJj/W6fgjuwhgzv9VFt
         l55pVy2EW5wgsrgNx33KLCLidCJCKeZpPteqrgww+MbwBYXey2okuxA0SQXOdMWwM5+k
         VM6tmHWIpTcTOpCOBeM3wugHoQkmVWdJFm4eNR/s80akMyKsqXaCaZYvt/L6ufJfm3FQ
         YZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2qYo1MGJF1dUqkWZBS2ODIBkbWMEa+jO4Gr7FJ3cZJ4=;
        b=fQ1TBrW1Hgpkh8IrnaEKbTelT1aC1Mlfe82E29zwfr3tp/GaTh/gnhgCtmmj9DDy9X
         pgLQ4gB/eBaUWc1O67nO0gUcvGgJioSA0AJm//BI/dhjmYZiztuX1Yr6f8Jly+6yzmzi
         GZvvoG5fe6wyB/+BMHZrUzaw6bVm5nXqsg1JJDdWU1kq2txX+QrPxEVk9gXMY8shxsLA
         2Aae2sQsGWLmmkftQNuEUogEw8wI6gEQLpJtIKlGIM65jwIG88CBb/RjSdgZjjwRPn6U
         CXUr7NuNutvV+BXfpNBTi8uBD43hRxijr9X9e+uSZjPDMYU37q9ex743tumP5AxLS2Hm
         6mdg==
X-Gm-Message-State: AOAM5304UdwkfsuuSQ5LXxt4UGVxIOrfXomS7Be7SAOjav4SzXVm6DZL
        68qPvzywqS2okVCO8R2pe2ltxR3yWAo=
X-Google-Smtp-Source: ABdhPJw6iofQQjZh6LveImuC79hEar8ODq339/8+I7lZAnRvqAYldhTAlowMGmwbHJ2sAmJIJLgWzg==
X-Received: by 2002:a05:600c:4642:: with SMTP id n2mr33755747wmo.103.1620758050658;
        Tue, 11 May 2021 11:34:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm14689441wrs.41.2021.05.11.11.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:34:10 -0700 (PDT)
Message-Id: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 May 2021 18:34:00 +0000
Subject: [PATCH v4 0/8] Directory traversal fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset fixes a few directory traversal issues, where fill_directory()
would traverse into directories that it shouldn't and not traverse into
directories that it should (one of which was originally reported on this
list at [1]). And it includes a few cleanups

Changes since v3, includes numerous cleanups suggested by Junio and Jeff
(thanks for the reviews!):

 * Removed the RFC labels, but if folks want a warning instead of a die on
   ls-files -i (see patch 3), let me know
 * Include the path passed to read_directory() in the printed trace2
   statistics
 * Print trace2 statistics before calling trace2_region_leave()
 * Make sure to convert both trace_performance_leave() calls
 * testcase style fixes
 * left a comment that directories-visited:1 referred to the toplevel
   directory
 * fixed up some commit message comments about "exclude" and mentioned yet
   another way it can be confusing.

As noted in previous versions of this series, if folks would prefer ls-files
-i to continue running but print a warning rather than making it an error as
I did in this series, let me know. Also, if anyone has any ideas about a
better place to put the "Some sidenotes" from the sixth commit message
rather than keeping them in a random commit message, that might be helpful
too.

[1] See
https://lore.kernel.org/git/DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com/
or alternatively https://github.com/git-for-windows/git/issues/2732.

Derrick Stolee (1):
  dir: update stale description of treat_directory()

Elijah Newren (7):
  dir: convert trace calls to trace2 equivalents
  dir: report number of visited directories and paths with trace2
  ls-files: error out on -i unless -o or -c are specified
  t7300: add testcase showing unnecessary traversal into ignored
    directory
  t3001, t7300: add testcase showcasing missed directory traversal
  dir: avoid unnecessary traversal into ignored directory
  dir: traverse into untracked directories if they may have ignored
    subfiles

 builtin/ls-files.c                 |   3 +
 dir.c                              | 112 +++++++++++-----
 dir.h                              |   4 +
 t/t1306-xdg-files.sh               |   2 +-
 t/t3001-ls-files-others-exclude.sh |   5 +
 t/t3003-ls-files-exclude.sh        |   4 +-
 t/t7063-status-untracked-cache.sh  | 206 +++++++++++++++++------------
 t/t7300-clean.sh                   |  42 ++++++
 t/t7519-status-fsmonitor.sh        |   8 +-
 9 files changed, 259 insertions(+), 127 deletions(-)


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1020%2Fnewren%2Fdirectory-traversal-fixes-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1020/newren/directory-traversal-fixes-v4
Pull-Request: https://github.com/git/git/pull/1020

Range-diff vs v3:

 1:  9f1c0d78d739 ! 1:  9204e36b7e90 [RFC] dir: convert trace calls to trace2 equivalents
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    [RFC] dir: convert trace calls to trace2 equivalents
     +    dir: convert trace calls to trace2 equivalents
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_st
       }
       
      +static void trace2_read_directory_statistics(struct dir_struct *dir,
     -+					     struct repository *repo)
     ++					     struct repository *repo,
     ++					     const char *path)
      +{
      +	if (!dir->untracked)
      +		return;
     ++	trace2_data_string("read_directory", repo, "path", path);
      +	trace2_data_intmax("read_directory", repo,
      +			   "node-creation", dir->untracked->dir_created);
      +	trace2_data_intmax("read_directory", repo,
     @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_st
      +	trace2_region_enter("dir", "read_directory", istate->repo);
       
       	if (has_symlink_leading_path(path, len)) {
     - 		trace_performance_leave("read directory %.*s", len, path);
     +-		trace_performance_leave("read directory %.*s", len, path);
     ++		trace2_region_leave("dir", "read_directory", istate->repo);
     + 		return dir->nr;
     + 	}
     + 
      @@ dir.c: int read_directory(struct dir_struct *dir, struct index_state *istate,
       	QSORT(dir->entries, dir->nr, cmp_dir_entry);
       	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
       
      -	trace_performance_leave("read directory %.*s", len, path);
     ++	if (trace2_is_enabled()) {
     ++		struct strbuf tmp = STRBUF_INIT;
     ++		strbuf_add(&tmp, path, len);
     ++		trace2_read_directory_statistics(dir, istate->repo, tmp.buf);
     ++		strbuf_release(&tmp);
     ++	}
     ++
      +	trace2_region_leave("dir", "read_directory", istate->repo);
       	if (dir->untracked) {
       		static int force_untracked_cache = -1;
     @@ dir.c: int read_directory(struct dir_struct *dir, struct index_state *istate,
       		}
       	}
      +
     -+	if (trace2_is_enabled())
     -+		trace2_read_directory_statistics(dir, istate->repo);
       	return dir->nr;
       }
       
     @@ t/t7063-status-untracked-cache.sh: iuc () {
       	return $ret
       }
       
     -+get_relevant_traces() {
     ++get_relevant_traces () {
      +	# From the GIT_TRACE2_PERF data of the form
      +	#    $TIME $FILE:$LINE | d0 | main | data | r1 | ? | ? | read_directo | $RELEVANT_STAT
      +	# extract the $RELEVANT_STAT fields.  We don't care about region_enter
      +	# or region_leave, or stats for things outside read_directory.
      +	INPUT_FILE=$1
      +	OUTPUT_FILE=$2
     -+	grep data.*read_directo $INPUT_FILE \
     -+	    | cut -d "|" -f 9 \
     -+	    >$OUTPUT_FILE
     ++	grep data.*read_directo $INPUT_FILE |
     ++	    cut -d "|" -f 9 \
     ++	    >"$OUTPUT_FILE"
      +}
      +
      +
     @@ t/t7063-status-untracked-cache.sh: EOF
      -gitignore invalidation: 1
      -directory invalidation: 0
      -opendir: 4
     -+ ..node-creation:3
     -+ ..gitignore-invalidation:1
     -+ ..directory-invalidation:0
     -+ ..opendir:4
     ++ ....path:
     ++ ....node-creation:3
     ++ ....gitignore-invalidation:1
     ++ ....directory-invalidation:0
     ++ ....opendir:4
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
     @@ t/t7063-status-untracked-cache.sh: test_expect_success 'untracked cache after fi
      -gitignore invalidation: 0
      -directory invalidation: 0
      -opendir: 0
     -+ ..node-creation:0
     -+ ..gitignore-invalidation:0
     -+ ..directory-invalidation:0
     -+ ..opendir:0
     ++ ....path:
     ++ ....node-creation:0
     ++ ....gitignore-invalidation:0
     ++ ....directory-invalidation:0
     ++ ....opendir:0
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
     @@ t/t7063-status-untracked-cache.sh: A  two
      -gitignore invalidation: 0
      -directory invalidation: 1
      -opendir: 1
     -+ ..node-creation:0
     -+ ..gitignore-invalidation:0
     -+ ..directory-invalidation:1
     -+ ..opendir:1
     ++ ....path:
     ++ ....node-creation:0
     ++ ....gitignore-invalidation:0
     ++ ....directory-invalidation:1
     ++ ....opendir:1
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
     @@ t/t7063-status-untracked-cache.sh: A  two
      -gitignore invalidation: 1
      -directory invalidation: 1
      -opendir: 4
     -+ ..node-creation:0
     -+ ..gitignore-invalidation:1
     -+ ..directory-invalidation:1
     -+ ..opendir:4
     ++ ....path:
     ++ ....node-creation:0
     ++ ....gitignore-invalidation:1
     ++ ....directory-invalidation:1
     ++ ....opendir:4
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
     @@ t/t7063-status-untracked-cache.sh: A  two
      -gitignore invalidation: 1
      -directory invalidation: 0
      -opendir: 4
     -+ ..node-creation:0
     -+ ..gitignore-invalidation:1
     -+ ..directory-invalidation:0
     -+ ..opendir:4
     ++ ....path:
     ++ ....node-creation:0
     ++ ....gitignore-invalidation:1
     ++ ....directory-invalidation:0
     ++ ....opendir:4
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
     @@ t/t7063-status-untracked-cache.sh: A  one
      -gitignore invalidation: 0
      -directory invalidation: 0
      -opendir: 1
     -+ ..node-creation:0
     -+ ..gitignore-invalidation:0
     -+ ..directory-invalidation:0
     -+ ..opendir:1
     ++ ....path:
     ++ ....node-creation:0
     ++ ....gitignore-invalidation:0
     ++ ....directory-invalidation:0
     ++ ....opendir:1
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
     @@ t/t7063-status-untracked-cache.sh: A  two
      -gitignore invalidation: 0
      -directory invalidation: 0
      -opendir: 1
     -+ ..node-creation:0
     -+ ..gitignore-invalidation:0
     -+ ..directory-invalidation:0
     -+ ..opendir:1
     ++ ....path:
     ++ ....node-creation:0
     ++ ....gitignore-invalidation:0
     ++ ....directory-invalidation:0
     ++ ....opendir:1
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
     @@ t/t7063-status-untracked-cache.sh: test_expect_success 'status after commit' '
      -gitignore invalidation: 0
      -directory invalidation: 0
      -opendir: 2
     -+ ..node-creation:0
     -+ ..gitignore-invalidation:0
     -+ ..directory-invalidation:0
     -+ ..opendir:2
     ++ ....path:
     ++ ....node-creation:0
     ++ ....gitignore-invalidation:0
     ++ ....directory-invalidation:0
     ++ ....opendir:2
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
     @@ t/t7063-status-untracked-cache.sh: test_expect_success 'test sparse status with
      -gitignore invalidation: 1
      -directory invalidation: 2
      -opendir: 2
     -+ ..node-creation:0
     -+ ..gitignore-invalidation:1
     -+ ..directory-invalidation:2
     -+ ..opendir:2
     ++ ....path:
     ++ ....node-creation:0
     ++ ....gitignore-invalidation:1
     ++ ....directory-invalidation:2
     ++ ....opendir:2
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
     @@ t/t7063-status-untracked-cache.sh: test_expect_success 'test sparse status again
      -gitignore invalidation: 0
      -directory invalidation: 0
      -opendir: 0
     -+ ..node-creation:0
     -+ ..gitignore-invalidation:0
     -+ ..directory-invalidation:0
     -+ ..opendir:0
     ++ ....path:
     ++ ....node-creation:0
     ++ ....gitignore-invalidation:0
     ++ ....directory-invalidation:0
     ++ ....opendir:0
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
     @@ t/t7063-status-untracked-cache.sh: test_expect_success 'test sparse status with
      -gitignore invalidation: 0
      -directory invalidation: 1
      -opendir: 3
     -+ ..node-creation:2
     -+ ..gitignore-invalidation:0
     -+ ..directory-invalidation:1
     -+ ..opendir:3
     ++ ....path:
     ++ ....node-creation:2
     ++ ....gitignore-invalidation:0
     ++ ....directory-invalidation:1
     ++ ....opendir:3
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
     @@ t/t7063-status-untracked-cache.sh: EOF
      -gitignore invalidation: 0
      -directory invalidation: 0
      -opendir: 0
     -+ ..node-creation:0
     -+ ..gitignore-invalidation:0
     -+ ..directory-invalidation:0
     -+ ..opendir:0
     ++ ....path:
     ++ ....node-creation:0
     ++ ....gitignore-invalidation:0
     ++ ....directory-invalidation:0
     ++ ....opendir:0
       EOF
      -	test_cmp ../trace.expect ../trace
      +	test_cmp ../trace.expect ../trace.relevant
 2:  8b511f228af8 ! 2:  6939253be825 [RFC] dir: report number of visited directories and paths with trace2
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    [RFC] dir: report number of visited directories and paths with trace2
     +    dir: report number of visited directories and paths with trace2
      
          Provide more statistics in trace2 output that include the number of
          directories and total paths visited by the directory traversal logic.
     @@ dir.c: static enum path_treatment read_directory_recursive(struct dir_struct *di
       
       		if (state > dir_state)
       			dir_state = state;
     -@@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
     - static void trace2_read_directory_statistics(struct dir_struct *dir,
     - 					     struct repository *repo)
     +@@ dir.c: static void trace2_read_directory_statistics(struct dir_struct *dir,
     + 					     struct repository *repo,
     + 					     const char *path)
       {
      +	trace2_data_intmax("read_directory", repo,
      +			   "directories-visited", dir->visited_directories);
     @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_st
      +			   "paths-visited", dir->visited_paths);
       	if (!dir->untracked)
       		return;
     - 	trace2_data_intmax("read_directory", repo,
     + 	trace2_data_string("read_directory", repo, "path", path);
      @@ dir.c: int read_directory(struct dir_struct *dir, struct index_state *istate,
       	struct untracked_cache_dir *untracked;
       
     @@ dir.c: int read_directory(struct dir_struct *dir, struct index_state *istate,
      +	dir->visited_directories = 0;
       
       	if (has_symlink_leading_path(path, len)) {
     - 		trace_performance_leave("read directory %.*s", len, path);
     + 		trace2_region_leave("dir", "read_directory", istate->repo);
      
       ## dir.h ##
      @@ dir.h: struct dir_struct {
     @@ dir.h: struct dir_struct {
       /*Count the number of slashes for string s*/
      
       ## t/t7063-status-untracked-cache.sh ##
     -@@ t/t7063-status-untracked-cache.sh: get_relevant_traces() {
     +@@ t/t7063-status-untracked-cache.sh: get_relevant_traces () {
       	INPUT_FILE=$1
       	OUTPUT_FILE=$2
     - 	grep data.*read_directo $INPUT_FILE \
     -+	    | grep -v visited \
     - 	    | cut -d "|" -f 9 \
     - 	    >$OUTPUT_FILE
     + 	grep data.*read_directo $INPUT_FILE |
     +-	    cut -d "|" -f 9 \
     ++	    cut -d "|" -f 9 |
     ++	    grep -v visited \
     + 	    >"$OUTPUT_FILE"
       }
     + 
 3:  44a1322c4402 ! 3:  8d0ca8104be6 [RFC] ls-files: error out on -i unless -o or -c are specified
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    [RFC] ls-files: error out on -i unless -o or -c are specified
     +    ls-files: error out on -i unless -o or -c are specified
      
          ls-files --ignored can be used together with either --others or
          --cached.  After being perplexed for a bit and digging in to the code, I
          assumed that ls-files -i was just broken and not printing anything and
     -    had a nice patch ready to submit when I finally realized that -i can be
     +    I had a nice patch ready to submit when I finally realized that -i can be
          used with --cached to find tracked ignores.
      
          While that was a mistake on my part, and a careful reading of the
     @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cm
       		ps_matched = xcalloc(pathspec.nr, 1);
       
      +	if ((dir.flags & DIR_SHOW_IGNORED) && !show_others && !show_cached)
     -+		die("ls-files --ignored is usually used with --others, but --cached is the default.  Please specify which you want.");
     ++		die("ls-files -i must be used with either -o or -c");
      +
       	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
       		die("ls-files --ignored needs some exclude pattern");
 4:  dc3d3f247141 ! 4:  317abab3571e t7300: add testcase showing unnecessary traversal into ignored directory
     @@ t/t7300-clean.sh: test_expect_success 'clean untracked paths by pathspec' '
      +		git clean -ffdxn -e untracked
      +	) &&
      +
     -+	grep data.*read_directo.*visited trace.output \
     -+		| cut -d "|" -f 9 >trace.relevant &&
     ++	# Make sure we only visited into the top-level directory, and did
     ++	# not traverse into the "untracked" subdirectory since it was excluded
     ++	grep data.*read_directo.*directories-visited trace.output |
     ++		cut -d "|" -f 9 >trace.relevant &&
      +	cat >trace.expect <<-EOF &&
     -+	 directories-visited:1
     -+	 paths-visited:4
     ++	 ..directories-visited:1
      +	EOF
      +	test_cmp trace.expect trace.relevant
      +'
 5:  73b03a1e8e05 = 5:  5eb019327b57 t3001, t7300: add testcase showcasing missed directory traversal
 6:  66ffc7f02d08 ! 6:  89cc01ef8598 dir: avoid unnecessary traversal into ignored directory
     @@ Commit message
            since "git ls-files -c -i" is supposed to list them.
      
          * The dir code often uses "ignored" and "excluded" interchangeably,
     -      which you need to keep in mind while reading the code.  Sadly, though,
     -      it can get very confusing since ignore rules can have exclusions, as
     -      in the last of the following .gitignore rules:
     -          .gitignore
     +      which you need to keep in mind while reading the code.
     +
     +    * "exclude" is used multiple ways in the code:
     +
     +      * As noted above, "exclude" is often a synonym for "ignored".
     +
     +      * The logic for parsing .gitignore files was re-used in
     +        .git/info/sparse-checkout, except there it is used to mark paths that
     +        the user wants to *keep*.  This was mostly addressed by commit
     +        65edd96aec ("treewide: rename 'exclude' methods to 'pattern'",
     +        2019-09-03), but every once in a while you'll find a comment about
     +        "exclude" referring to these patterns that might in fact be in use
     +        by the sparse-checkout machinery for inclusion rules.
     +
     +      * The word "EXCLUDE" is also used for pathspec negation, as in
     +          (pathspec->items[3].magic & PATHSPEC_EXCLUDE)
     +        Thus if a user had a .gitignore file containing
                *~
                *.log
                !settings.log
     -      In the last entry above, (pathspec->items[3].magic & PATHSPEC_EXCLUDE)
     -      will be true due the the '!' negating the rule.  Someone might refer
     -      to this as "excluded".  That means the file 'settings.log' will not
     -      match, and thus not be ignored.  So we won't return path_excluded for
     -      it.  So it's an exclude rule that prevents the file from being an
     -      exclude.  The non-excluded rules are the ones that result in files
     -      being excludes.  Great fun, eh?
     +        And then ran
     +          git add -- 'settings.*' ':^settings.log'
     +        Then :^settings.log is a pathspec negation making settings.log not
     +        be requested to be added even though all other settings.* files are
     +        being added.  Also, !settings.log in the gitignore file is a negative
     +        exclude pattern meaning that settings.log is normally a file we
     +        want to track even though all other *.log files are ignored.
      
          Sometimes it feels like dir.c needs its own glossary with its many
          definitions, including the multiply-defined terms.
 7:  acde436b220e = 7:  4a561e1229e4 dir: traverse into untracked directories if they may have ignored subfiles
 8:  57135c357774 = 8:  2945e749f5e3 dir: update stale description of treat_directory()

-- 
gitgitgadget
