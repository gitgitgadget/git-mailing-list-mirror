Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC43C433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 23:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9036196E
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 23:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbhCSXnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 19:43:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60241 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCSXn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 19:43:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8FFAB8B74;
        Fri, 19 Mar 2021 19:43:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QZ41KC+4pknhAtM1gJQVquVAgwY=; b=FlZLa+
        Qq3EQxraZy7DogoWG7hLALOI8eA4lPuxubTKr00mjc1n6aFkiPmgnfqOKNvkd01I
        H25mFqOUJCpyI8Go8U6/WrsxAxYPZyEIhM3dSrP34l9nGLwM+huA9QSEkkc0A2Hw
        rx5NohXxOm9YL8L+EVdl+4hibn2f6nr+Dl6jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aDUfCJtWvBm0/KusdjciODhompZvZrI4
        eb+kbTiStHCD9fzHRU9d8aZCZZWKHoDa5urutE9J5/LjUsaB4Q08owfmmCAO+Esb
        /EZoWrvl9L1aKjU78DPour256lhuk2jn00NkXrf98Bo6W++zrdMWNBnmTWwpafqp
        TR4yC4YHaf0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE69BB8B73;
        Fri, 19 Mar 2021 19:43:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B1FAB8B71;
        Fri, 19 Mar 2021 19:43:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 01/20] sparse-index: design doc and format update
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <62ac13945bec13270e0898126756c3f947ae264b.1615912983.git.gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 16:43:24 -0700
In-Reply-To: <62ac13945bec13270e0898126756c3f947ae264b.1615912983.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 16 Mar 2021
        16:42:44 +0000")
Message-ID: <xmqqczvulnfn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5C793AA-890C-11EB-8F10-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> This begins a long effort to update the index format to allow sparse
> directory entries. This should result in a significant improvement to
> Git commands when HEAD contains millions of files, but the user has
> selected many fewer files to keep in their sparse-checkout definition.

This compromise makes sense.

In the past, we often dreamed of recording trees in the index
(instead of using a bolted on extension like cache-tree, treating
trees as first-class citizens) and lazily expanding it only when the
user starts modifying the paths within the subdirectory.

But such an optimization never materialized, as the dual and
conflicting nature of the index to keep track of the contents for
the "next" commit (for which it is sufficient to just record trees
for parts that have not been modified) and to cache stat information
to detect which working tree paths may possibly have modifications
(for which, we used the one-entry-per-path nature of the cache
entries so far) was never resolved.

But if we limit the use of trees-in-index for sparse/cone checkout
case, we do not even have to worry about having to cache the stat
information for those paths that we are not going to populate in the
working tree at all.  It is a great simplification of the problem.

> +  These entries have mode `0040000`, include the `SKIP_WORKTREE` bit, and
> +  the path ends in a directory separator.
> +

Why leading two 0's?  At the tree object level, we do not 0-pad blob
mode word, and if you are writing for C programmers, you need only
one '0' prefix to signal that it is in octal (in the on-disk index
file, the blob mode word is stored in a be16 word).

> diff --git a/Documentation/technical/sparse-index.txt b/Documentation/technical/sparse-index.txt
> new file mode 100644
> index 000000000000..aa116406a016
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

s/worktree/working tree/; The former is the thing the "git worktree"
command deals with.  The latter is relevant even when "git worktree"
is not used (the traditional "git clone and you get a working tree
to work in").

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

OK.

> +These dimensions are also ordered by how expensive they are per item: it
> +is expensive to detect a modified file than it is to write one that we
> +know must be populated; changing `HEAD` only really requires updating the
> +index.

This is a bit too dense to grok.  Among Populated, there are some
Modified but it takes lstat(2) per path or fsmonitor listening to
inotify to know which ones are in the Modified set.  Is that the
"expensive" you are referring to here?  I am not sure how you
compared the cost to know if a path is modified or merely populated
with the cost of "write one that we know must be populated" (which I
take as "given a populated file, make modification to it").  Also it
is unclear what you mean by "changing HEAD only require updating the
index".  Certainly when "git switch" flips HEAD from one commit to
another, you'd update the index and update the files in the working
tree (in the Populated part that is in the sparse-checkout cone) to
match, no?

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

OK.

> +With cone mode patterns, it is possible to detect when an entire
> +directory will have its contents outside of the sparse-checkout definition.
> +Instead of listing all of the files it contains as individual entries, a
> +sparse-index contains an entry with the directory name, referencing the
> +object ID of the tree at `HEAD` and marked with the `SKIP_WORKTREE` bit.
> +If we need to discover the details for paths within that directory, we
> +can parse trees to find that list.

;-)

