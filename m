Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076DAC433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3AC565108
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbhCPQnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhCPQnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17256C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x16so7793875wrn.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0vpHjpdIXCkZI1YqvNy1aNFYzJ9Qs7jF1L1AqoYGTHM=;
        b=LW2hzUJRfLnKBbAhTn2fe2mBaO5hPcRutzkZ2UJN+HabJrMAhlvTzpDMSYXD+EqlHa
         VC8sXRcxfuOpU1fsGgcvDdzA47y23sbut1HSW8b9/PrdpmMzs7Mclacd26i1taNxMq91
         CeljhL5xDmE8KdzGXhOmUkNIhE598lVy69dLNQM2Z8P0Xnd75OzcocEi7+5Hp15RJ7YM
         ZkRcc38v/CsCld1CAEDp5YRUJXH8E2LtSehlqb9ymc/fepuCve0/u7ztREHgnj3CREfU
         XksSGbBUHZiTWCpCteM/N6R6NVPrUmg3zfXuU6S7nt0PRVb3gYJ2g9AY+MO7FfjtF8FY
         5CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0vpHjpdIXCkZI1YqvNy1aNFYzJ9Qs7jF1L1AqoYGTHM=;
        b=V1D9JGWs0UkMs82fPyO/SGfKFPqYfw1l8d0UYK3+JyCuARtamfyMHysRpTQkXU7dCy
         Y5249yb3IxtDgk+GGxvkHWet27iRg+mq7+psh3ndn2F+Pb7m4NAKijO7fBWjFL1DNUZv
         2YKK5ExO1unKwRHGGxWk3x4PdBO1FiQQ6u8klk1z187eOSPI7SFeIMzxRPphav0D8BP+
         k6U/mhVjfnDpu4Phr7uDn6IbYJ4VwymHLhuD82NXtAUV1icj2AiC+x+f+ZfGhcRJaTvl
         fvFZouaVGdQdZMIPU072Ay9vKkICcngLuHrk+zFw7XPVWjtdTGW7h1q4deu3JSe59+6K
         zC0A==
X-Gm-Message-State: AOAM5305gulyhq/z09Z7U5AxSjEekh5JRo2dHVw8lgCVZVbBFnlP+T/0
        Kw/ixx7ffUXo8uW36KauByxyH+ULm0M=
X-Google-Smtp-Source: ABdhPJws9nGlg9KcBI9g7WFF4d7Ge9YLqNw4SJzdn4B4MXNvvMQaWDQGC0KjuRSy6jkrk+XpgtfzgQ==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr5847038wrw.328.1615912985687;
        Tue, 16 Mar 2021 09:43:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s16sm22560229wru.91.2021.03.16.09.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:05 -0700 (PDT)
Message-Id: <62ac13945bec13270e0898126756c3f947ae264b.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:44 +0000
Subject: [PATCH v3 01/20] sparse-index: design doc and format update
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This begins a long effort to update the index format to allow sparse
directory entries. This should result in a significant improvement to
Git commands when HEAD contains millions of files, but the user has
selected many fewer files to keep in their sparse-checkout definition.

Currently, the index format is only updated in the presence of
extensions.sparseIndex instead of increasing a file format version
number. This is temporary, and index v5 is part of the plan for future
work in this area.

The design document details many of the reasons for embarking on this
work, and also the plan for completing it safely.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/index-format.txt |   7 +
 Documentation/technical/sparse-index.txt | 173 +++++++++++++++++++++++
 2 files changed, 180 insertions(+)
 create mode 100644 Documentation/technical/sparse-index.txt

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index d363a71c37ec..cc548eaa0e97 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -44,6 +44,13 @@ Git index format
   localization, no special casing of directory separator '/'). Entries
   with the same name are sorted by their stage field.
 
+  An index entry typically represents a file. However, if sparse-checkout
+  is enabled in cone mode (`core.sparseCheckoutCone` is enabled) and the
+  `extensions.sparseIndex` extension is enabled, then the index may
+  contain entries for directories outside of the sparse-checkout definition.
+  These entries have mode `0040000`, include the `SKIP_WORKTREE` bit, and
+  the path ends in a directory separator.
+
   32-bit ctime seconds, the last time a file's metadata changed
     this is stat(2) data
 
