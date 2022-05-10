Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39E6C433FE
	for <git@archiver.kernel.org>; Tue, 10 May 2022 17:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbiEJRTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 13:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347851AbiEJRTd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 13:19:33 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D7C2BF318
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:15:34 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id kj8so13045439qvb.6
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzXaXrKUafMS6rHy975rnrfQ8wza3hgYh+/NBZc3+ZI=;
        b=dHdFMdzAN3AM8+CFJjC0JlkE6+IGAhFdU+WfFN6MvJ7pHtCkSDk6HCEQ6oCY3lrmGM
         e8FPFIicz6BtIG/V1jbsizCdamQiRKpAZzkayvrtp2WVaZaZBLGnSKYAIYranzVy/i8w
         7KpRDlWB0WkSvszrVygGgd4BY/Ydp13kEULCtPUdglt09//cho19TPqaMln0jiS8PVAv
         jwZd2fkmGuhyexoTc4doJEzhpIePjqNJJQN1ISFoQGSv1x5tHFxgR4l64yaq3iL4ZjJJ
         0mlgmTLcUR2CyNijx6lO/Av7/u3vGBwJmnVD/Gem5DLW4YydaJFbuBcYSHthj3SicxDX
         E/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzXaXrKUafMS6rHy975rnrfQ8wza3hgYh+/NBZc3+ZI=;
        b=Tng0dONmwwfMpaccvzMRjx98yh7aMC3mthlT2ogZ0QpxerNTUakEnfDvv5/wbChGOP
         ++3r3QgRbmKAih104DD2czkJzCTGS/mmo0BhY56BYhuQBvA+WkUAjq560qC7Bjctj0No
         uHhTNEQFGClngtaE7ZrhHM/7949rQ8lR5nY+i98Ftdb+H2GUkiTpEKXwdMR2ZjRCbHjf
         QnGIBuoKjB64SAeAial0EnSTKIrjopfI2httMhsDOcflEVNNujhB6K9WuoqtkwZmwm71
         7OYO5weDWDe0bQzAluXt48MUKTNlfnAqctc5cDLTyrzCugxjcCr+Eeyz4DFcJD6/8jrL
         R65Q==
X-Gm-Message-State: AOAM530Ado8fc6xSxP9aEwEM5b6u/Gw6BBVqrwUDrHw2HLRskCd1BHht
        JfWgbDY8SfgBHVOFJ8Mbj0sx4vFrrb2LvA==
X-Google-Smtp-Source: ABdhPJxlTncoaERXlN1n4/XkkThKdEQugZou+l4WcOocWZb0pBrzOy5Jx4IZhdWUjB4qyYtSmy6izQ==
X-Received: by 2002:a05:6214:18ea:b0:458:12e7:1d88 with SMTP id ep10-20020a05621418ea00b0045812e71d88mr18810072qvb.38.1652202933532;
        Tue, 10 May 2022 10:15:33 -0700 (PDT)
Received: from localhost.localdomain (pool-100-33-115-203.nycmny.fios.verizon.net. [100.33.115.203])
        by smtp.gmail.com with ESMTPSA id x74-20020a37634d000000b0069ff51425a2sm8963787qkb.120.2022.05.10.10.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:15:32 -0700 (PDT)
From:   Goss Geppert <gg.oss.dev@gmail.com>
X-Google-Original-From: Goss Geppert <ggossdev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 0/2] dir: consider worktree config in path recursion
Date:   Tue, 10 May 2022 17:15:25 +0000
Message-Id: <20220510171527.25778-1-ggossdev@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505203234.21586-1-ggossdev@gmail.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated for requested revisions:
* Split patch between fix and clean-up
* Added a test
* Included my sign-off

It wasn't clear to me where the testcases should be placed--let me know
if a different location is more appropriate.


Goss Geppert (2):
  dir: consider worktree config in path recursion
  dir: minor refactoring / clean-up

 dir.c                          | 38 ++++++++++++---
 t/t2205-add-worktree-config.sh | 89 ++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 7 deletions(-)
 create mode 100755 t/t2205-add-worktree-config.sh

