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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764BAC433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E47F64DDC
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhBWUPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbhBWUPO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:14 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F203C061786
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o16so1657392wmh.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DJnTwocUJqKSt9dOPfPou2h/3d024kYNJiAp5xWd0UA=;
        b=L87XHzL1tQj2JGwjfetkrQcyjCZLlN0hLoswGdr9jvm8BL0oW2f0x4nWy5Ha66ijOy
         7HwlOf0DaPAC0XXqD9J8p8XC1dyKtI2WPa7na5d+KXQCp5oFbp/34CdPDzL3Y39MQ0w8
         GaJ7u2lWJQ+ewtS/vSjRwvPuy8H/lyOWC3IdnigplxNbFJ65PKK6w4s0jIkxQfSuQypI
         EzGgtDhfToO2rVqoFKeTEzwsjK03FXKb5c1HEpLEZx5p1Qearn/L5J2/cs56GoL6Pzzc
         Nrb/dQ++DXOnsITEGrLn2aMBeVwmqKwXsEr8imezNl8GIIjaEC2uc13QWz7EAti4nsCd
         02jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DJnTwocUJqKSt9dOPfPou2h/3d024kYNJiAp5xWd0UA=;
        b=XPqJ1w4Cxu8mL8t16AfF6lOaa20VsuaClf+WQngDgLJvlC5K/I7SApx4Elbb4uX3t9
         phKn1WxrMDW7Fhp+Hxti7NxHAefEFVoN+J7MTo1ElmOgySliMUKKAC0tS3tB9O5Fy/AU
         XWUy71Ry7skWApaFjCdxzNeXvUdGtykDkq9B97gF7oyAoomJYIh9fHpb5sFXLS2wzuW0
         Xv+oSH51aGohoG4LNBhe00vedTqAeL7gv8AO31xGGAzQv8OZYrqOBBsXkVBwLDaxxnbo
         v8OwxYOY6+HfMDftoIxmNIv+Kj6oavOBORRBNSNFsrX+ZmzofVo0VCnbjZJe4LgQTp2D
         AW8g==
X-Gm-Message-State: AOAM533N1J7GiCFzTeGZBnaVf+j9gukf+t1yyqSzE/hSWqCbHT2HWp9f
        y7NXYUTADcvQC6i0MOTgReVET8i1ZBc=
X-Google-Smtp-Source: ABdhPJywrMZaEYKckO1mS+ypqDSjGxQsLnfpwp3M6VpAqwCB5m9iC6a+sOnBHHVXNYAl4boTKnzfaw==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr406176wmk.101.1614111271942;
        Tue, 23 Feb 2021 12:14:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12sm15696748wrg.9.2021.02.23.12.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:31 -0800 (PST)
Message-Id: <daa9a6bcefbce977606484d502f5cfd7fca63ecc.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:10 +0000
Subject: [PATCH 01/20] sparse-index: design doc and format update
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
 Documentation/technical/sparse-index.txt | 167 +++++++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100644 Documentation/technical/sparse-index.txt

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index b633482b1bdf..387126582556 100644
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
index 000000000000..9070836f0655
--- /dev/null
+++ b/Documentation/technical/sparse-index.txt
@@ -0,0 +1,167 @@
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
+This addition of sparse-directory entries violates expectations about the
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

