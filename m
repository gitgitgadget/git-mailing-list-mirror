Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A57C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA2564E31
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhBAHAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 02:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhBAHAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 02:00:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213BDC061788
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c4so12609049wru.9
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mXhJuCaPYYFmBKnJdgRD818ZWMUQjVLF9ZfvmsfqxHk=;
        b=C7ydMNitUr87dHK4UFM3xXnQ0paDwbU7PsaSnGTcxDu/sIIGAgL5pPfHIzI3szw91I
         NJ5R7ZduV4gZdD+hhDl5raUxwGqVwMMKxmqz7cHZ5t2/15KxzmP4Lv8ztXqwGjUvsGqz
         JbxalvrSiITAAp5HahnV9dl+KyZxbgR3av6Q4tFNx+RGySFTDfw3W3+Wiz7dcCMAkd18
         5BrhmZryhdk9GglBK5w5TXMDYTJEBdjnnWRhPKOqERzn0BSAZYgDAf8oUc1jeI2G7xtu
         4Rf2MERUYm9fkBj6nhHwwZQ9RCqw7L4I9jK4Y7H8SPYeNP8WSXnuSR9E4LTFRDK2qGNs
         i2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mXhJuCaPYYFmBKnJdgRD818ZWMUQjVLF9ZfvmsfqxHk=;
        b=fQtV/QZgzGWFd6TLMUGl6fvt5sarn2lYZR/3fcWF7gJoXkzXj+omn7EBfaTs0xKO0u
         lASZ5inG+axakyB+tGrbn4aKrkA2xiHIStEIHfy0EJ209TZS5T5JrN5P/G0Iwo6tJlen
         ryZ1VmTXe1uA2qnv/gRPuP1XVkTrQ0UewnM+HZXVna9Aj4gLYPP/wSGmGGTCUxfsQYp6
         Z7THKQkeGnpjb2eBWkEQ3pV0SFSpqf2E9UomgnrjkGDxTx8yH90PmDTNpusUEMVk24F1
         2JCkpDfEJDwb8+2W9xvxAn89cw34SHKqB6BmLoFXiEqkpulcbzzYhB57Q85MgeB3jXBO
         CJmQ==
X-Gm-Message-State: AOAM533NTR36VCE0kaZY8x7wYF7oUajxERuL6MS1goyOLVKWylpSrKTR
        P7Dm58fO5U2f/OACSi/iKbjDJx8YOjI=
X-Google-Smtp-Source: ABdhPJzge4IMOBO6oJN9H7lkiE0M1kemJ0MYJDoCEmbXFIHLz2nk1TB0DYBUylxMQnWjXFZo2YmYRQ==
X-Received: by 2002:a5d:5910:: with SMTP id v16mr17032750wrd.29.1612162736390;
        Sun, 31 Jan 2021 22:58:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1sm19678257wmj.31.2021.01.31.22.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 22:58:55 -0800 (PST)
Message-Id: <8647b5d2e38d7c00b4b189b5cba27cc4f61b778c.1612162726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
References: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
        <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 06:58:41 +0000
Subject: [PATCH v7 07/11] commit-graph: document generation number v2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

Git uses topological levels in the commit-graph file for commit-graph
traversal operations like 'git log --graph'. Unfortunately, topological
levels can perform worse than committer date when parents of a commit
differ greatly in generation numbers [1]. For example, 'git merge-base
v4.8 v4.9' on the Linux repository walks 635,579 commits using
topological levels and walks 167,468 using committer date. Since
091f4cf3 (commit: don't use generation numbers if not needed,
2018-08-30), 'git merge-base' uses committer date heuristic unless there
is a cutoff because of the performance hit.

[1] https://lore.kernel.org/git/efa3720fb40638e5d61c6130b55e3348d8e4339e.1535633886.git.gitgitgadget@gmail.com/

Thus, the need for generation number v2 was born. As Git used to die
when graph version understood by it and in the commit-graph file are
different [2], we needed a way to distinguish between the old and new
generation number without incrementing the graph version.

[2] https://lore.kernel.org/git/87a7gdspo4.fsf@evledraar.gmail.com/

