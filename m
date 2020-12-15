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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC11AC2BB9A
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA90322B2D
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgLOS2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbgLOS2u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:28:50 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F55C0617A6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y17so20817691wrr.10
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Usg4UfYeXBurMbbQ3jLxp6ODrcdGCA+WNX7oEdyyrNA=;
        b=GIbodhi7/7f5yQZTZKiI5O0HYDGouNMpxm728i/iW9gWLN7cB1EkLxz3VmVfntoFxB
         7aY4FuwUWLW335C9jfVrTCqWGmYxkJEOjy5jj9Rpn9Y/8RzNTdhwNJjHdYWL961rxLko
         T7AGVWAWyOQgIYmBI6f1EMVZR/McFJlXADRYIISSYx/6L7q4vBptSOGV5lRYtgIdHF8R
         04AkVE34LYJ+Uimgcf/EwaTM2wfgnS2K+hFcwxUHa7TLhCOhmxo86DeJRrVQViQ0Vf/x
         HWQ0tigbpslizC+TtuN3wK9yYFUpRYw0xavpY8XtYDOx463PPi+ngQE1W8yjVSoHFIx7
         vOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Usg4UfYeXBurMbbQ3jLxp6ODrcdGCA+WNX7oEdyyrNA=;
        b=HMQRV0sQnIB18CsV5fdTm6yQf0Sb5JtJKBs96jV1e/zj9JMK3s1RRnHqJpFrxdPaQr
         z+ZsBB+2gEqUGXECpEgcXoj/kcyPC+yvJM5dPlC80qc82oM6RT3bQ8340I2RkNn8tL/x
         Xo+EPBouylNSdfoU1NsbcPUxEQbgnTQadZz6C2lggDxOUrBwrKwlh19Mmfoamug28AI5
         rQT5k6PpMGxAItKDPH0c4X6utrD/bNoM3pKu1Z9afXd4BU4AM1V80PsrSXeasQIIxIys
         rAdKoZGcOHTyk5vph61eaQl1HjnF4I8Doa93RlIx5E33ZQ5qe3nu4G3hz95Eych0YzcQ
         XVYw==
X-Gm-Message-State: AOAM5308h7A07CmisuA/JJR6cJkCLtNMtbhFuLjKGMIW6yvZc29D9ARZ
        MmSC00xkmlsqeTu4mmdo/sWDz87bUMw=
X-Google-Smtp-Source: ABdhPJyaJwYQJZLEwQA5GjnwAL+O03M8wd66hLA+MQl98gdYgggUAcaNwKFQPfTPgt3RggYTTc3yEQ==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr32943925wrt.290.1608056888118;
        Tue, 15 Dec 2020 10:28:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm39833879wri.42.2020.12.15.10.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:28:07 -0800 (PST)
Message-Id: <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:27:55 +0000
Subject: [PATCH v3 00/11] merge-ort: add basic rename detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series builds on en/merge-ort-2 and adds basic rename detection to
merge-ort.

