Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ACDC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC6260238
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbhDLVIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbhDLVIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5729DC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u20so3045791wmj.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EEiLnZcxBnalSrtS0KgvDP7CGUo9RluvCjn0alofKlM=;
        b=DEv4MpHDAXi4Z9lSP0rZV50luh+cl1axctVF2OEN/bdmJbNB+Ouiu1VYD3t7mfg7CZ
         cSW3KNVRm1H01IjN9od+weO1HPWgwMc1U52nyRUWEcAyqG0biDkySb5kzoIoWdjVL/Ea
         snqJ2Te1Zv4I5DHlFHZ80x2k+nn6HX4PJC892eFrfwCrMycJNpfbQHEtvyU/6gIYzaXf
         Kfr6jWIeKcxp9MhewdcjcWD9o+PgiqP5xQqXMZt+CIBi7ByT5BG0c4fz/1njI8AjHs/q
         6AwKATxSHNj00DR4rK2roiwOxkfzZtZXhwmw+EUe8MzuLiQXPPjcmyt51F21yZzZtF2M
         j7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EEiLnZcxBnalSrtS0KgvDP7CGUo9RluvCjn0alofKlM=;
        b=dNQgahukUKQiap9ceQ/mjBqra2OplZkub2cfAmz8Bw+hw/66/3Zr2J9KFnph9exBEz
         7AL0qTPI7FrHsFPL212cvmkpPvnvwKipwheYOxZi0Zt9FwPS9o/2Kc349E/ke+NWnTf9
         rggAkuS9Ia3NkNcieCt5kwshyC7Zp73OZTNny5oWp4el8Yb80Bai3u3vA9bEMWl4uGwQ
         Vdlx0J2Xx258BT40AFFI0ra15smUYBo+Js2bMwepstyFTowReQmvEsMtB0NsaKHrdyO7
         KTOrGs6Axefs5GwzJB1lgfmOXDH/WudKKFrYiS2ZaAnSVgSHAmtsgqNiJCA1hg5cPG2B
         qZzA==
X-Gm-Message-State: AOAM530r3yKA2yLVMzdUbjjMwpaGuTHeiqMELMP1kW/yW96f29e2h5Ba
        QM7no+yPj6ySj7VTJGb3koQ8zI6+gsA=
X-Google-Smtp-Source: ABdhPJz8xWQSCYbD39XPvS3coQOrqSwdQK/RUsMJSCIsd26k2MEnL6JkpX2PUu11s628/ayC8F+0Ew==
X-Received: by 2002:a1c:4e0b:: with SMTP id g11mr866031wmh.149.1618261699983;
        Mon, 12 Apr 2021 14:08:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm18642133wrt.22.2021.04.12.14.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:19 -0700 (PDT)
Message-Id: <4731f610ba6e70a271126e513f8df46d4e0cc5c6.1618261697.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:07:52 +0000
Subject: [PATCH v3 01/26] sparse-index: API protection strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
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
* merge-ort.c:record_conflicted_index_entries()
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
 Documentation/technical/sparse-index.txt | 37 ++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/sparse-index.txt b/Documentation/technical/sparse-index.txt
index 8d3d80804604..3b24c1a219f8 100644
--- a/Documentation/technical/sparse-index.txt
+++ b/Documentation/technical/sparse-index.txt
@@ -85,8 +85,41 @@ index, as well.
 
 Next, consumers of the index will be guarded against operating on a
 sparse-index by inserting calls to `ensure_full_index()` or
-`expand_index_to_path()`. After these guards are in place, we can begin
-leaving sparse-directory entries in the in-memory index structure.
+`expand_index_to_path()`. If a specific path is requested, then those will
+be protected from within the `index_file_exists()` and `index_name_pos()`
+API calls: they will call `ensure_full_index()` if necessary. The
+intention here is to preserve existing behavior when interacting with a
+sparse-checkout. We don't want a change to happen by accident, without
+tests. Many of these locations may not need any change before removing the
+guards, but we should not do so without tests to ensure the expected
+behavior happens.
+
+It may be desirable to _change_ the behavior of some commands in the
+presence of a sparse index or more generally in any sparse-checkout
+scenario. In such cases, these should be carefully communicated and
+tested. No such behavior changes are intended during this phase.
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
 
 Even after inserting these guards, we will keep expanding sparse-indexes
 for most Git commands using the `command_requires_full_index` repository
-- 
gitgitgadget

