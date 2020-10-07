Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C40AC4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07344208C7
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHuw332S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgJGOKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgJGOKC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 10:10:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24912C0613D6
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 07:10:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j2so2343420wrx.7
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 07:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hiVEWQSG+HZfs7BMxvnv6ua0Bsg8vshDXec12N3xsX4=;
        b=kHuw332SAnQYW3Cy/0oOzt9OYX0OMU7siKDbvuz9XUQJhObVt9uYOTmxDTBhFGxnFD
         yIvpO46jUaERGhiBIDyb1XyGZ5JtrKKy3ZbzOOIP3AsFG8dBHgtVZcT/vFEm5xtmK/vm
         gN7yEcZw/eePkNQKkDtvGaeP2qmRjC2n4UGvtDWYAH0pCUNmUItYjwjtMAbtIr4OQJSw
         67NFZJ+99MCprEL54YHqcNAO3wFnZAvL7+KvyFL/2L/OVE2bjStAdx/+VbidP7/KMAxH
         /Se0ZsfPdDOS77+lOs9Ppe+1SXHirK3q7x6/JxH5Z/uohW11LUKysQhUDmmkImn5PPAe
         rJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hiVEWQSG+HZfs7BMxvnv6ua0Bsg8vshDXec12N3xsX4=;
        b=oIlyjb5Nocm27lOzr6zNNmI97fZcg9RBOhWzQ2SV4MFDH0uzTu7cMf+psaaWJbcVHJ
         MgPPIJERDNsAqjPYCp1/9mi+AHoSssY3WNzQHobXFuIepOyBBbHVdJGriPCUXuw2Di5h
         NkcLqdeO0ALzWdRrSQpApGoliM6dtuDsivPWqqHGvyIn4HRhFRPo4Xt2Z2FQq47eAYtd
         FruQwrySv3i3rmHuBPGdhbAsodYD+3eI34MyfwbX75HoxU6oFlPkml2lElvmsQ5xtK20
         WSfEin9I5d1XTK3cwXqzg0DTUoH0X9Y1wtWQ/4Zpghgcs69J7CEDVAIeIJIWLyNSXtM5
         6HAw==
X-Gm-Message-State: AOAM530WK4shrHKCCHT+5bzkyWzmJ9kU+JpL7lvEpIVhHTOjgbdaaJ6J
        y/nMXUjyjLKQNLiw1yWFSkl166RkDOw=
X-Google-Smtp-Source: ABdhPJyQniRIACftN8MzjrgqFBr5FSveE9kzMZBNoGwN17dhvU8YbhQfx1Z/1VspqciWwv+AKNvmYQ==
X-Received: by 2002:adf:e304:: with SMTP id b4mr3612169wrj.141.1602079800402;
        Wed, 07 Oct 2020 07:10:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm3265845wri.45.2020.10.07.07.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:09:59 -0700 (PDT)
Message-Id: <9ada43967d29a3ec717b6a8db0de5b09e6d916b1.1602079786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 14:09:45 +0000
Subject: [PATCH v4 10/10] doc: add corrected commit date info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

With generation data chunk and corrected commit dates implemented, let's
update the technical documentation for commit-graph.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 .../technical/commit-graph-format.txt         | 21 +++++--
 Documentation/technical/commit-graph.txt      | 62 ++++++++++++++++---
 2 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index b3b58880b9..08d9026ad4 100644
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
 
@@ -86,13 +82,26 @@ CHUNK DATA:
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
 
+  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes)
+    * This list of 4-byte values store corrected commit date offsets for the
+      commits, arranged in the same order as commit data chunk.
+    * If the corrected commit date offset cannot be stored within 31 bits,
+      the value has its most-significant bit on and the other bits store
+      the position of corrected commit date into the Generation Data Overflow
+      chunk.
+
+  Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
+    * This list of 8-byte values stores the corrected commit dates for commits
+      with corrected commit date offsets that cannot be stored within 31 bits.
+
   Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
       This list of 4-byte values store the second through nth parents for
       all octopus merges. The second parent value in the commit data stores
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index f14a7659aa..75f71c4c7b 100644
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
+  * A commit with no parents (a root commit) has corrected committer date
+    equal to its committer date.
 
-Equivalently, the generation number of a commit A is one more than the
+  * A commit with at least one parent has corrected committer date equal to
+    the maximum of its commiter date and one more than the largest corrected
+    committer date among its parents.
+
+  * As a special case, a root commit with timestamp zero has corrected commit
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
 
+The properties applies to both versions of generation number, that is both
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
@@ -93,7 +115,7 @@ fully-computed generation numbers. Using strict inequality may result in
 walking a few extra commits, but the simplicity in dealing with commits
 with generation number *_INFINITY or *_ZERO is valuable.
 
-We use the macro GENERATION_NUMBER_MAX = 0x3FFFFFFF to for commits whose
+We use the macro GENERATION_NUMBER_MAX for commits whose
 generation numbers are computed to be at least this value. We limit at
 this value since it is the largest value that can be stored in the
 commit-graph file using the 30 bits available to generation numbers. This
@@ -267,6 +289,30 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
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
+levels of the higher layer. For this reason, Git inspects each layer to
+see if any layer is missing corrected commit dates. In such a case, Git
+only uses topological level
+
+When writing a new layer in split commit-graph, we write corrected commit
+dates if the topmost layer has corrected commit dates written. This
+guarantees that if a layer has corrected commit dates, all lower layers
+must have corrected commit dates as well.
+
+When merging layers, we do not consider whether the merged layers had corrected
+commit dates. Instead, the new layer will have corrected commit dates if and
+only if all existing layers below the new layer have corrected commit dates.
+
 ## Deleting graph-{hash} files
 
 After a new tip file is written, some `graph-{hash}` files may no longer
-- 
gitgitgadget