Changes since v2 (all due to feedback from Stolee's reviews):

 * reordered two of the patches (one depended on vars declared in another)
 * a few other adjustments to make patches individually compile (I usually
   check this; so embarrassing that I somehow missed it)

Elijah Newren (11):
  merge-ort: add basic data structures for handling renames
  merge-ort: add initial outline for basic rename detection
  merge-ort: implement detect_regular_renames()
  merge-ort: implement compare_pairs() and collect_renames()
  merge-ort: add basic outline for process_renames()
  merge-ort: add implementation of both sides renaming identically
  merge-ort: add implementation of both sides renaming differently
  merge-ort: add implementation of rename/delete conflicts
  merge-ort: add implementation of rename collisions
  merge-ort: add implementation of normal rename handling
  merge-ort: add implementation of type-changed rename handling

 merge-ort.c | 446 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 430 insertions(+), 16 deletions(-)


base-commit: c5a6f65527aa3b6f5d7cf25437a88d8727ab0646
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-812%2Fnewren%2Fort-renames-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-812/newren/ort-renames-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/812

Range-diff vs v2:

  1:  78621ca0788 =  1:  78621ca0788 merge-ort: add basic data structures for handling renames
  2:  d846decf40b =  2:  d846decf40b merge-ort: add initial outline for basic rename detection
  3:  620fc64032d =  3:  620fc64032d merge-ort: implement detect_regular_renames()
  4:  9382dc4d50b =  4:  9382dc4d50b merge-ort: implement compare_pairs() and collect_renames()
  5:  d20fab8d403 =  5:  d20fab8d403 merge-ort: add basic outline for process_renames()
  6:  15fff3dd0c4 !  6:  7ec51feb418 merge-ort: add implementation of both sides renaming identically
     @@ merge-ort.c: static int process_renames(struct merge_options *opt,
       			const char *pathnames[3];
      +			struct version_info merged;
      +			struct conflict_info *base, *side1, *side2;
     -+			unsigned was_binary_blob = 0;
       
       			pathnames[0] = oldpath;
       			pathnames[1] = newpath;
  7:  d00e26be784 !  7:  d37e2626c30 merge-ort: add implementation of both sides renaming differently
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     +@@ merge-ort.c: static int process_renames(struct merge_options *opt,
     + 			const char *pathnames[3];
     + 			struct version_info merged;
     + 			struct conflict_info *base, *side1, *side2;
     ++			unsigned was_binary_blob = 0;
     + 
     + 			pathnames[0] = oldpath;
     + 			pathnames[1] = newpath;
      @@ merge-ort.c: static int process_renames(struct merge_options *opt,
       			}
       
  9:  f017534243c !  8:  6b79da5e8a4 merge-ort: add implementation of rename/delete conflicts
     @@ merge-ort.c: static int process_renames(struct merge_options *opt,
       		old_ent = strmap_get_entry(&opt->priv->paths, pair->one->path);
       		oldpath = old_ent->key;
      @@ merge-ort.c: static int process_renames(struct merge_options *opt,
     - 		if (type_changed && collision) {
       			/* special handling so later blocks can handle this */
       			die("Not yet implemented");
     + 		}
      +		if (source_deleted) {
      +			if (target_index == 1) {
      +				rename_branch = opt->branch1;
     @@ merge-ort.c: static int process_renames(struct merge_options *opt,
      +				rename_branch = opt->branch2;
      +				delete_branch = opt->branch1;
      +			}
     - 		}
     ++		}
       
       		assert(source_deleted || oldinfo->filemask & old_sidemask);
     + 
      @@ merge-ort.c: static int process_renames(struct merge_options *opt,
     - 				   "to %s in %s, but deleted in %s."),
     - 				 oldpath, newpath, rename_branch, delete_branch);
     + 			/* rename/add/delete or rename/rename(2to1)/delete */
     + 			die("Not yet implemented");
       		} else {
      -			/* a few different cases... */
      +			/*
  8:  edd610321a0 !  9:  065fc0396dc merge-ort: add implementation of rename collisions
     @@ merge-ort.c: static int process_renames(struct merge_options *opt,
      +						     &side1->stages[1],
      +						     &side2->stages[2],
      +						     pathnames,
     -+						     1 + 2*opt->priv->call_depth,
     ++						     1 + 2 * opt->priv->call_depth,
      +						     &merged);
      +
      +			memcpy(&newinfo->stages[target_index], &merged,
     @@ merge-ort.c: static int process_renames(struct merge_options *opt,
      +				   "to %s in %s, but deleted in %s."),
      +				 oldpath, newpath, rename_branch, delete_branch);
       		} else {
     - 			/* a few different cases... */
     - 			if (type_changed) {
     + 			/*
     + 			 * a few different cases...start by copying the
 10:  22cb7110261 = 10:  73426c16687 merge-ort: add implementation of normal rename handling
 11:  ff09ddb9caf ! 11:  8f4662398ab merge-ort: add implementation of type-changed rename handling
     @@ Commit message
      
       ## merge-ort.c ##
      @@ merge-ort.c: static int process_renames(struct merge_options *opt,
     + 			(S_ISREG(oldinfo->stages[other_source_index].mode) !=
       			 S_ISREG(newinfo->stages[target_index].mode));
       		if (type_changed && collision) {
     - 			/* special handling so later blocks can handle this */
     +-			/* special handling so later blocks can handle this */
      -			die("Not yet implemented");
      +			/*
     ++			 * special handling so later blocks can handle this...
     ++			 *
      +			 * if type_changed && collision are both true, then this
      +			 * was really a double rename, but one side wasn't
      +			 * detected due to lack of break detection.  I.e.
     @@ merge-ort.c: static int process_renames(struct merge_options *opt,
      +			 * See also t6430, 'rename vs. rename/symlink'
      +			 */
      +			collision = 0;
     -+		}
     + 		}
       		if (source_deleted) {
       			if (target_index == 1) {
     - 				rename_branch = opt->branch1;
      @@ merge-ort.c: static int process_renames(struct merge_options *opt,
       			newinfo->pathnames[0] = oldpath;
       			if (type_changed) {

-- 
gitgitgadget
