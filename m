Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75D6C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 05:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiGAFX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 01:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiGAFXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 01:23:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C228E167F3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f190so584171wma.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=84rGk+tpPrHNm2McZSch+ZE6AZpXXt2cSHblgn004xk=;
        b=ccjLXkktQpHI4YnNmkpr+Z1kYhgtdKeHl7uKFXz0w07WVZsLNW1C7eRRiJ1wOZS7GE
         gesXPRIRO/ULlUz8QU2gIOZdR9+j1T87IKzF7J42ArJ4eCcek3kzzWwxEJPN7uDGGgeP
         6XICSs6g/FwG0o/Z/c6H/4gzsNWPCQkpfxVMKeaAWxRxd3bHm27zBqRXUSv2abAk+LZl
         mTXqErruDvZLHpt31Ed+Dw9zeqzezPDoNh1gRF+48fSShbSBSiuoWhhNwnVzubZ6P8bC
         Hk36MkvABW1Xs37vtyDjsepY6T0Y90m9QC+ErbD65NCBSrD2pdrsm1NLkpGThQlzn6A9
         qOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=84rGk+tpPrHNm2McZSch+ZE6AZpXXt2cSHblgn004xk=;
        b=QBZKn4sn3JgaPn/0HO/FBOYZpl1RSJSX49wQGWQj6HiuDq2CVlbnOfxD0/uyzEkG08
         Ycd8kwj6XUBcXzfYWR4Ux4WzQh/CAk5pYtAn2h3HncIcwYYtPvFCVPkAQHhSbYJz1tmb
         LgMeofup5q1kO86D0dGeFr8zzwTi22wm4YNLEiWzVCy71D302clqhGzZsyNFDLTr0DVN
         kptWN29lDMGwcrGZE8lex2MqjTeYpZ+lIf83VDlkhlR2BZVYixZmYfqe2AH8RfCksH6h
         1Mi6LTrZcw4W3KGnpY+EA1rOXR9xhTZSyiulMBrQglw63+CVJZn98c8GrGLfmFNJsrmf
         Ffdg==
X-Gm-Message-State: AJIora/k9+CpDABs2ae8oJe05VDeBeMT5cB0IbeABDAEU1xWaEWXkWQu
        vWj8PrLtftn6LIeu2BUb4EtjG8b12xU=
X-Google-Smtp-Source: AGRyM1uIBshimp5fMn96imFkey7KkfvQHThqQCQ7z6wB0EU1LM4Ra7dvbC4qXYm3QdKzKU0/lxM1eQ==
X-Received: by 2002:a05:600c:354c:b0:39c:7e86:6ff5 with SMTP id i12-20020a05600c354c00b0039c7e866ff5mr15342764wmq.145.1656653002018;
        Thu, 30 Jun 2022 22:23:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5-20020a056000018500b0021bbe0f3c88sm17661656wrx.55.2022.06.30.22.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 22:23:21 -0700 (PDT)
Message-Id: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
References: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jul 2022 05:23:15 +0000
Subject: [PATCH v3 0/5] Fix dual rename into each other plus conflicting adds
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds some testcases based on the tensorflow repository issue
reported by Glen Choo at [1], demonstrating bugs in both the ort and
recursive strategies. It also provides a fix for the ort strategy.

Changes since v2:

 * Added a couple preparatory cleanup patches
 * Added a comment about why sub1/newfile is important to the new testcases
 * A couple other minor code cleanups

Changes since v1:

 * Fixed some wording issues in comments, and added a bit more details to
   one of the commit messages

[1]
https://lore.kernel.org/git/kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com/

Elijah Newren (5):
  t6423: add tests of dual directory rename plus add/add conflict
  merge-ort: small cleanups of check_for_directory_rename
  merge-ort: make a separate function for freeing struct collisions
  merge-ort: shuffle the computation and cleanup of potential collisions
  merge-ort: fix issue with dual rename and add/add conflict

 merge-ort.c                         |  74 +++++++++++++-------
 t/t6423-merge-rename-directories.sh | 105 ++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 26 deletions(-)


base-commit: e54793a95afeea1e10de1e5ad7eab914e7416250
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1268%2Fnewren%2Ffix-dual-rename-into-each-other-plus-conflicting-adds-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1268/newren/fix-dual-rename-into-each-other-plus-conflicting-adds-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1268