> +At time of writing, sparse-directory entries violate expectations about the
> +index format and its in-memory data structure. There are many consumers in
> +the codebase that expect to iterate through all of the index entries and
> +see only files.

True.

> In addition, they expect to see all files at `HEAD`.

It is not clear to me what this means.  After "git add", "git
ls-files" would expect to see a file that may not even in HEAD.
After "git rm", it would expect to see some file missing from the
set of paths in HEAD.  While I do not think that is what you meant
here, it is hard to guess what you wanted to say.

> One
> +way to handle this is to parse trees to replace a sparse-directory entry
> +with all of the files within that tree as the index is loaded. However,
> +parsing trees is slower than parsing the index format, so that is a slower
> +operation than if we left the index alone.

Besides, that would leave in-core index fully populated, so I would
suspect that you'd lose a lot of benefit that comes from having to
keep much fewer entries in the in-core index than what is in HEAD.
It would be nice for "git diff-index --cached" (which is part of
"git status") to be able to skip a single "tree" entry in the sparse
index as "known to be untouched", than skipping thousands of paths
in that single subdirectory (in a mega monorepo project) as "these
are marked with SKIP_WORKTREE so ignore what is in the working tree".

> +The implementation plan below follows four phases to slowly integrate with
> +the sparse-index. The intention is to incrementally update Git commands to
> +interact safely with the sparse-index without significant slowdowns. This
> +may not always be possible, but the hope is that the primary commands that
> +users need in their daily work are dramatically improved.

OK.

> +Phase I: Format and initial speedups
> +------------------------------------
> +
> +During this phase, Git learns to enable the sparse-index and safely parse
> +one. Protections are put in place so that every consumer of the in-memory
> +data structure can operate with its current assumption of every file at
> +`HEAD`.

IOW, before they iterate over the in-core index, tree entries are expanded
into bunch of individual entries with SKIP_WORKTREE bit?  Makes sense.

> +At first, every index parse will expand the sparse-directory entries into
> +the full list of paths at `HEAD`. This will be slower in all cases. The
> +only noticable change in behavior will be that the serialized index file
> +contains sparse-directory entries.

Hmph, do you mean that the expansion is done by not replacing each
"tree" entry with blob entries for the contents of the directory,
but the original "tree" entry is still left in the in-core index?
It is not immediately clear what we are trying to gain by leaving it
in, but let's read on.  Perhaps we can get rid of cache-tree
extension and replace its use with these "tree" entries whose
content paths are populated in the index?

> +To start, we use a new repository extension, `extensions.sparseIndex`, to
> +allow inserting sparse-directory entries into indexes with file format
> +versions 2, 3, and 4. This prevents Git versions that do not understand
> +the sparse-index from operating on one, but it also prevents other
> +operations that do not use the index at all. A new format, index v5, will
> +be introduced that includes sparse-directory entries by default. It might
> +also introduce other features that have been considered for improving the
> +index, as well.

OK.

> +Next, consumers of the index will be guarded against operating on a
> +sparse-index by inserting calls to `ensure_full_index()` or
> +`expand_index_to_path()`. After these guards are in place, we can begin
> +leaving sparse-directory entries in the in-memory index structure.

It is unclear why "we can begin leaving"; an iterator that only
expects to see blobs would need to be updated to skip them, too, no?
They would probably be already skipping blob entries that are marked
with the SKIP_WORKTREE bit, so it may be just a matter of skipping
more things than the current code.

Or did I misread the design presented earlier, and when a directory
that is outside the cone is expanded into the paths of blobs in the
directory, the "tree" entry is removed from the in-core index?

> +Even after inserting these guards, we will keep expanding sparse-indexes
> +for most Git commands using the `command_requires_full_index` repository
> +setting. This setting will be on by default and disabled one builtin at a
> +time until we have sufficient confidence that all of the index operations
> +are properly guarded.

OK.

> +To complete this phase, the commands `git status` and `git add` will be
> +integrated with the sparse-index so that they operate with O(Populated)
> +performance. They will be carefully tested for operations within and
> +outside the sparse-checkout definition.

;-)