The following candidates were proposed (https://github.com/derrickstolee/gen-test,
https://github.com/abhishekkumar2718/git/pull/1):
- (Epoch, Date) Pairs.
- Maximum Generation Numbers.
- Corrected Commit Date.
- FELINE Index.
- Corrected Commit Date with Monotonically Increasing Offsets.

Based on performance, local computability, and immutability (along with
the introduction of an additional commit-graph chunk which relieved the
requirement of backwards-compatibility) Corrected Commit Date was chosen
as generation number v2 and is defined as follows:

For a commit C, let its corrected commit date  be the maximum of the
commit date of C and the corrected commit dates of its parents plus 1.
Then corrected commit date offset is the difference between corrected
commit date of C and commit date of C. As a special case, a root commit
with the timestamp zero has corrected commit date of 1 to distinguish it
from GENERATION_NUMBER_ZERO (that is, an uncomputed generation number).

While it was proposed initially to store corrected commit date offsets
within Commit Data Chunk, storing the offsets in a new chunk did not
affect the performance measurably. The new chunk is "Generation DATa
(GDAT) chunk" and it stores corrected commit date offsets while CDAT
chunk stores topological level. The old versions of Git would ignore
GDAT chunk, using topological levels from CDAT chunk. In contrast, new
versions of Git would use corrected commit dates, falling back to
topological level if the generation data chunk is absent in the
commit-graph file.

While storing corrected commit date offsets saves us 4 bytes per commit
(as compared with storing corrected commit dates directly), it's however
possible for the offset to overflow the space allocated. To handle such
cases, we introduce a new chunk, _Generation Data Overflow_ (GDOV) that
stores the corrected commit date. For overflowing offsets, we set MSB
and store the position into the GDOV chunk, in a mechanism similar to
the Extra Edges list chunk.

For mixed generation number environment (for example new Git on the
command line, old Git used by GUI client), we can encounter a
mixed-chain commit-graph (a commit-graph chain where some of split
commit-graph files have GDAT chunk and others do not). As backward
compatibility is one of the goals, we can define the following behavior:

While reading a mixed-chain commit-graph version, we fall back on
topological levels as corrected commit dates and topological levels
cannot be compared directly.

When adding new layer to the split commit-graph file, and when merging
some or all layers (replacing them in the latter case), the new layer
will have GDAT chunk if and only if in the final result there would be
no layer without GDAT chunk just below it.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 .../technical/commit-graph-format.txt         | 28 +++++--
 Documentation/technical/commit-graph.txt      | 77 +++++++++++++++----
 2 files changed, 86 insertions(+), 19 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index b3b58880b92..b6658eff188 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -4,11 +4,7 @@ Git commit graph format
 The Git commit graph stores a list of commit OIDs and some associated
 metadata, including:
 
-- The generation number of the commit. Commits with no parents have
-  generation number 1; commits with parents have generation number
-  one more than the maximum generation number of its parents. We
-  reserve zero as special, and can be used to mark a generation
-  number invalid or as "not computed".
+- The generation number of the commit.
 
 - The root tree OID.
 
@@ -86,13 +82,33 @@ CHUNK DATA:
       position. If there are more than two parents, the second value
       has its most-significant bit on and the other bits store an array
       position into the Extra Edge List chunk.
-    * The next 8 bytes store the generation number of the commit and
+    * The next 8 bytes store the topological level (generation number v1)
+      of the commit and
       the commit time in seconds since EPOCH. The generation number
       uses the higher 30 bits of the first 4 bytes, while the commit
       time uses the 32 bits of the second 4 bytes, along with the lowest
       2 bits of the lowest byte, storing the 33rd and 34th bit of the
       commit time.
 
+  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
+    * This list of 4-byte values store corrected commit date offsets for the
+      commits, arranged in the same order as commit data chunk.
+    * If the corrected commit date offset cannot be stored within 31 bits,
+      the value has its most-significant bit on and the other bits store
+      the position of corrected commit date into the Generation Data Overflow
+      chunk.
+    * Generation Data chunk is present only when commit-graph file is written
+      by compatible versions of Git and in case of split commit-graph chains,
+      the topmost layer also has Generation Data chunk.
+
+  Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
+    * This list of 8-byte values stores the corrected commit date offsets
+      for commits with corrected commit date offsets that cannot be
+      stored within 31 bits.
+    * Generation Data Overflow chunk is present only when Generation Data
+      chunk is present and atleast one corrected commit date offset cannot
+      be stored within 31 bits.
+
   Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
       This list of 4-byte values store the second through nth parents for
       all octopus merges. The second parent value in the commit data stores
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index f14a7659aa8..f05e7bda1a9 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -38,14 +38,31 @@ A consumer may load the following info for a commit from the graph:
 
 Values 1-4 satisfy the requirements of parse_commit_gently().
 
-Define the "generation number" of a commit recursively as follows:
+There are two definitions of generation number:
+1. Corrected committer dates (generation number v2)
+2. Topological levels (generation nummber v1)
 
- * A commit with no parents (a root commit) has generation number one.
+Define "corrected committer date" of a commit recursively as follows:
 
- * A commit with at least one parent has generation number one more than
-   the largest generation number among its parents.
+ * A commit with no parents (a root commit) has corrected committer date
+    equal to its committer date.
 
-Equivalently, the generation number of a commit A is one more than the
+ * A commit with at least one parent has corrected committer date equal to
+    the maximum of its commiter date and one more than the largest corrected
+    committer date among its parents.
+
+ * As a special case, a root commit with timestamp zero has corrected commit
+    date of 1, to be able to distinguish it from GENERATION_NUMBER_ZERO
+    (that is, an uncomputed corrected commit date).
+
+Define the "topological level" of a commit recursively as follows:
+
+ * A commit with no parents (a root commit) has topological level of one.
+
+ * A commit with at least one parent has topological level one more than
+   the largest topological level among its parents.
+
+Equivalently, the topological level of a commit A is one more than the
 length of a longest path from A to a root commit. The recursive definition
 is easier to use for computation and observing the following property:
 
@@ -60,6 +77,9 @@ is easier to use for computation and observing the following property:
     generation numbers, then we always expand the boundary commit with highest
     generation number and can easily detect the stopping condition.
 
+The property applies to both versions of generation number, that is both
+corrected committer dates and topological levels.
+
 This property can be used to significantly reduce the time it takes to
 walk commits and determine topological relationships. Without generation
 numbers, the general heuristic is the following:
@@ -67,7 +87,9 @@ numbers, the general heuristic is the following:
     If A and B are commits with commit time X and Y, respectively, and
     X < Y, then A _probably_ cannot reach B.
 
-This heuristic is currently used whenever the computation is allowed to
+In absence of corrected commit dates (for example, old versions of Git or
+mixed generation graph chains),
+this heuristic is currently used whenever the computation is allowed to
 violate topological relationships due to clock skew (such as "git log"
 with default order), but is not used when the topological order is
 required (such as merge base calculations, "git log --graph").
@@ -77,7 +99,7 @@ in the commit graph. We can treat these commits as having "infinite"
 generation number and walk until reaching commits with known generation
 number.
 
-We use the macro GENERATION_NUMBER_INFINITY = 0xFFFFFFFF to mark commits not
+We use the macro GENERATION_NUMBER_INFINITY to mark commits not
 in the commit-graph file. If a commit-graph file was written by a version
 of Git that did not compute generation numbers, then those commits will
 have generation number represented by the macro GENERATION_NUMBER_ZERO = 0.
@@ -93,12 +115,12 @@ fully-computed generation numbers. Using strict inequality may result in
 walking a few extra commits, but the simplicity in dealing with commits
 with generation number *_INFINITY or *_ZERO is valuable.
 
-We use the macro GENERATION_NUMBER_MAX = 0x3FFFFFFF to for commits whose
-generation numbers are computed to be at least this value. We limit at
-this value since it is the largest value that can be stored in the
-commit-graph file using the 30 bits available to generation numbers. This
-presents another case where a commit can have generation number equal to
-that of a parent.
+We use the macro GENERATION_NUMBER_V1_MAX = 0x3FFFFFFF for commits whose
+topological levels (generation number v1) are computed to be at least
+this value. We limit at this value since it is the largest value that
+can be stored in the commit-graph file using the 30 bits available
+to topological levels. This presents another case where a commit can
+have generation number equal to that of a parent.
 
 Design Details
 --------------
@@ -267,6 +289,35 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
 number of commits) could be extracted into config settings for full
 flexibility.
 
