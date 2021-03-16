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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7938C4332E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F5E64FB3
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhCPVRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhCPVRV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCAFC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so19637wmc.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BI76sl3lCMYZ2muS08vHRkaeFR9DdCcz1ssru/X4414=;
        b=AyR+VzkFQSSnCtlGUOab0DXkPzSgxax+iJhippJaUDgwMbbTSM4MmZfgpfs4ckPbIx
         DD1KHwg67BF3PC6r0pQqyMN4pkviLhN7owCycrykVU7M5OXuPV3Kwn7ctrfpGBRuipSd
         QAIwqxM/5VxR8zSWzMXgb04qM73r5ttlUZr/JOCBer8OFy+cxgN2KGsltJKhTlAx3/kI
         iMnRSLHrzOK8WEWBW6QoKE+yqYWVQr2G4UYc8mZYwI+XCmazA7BCtz7tNqM7HdSC3Yx0
         EegI7tp1dwbr4M8XKAxWBESlA8c/PB4bsbwIlj9poEwTeZPpCUP4tE6Ql8GPWRL51I3S
         Bn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BI76sl3lCMYZ2muS08vHRkaeFR9DdCcz1ssru/X4414=;
        b=prmg670KpTCHAstgelpbAXVttFm+SCHQRqykqJR2DjsbwpOZ8ft9ocHju42WUbOAqi
         ImeZtsfFkXg66JF/2HaDxAwuPJXngFj17AeqM7Phnlzoz15R3xepzDb1YXB9FzmcObip
         UvSwgqAQ9u0osScEBCCIuSGcDcVjgFaHT1mIsku6pf5nrGhvfs7d1akUAyEVqJT1XUmU
         3A39vAXrrfGDkb7+yQHwfyCqzdAxUDQ0T7yv2gkGCKvviLcxdqYp2X+p0Ik38IG3FEIN
         +mQqbJswJQJl2nBGHANrwPvYL441/qZsgdWookxVHOdSEwBmbkb3M0gRitLJFJHUkw6w
         A5gw==
X-Gm-Message-State: AOAM530ffpS1Do6KbeBf4kxGU6CU2p39e7nAcBcHrC6zfB8oKSBGD0xM
        9d61L2gWF5dRhpJiAQHyRIUluglNVWA=
X-Google-Smtp-Source: ABdhPJwGpfhoUINjOSyNVZOl+GFMiUrDGA8USG5RDcrz863FO+ywnQ02Frr26A1Tf4/puiqMRm+m8A==
X-Received: by 2002:a1c:7ed4:: with SMTP id z203mr622220wmc.89.1615929439854;
        Tue, 16 Mar 2021 14:17:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11sm23298428wrq.74.2021.03.16.14.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:19 -0700 (PDT)
Message-Id: <bbf19f8a2be599a3451469731eed2eada7d3456a.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:51 +0000
Subject: [PATCH 03/27] sparse-index: API protection strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Edit and expand the sparse-index design document with the plan for
guarding index operations with ensure_full_index().

Notably, the plan has changed to not have an expand_to_path() method in
favor of checking for a sparse-directory hit inside of the
index_path_pos() API.

The changes that follow this one will incrementally add
ensure_full_index() guards to iterations over all cache entries. Some
iterations over the cache entries are not protected due to a few
categories listed in the document. Since these are not being modified,
here is a short list of the files and methods that will not receive
these guards:

Looking for non-zero stage:
* builtin/add.c:chmod_pathspec()
* builtin/merge.c:count_unmerged_entries()
* read-cache.c:unmerged_index()
* rerere.c:check_one_conflict(), find_conflict(), rerere_remaining()
* revision.c:prepare_show_merge()
* sequencer.c:append_conflicts_hint()
* wt-status.c:wt_status_collect_changes_initial()

Looking for submodules:
* builtin/submodule--helper.c:module_list_compute()
* submodule.c: several methods
* worktree.c:validate_no_submodules()

Part of the index API:
* name-hash.c: lazy init methods
* preload-index.c:preload_thread(), preload_index()
* read-cache.c: file format methods

Checking for correct order of cache entries:
* read-cache.c:check_ce_order()

Ignores SKIP_WORKTREE entries or already aware:
* unpack-trees.c:mark_new_skip_worktree()
* wt-status.c:wt_status_check_sparse_checkout()

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/sparse-index.txt | 32 +++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/sparse-index.txt b/Documentation/technical/sparse-index.txt
index aa116406a016..7ab51bf6c441 100644
--- a/Documentation/technical/sparse-index.txt
+++ b/Documentation/technical/sparse-index.txt
@@ -82,9 +82,35 @@ also introduce other features that have been considered for improving the
 index, as well.
 
 Next, consumers of the index will be guarded against operating on a
-sparse-index by inserting calls to `ensure_full_index()` or
-`expand_index_to_path()`. After these guards are in place, we can begin
-leaving sparse-directory entries in the in-memory index structure.
+sparse-index by inserting calls to `ensure_full_index()` before iterating
+over all cache entries. If a specific path is requested, then those will
+be protected from within the `index_file_exists()` and `index_name_pos()`
+API calls: they will call `ensure_full_index()` if necessary.
+
+During a scan of the codebase, not every iteration of the cache entries
+needs an `ensure_full_index()` check. The basic reasons include:
+
+1. The loop is scanning for entries with non-zero stage. These entries
+   are not collapsed into a sparse-directory entry.
+
+2. The loop is scanning for submodules. These entries are not collapsed
+   into a sparse-directory entry.
+
+3. The loop is part of the index API, especially around reading or
+   writing the format.
+
+4. The loop is checking for correct order of cache entries and that is
+   correct if and only if the sparse-directory entries are in the correct
+   location.
+
+5. The loop ignores entries with the `SKIP_WORKTREE` bit set, or is
+   otherwise already aware of sparse directory entries.
+
+6. The sparse-index is disabled at this point when using the split-index
+   feature, so no effort is made to protect the split-index API.
+
+After these guards are in place, we can begin leaving sparse-directory
+entries in the in-memory index structure.
 
 Even after inserting these guards, we will keep expanding sparse-indexes
 for most Git commands using the `command_requires_full_index` repository
-- 
gitgitgadget

