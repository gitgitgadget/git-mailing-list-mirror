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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453E7C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B45D64FDF
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCIGZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhCIGYt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 01:24:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234FCC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 22:24:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l11so10530347wrp.7
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 22:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fBkAcMHNqqBNmtDJYEo5YD53srHFvM4GpnLdfZD7dd0=;
        b=amBioPSsyRvmueaz+JDxA3TlJsxTKpzvwqX06jLEXmH/Cgqh9wfJlrb3e0YmU5wG78
         lFYXARPg5LERVfLAtbzMEvQi5WJG1ORCgE9po1EUWn8QOh0TNxvhxnE63o2IQNAyaW1M
         H6nldhh76Lu9cvjvLgntqZi2WneGGzlL3vjo1Qe+qvzqezOO9Rodid/JI13Ub+jaMkBe
         94g9i2EGEV0kmyFPSyxsYSuG1iP8fzGpxS9ou75mPZLXb9QO+sOl9gO5kf1xXXF+gv94
         3Kvf1AIpjbfMdJ8w/FfnMsMaFD0EstRydhgaHdR5kJce3NpvFTM4aao81yXwj+nK4ZDS
         6AGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fBkAcMHNqqBNmtDJYEo5YD53srHFvM4GpnLdfZD7dd0=;
        b=jQ1C+6tiJhQvhySTuugp41GUD/hRR+AMbaBvUfcIM2t10oZEN0g+zKrPpQlCLEBDPU
         HKY2QJ6LOEe08f4qxSAP7LodHl7siJDnOmEMsk3QwmGH0RaqL00BNTYTI2/iYui7T5Q7
         nfTByEp5KiIplsR0VjGNoeRZ4G0UDHS2Y3kph4VU/EopHkawIoKkAnjhWneWJtjdaOgE
         YNjt6gzMg7MPO/8/cHo460FDP/BM2xV8w9nS71d3HonF+4vLU0c4Uv9xhHtYn/FpBuKO
         QlQvgKsdFDXcxIyvbNA4P3TfBtxKXTWiTHSqHmlJj55umFoe+QfbzHGSzigKBauIZGOT
         ZI3w==
X-Gm-Message-State: AOAM530V5y0wDfK62YgDbu1myDP3y3CgkFIAiUh28kxJn8112PU1Jxi/
        Dv3JSP6uDqDFGlK+76QkKv/gjYk85VU=
X-Google-Smtp-Source: ABdhPJyz1tA4ruTY+x9XqRDRy+2dILRyvHLT1wNuO5hdjTTyujnMFO4fegiV5JnC3ece++AMdj9t8w==
X-Received: by 2002:adf:ff8c:: with SMTP id j12mr26216785wrr.297.1615271087858;
        Mon, 08 Mar 2021 22:24:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10sm21826421wrl.19.2021.03.08.22.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:24:47 -0800 (PST)
Message-Id: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 06:24:35 +0000
Subject: [PATCH v2 00/10] Complete merge-ort implementation...almost
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series (nearly) completes the merge-ort implementation, cleaning up
testsuite failures. The exceptions are some t6423 failures being addressed
independently[1].

Changes since v1, to address feedback from Ævar:

 * Squashed patches 3 & 4
 * Various style fixes
 * Check attr_index->initialized before calling initialize_attr_index()
   instead of inside initialize_attr_index()
 * Simplify GIT_TEST_MERGE_ALGORITHM comparison to only have if-then block

Stuff not included in v2:

 * Ævar suggested patching the test expectation on the 4 known failing tests
   so that all tests passed under GIT_TEST_MERGE_ALGORITHM=ort. Seems
   reasonable, but the semantic conflicts with other series might make it
   more trouble than it's worth and other series will fix all 4 tests.
   Leaving as-is for now to avoid putting more burden on Junio; see
   https://lore.kernel.org/git/CABPp-BHeR6m4-M=nSX5NZtA2js3E3EVbAyDSMtp3-rN2QnUjqw@mail.gmail.com/
 * Ævar noted a few bigger cleanups to surrounding code that could also be
   done, even if orthogonal to this series. I'll leave those for other
   series to address.