Range-diff vs v2:

 1:  bf4c03d01d5 ! 1:  a16a1c4d947 t6423: add tests of dual directory rename plus add/add conflict
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '12k: Directory rename
      +#
      +#   Expected: sub3/{file, newfile, sub2/other}
      +#             CONFLICT (add/add): sub1/sub2/new_add_add_file
     ++#
     ++#   Note that sub1/newfile is not extraneous.  Directory renames are only
     ++#   detected if they are needed, and they are only needed if the old directory
     ++#   had a new file added on the opposite side of history.  So sub1/newfile
     ++#   is needed for there to be a sub1/ -> sub3/ rename.
      +
      +test_setup_12l () {
      +	test_create_repo 12l_$1 &&
      +	(
      +		cd 12l_$1 &&
      +
     -+		mkdir -p sub1 sub2
     ++		mkdir sub1 sub2
      +		echo file >sub1/file &&
      +		echo other >sub2/other &&
      +		git add sub1 sub2 &&
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '12k: Directory rename
      +
      +		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 &&
      +
     -+		git ls-files -s >out &&
     -+		test_line_count = 5 out &&
     ++		test_stdout_line_count = 5 git ls-files -s &&
      +
      +		git rev-parse >actual \
      +			:0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '12k: Directory rename
      +		test_cmp expect actual &&
      +
      +		git ls-files -o >actual &&
     -+		test_write_lines actual expect out >expect &&
     ++		test_write_lines actual expect >expect &&
      +		test_cmp expect actual
      +	)
      +'
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '12k: Directory rename
      +
      +		test_must_fail git -c merge.directoryRenames=true merge -s recursive A^0 &&
      +
     -+		git ls-files -s >out &&
     -+		test_line_count = 5 out &&
     ++		test_stdout_line_count = 5 git ls-files -s &&
      +
      +		git rev-parse >actual \
      +			:0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '12k: Directory rename
      +		test_cmp expect actual &&
      +
      +		git ls-files -o >actual &&
     -+		test_write_lines actual expect out >expect &&
     ++		test_write_lines actual expect >expect &&
      +		test_cmp expect actual
      +	)
      +'
 -:  ----------- > 2:  297fef60b19 merge-ort: small cleanups of check_for_directory_rename
 -:  ----------- > 3:  f5f87acbbd2 merge-ort: make a separate function for freeing struct collisions
 2:  cfa38f01481 ! 4:  d3eac3d0bf6 merge-ort: shuffle the computation and cleanup of potential collisions
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     -@@ merge-ort.c: static void compute_collisions(struct strmap *collisions,
     - 	}
     - }
     - 
     -+static void free_collisions(struct strmap *collisions)
     -+{
     -+	struct hashmap_iter iter;
     -+	struct strmap_entry *entry;
     -+
     -+	/* Free each value in the collisions map */
     -+	strmap_for_each_entry(collisions, &iter, entry) {
     -+		struct collision_info *info = entry->value;
     -+		string_list_clear(&info->source_files, 0);
     -+	}
     -+	/*
     -+	 * In compute_collisions(), we set collisions.strdup_strings to 0
     -+	 * so that we wouldn't have to make another copy of the new_path
     -+	 * allocated by apply_dir_rename().  But now that we've used them
     -+	 * and have no other references to these strings, it is time to
     -+	 * deallocate them.
     -+	 */
     -+	free_strmap_strings(collisions);
     -+	strmap_clear(collisions, 1);
     -+}
     -+
     - static char *check_for_directory_rename(struct merge_options *opt,
     - 					const char *path,
     - 					unsigned side_index,
      @@ merge-ort.c: static char *check_for_directory_rename(struct merge_options *opt,
       	}
       
     @@ merge-ort.c: static int detect_regular_renames(struct merge_options *opt,
       	int i, clean = 1;
      -	struct strmap collisions;
       	struct diff_queue_struct *side_pairs;
     --	struct hashmap_iter iter;
     --	struct strmap_entry *entry;
       	struct rename_info *renames = &opt->priv->renames;
       
       	side_pairs = &renames->pairs[side_index];
     @@ merge-ort.c: static int collect_renames(struct merge_options *opt,
       		result->queue[result->nr++] = p;
       	}
       
     --	/* Free each value in the collisions map */
     --	strmap_for_each_entry(&collisions, &iter, entry) {
     --		struct collision_info *info = entry->value;
     --		string_list_clear(&info->source_files, 0);
     --	}
     --	/*
     --	 * In compute_collisions(), we set collisions.strdup_strings to 0
     --	 * so that we wouldn't have to make another copy of the new_path
     --	 * allocated by apply_dir_rename().  But now that we've used them
     --	 * and have no other references to these strings, it is time to
     --	 * deallocate them.
     --	 */
     --	free_strmap_strings(&collisions);
     --	strmap_clear(&collisions, 1);
     +-	free_collisions(&collisions);
       	return clean;
       }
       
 3:  da3ae38e390 ! 5:  121761e26e2 merge-ort: fix issue with dual rename and add/add conflict
     @@ Commit message
       ## merge-ort.c ##
      @@ merge-ort.c: static char *check_for_directory_rename(struct merge_options *opt,
       	struct strmap_entry *rename_info;
     - 	struct strmap_entry *otherinfo = NULL;
     + 	struct strmap_entry *otherinfo;
       	const char *new_dir;
      +	int other_side = 3 - side_index;
       
     +-	/* Cases where we don't have a directory rename for this path */
      +	/*
      +	 * Cases where we don't have or don't want a directory rename for
     -+	 * this path, so we return NULL.
     ++	 * this path.
      +	 */
       	if (strmap_empty(dir_renames))
     - 		return new_path;
     + 		return NULL;
      +	if (strmap_get(&collisions[other_side], path))
     -+		return new_path;
     ++		return NULL;
       	rename_info = check_dir_renamed(path, dir_renames);
       	if (!rename_info)
     - 		return new_path;
     + 		return NULL;
      
       ## t/t6423-merge-rename-directories.sh ##
      @@ t/t6423-merge-rename-directories.sh: test_setup_12l () {

-- 
gitgitgadget
