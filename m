Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F027BC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61AB60238
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbhHQNYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240027AbhHQNYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:24:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527C5C0612A5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so1919914wme.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sk95VlD300khf7LCCVrlYCFtK5ZErMI+A55wcXHXMLk=;
        b=c94lXCicJpXPanbvV0gHCvDGTA3VEoVFfc8TA0Gpmr0ohFjbBihHcVMXWOE7QC8/zp
         8qemrQp2wXqhV1OomPsEiPCegSuapFXoSkz9VGGSW5wZvT7i4wcFQweLruGAbPWG9+0h
         Ty3jdjN7VM5YlrorqWRDNYauKymEoVGc+g52XQ9sbMNrNptOzA/z5AakRKW1muAuru5N
         +kXEMMM6FLiH/TphMaRg9UM/ynVNH5A7NmjXdgKR/vxsiXIjw+/4zHDnPrKB+Q86Z+/y
         yr/nNjNP847mLLupHdq0fn4CFACuUZkYN9sq8OsWrdpJaAvWkFBG3ikNxsbRw63jA/7K
         w0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sk95VlD300khf7LCCVrlYCFtK5ZErMI+A55wcXHXMLk=;
        b=dhef6iBNhYH4pL9XUpT3GS1eScuOsNCNMTIwNIg/0q4mNfecgdvh0fC7KHHI1cdMk6
         +Yt1zZ3RtFzFqkaqKeN6zzVtGd4AcucTsiLWfpuiWgymMdtCBdOmmJ+KPOhIfLaO05O8
         Eir5Ygs0qlP+Yi9kgf2ZvBgi6XeCZkKwykYjXiyezoJQuHovV67p4jdxqeq0LsyQX0G+
         0/694tiDsrWrvSRcfze7YCzgF8PbNxd3bOeLPZSpSs289UjI5hMdh7iVWa6rIss9jqmT
         /ZCzEh6O7EUTj4oNuEf066mytjNon7LGe98NhA3r/LWVOXPHeZxCsuQzRycnXuKF9DGq
         Pciw==
X-Gm-Message-State: AOAM533qSOS2JrDBZ1eO77tyJVGe3t8gjz8RZEO7FTM9ztKaVWLD7zl+
        mQWRuV+ecz080QoMfxwoF+reX6smVOM=
X-Google-Smtp-Source: ABdhPJx+4PYYkpU4aWcAhz2gKcWVwHMPf8JA+LwzE1vY4ujI2xY0PFvyBZF6OvnRxRqmRJAi0oajJg==
X-Received: by 2002:a7b:c014:: with SMTP id c20mr3272652wmb.81.1629206604843;
        Tue, 17 Aug 2021 06:23:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm2072811wmc.25.2021.08.17.06.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:23:24 -0700 (PDT)
Message-Id: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:23:14 +0000
Subject: [PATCH v3 0/8] Sparse index: delete ignored files outside sparse cone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UPDATE: I had to base this version on a merge of ds/add-with-sparse-index
and v2.33.0-rc1 because of some changes to dir.h that became important!

We launched an experimental release [1] of the sparse-index feature to our
internal users. We immediately discovered a problem due to the isolated way
in which we tested the sparse index: we were never building the project and
changing our sparse-checkout definition.

