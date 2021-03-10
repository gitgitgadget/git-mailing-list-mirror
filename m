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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D53C43332
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB0A64FD9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhCJWTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhCJWTq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 17:19:46 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B43C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 14:19:46 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id b8so18019557oti.7
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 14:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LomXUTm3ZrwSi2E+3GS175qMBwpn2sI8HpyFUKSXwlo=;
        b=FQdGh6KNzIQleYMIiarhhfPlYx/174sOQKQDhQ8DyUZvSnVUgCYmMIiks9rYukRzdA
         A/fHpIwAimYU/4VVOJLQ5OftIgVkdsCyQejdXor+c/TqOL0l6dLjgR+flgQ15z86JqDb
         1QD+1ZSzl4WUOOKLNXAMAYpBtvson09ik4cjP18BRVKVNecpVyRrFJAMaaUnW5nOqVip
         abbNRNUufNRs98MeDyITPi12lEzSLKtZAQRWMHu8LxSuAkA3t8tQjY59Z/eCtQnSo7vE
         /2+x6caeKlfh7tvB4Wr7MKoWXIT7nQSgZCg7kWrTxZrRipVD5WivEqP9bfGLIIzKIzIQ
         JNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LomXUTm3ZrwSi2E+3GS175qMBwpn2sI8HpyFUKSXwlo=;
        b=sC0cBp6Vt56X/4n1MiYGINMJHVZdua5lHF8DRLX4FvhNewJ4SCLmNU+dK6KiX9OY31
         4Rbxgtflz5x1o16ywTbR+PxtpnPSSpB3yrt9aPRSnKYMr3UWLmTKHUWUADmw14bMxmVJ
         I+Gu8Rh6hfP6Vm2AmLpHce0aw4wbXmdmzWlYZGFC5nWt0bKS42b6D/uu4g29Iml9XpUO
         u0etoQ9tiQ7ZhsjzuoDA9E4vaCXgKRzmlFEle0Z9Ti8QUkfYvdmHW71O2EuW/regYT2M
         Z99IQF7qgSh82Ivo1QRzPKPytpOv0qBqoyAeR11GU1hIcngp8zlenmEumBUmT8dxOo89
         0W6g==
X-Gm-Message-State: AOAM533yWK7GzIOMdO2OOwLl+AyvHI7mNDq/SA017EBSXWycJ6WttwZ7
        5sx8cq43FV5Jd2h6fMs71VKHrqj9fCSGvgDUDp0=
X-Google-Smtp-Source: ABdhPJyFy4S5SpEh6tw38e7DgFQaIEELYeeVIWd05LdHb8O+EM+40o792VJkHIYv181lWwr+10UwLGDmm4UgZs2pM2U=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr4210239otf.316.1615414785121;
 Wed, 10 Mar 2021 14:19:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <pull.883.v2.git.1615404664.gitgitgadget@gmail.com> <2fe413fdac808807e2058caeee6ce86c54a678c0.1615404664.git.gitgitgadget@gmail.com>
