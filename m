Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C454C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219682310C
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbhASTyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbhASTyg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:54:36 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B506C061574
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:53:56 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d26so20914412wrb.12
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PBnHjrMSgB+H7diAhVzOxfKV43NJ7Dwq50tGZtcXtDU=;
        b=XSGIaoGhHOe7ulaPOzEtUajqToIeUdjoR3bSEYrlcJ//NOhmL0yN1d8460MK4w+uoJ
         /W0tp98bl/goKv0dutfn+ZlzFUKRhReN+Jtva2bKazyh++YjMqsh+G9H7IH1M2KQlb5O
         63XsYZ8LXvlR0JF00sP1+BD1xoG+ywOCUpc+e355E4+jW32qvCrOI8tfCBCiA6Wuhbaz
         eu1eiPLMOHOsWLwBPyY2I4V5sEx3RaCKoELhz368y2BJ95qLbkxZ/FUw4yrEErRD/5BP
         Rkilw7EGHlpZBv3bqnif6IyFpNTMjPMmzFEYKGxyT+Hlmp/ocUWHGJB+N3SahoxFej05
         ttkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PBnHjrMSgB+H7diAhVzOxfKV43NJ7Dwq50tGZtcXtDU=;
        b=q3WnGbj9fagUZQHiUKIFYea0GqlOSs0yXqUS6JuHCmTxdDhhAU4X1cnKCr/YskJs+w
         +ZPY/O+X1J7vsfuky4vdAQMQTdKw9JrY4TgwkBsm+YTrCm67mpSEcRZDschDGSdvLahW
         IqnunKTt8vkXgDFrRftC+Ep0a/wjosDGxWiDHya6ijtiKT7CYMa3PSF3hIRR4W8nhEaQ
         waM6f0RTdpgSIVxXH6Oud2r8xIwACBAUKn7kX25UzkBWcRJA3+hpsxB7iAYwyfdiITaX
         3aRWpNw5kYMW9isNHMYOZ73U5v5GeW85UOn3hfcDGu/37/S8YVFuh8+ekUECqrHSwsru
         g6iQ==
X-Gm-Message-State: AOAM533MTOkVKe9KI/sJMV01kUhiX5f0S6uYBqu5ZeVDstmFT28mH7sE
        oJBY3f5KDdCVvorBpxPqtNdBC5Xwl3Y=
X-Google-Smtp-Source: ABdhPJz/Saq6gu6PxmPkZDabWIkBBqzSjhkxrZ8VVhDsTrE4zy6acSRI2kOvjku+VbrcWKYXlin8og==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr5900077wrr.306.1611086034915;
        Tue, 19 Jan 2021 11:53:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6sm40881566wrm.90.2021.01.19.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:53:54 -0800 (PST)
Message-Id: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:36 +0000
Subject: [PATCH v3 00/17] Add directory rename detection to merge-ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on a merge of en/merge-ort-3 (en/merge-ort-recursive has
since merged to master and need not be listed as a dependent series
anymore).

This series mostly implements directory rename detection for merge-ort; ;
I'll cover the "mostly" bit below. If one merges this series with
en/ort-conflict-handling, then this series drops the number of failing tests
in the testsuite under GIT_TEST_MERGE_ALGORITHM=ort from 60 down to 8.

As noted in the earlier submissions, most all the logic is copied from
merge-recursive.c, with numerous but minor modifications due to differences
in data structures. The final patch, however, is new and fixes a known bug
in merge-recursive (showcased by testcase 12f of t6423).

Changes since v2:

 * numerous small fixups highlighted by Taylor in his reviews

Elijah Newren (17):
  merge-ort: add new data structures for directory rename detection
  merge-ort: initialize and free new directory rename data structures
  merge-ort: collect which directories are removed in dirs_removed
  merge-ort: add outline for computing directory renames
  merge-ort: add outline of get_provisional_directory_renames()
  merge-ort: copy get_renamed_dir_portion() from merge-recursive.c
  merge-ort: implement compute_rename_counts()
  merge-ort: implement handle_directory_level_conflicts()
  merge-ort: modify collect_renames() for directory rename handling
  merge-ort: implement compute_collisions()
  merge-ort: implement apply_dir_rename() and check_dir_renamed()
  merge-ort: implement check_for_directory_rename()
  merge-ort: implement handle_path_level_conflicts()
  merge-ort: add a new toplevel_dir field
  merge-ort: implement apply_directory_rename_modifications()
  merge-ort: process_renames() now needs more defensiveness
  merge-ort: fix a directory rename detection bug

 merge-ort.c | 830 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 811 insertions(+), 19 deletions(-)


base-commit: 8f894b22636d5d0cdfca0ae5fd88d327cc3349b3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-835%2Fnewren%2Fort-directory-renames-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-835/newren/ort-directory-renames-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/835