[1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.exp

Users who ran a build in one project and then moved to another still had
build artifacts in their worktree that lived inside the old directories.
Since the files are marked by the .gitignore patterns, these files were not
removed by the 'git sparse-checkout set' command. However, they make the
sparse-index unusable because every 'git status' command needs to expand the
sparse-directory entries in order to see if the files are tracked or not.
This made the first experimental release actually slower for all users
because of this cost.

The solution we shipped to these customers was to change the way our fork
handles these ignored files. Specifically, instead of Git completely
ignoring the files, we changed Git to understand that with cone-mode
sparse-checkout patterns, the users is asking for entire directories to be
removed from the worktree. The link [1] included earlier has this change.

I believe that this is a reasonable expectation, though I recognize that it
might look like breaking the expectations of how .gitignore files work.

Since feedback demonstrated that this is a desired behavior, v2 includes
this behavior for all "cone mode" repositories.

I'm interested in the community's thoughts about this change, as it seems
like one that we should make carefully and intentionally.

While the rewrite of the t7519 test seems unrelated, it is required to avoid
a test failure with this change that deletes files outside of the cone. By
moving the test into repositories not at $TRASH_DIRECTORY, we gain more
control over the repository structure.


Update in V3
============

 * As promised [2], the helper methods are fixed to work with non-cone-mode
   patterns. A later series will use them to their fullest potential
   (changing git add, git rm, and git mv when interacting with sparse
   entries).

[2]
https://lore.kernel.org/git/bac76c72-955d-1ade-4ecf-778ffc45f297@gmail.com/


Updates in V2
=============

 * This version correctly leaves untracked files alone. If untracked files
   are found, then the directory is left as-is, in case those ignored files
   are important to the user's work resolving those untracked files.

 * This behavior is now enabled by core.sparseCheckoutCone=true.

 * To use a sparse index as an in-memory data structure even when
   index.sparse is disabled, a new patch is included to modify the prototype
   of convert_to_sparse() to include a flags parameter.

 * A few cleanup patches that I was collecting based on feedback from the
   experimental release and intending for my next series were necessary for
   this implementation.

 * Cleaned up the tests (no NEEDSWORK) and the remainders of a previous
   implementation that used run_subcommand().

Thanks, -Stolee

Derrick Stolee (8):
  t7519: rewrite sparse index test
  sparse-index: silently return when not using cone-mode patterns
  sparse-index: silently return when cache tree fails
  unpack-trees: fix nested sparse-dir search
  sparse-checkout: create helper methods
  attr: be careful about sparse directories
  sparse-index: add SPARSE_INDEX_IGNORE_CONFIG flag
  sparse-checkout: clear tracked sparse dirs

 Documentation/git-sparse-checkout.txt |  8 +++
 attr.c                                | 14 ++++
 builtin/add.c                         |  8 +--
 builtin/sparse-checkout.c             | 95 +++++++++++++++++++++++++++
 dir.c                                 | 33 ++++++++++
 dir.h                                 |  6 ++
 read-cache.c                          |  4 +-
 sparse-index.c                        | 70 +++++++++++---------
 sparse-index.h                        |  3 +-
 t/t1091-sparse-checkout-builtin.sh    | 59 +++++++++++++++++
 t/t7519-status-fsmonitor.sh           | 38 ++++++-----
 unpack-trees.c                        | 18 +++--
 12 files changed, 294 insertions(+), 62 deletions(-)


base-commit: 80b8d6c56b8a5f5db1d5c2a0159fd808e8a7fc4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1009%2Fderrickstolee%2Fsparse-index%2Fignored-files-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1009/derrickstolee/sparse-index/ignored-files-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1009

Range-diff vs v2:

 1:  e66106f7a99 = 1:  e66106f7a99 t7519: rewrite sparse index test
 2:  fb3ff9108bf = 2:  fb3ff9108bf sparse-index: silently return when not using cone-mode patterns
 3:  37198535268 = 3:  37198535268 sparse-index: silently return when cache tree fails
 4:  10bcadb284e = 4:  10bcadb284e unpack-trees: fix nested sparse-dir search
 5:  e9ed5cd2830 ! 5:  5d28570c82a sparse-checkout: create helper methods
     @@ dir.c: done:
       
      +int init_sparse_checkout_patterns(struct index_state *istate)
      +{
     -+	if (istate->sparse_checkout_patterns)
     ++	if (!core_apply_sparse_checkout ||
     ++	    istate->sparse_checkout_patterns)
      +		return 0;
      +
      +	CALLOC_ARRAY(istate->sparse_checkout_patterns, 1);
     @@ dir.c: done:
      +	return 0;
      +}
      +
     -+enum pattern_match_result path_in_sparse_checkout(const char *path,
     -+						  struct index_state *istate)
     ++int path_in_sparse_checkout(const char *path,
     ++			    struct index_state *istate)
      +{
     ++	const char *base;
      +	int dtype = DT_REG;
      +	init_sparse_checkout_patterns(istate);
      +
      +	if (!istate->sparse_checkout_patterns)
      +		return MATCHED;
      +
     -+	return path_matches_pattern_list(path, strlen(path), NULL, &dtype,
     ++	base = strrchr(path, '/');
     ++	return path_matches_pattern_list(path, strlen(path), base ? base + 1 : path,
     ++					 &dtype,
      +					 istate->sparse_checkout_patterns,
     -+					 istate);
     ++					 istate) > 0;
      +}
      +
       static struct path_pattern *last_matching_pattern_from_lists(
     @@ dir.h: enum pattern_match_result path_matches_pattern_list(const char *pathname,
      +
      +int init_sparse_checkout_patterns(struct index_state *state);
      +
     -+enum pattern_match_result path_in_sparse_checkout(const char *path,
     -+						  struct index_state *istate);
     ++int path_in_sparse_checkout(const char *path,
     ++			    struct index_state *istate);
      +
       struct dir_entry *dir_add_ignored(struct dir_struct *dir,
       				  struct index_state *istate,
 6:  5680df62e1c = 6:  c9e100e68f8 attr: be careful about sparse directories
 7:  1dd73b36eb4 = 7:  b0ece4b7dcc sparse-index: add SPARSE_INDEX_IGNORE_CONFIG flag
 8:  f74015a2be9 = 8:  febef675f05 sparse-checkout: clear tracked sparse dirs

-- 
gitgitgadget
