Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FB8C4361A
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9EE861434
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbhELRnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347740AbhELR3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:29:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EEDC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i128so13315100wma.5
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QtTPNNGckQgVr/GjWa+OGb/pTPuHaj7pMjP4dUSTgJk=;
        b=G69hUTURei0iWSd0IXqSrm5wuuWbJITR+Xc6GhLbTEZHiWfbQXYc5URl303Gb8W1e1
         ApNf54nQT5CgR0RLX+9YaVjC89pZuLuBmp8A6FA1p0RZKr6SzNHHAetM7j6cUjXG1IVQ
         iNDFJa7OM9woa7Nb+QEXPdzvFdO0DnGm5zLT3RK7O0vgzGX8MdKA9AVwi3w7C+dO5a9z
         iRqwGVyVVwucaSp52v9TlnGfwooSj/r5FCx/kHtkIKenSRS8Tclqe3mx8dfvHrbDe+GZ
         Fs/YGk5Bg9pbZIsJhqbpR3R3OVvpq5wurVyMXy04H+PF2HSFGABHPESpWVQi86BHKFGC
         aguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QtTPNNGckQgVr/GjWa+OGb/pTPuHaj7pMjP4dUSTgJk=;
        b=m3cyQ+e2ipOu37UweiafSQeUQ1teB1MQZvSCqZFPlWTdfhH+lOtAOSVxLw+IeGFrBD
         ETnrT5rc9ximrKXNmuLswnOXUozO75wSVu8zZiFtX83K/xTTXE6jwn85loCnvaVkrL4b
         q9PWZgtk2/knNukuuQr5y4gsJX9nc7xPwI6MZA2Jl3AxJl8CP7bV80Flk4/DO+fDQHg9
         xfx5ZrECJjEHymjNUV3S8tw4t19bU+3cEv7FyU+qvR8wolHr43KyQILz88sF2TlNwp6Y
         bs8HEBdhDLtUYPoXR7zanKEUw4zeF7w1xbfgTUx+ja6NyysJd7/F75PViVDS17g6TOJx
         X7Ag==
X-Gm-Message-State: AOAM531p2Rj0Jbv1LmCOT4g66wSLeRkxFkssh0vcLU8M1G/mJ2eAggyg
        4lyY5R2aaIODXeIaVEWGWchOli2PQGs=
X-Google-Smtp-Source: ABdhPJwX7vAumI2tdk5B+RAx03bF/5NWafckpNMLf0tccTNXuyYjuaDo9nY/rPk2nKoPABnbIjNsng==
X-Received: by 2002:a1c:2097:: with SMTP id g145mr12645017wmg.33.1620840504669;
        Wed, 12 May 2021 10:28:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p20sm1677762wmq.10.2021.05.12.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:28:23 -0700 (PDT)
Message-Id: <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 17:28:13 +0000
Subject: [PATCH v5 0/9] Directory traversal fixes
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

Changes since v4:

 * Tweak the trace2 statistics emitting a bit, as per suggestions from Jeff.
 * Introduce a new readdir_skip_dot_and_dotdot() helper at the end of the
   series, and use it everywhere we repeat the same code to skip '.' and
   '..' entries from readdir. Also use it in dir.c's read_cached_dir() so we
   can be consistent about skipping it, even for statistics, across
   platforms.

If anyone has any ideas about a better place to put the "Some sidenotes"
from the sixth commit message rather than keeping them in a random commit
message, that might be helpful.

[1] See
https://lore.kernel.org/git/DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com/
or alternatively https://github.com/git-for-windows/git/issues/2732.

Derrick Stolee (1):
  dir: update stale description of treat_directory()

Elijah Newren (8):
  dir: convert trace calls to trace2 equivalents
  dir: report number of visited directories and paths with trace2
  ls-files: error out on -i unless -o or -c are specified
  t7300: add testcase showing unnecessary traversal into ignored
    directory
  t3001, t7300: add testcase showcasing missed directory traversal
  dir: avoid unnecessary traversal into ignored directory
  dir: traverse into untracked directories if they may have ignored
    subfiles
  dir: introduce readdir_skip_dot_and_dotdot() helper

 builtin/clean.c                    |   4 +-
 builtin/ls-files.c                 |   3 +
 builtin/worktree.c                 |   4 +-
 diff-no-index.c                    |   5 +-
 dir.c                              | 146 +++++++++++++-------
 dir.h                              |   6 +
 entry.c                            |   5 +-
 notes-merge.c                      |   5 +-
 object-file.c                      |   4 +-
 packfile.c                         |   5 +-
 rerere.c                           |   4 +-
 t/t1306-xdg-files.sh               |   2 +-
 t/t3001-ls-files-others-exclude.sh |   5 +
 t/t3003-ls-files-exclude.sh        |   4 +-
 t/t7063-status-untracked-cache.sh  | 206 +++++++++++++++++------------
 t/t7300-clean.sh                   |  42 ++++++
 t/t7519-status-fsmonitor.sh        |   8 +-
 worktree.c                         |  12 +-
 18 files changed, 298 insertions(+), 172 deletions(-)


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1020%2Fnewren%2Fdirectory-traversal-fixes-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1020/newren/directory-traversal-fixes-v5
Pull-Request: https://github.com/git/git/pull/1020