+## Handling Mixed Generation Number Chains
+
+With the introduction of generation number v2 and generation data chunk, the
+following scenario is possible:
+
+1. "New" Git writes a commit-graph with the corrected commit dates.
+2. "Old" Git writes a split commit-graph on top without corrected commit dates.
+
+A naive approach of using the newest available generation number from
+each layer would lead to violated expectations: the lower layer would
+use corrected commit dates which are much larger than the topological
+levels of the higher layer. For this reason, Git inspects the topmost
+layer to see if the layer is missing corrected commit dates. In such a case
+Git only uses topological level for generation numbers.
+
+When writing a new layer in split commit-graph, we write corrected commit
+dates if the topmost layer has corrected commit dates written. This
+guarantees that if a layer has corrected commit dates, all lower layers
+must have corrected commit dates as well.
+
+When merging layers, we do not consider whether the merged layers had corrected
+commit dates. Instead, the new layer will have corrected commit dates if the
+layer below the new layer has corrected commit dates.
+
+While writing or merging layers, if the new layer is the only layer, it will
+have corrected commit dates when written by compatible versions of Git. Thus,
+rewriting split commit-graph as a single file (`--split=replace`) creates a
+single layer with corrected commit dates.
+
 ## Deleting graph-{hash} files
 
 After a new tip file is written, some `graph-{hash}` files may no longer
-- 
gitgitgadget