Range-diff vs v2:

  1:  41a99640cc5 =  1:  3b14afd4129 merge-ort: add new data structures for directory rename detection
  2:  762151802be =  2:  9da04816c3b merge-ort: initialize and free new directory rename data structures
  3:  bb4b6d20480 =  3:  3061a6ae69c merge-ort: collect which directories are removed in dirs_removed
  4:  ccb30dfc3c4 !  4:  0dd6e83d2b0 merge-ort: add outline for computing directory renames
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
      +	   opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT);
      +
      +	if (need_dir_renames) {
     -+		for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++)
     -+			get_provisional_directory_renames(opt, s, &clean);
     ++		get_provisional_directory_renames(opt, MERGE_SIDE1, &clean);
     ++		get_provisional_directory_renames(opt, MERGE_SIDE2, &clean);
      +		handle_directory_level_conflicts(opt);
      +	}
      +
  5:  bb4285250cd !  5:  b008ba35712 merge-ort: add outline of get_provisional_directory_renames()
     @@ merge-ort.c: static int handle_content_merge(struct merge_options *opt,
      +			}
      +		}
      +
     -+		if (max == 0)
     -+			continue;
     -+
      +		if (bad_max == max) {
      +			path_msg(opt, source_dir, 0,
      +			       _("CONFLICT (directory rename split): "
     @@ merge-ort.c: static int handle_content_merge(struct merge_options *opt,
      +				 "no destination getting a majority of the "
      +				 "files."),
      +			       source_dir);
     -+			*clean &= 0;
     ++			*clean = 0;
      +		} else {
      +			strmap_put(&renames->dir_renames[side],
      +				   source_dir, (void*)best);
  6:  4e79a96ba1c =  6:  54c18505706 merge-ort: copy get_renamed_dir_portion() from merge-recursive.c
  7:  1e48cde01b9 !  7:  5b5c8368174 merge-ort: implement compute_rename_counts()
     @@ Commit message
          merge-ort: implement compute_rename_counts()
      
          This function is based on the first half of get_directory_renames() from
     -    merge-recursive.c
     +    merge-recursive.c; as part of the implementation, factor out a routine,
     +    increment_count(), to update the bookkeeping to track the number of
     +    items renamed into new directories.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ merge-ort.c: static void get_renamed_dir_portion(const char *old_path, const cha
      +		char *old_dir, *new_dir;
      +		struct diff_filepair *pair = pairs->queue[i];
      +
     ++		/* File not part of directory rename if it wasn't renamed */
      +		if (pair->status != 'R')
      +			continue;
      +
  8:  f6efa4350d6 !  8:  cafff61893a merge-ort: implement handle_directory_level_conflicts()
     @@ Commit message
          This is modelled on the version of handle_directory_level_conflicts()
          from merge-recursive.c, but is massively simplified due to the following
          factors:
     -      * strmap API provides simplifications over using direct hashamp
     +      * strmap API provides simplifications over using direct hashmap
            * we have a dirs_removed field in struct rename_info that we have an
              easy way to populate from collect_merge_info(); this was already
              used in compute_rename_counts() and thus we do not need to check
     @@ merge-ort.c: static void get_provisional_directory_renames(struct merge_options
      +	struct hashmap_iter iter;
      +	struct strmap_entry *entry;
      +	struct string_list duplicated = STRING_LIST_INIT_NODUP;
     -+	struct strmap *side1_dir_renames = &opt->priv->renames.dir_renames[1];
     -+	struct strmap *side2_dir_renames = &opt->priv->renames.dir_renames[2];
     ++	struct rename_info *renames = &opt->priv->renames;
     ++	struct strmap *side1_dir_renames = &renames->dir_renames[MERGE_SIDE1];
     ++	struct strmap *side2_dir_renames = &renames->dir_renames[MERGE_SIDE2];
      +	int i;
      +
      +	strmap_for_each_entry(side1_dir_renames, &iter, entry) {
     @@ merge-ort.c: static void get_provisional_directory_renames(struct merge_options
      +			string_list_append(&duplicated, entry->key);
      +	}
      +
     -+	for (i=0; i<duplicated.nr; ++i) {
     ++	for (i = 0; i < duplicated.nr; i++) {
      +		strmap_remove(side1_dir_renames, duplicated.items[i].string, 0);
      +		strmap_remove(side2_dir_renames, duplicated.items[i].string, 0);
      +	}
  9:  bdd9d6cd702 =  9:  e9e621a0b70 merge-ort: modify collect_renames() for directory rename handling
 10:  9a06c698857 = 10:  28ae21bcb46 merge-ort: implement compute_collisions()
 11:  2ffb93c37ac = 11:  95f6e119072 merge-ort: implement apply_dir_rename() and check_dir_renamed()
 12:  cbfdf4d9ba0 = 12:  ad08c6ece4d merge-ort: implement check_for_directory_rename()
 13:  734891cb315 = 13:  1bece72e37a merge-ort: implement handle_path_level_conflicts()
 14:  4b912f2c025 = 14:  ee1398e3793 merge-ort: add a new toplevel_dir field
 15:  d74417e86c5 = 15:  ef86b7c07e3 merge-ort: implement apply_directory_rename_modifications()
 16:  11e45af831d = 16:  f1c7ce8123f merge-ort: process_renames() now needs more defensiveness
 17:  551878bd84d ! 17:  7c24f9f7aed merge-ort: fix a directory rename detection bug
     @@ merge-ort.c: static void compute_rename_counts(struct diff_queue_struct *pairs,
      -		char *old_dir, *new_dir;
       		struct diff_filepair *pair = pairs->queue[i];
       
     + 		/* File not part of directory rename if it wasn't renamed */
       		if (pair->status != 'R')
       			continue;
       

-- 
gitgitgadget
