Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD2CC433DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64183206DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtbAV0/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHICyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHICyB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:54:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AE8C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:54:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 9so4778175wmj.5
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ToI4nwdtL3GkFmibdyswuTEHfpGjEVUQmYdZnttMOF0=;
        b=LtbAV0/yP2xhFfmtECUA7xa5DtvEGeYSrGUtc2xee16iEjiE79uJWy4pgjrmzhRKk/
         I7Hxb6/4xvoA8GqyWizql/6K/Ez+8tNHAGGtjVGVH7EodQCgyjR10I3kbD5B2iTx9Fzt
         1eiuEYI0ee/Y5gL58idqj6ChGCBwiA0TjFQ1ACjEhCdqzhr5WtS5/oWVNfazmUIZXzTb
         SD6LZMWStvsHr4O8tl0+c5fHBIZL7CXmf4u/FMEiT9ZrAngaCQY8fP4InJb4qI2QArNJ
         7yAVzShXUsXV7FhznvA5e5ygHQovXamCGHjlpRwHccv6jnAcrisWQuEdJYMUoDPJwnYe
         GJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ToI4nwdtL3GkFmibdyswuTEHfpGjEVUQmYdZnttMOF0=;
        b=A3kVn2M5tblSAAjKOQsXmncKLgGaufK3l5jGTD8Uqy72Zf76CQG2yBIU8H1f55ap1A
         iscjgFHDgmgpyCpq5VwnIgqDIoIJdtZE0UT6RlplvV873X89PVu+S4BtLDKDMmAhXVt7
         5Kvlmf8brdYf4kAT8YOMPwrEXiatE5i3LSaBysDuTzvYhWS51H3c8EzKqn1ZWju/xYl2
         4xSq9wmRBWt1E+l0suvzIusTJcpo/odSZN1tOB0NSac1+XsAKSkOBu4xiK7CFy5vRnG7
         dUg65AWiFi/RHu36DU2fNKV4Is3otcV0mhyEXadFIpeP5mIw7u8AOayN+l9p9JcoxFYr
         YM1Q==
X-Gm-Message-State: AOAM531HRwFDJifT1IpA0sELTR1v8k4GPlzV+yIH9r6S82nyCzFYLg+7
        UhfzntVwurSuZLV/CTdk5adZzUfe
X-Google-Smtp-Source: ABdhPJxwnc6VvLeAYJEbFIldSZ5DodhweTIpis9eRJvnUAGprEQnNkuDk4PaJWesepltQmX4ucLoLA==
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr19146401wmh.136.1596941639622;
        Sat, 08 Aug 2020 19:53:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm16520464wmb.12.2020.08.08.19.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 19:53:58 -0700 (PDT)
Message-Id: <4c34294602b23f4427b024bbd38e4403a397fc50.1596941625.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Aug 2020 02:53:44 +0000
Subject: [PATCH v2 10/10] doc: add corrected commit date info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

With generation data chunk and corrected commit dates implemented, let's
update the technical documentation for commit-graph.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 .../technical/commit-graph-format.txt         | 12 ++---
 Documentation/technical/commit-graph.txt      | 45 ++++++++++++-------
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 440541045d..71c43884ec 100644
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
 
@@ -88,6 +84,12 @@ CHUNK DATA:
       2 bits of the lowest byte, storing the 33rd and 34th bit of the
       commit time.
 
+  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
+    * This list of 4-byte values store corrected commit date offsets for the
+      commits, arranged in the same order as commit data chunk.
+    * This list can be later modified to store future generation number related
+      data.
+
   Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
       This list of 4-byte values store the second through nth parents for
       all octopus merges. The second parent value in the commit data stores
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 808fa30b99..f27145328c 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -38,14 +38,27 @@ A consumer may load the following info for a commit from the graph:
 
 Values 1-4 satisfy the requirements of parse_commit_gently().
 
-Define the "generation number" of a commit recursively as follows:
+There are two definitions of generation number:
+1. Corrected committer dates
+2. Topological levels
+
+Define "corrected committer date" of a commit recursively as follows:
+
+  * A commit with no parents (a root commit) has corrected committer date
+    equal to its committer date.
+
+  * A commit with at least one parent has corrected committer date equal to
+    the maximum of its commiter date and one more than the largest corrected
+    committer date among its parents.
+
+Define the "topological level" of a commit recursively as follows:
 
  * A commit with no parents (a root commit) has generation number one.
 
- * A commit with at least one parent has generation number one more than
-   the largest generation number among its parents.
+ * A commit with at least one parent has topological level one more than
+   the largest topological level among its parents.
 
-Equivalently, the generation number of a commit A is one more than the
+Equivalently, the topological level of a commit A is one more than the
 length of a longest path from A to a root commit. The recursive definition
 is easier to use for computation and observing the following property:
 
@@ -67,17 +80,12 @@ numbers, the general heuristic is the following:
     If A and B are commits with commit time X and Y, respectively, and
     X < Y, then A _probably_ cannot reach B.
 
-This heuristic is currently used whenever the computation is allowed to
-violate topological relationships due to clock skew (such as "git log"
-with default order), but is not used when the topological order is
-required (such as merge base calculations, "git log --graph").
-
 In practice, we expect some commits to be created recently and not stored
 in the commit graph. We can treat these commits as having "infinite"
 generation number and walk until reaching commits with known generation
 number.
 
-We use the macro GENERATION_NUMBER_INFINITY = 0xFFFFFFFF to mark commits not
+We use the macro GENERATION_NUMBER_INFINITY to mark commits not
 in the commit-graph file. If a commit-graph file was written by a version
 of Git that did not compute generation numbers, then those commits will
 have generation number represented by the macro GENERATION_NUMBER_ZERO = 0.
@@ -93,12 +101,11 @@ fully-computed generation numbers. Using strict inequality may result in
 walking a few extra commits, but the simplicity in dealing with commits
 with generation number *_INFINITY or *_ZERO is valuable.
 
-We use the macro GENERATION_NUMBER_MAX = 0x3FFFFFFF to for commits whose
-generation numbers are computed to be at least this value. We limit at
-this value since it is the largest value that can be stored in the
-commit-graph file using the 30 bits available to generation numbers. This
-presents another case where a commit can have generation number equal to
-that of a parent.
+We use the macro GENERATION_NUMBER_MAX for commits whose generation numbers
+are computed to be at least this value. We limit at this value since it is
+the largest value that can be stored in the commit-graph file using the
+available to generation numbers. This presents another case where a
+commit can have generation number equal to that of a parent.
 
 Design Details
 --------------
@@ -267,6 +274,12 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
 number of commits) could be extracted into config settings for full
 flexibility.
 
+We also merge commit-graph chains when we try to write a commit graph with
+two different generation number definitions as they cannot be compared directly.
+We overwrite the existing chain and create a commit-graph with the newer or more
+efficient defintion. For example, overwriting topological levels commit graph
+chain to create a corrected commit dates commit graph chain.
+
 ## Deleting graph-{hash} files
 
 After a new tip file is written, some `graph-{hash}` files may no longer
-- 
gitgitgadget
