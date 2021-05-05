Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77120C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 11:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FED61078
	for <git@archiver.kernel.org>; Wed,  5 May 2021 11:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhEEL51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 07:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhEEL50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 07:57:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F8C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 04:56:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l13so1510390wru.11
        for <git@vger.kernel.org>; Wed, 05 May 2021 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+DbsHmTo6JmZbaA4DFBE19RNOwDTJe4Cj8xbnxyfcGc=;
        b=DZw8Y+0nCPDA/WwRjRnzRU/Ocbl1orZUXel+B68yPZUtAR8pn+gw8rh7HSK1qMoo2b
         vIUEKwYX0I/W7EQphNnu+k+exOTPhQZoUmtcNS3HGmHJx+lTpCoZJ25oyoyGGhEJUQJh
         RWmrudR0TBZuqonUrE9bjbf5BuTibvl47K3QNatscI1pfad01+Dgj17BVy0m7PxnI9uY
         h5LHIo9W5MsyYyBuOOQEJlGFZdL+SUnyaYsTBvsz/EFSKvvc/sEf3JyTW7US31mvc7DI
         C8bWN8OdBGG6fLFf/PxVjxr5EvXYu69JDUI0GocWb5DKCqK+udP39AtpLyHdnhu4Yq8I
         lCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+DbsHmTo6JmZbaA4DFBE19RNOwDTJe4Cj8xbnxyfcGc=;
        b=B6kcHonlDdn8cfCZfykT4gvLAq+hf3gmUm0uoceu186voqgE6yPM2b45RgvkyqM6cN
         i8SJFktRCiZELqBBeYK0NcrsKa/0LhKxGFnwyJeRJnD60H4r1fjJ3jSg3UaCNteuNtJx
         cxmjnqF+bPvoBm+vbuqR+TcmrkE+g0rFiR6AhVKFc7hiPW7S3p+OngTGnbEOm8ww9uQQ
         NEv5bPNDufvFyps3Rbwi8dlKvWITDVp7fE/Hs+ao5gMPYXS4UtW2f5qH0J0F9a8FXTuu
         sSwePT10FqZwMi6UzbRIf7lABCDMha/HOjM9Wy5J6ipwamJdhEFDZ6TdhTpZMbsjC/aY
         /X6w==
X-Gm-Message-State: AOAM533VYIdInFd8dyP0SI2BdL3YeaaNVejc0EG0QjWenJF0d2eg0Dkq
        6lYPtO6H3NXyM27kfMgQSt7+JaRB5Ac=
X-Google-Smtp-Source: ABdhPJzHKJlTXbBngSMSIyeGGhgSt9A4DNHWqjpoIOE6MZaD2qDJ3e9lbkXXEQGIwzmntdztFowypw==
X-Received: by 2002:adf:e0c8:: with SMTP id m8mr38490797wri.349.1620215787676;
        Wed, 05 May 2021 04:56:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm19392332wrf.91.2021.05.05.04.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 04:56:27 -0700 (PDT)
Message-Id: <pull.1013.v2.git.git.1620215786.gitgitgadget@gmail.com>
In-Reply-To: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com>
References: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com>
From:   "Joachim Kuebart via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 May 2021 11:56:24 +0000
Subject: [PATCH v2 0/2] git-p4: speed up search for branch parent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this iteration, I have added more context and measurements to the commit
message.

I have also made small improvements to the code suggested by reviewers.

I enhanced t9801-git-p4-branch.sh to test for the functionality, namely that
branches are branched off at the correct point in their parents' history.

Signed-off-by: Joachim Kuebart joachim.kuebart@gmail.com

cc: Joachim Kuebart joachim.kuebart@gmail.com

Joachim Kuebart (2):
  git-p4: ensure complex branches are cloned correctly
  git-p4: speed up search for branch parent

 git-p4.py                | 21 ++++++++++-----------
 t/t9801-git-p4-branch.sh |  2 ++
 2 files changed, 12 insertions(+), 11 deletions(-)


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1013%2Fjkuebart%2Fp4-faster-parent-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1013/jkuebart/p4-faster-parent-v2
Pull-Request: https://github.com/git/git/pull/1013