diff --git a/Documentation/technical/sparse-index.txt b/Documentation/technical/sparse-index.txt
new file mode 100644
index 000000000000..aa116406a016
--- /dev/null
+++ b/Documentation/technical/sparse-index.txt
@@ -0,0 +1,173 @@
+Git Sparse-Index Design Document
+================================
+
+The sparse-checkout feature allows users to focus a working directory on
+a subset of the files at HEAD. The cone mode patterns, enabled by
+`core.sparseCheckoutCone`, allow for very fast pattern matching to
+discover which files at HEAD belong in the sparse-checkout cone.
+
+Three important scale dimensions for a Git worktree are:
+
+* `HEAD`: How many files are present at `HEAD`?
+
+* Populated: How many files are within the sparse-checkout cone.
+
+* Modified: How many files has the user modified in the working directory?
+
+We will use big-O notation -- O(X) -- to denote how expensive certain
+operations are in terms of these dimensions.
+
+These dimensions are ordered by their magnitude: users (typically) modify
+fewer files than are populated, and we can only populate files at `HEAD`.
+These dimensions are also ordered by how expensive they are per item: it
+is expensive to detect a modified file than it is to write one that we
+know must be populated; changing `HEAD` only really requires updating the
+index.
+
+Problems occur if there is an extreme imbalance in these dimensions. For
+example, if `HEAD` contains millions of paths but the populated set has
+only tens of thousands, then commands like `git status` and `git add` can
+be dominated by operations that require O(`HEAD`) operations instead of
+O(Populated). Primarily, the cost is in parsing and rewriting the index,
+which is filled primarily with files at `HEAD` that are marked with the
+`SKIP_WORKTREE` bit.
+
+The sparse-index intends to take these commands that read and modify the
+index from O(`HEAD`) to O(Populated). To do this, we need to modify the
+index format in a significant way: add "sparse directory" entries.
+
+With cone mode patterns, it is possible to detect when an entire
+directory will have its contents outside of the sparse-checkout definition.
+Instead of listing all of the files it contains as individual entries, a
+sparse-index contains an entry with the directory name, referencing the
+object ID of the tree at `HEAD` and marked with the `SKIP_WORKTREE` bit.
+If we need to discover the details for paths within that directory, we
+can parse trees to find that list.
+
+At time of writing, sparse-directory entries violate expectations about the
+index format and its in-memory data structure. There are many consumers in
+the codebase that expect to iterate through all of the index entries and
+see only files. In addition, they expect to see all files at `HEAD`. One
+way to handle this is to parse trees to replace a sparse-directory entry
+with all of the files within that tree as the index is loaded. However,
+parsing trees is slower than parsing the index format, so that is a slower
+operation than if we left the index alone.
+
+The implementation plan below follows four phases to slowly integrate with
+the sparse-index. The intention is to incrementally update Git commands to
+interact safely with the sparse-index without significant slowdowns. This
+may not always be possible, but the hope is that the primary commands that
+users need in their daily work are dramatically improved.
+
+Phase I: Format and initial speedups
+------------------------------------
+
+During this phase, Git learns to enable the sparse-index and safely parse
+one. Protections are put in place so that every consumer of the in-memory
+data structure can operate with its current assumption of every file at
+`HEAD`.
+
+At first, every index parse will expand the sparse-directory entries into
+the full list of paths at `HEAD`. This will be slower in all cases. The
+only noticable change in behavior will be that the serialized index file
+contains sparse-directory entries.
+
+To start, we use a new repository extension, `extensions.sparseIndex`, to
+allow inserting sparse-directory entries into indexes with file format
+versions 2, 3, and 4. This prevents Git versions that do not understand
+the sparse-index from operating on one, but it also prevents other
+operations that do not use the index at all. A new format, index v5, will
+be introduced that includes sparse-directory entries by default. It might
+also introduce other features that have been considered for improving the
+index, as well.
+
+Next, consumers of the index will be guarded against operating on a
+sparse-index by inserting calls to `ensure_full_index()` or
+`expand_index_to_path()`. After these guards are in place, we can begin
+leaving sparse-directory entries in the in-memory index structure.
+
+Even after inserting these guards, we will keep expanding sparse-indexes
+for most Git commands using the `command_requires_full_index` repository
+setting. This setting will be on by default and disabled one builtin at a
+time until we have sufficient confidence that all of the index operations
+are properly guarded.
+
+To complete this phase, the commands `git status` and `git add` will be
+integrated with the sparse-index so that they operate with O(Populated)
+performance. They will be carefully tested for operations within and
+outside the sparse-checkout definition.
+
+Phase II: Careful integrations
+------------------------------
+
+This phase focuses on ensuring that all index extensions and APIs work
+well with a sparse-index. This requires significant increases to our test
+coverage, especially for operations that interact with the working
+directory outside of the sparse-checkout definition. Some of these
+behaviors may not be the desirable ones, such as some tests already
+marked for failure in `t1092-sparse-checkout-compatibility.sh`.
+
+The index extensions that may require special integrations are:
+
+* FS Monitor
+* Untracked cache
+
+While integrating with these features, we should look for patterns that
+might lead to better APIs for interacting with the index. Coalescing
+common usage patterns into an API call can reduce the number of places
+where sparse-directories need to be handled carefully.
+
+Phase III: Important command speedups
+-------------------------------------
+
+At this point, the patterns for testing and implementing sparse-directory
+logic should be relatively stable. This phase focuses on updating some of
+the most common builtins that use the index to operate as O(Populated).
+Here is a potential list of commands that could be valuable to integrate
+at this point:
+
+* `git commit`
+* `git checkout`
+* `git merge`
+* `git rebase`
+
+Hopefully, commands such as `git merge` and `git rebase` can benefit
+instead from merge algorithms that do not use the index as a data
+structure, such as the merge-ORT strategy. As these topics mature, we
+may enable the ORT strategy by default for repositories using the
+sparse-index feature.
+
+Along with `git status` and `git add`, these commands cover the majority
+of users' interactions with the working directory. In addition, we can
+integrate with these commands:
+
+* `git grep`
+* `git rm`
+
+These have been proposed as some whose behavior could change when in a
+repo with a sparse-checkout definition. It would be good to include this
+behavior automatically when using a sparse-index. Some clarity is needed
+to make the behavior switch clear to the user.
+
+This phase is the first where parallel work might be possible without too
+much conflicts between topics.
+
+Phase IV: The long tail
+-----------------------
+
+This last phase is less a "phase" and more "the new normal" after all of
+the previous work.
+
+To start, the `command_requires_full_index` option could be removed in
+favor of expanding only when hitting an API guard.
+
+There are many Git commands that could use special attention to operate as
+O(Populated), while some might be so rare that it is acceptable to leave
+them with additional overhead when a sparse-index is present.
+
+Here are some commands that might be useful to update:
+
+* `git sparse-checkout set`
+* `git am`
+* `git clean`
+* `git stash`
-- 
gitgitgadget