In-Reply-To: <2fe413fdac808807e2058caeee6ce86c54a678c0.1615404664.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Mar 2021 14:19:34 -0800
Message-ID: <CABPp-BGwyyOHJbPtJ2qzsCbOyag5aj1UfRfeDeDj7z3W6zwkow@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] sparse-index: design doc and format update
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> This begins a long effort to update the index format to allow sparse
> directory entries. This should result in a significant improvement to
> Git commands when HEAD contains millions of files, but the user has
> selected many fewer files to keep in their sparse-checkout definition.
>
> Currently, the index format is only updated in the presence of
> extensions.sparseIndex instead of increasing a file format version
> number. This is temporary, and index v5 is part of the plan for future
> work in this area.
>
> The design document details many of the reasons for embarking on this
> work, and also the plan for completing it safely.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/index-format.txt |   7 +
>  Documentation/technical/sparse-index.txt | 173 +++++++++++++++++++++++
>  2 files changed, 180 insertions(+)
>  create mode 100644 Documentation/technical/sparse-index.txt
>
> diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
> index b633482b1bdf..387126582556 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -44,6 +44,13 @@ Git index format
>    localization, no special casing of directory separator '/'). Entries
>    with the same name are sorted by their stage field.
>
> +  An index entry typically represents a file. However, if sparse-checkout
> +  is enabled in cone mode (`core.sparseCheckoutCone` is enabled) and the
> +  `extensions.sparseIndex` extension is enabled, then the index may
> +  contain entries for directories outside of the sparse-checkout definition.
> +  These entries have mode `0040000`, include the `SKIP_WORKTREE` bit, and
> +  the path ends in a directory separator.
> +
>    32-bit ctime seconds, the last time a file's metadata changed
>      this is stat(2) data
>
> diff --git a/Documentation/technical/sparse-index.txt b/Documentation/technical/sparse-index.txt
> new file mode 100644
> index 000000000000..787a2a0b3b81
> --- /dev/null
> +++ b/Documentation/technical/sparse-index.txt
> @@ -0,0 +1,173 @@
> +Git Sparse-Index Design Document
> +================================
> +
> +The sparse-checkout feature allows users to focus a working directory on
> +a subset of the files at HEAD. The cone mode patterns, enabled by
> +`core.sparseCheckoutCone`, allow for very fast pattern matching to
> +discover which files at HEAD belong in the sparse-checkout cone.
> +
> +Three important scale dimensions for a Git worktree are:
> +
> +* `HEAD`: How many files are present at `HEAD`?
> +
> +* Populated: How many files are within the sparse-checkout cone.
> +
> +* Modified: How many files has the user modified in the working directory?
> +
> +We will use big-O notation -- O(X) -- to denote how expensive certain
> +operations are in terms of these dimensions.
> +
> +These dimensions are ordered by their magnitude: users (typically) modify
> +fewer files than are populated, and we can only populate files at `HEAD`.
> +These dimensions are also ordered by how expensive they are per item: it
> +is expensive to detect a modified file than it is to write one that we
> +know must be populated; changing `HEAD` only really requires updating the
> +index.
> +
> +Problems occur if there is an extreme imbalance in these dimensions. For
> +example, if `HEAD` contains millions of paths but the populated set has
> +only tens of thousands, then commands like `git status` and `git add` can
> +be dominated by operations that require O(`HEAD`) operations instead of
> +O(Populated). Primarily, the cost is in parsing and rewriting the index,
> +which is filled primarily with files at `HEAD` that are marked with the
> +`SKIP_WORKTREE` bit.
> +
> +The sparse-index intends to take these commands that read and modify the
> +index from O(`HEAD`) to O(Populated). To do this, we need to modify the
> +index format in a significant way: add "sparse directory" entries.
> +
> +With cone mode patterns, it is possible to detect when an entire
> +directory will have its contents outside of the sparse-checkout definition.
> +Instead of listing all of the files it contains as individual entries, a
> +sparse-index contains an entry with the directory name, referencing the
> +object ID of the tree at `HEAD` and marked with the `SKIP_WORKTREE` bit.
> +If we need to discover the details for paths within that directory, we
> +can parse trees to find that list.
> +
> +At time of writing, sparse-directory entries violate expectations about the
> +index format and its in-memory data structure. There are many consumers in
> +the codebase that expect to iterate through all of the index entries and
> +see only files. In addition, they expect to see all files at `HEAD`. One
> +way to handle this is to parse trees to replace a sparse-directory entry
> +with all of the files within that tree as the index is loaded. However,
> +parsing trees is slower than parsing the index format, so that is a slower
> +operation than if we left the index alone.
> +
> +The implementation plan below follows four phases to slowly integrate with
> +the sparse-index. The intention is to incrementally update Git commands to
> +interact safely with the sparse-index without significant slowdowns. This
> +may not always be possible, but the hope is that the primary commands that
> +users need in their daily work are dramatically improved.
> +
> +Phase I: Format and initial speedups
> +------------------------------------
> +
> +During this phase, Git learns to enable the sparse-index and safely parse
> +one. Protections are put in place so that every consumer of the in-memory
> +data structure can operate with its current assumption of every file at
> +`HEAD`.
> +
> +At first, every index parse will expand the sparse-directory entries into
> +the full list of paths at `HEAD`. This will be slower in all cases. The
> +only noticable change in behavior will be that the serialized index file
> +contains sparse-directory entries.
> +
> +To start, we use a new repository extension, `extensions.sparseIndex`, to
> +allow inserting sparse-directory entries into indexes with file format
> +versions 2, 3, and 4. This prevents Git versions that do not understand
> +the sparse-index from operating on one, but it also prevents other
> +operations that do not use the index at all. A new format, index v5, will
> +be introduced that includes sparse-directory entries by default. It might
> +also introduce other features that have been considered for improving the
> +index, as well.
> +
> +Next, consumers of the index will be guarded against operating on a
> +sparse-index by inserting calls to `ensure_full_index()` or
> +`expand_index_to_path()`. After these guards are in place, we can begin
> +leaving sparse-directory entries in the in-memory index structure.
> +
> +Even after inserting these guards, we will keep expanding sparse-indexes
> +for most Git commands using the `command_requires_full_index` repository
> +setting. This setting will be on by default and disabled one builtin at a
> +time until we have sufficient confidence that all of the index operations
> +are properly guarded.
> +
> +To complete this phase, the commands `git status` and `git add` will be
> +integrated with the sparse-index so that they operate with O(Populated)
> +performance. They will be carefully tested for operations within and
> +outside the sparse-checkout definition.
> +
> +Phase II: Careful integrations
> +------------------------------
> +
> +This phase focuses on ensuring that all index extensions and APIs work
> +well with a sparse-index. This requires significant increases to our test
> +coverage, especially for operations that interact with the working
> +directory outside of the sparse-checkout definition. Some of these
> +behaviors may not be the desirable ones, such as some tests already
> +marked for failure in `t1092-sparse-checkout-compatibility.sh`.
> +
> +The index extensions that may require special integrations are:
> +
> +* FS Monitor
> +* Untracked cache
> +
> +While integrating with these features, we should look for patterns that
> +might lead to better APIs for interacting with the index. Coalescing
> +common usage patterns into an API call can reduce the number of places
> +where sparse-directories need to be handled carefully.
> +
> +Phase III: Important command speedups
> +-------------------------------------
> +
> +At this point, the patterns for testing and implementing sparse-directory
> +logic should be relatively stable. This phase focuses on updating some of
> +the most common builtins that use the index to operate as O(Populated).
> +Here is a potential list of commands that could be valuable to integrate
> +at this point:
> +
> +* `git commit`
> +* `git checkout`
> +* `git merge`
> +* `git rebase`
> +
> +Hopefully, commands such as `git merge` and `git rebase` can benefit
> +instead from merge algorithms that do not use the index as a data
> +structure, such as the merge-ORT strategy. As these topics mature, we
> +may enalbe the ORT strategy by default for repositories using the

s/enalbe/enable/

> +sparse-index feature.
> +
> +Along with `git status` and `git add`, these commands cover the majority
> +of users' interactions with the working directory. In addition, we can
> +integrate with these commands:
> +
> +* `git grep`
> +* `git rm`
> +
> +These have been proposed as some whose behavior could change when in a
> +repo with a sparse-checkout definition. It would be good to include this
> +behavior automatically when using a sparse-index. Some clarity is needed
> +to make the behavior switch clear to the user.
> +
> +This phase is the first where parallel work might be possible without too
> +much conflicts between topics.
> +
> +Phase IV: The long tail
> +-----------------------
> +
> +This last phase is less a "phase" and more "the new normal" after all of
> +the previous work.
> +
> +To start, the `command_requires_full_index` option could be removed in
> +favor of expanding only when hitting an API guard.
> +
> +There are many Git commands that could use special attention to operate as
> +O(Populated), while some might be so rare that it is acceptable to leave
> +them with additional overhead when a sparse-index is present.
> +
> +Here are some commands that might be useful to update:
> +
> +* `git sparse-checkout set`
> +* `git am`
> +* `git clean`
> +* `git stash`
> --
> gitgitgadget
>