[1] See
https://lore.kernel.org/git/pull.845.git.1614484707.gitgitgadget@gmail.com/
and batch 10 and 12 from
https://github.com/gitgitgadget/git/pulls?q=is%3Apr+author%3Anewren+Optimization+batch

Elijah Newren (10):
  merge-ort: use STABLE_QSORT instead of QSORT where required
  merge-ort: add a special minimal index just for renormalization
  merge-ort: have ll_merge() use a special attr_index for
    renormalization
  merge-ort: let renormalization change modify/delete into clean delete
  merge-ort: support subtree shifting
  t6428: new test for SKIP_WORKTREE handling and conflicts
  merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
  t: mark several submodule merging tests as fixed under merge-ort
  merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
  merge-recursive: add a bunch of FIXME comments documenting known bugs

 branch.c                                      |   1 +
 builtin/rebase.c                              |   1 +
 merge-ort.c                                   | 229 ++++++++++++++++--
 merge-recursive.c                             |  37 +++
 path.c                                        |   1 +
 path.h                                        |   2 +
 sequencer.c                                   |   5 +
 t/t3512-cherry-pick-submodule.sh              |   7 +-
 t/t3513-revert-submodule.sh                   |   5 +-
 t/t5572-pull-submodule.sh                     |   7 +-
 t/t6428-merge-conflicts-sparse.sh             | 158 ++++++++++++
 t/t6437-submodule-merge.sh                    |   5 +-
 t/t6438-submodule-directory-file-conflicts.sh |   7 +-
 13 files changed, 440 insertions(+), 25 deletions(-)
 create mode 100755 t/t6428-merge-conflicts-sparse.sh


base-commit: f01623b2c9d14207e497b21ebc6b3ec4afaf4b46
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-973%2Fnewren%2Fort-remainder-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-973/newren/ort-remainder-v2
Pull-Request: https://github.com/git/git/pull/973