Range-diff vs v1:

 -:  ------------ > 1:  0ee0b7b55691 git-p4: ensure complex branches are cloned correctly
 1:  a171f7e6c023 ! 2:  41b3a23f682c git-p4: speed up search for branch parent
     @@ Metadata
       ## Commit message ##
          git-p4: speed up search for branch parent
      
     -    Previously, the code iterated through the parent branch commits and
     -    compared each one to the target tree using diff-tree.
     +    For every new branch that git-p4 imports, it needs to find the commit
     +    where it branched off its parent branch. While p4 doesn't record this
     +    information explicitly, the first changelist on a branch is usually an
     +    identical copy of the parent branch.
      
     -    This patch outputs the revision's tree hash along with the commit hash,
     -    thereby saving the diff-tree invocation. This results in a considerable
     -    speed-up, at least on Windows.
     +    The method searchParent() tries to find a commit in the history of the
     +    given "parent" branch whose tree exactly matches the initial changelist
     +    of the new branch, "target". The code iterates through the parent
     +    commits and compares each of them to this initial changelist using
     +    diff-tree.
     +
     +    Since we already know the tree object name we are looking for, spawning
     +    diff-tree for each commit is wasteful.
     +
     +    Use the "--format" option of "rev-list" to find out the tree object name
     +    of each commit in the history, and find the tree whose name is exactly
     +    the same as the tree of the target commit to optimize this.
     +
     +    This results in a considerable speed-up, at least on Windows. On one
     +    Windows machine with a fairly large repository of about 16000 commits in
     +    the parent branch, the current code takes over 7 minutes, while the new
     +    code only takes just over 10 seconds for the same changelist:
     +
     +    Before:
     +
     +        $ time git p4 sync
     +        Importing from/into multiple branches
     +        Depot paths: //depot
     +        Importing revision 31274 (100.0%)
     +        Updated branches: b1
     +
     +        real    7m41.458s
     +        user    0m0.000s
     +        sys     0m0.077s
     +
     +    After:
     +
     +        $ time git p4 sync
     +        Importing from/into multiple branches
     +        Depot paths: //depot
     +        Importing revision 31274 (100.0%)
     +        Updated branches: b1
     +
     +        real    0m10.235s
     +        user    0m0.000s
     +        sys     0m0.062s
      
          Signed-off-by: Joachim Kuebart <joachim.kuebart@gmail.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Luke Diamand <luke@diamand.org>
      
       ## git-p4.py ##
      @@ git-p4.py: def importNewBranch(self, branch, maxChange):
     @@ git-p4.py: def importNewBranch(self, branch, maxChange):
           def searchParent(self, parent, branch, target):
      -        parentFound = False
      -        for blob in read_pipe_lines(["git", "rev-list", "--reverse",
     -+        for tree in read_pipe_lines(["git", "rev-parse",
     -+                                     "{}^{{tree}}".format(target)]):
     -+            targetTree = tree.strip()
     -+        for blob in read_pipe_lines(["git", "rev-list", "--format=%H %T",
     ++        targetTree = read_pipe(["git", "rev-parse",
     ++                                "{}^{{tree}}".format(target)]).strip()
     ++        for line in read_pipe_lines(["git", "rev-list", "--format=%H %T",
                                            "--no-merges", parent]):
      -            blob = blob.strip()
      -            if len(read_pipe(["git", "diff-tree", blob, target])) == 0:
      -                parentFound = True
     -+            if blob[:7] == "commit ":
     ++            if line.startswith("commit "):
      +                continue
     -+            blob = blob.strip().split(" ")
     -+            if blob[1] == targetTree:
     ++            commit, tree = line.strip().split(" ")
     ++            if tree == targetTree:
                       if self.verbose:
      -                    print("Found parent of %s in commit %s" % (branch, blob))
      -                break
     @@ git-p4.py: def importNewBranch(self, branch, maxChange):
      -            return blob
      -        else:
      -            return None
     -+                    print("Found parent of %s in commit %s" % (branch, blob[0]))
     -+                return blob[0]
     ++                    print("Found parent of %s in commit %s" % (branch, commit))
     ++                return commit
      +        return None
       
           def importChanges(self, changes, origin_revision=0):

-- 
gitgitgadget