Range-diff vs v4:

  1:  9204e36b7e90 !  1:  6b1b4820dd20 dir: convert trace calls to trace2 equivalents
     @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_st
       	return root;
       }
       
     -+static void trace2_read_directory_statistics(struct dir_struct *dir,
     -+					     struct repository *repo,
     -+					     const char *path)
     ++static void emit_traversal_statistics(struct dir_struct *dir,
     ++				      struct repository *repo,
     ++				      const char *path,
     ++				      int path_len)
      +{
     ++	if (!trace2_is_enabled())
     ++		return;
     ++
     ++	if (!path_len) {
     ++		trace2_data_string("read_directory", repo, "path", "");
     ++	} else {
     ++		struct strbuf tmp = STRBUF_INIT;
     ++		strbuf_add(&tmp, path, path_len);
     ++		trace2_data_string("read_directory", repo, "path", tmp.buf);
     ++		strbuf_release(&tmp);
     ++	}
     ++
      +	if (!dir->untracked)
      +		return;
     -+	trace2_data_string("read_directory", repo, "path", path);
      +	trace2_data_intmax("read_directory", repo,
      +			   "node-creation", dir->untracked->dir_created);
      +	trace2_data_intmax("read_directory", repo,
     @@ dir.c: int read_directory(struct dir_struct *dir, struct index_state *istate,
       	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
       
      -	trace_performance_leave("read directory %.*s", len, path);
     -+	if (trace2_is_enabled()) {
     -+		struct strbuf tmp = STRBUF_INIT;
     -+		strbuf_add(&tmp, path, len);
     -+		trace2_read_directory_statistics(dir, istate->repo, tmp.buf);
     -+		strbuf_release(&tmp);
     -+	}
     ++	emit_traversal_statistics(dir, istate->repo, path, len);
      +
      +	trace2_region_leave("dir", "read_directory", istate->repo);
       	if (dir->untracked) {
  2:  6939253be825 !  2:  cfe2898b7a7e dir: report number of visited directories and paths with trace2
     @@ dir.c: static enum path_treatment read_directory_recursive(struct dir_struct *di
       
       		if (state > dir_state)
       			dir_state = state;
     -@@ dir.c: static void trace2_read_directory_statistics(struct dir_struct *dir,
     - 					     struct repository *repo,
     - 					     const char *path)
     - {
     +@@ dir.c: static void emit_traversal_statistics(struct dir_struct *dir,
     + 		strbuf_release(&tmp);
     + 	}
     + 
      +	trace2_data_intmax("read_directory", repo,
      +			   "directories-visited", dir->visited_directories);
      +	trace2_data_intmax("read_directory", repo,
      +			   "paths-visited", dir->visited_paths);
     ++
       	if (!dir->untracked)
       		return;
     - 	trace2_data_string("read_directory", repo, "path", path);
     + 	trace2_data_intmax("read_directory", repo,
      @@ dir.c: int read_directory(struct dir_struct *dir, struct index_state *istate,
       	struct untracked_cache_dir *untracked;
       
  3:  8d0ca8104be6 =  3:  279ef30ffbc2 ls-files: error out on -i unless -o or -c are specified
  4:  317abab3571e =  4:  5a8807a1992c t7300: add testcase showing unnecessary traversal into ignored directory
  5:  5eb019327b57 =  5:  b014ccbbaf3e t3001, t7300: add testcase showcasing missed directory traversal
  6:  89cc01ef8598 =  6:  ae1c9e37b21b dir: avoid unnecessary traversal into ignored directory
  7:  4a561e1229e4 =  7:  6fa1e85edf2f dir: traverse into untracked directories if they may have ignored subfiles
  8:  2945e749f5e3 =  8:  179f992edc92 dir: update stale description of treat_directory()
  -:  ------------ >  9:  b7c6176560bd dir: introduce readdir_skip_dot_and_dotdot() helper

-- 
gitgitgadget