Range-diff against v1:
1:  b9ca67e61d ! 1:  83bf9f40ac dir: consider worktree config in path recursion
    @@ Commit message
     
         Prior to this commit, the `add` operation was silently ignored.
     
    +    Signed-off-by: Goss Geppert <ggossdev@gmail.com>
    +
      ## dir.c ##
     @@ dir.c: static enum path_treatment treat_directory(struct dir_struct *dir,
    - 	 */
    - 	enum path_treatment state;
    - 	int matches_how = 0;
    --	int nested_repo = 0, check_only, stop_early;
    -+	int check_only, stop_early;
    - 	int old_ignored_nr, old_untracked_nr;
    - 	/* The "len-1" is to strip the final '/' */
    - 	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
    -@@ dir.c: static enum path_treatment treat_directory(struct dir_struct *dir,
      
      	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
      		!(dir->flags & DIR_NO_GITLINKS)) {
    @@ dir.c: static enum path_treatment treat_directory(struct dir_struct *dir,
     +		 * 1) we are in a nonbare repository, and
     +		 * 2) `dirname` is not an immediate parent of `the_repository->gitdir`,
     +		 *    which could occur if the `worktree` location was manually
    -+		 *    configured by the user
    ++		 *    configured by the user; see t2205 testcases 1a-1d for examples
    ++		 *    where this matters
     +		 */
    -+		int nested_repo;
      		struct strbuf sb = STRBUF_INIT;
      		strbuf_addstr(&sb, dirname);
      		nested_repo = is_nonbare_repository_dir(&sb);
    @@ dir.c: static enum path_treatment treat_directory(struct dir_struct *dir,
     +			free(real_dirname);
     +		}
      		strbuf_release(&sb);
    --	}
    --	if (nested_repo) {
    --		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
    --		    (matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
    --			return path_none;
    --		return excluded ? path_excluded : path_untracked;
    -+
    -+		if (nested_repo) {
    -+			if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
    -+				(matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
    -+				return path_none;
    -+			return excluded ? path_excluded : path_untracked;
    -+		}
      	}
    - 
    - 	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
    + 	if (nested_repo) {
    +
    + ## t/t2205-add-worktree-config.sh (new) ##
    +@@
    ++#!/bin/sh
    ++
    ++test_description='directory traversal respects worktree config
    ++
    ++This test configures the repository`s worktree to be two levels above the
    ++`.git` directory and checks whether we are able to add to the index those files
    ++that are in either (1) the manually configured worktree directory or (2) the
    ++standard worktree location with respect to the `.git` directory (i.e. ensuring
    ++that the encountered `.git` directory is not treated as belonging to a foreign
    ++nested repository)'
    ++
    ++. ./test-lib.sh
    ++
    ++test_expect_success '1a: setup' '
    ++	test_create_repo test1 &&
    ++	git --git-dir="test1/.git" config core.worktree "$(pwd)" &&
    ++
    ++	mkdir -p outside-tracked outside-untracked &&
    ++	mkdir -p test1/inside-tracked test1/inside-untracked &&
    ++	>file-tracked &&
    ++	>file-untracked &&
    ++	>outside-tracked/file &&
    ++	>outside-untracked/file &&
    ++	>test1/file-tracked &&
    ++	>test1/file-untracked &&
    ++	>test1/inside-tracked/file &&
    ++	>test1/inside-untracked/file &&
    ++
    ++	cat >expect-tracked-unsorted <<-EOF &&
    ++	../file-tracked
    ++	../outside-tracked/file
    ++	file-tracked
    ++	inside-tracked/file
    ++	EOF
    ++
    ++	cat >expect-untracked-unsorted <<-EOF &&
    ++	../file-untracked
    ++	../outside-untracked/file
    ++	file-untracked
    ++	inside-untracked/file
    ++	EOF
    ++
    ++	cat expect-tracked-unsorted expect-untracked-unsorted >expect-all-unsorted &&
    ++
    ++	cat >.gitignore <<-EOF
    ++	.gitignore
    ++	actual-*
    ++	expect-*
    ++	EOF
    ++'
    ++
    ++test_expect_success '1b: pre-add all' '
    ++	local parent_dir="$(pwd)" &&
    ++	(
    ++		cd test1 &&
    ++		git ls-files -o --exclude-standard "$parent_dir" >../actual-all-unsorted
    ++	) &&
    ++	sort actual-all-unsorted >actual-all &&
    ++	sort expect-all-unsorted >expect-all &&
    ++	test_cmp expect-all actual-all
    ++'
    ++
    ++test_expect_success '1c: post-add tracked' '
    ++	local parent_dir="$(pwd)" &&
    ++	(
    ++		cd test1 &&
    ++		git add file-tracked &&
    ++		git add inside-tracked &&
    ++		git add ../outside-tracked &&
    ++		git add "$parent_dir/file-tracked" &&
    ++		git ls-files "$parent_dir" >../actual-tracked-unsorted
    ++	) &&
    ++	sort actual-tracked-unsorted >actual-tracked &&
    ++	sort expect-tracked-unsorted >expect-tracked &&
    ++	test_cmp expect-tracked actual-tracked
    ++'
    ++
    ++test_expect_success '1d: post-add untracked' '
    ++	local parent_dir="$(pwd)" &&
    ++	(
    ++		cd test1 &&
    ++		git ls-files -o --exclude-standard "$parent_dir" >../actual-untracked-unsorted
    ++	) &&
    ++	sort actual-untracked-unsorted >actual-untracked &&
    ++	sort expect-untracked-unsorted >expect-untracked &&
    ++	test_cmp expect-untracked actual-untracked
    ++'
    ++
    ++test_done
-:  ---------- > 2:  0da9804776 dir: minor refactoring / clean-up
-- 
2.36.0