Range-diff vs v1:

  1:  3ca16a5e3466 =  1:  3ca16a5e3466 merge-ort: use STABLE_QSORT instead of QSORT where required
  2:  24454e67b186 =  2:  24454e67b186 merge-ort: add a special minimal index just for renormalization
  3:  815af5d30ebd !  3:  386cb3230b67 merge-ort: add a function for initializing our special attr_index
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    merge-ort: add a function for initializing our special attr_index
     +    merge-ort: have ll_merge() use a special attr_index for renormalization
      
     -    Add a function which can be called to populate the attr_index with the
     -    appropriate .gitattributes contents when necessary.  Make it return
     -    early if the attr_index is already initialized or if we are not
     -    renormalizing files.
     +    ll_merge() needs an index when renormalization is requested.  Create one
     +    specifically for just this purpose with just the one needed entry.  This
     +    fixes t6418.4 and t6418.5 under GIT_TEST_MERGE_ALGORITHM=ort.
      
          NOTE 1: Even if the user has a working copy or a real index (which is
          not a given as merge-ort can be used in bare repositories), we
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     +@@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
     + 	string_list_clear(&opti->paths_to_free, 0);
     + 	opti->paths_to_free.strdup_strings = 0;
     + 
     +-	if (opti->attr_index.cache_nr)
     ++	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
     + 		discard_index(&opti->attr_index);
     + 
     + 	/* Free memory used by various renames maps */
      @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
       	return 0;
       }
       
     -+MAYBE_UNUSED
      +static void initialize_attr_index(struct merge_options *opt)
      +{
      +	/*
     @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
      +	struct index_state *attr_index = &opt->priv->attr_index;
      +	struct cache_entry *ce;
      +
     -+	if (!opt->renormalize)
     -+		return;
     ++	attr_index->initialized = 1;
      +
     -+	if (attr_index->initialized)
     ++	if (!opt->renormalize)
      +		return;
     -+	attr_index->initialized = 1;
      +
      +	mi = strmap_get(&opt->priv->paths, GITATTRIBUTES_FILE);
      +	if (!mi)
     @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
      +		add_index_entry(attr_index, ce,
      +				ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
      +		get_stream_filter(attr_index, GITATTRIBUTES_FILE, &ce->oid);
     -+	}
     -+	else {
     ++	} else {
      +		int stage, len;
      +		struct conflict_info *ci;
      +
      +		ASSIGN_AND_VERIFY_CI(ci, mi);
     -+		for (stage=0; stage<3; ++stage) {
     ++		for (stage = 0; stage < 3; stage++) {
      +			unsigned stage_mask = (1 << stage);
      +
      +			if (!(ci->filemask & stage_mask))
     @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
       static int merge_3way(struct merge_options *opt,
       		      const char *path,
       		      const struct object_id *o,
     +@@ merge-ort.c: static int merge_3way(struct merge_options *opt,
     + 	char *base, *name1, *name2;
     + 	int merge_status;
     + 
     ++	if (!opt->priv->attr_index.initialized)
     ++		initialize_attr_index(opt);
     ++
     + 	ll_opts.renormalize = opt->renormalize;
     + 	ll_opts.extra_marker_size = extra_marker_size;
     + 	ll_opts.xdl_opts = opt->xdl_opts;
     +@@ merge-ort.c: static int merge_3way(struct merge_options *opt,
     + 
     + 	merge_status = ll_merge(result_buf, path, &orig, base,
     + 				&src1, name1, &src2, name2,
     +-				opt->repo->index, &ll_opts);
     ++				&opt->priv->attr_index, &ll_opts);
     + 
     + 	free(base);
     + 	free(name1);
  4:  cb035ac5fe4a <  -:  ------------ merge-ort: have ll_merge() calls use the attr_index for renormalization
  5:  b70ef4d7000a !  4:  7fcabded5016 merge-ort: let renormalization change modify/delete into clean delete
     @@ merge-ort.c: static int string_list_df_name_compare(const char *one, const char
      +	int ret = 0; /* assume changed for safety */
      +	const struct index_state *idx = &opt->priv->attr_index;
      +
     -+	initialize_attr_index(opt);
     ++	if (!idx->initialized)
     ++		initialize_attr_index(opt);
      +
      +	if (base->mode != side->mode)
      +		return 0;
  6:  d04ddabde124 =  5:  e21eea71e707 merge-ort: support subtree shifting
  7:  6ccb24b557fc =  6:  d1d8c017b23f t6428: new test for SKIP_WORKTREE handling and conflicts
  8:  100c0187bdfe =  7:  90a57ade629d merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
  9:  95a6c0abe558 !  8:  fcce88c5ac3d t: mark several submodule merging tests as fixed under merge-ort
     @@ t/t3512-cherry-pick-submodule.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       
      -KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
      -KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
     -+if test "$GIT_TEST_MERGE_ALGORITHM" = ort
     ++if test "$GIT_TEST_MERGE_ALGORITHM" != ort
      +then
     -+	:  # No special additional KNOWN_FAILURE knobs to set
     -+else
      +	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
      +	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
      +fi
     @@ t/t3513-revert-submodule.sh: git_revert () {
       }
       
      -KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
     -+if test "$GIT_TEST_MERGE_ALGORITHM" = ort
     ++if test "$GIT_TEST_MERGE_ALGORITHM" != ort
      +then
     -+	:  # No special additional KNOWN_FAILURE knobs to set
     -+else
      +	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
      +fi
       test_submodule_switch_func "git_revert"
     @@ t/t5572-pull-submodule.sh: git_pull_noff () {
       
      -KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
      -KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
     -+if test "$GIT_TEST_MERGE_ALGORITHM" = ort
     ++if test "$GIT_TEST_MERGE_ALGORITHM" != ort
      +then
     -+	:  # No special additional KNOWN_FAILURE knobs to set
     -+else
      +	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
      +	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
      +fi
     @@ t/t6438-submodule-directory-file-conflicts.sh: test_submodule_switch "merge --ff
       
      -KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
      -KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
     -+if test "$GIT_TEST_MERGE_ALGORITHM" = ort
     ++if test "$GIT_TEST_MERGE_ALGORITHM" != ort
      +then
     -+	:  # No special additional KNOWN_FAILURE knobs to set
     -+else
      +	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
      +	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
      +fi
 10:  d8c6eb39aa7c =  9:  93b241c2f213 merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
 11:  0409118d4ff7 = 10:  a9a95bb0391f merge-recursive: add a bunch of FIXME comments documenting known bugs

-- 
gitgitgadget
