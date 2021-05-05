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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B443FC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 11:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852F661176
	for <git@archiver.kernel.org>; Wed,  5 May 2021 11:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhEEL52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhEEL50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 07:57:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DA3C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 04:56:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d11so1521626wrw.8
        for <git@vger.kernel.org>; Wed, 05 May 2021 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hvn7EiGjvwy1Mi/ScKX4qJbM5soS2kTD5YIgEB63P3U=;
        b=VOLSArWc6abhFQWvEX9AnGTmYCd+ZDhpJaFuPC7rwFVh+xuMjuqCulJBaBWCWQHc6G
         ixEf7uHIFjgjAMNTBOwAwys6LMgpv8Z5Xdxxn80Fk9Q9Dk1aR30T2bNNX6TlJAGliR2i
         aFDkiVmjQh2W1f85BaAQ8tblx5Ez4cys67RNfWBuKOiNHtHNPa4/+sKaC1YBvPkTPYva
         1iDG/CwDDHfjXA0sGkvtkQ9TTDtb3ZzvWJkmaclf94nRUzfcxKTh5F+6ppLx0xbGojxn
         ydZolDmhG5ad9M5EJUAdP2iZVMXuFkg9RAIH58DlGjC4LPRX7qnmuK2gsB7AF3SBYG1j
         qeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hvn7EiGjvwy1Mi/ScKX4qJbM5soS2kTD5YIgEB63P3U=;
        b=pI9Zc44jeRHawlq2JjP181weOK1Z8wcBBKlrSrqvkb+9mlRCRfgvavb1dOt4qmaMOu
         W75rMHDAMc7ZWudWtOvhDa4G0lBWa+8h9NXtjrxZ1+zxe7A2hV+eSJ6Gb7vp85taqBZa
         EPWq5DvAJ52N4P65mnoWa9a6rHjmFGcT4EK0ioydpk6oOs7vimpPj+gTll4YcTW+A8q9
         jNtLGDev7fXlTUx89p0xET/QcBo2ooH8xMdT3ijtFqKhKhmJMnEjgnqRK8mYSK4blc1D
         +sMf7ThlaMt5bdMWI7l9ij5qO+zjYrjClHGf8NEOKX2zVrJQFJJSivvop2Xb5rzJAJTi
         9JSQ==
X-Gm-Message-State: AOAM533PwgR355JzGMBIVcjUppA6e1LHQLXohYT+dH5b3P9ejdLs3Ynh
        Ufy7LkZ4t9JWy9D8q7DJ2dm72rQmMxM=
X-Google-Smtp-Source: ABdhPJwpGQVeFloEQLUdPu3K6/FKtR/AqpELPoGb7cCSnnFRUTVDD1+vHKqw/STyjDuvW/QYYngYbQ==
X-Received: by 2002:adf:e44e:: with SMTP id t14mr38682019wrm.310.1620215788954;
        Wed, 05 May 2021 04:56:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm6493918wrt.30.2021.05.05.04.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 04:56:28 -0700 (PDT)
Message-Id: <41b3a23f682cddb3720de14723854c5956f25704.1620215786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1013.v2.git.git.1620215786.gitgitgadget@gmail.com>
References: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com>
        <pull.1013.v2.git.git.1620215786.gitgitgadget@gmail.com>
From:   "Joachim Kuebart via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 May 2021 11:56:26 +0000
Subject: [PATCH v2 2/2] git-p4: speed up search for branch parent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joachim Kuebart <joachim.kuebart@gmail.com>

For every new branch that git-p4 imports, it needs to find the commit
where it branched off its parent branch. While p4 doesn't record this
information explicitly, the first changelist on a branch is usually an
identical copy of the parent branch.

The method searchParent() tries to find a commit in the history of the
given "parent" branch whose tree exactly matches the initial changelist
of the new branch, "target". The code iterates through the parent
commits and compares each of them to this initial changelist using
diff-tree.

Since we already know the tree object name we are looking for, spawning
diff-tree for each commit is wasteful.

Use the "--format" option of "rev-list" to find out the tree object name
of each commit in the history, and find the tree whose name is exactly
the same as the tree of the target commit to optimize this.

This results in a considerable speed-up, at least on Windows. On one
Windows machine with a fairly large repository of about 16000 commits in
the parent branch, the current code takes over 7 minutes, while the new
code only takes just over 10 seconds for the same changelist:

Before:

    $ time git p4 sync
    Importing from/into multiple branches
    Depot paths: //depot
    Importing revision 31274 (100.0%)
    Updated branches: b1

    real    7m41.458s
    user    0m0.000s
    sys     0m0.077s

After:

    $ time git p4 sync
    Importing from/into multiple branches
    Depot paths: //depot
    Importing revision 31274 (100.0%)
    Updated branches: b1

    real    0m10.235s
    user    0m0.000s
    sys     0m0.062s

Signed-off-by: Joachim Kuebart <joachim.kuebart@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 09c9e93ac401..d34a1946b754 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3600,19 +3600,18 @@ def importNewBranch(self, branch, maxChange):
         return True
 
     def searchParent(self, parent, branch, target):
-        parentFound = False
-        for blob in read_pipe_lines(["git", "rev-list", "--reverse",
+        targetTree = read_pipe(["git", "rev-parse",
+                                "{}^{{tree}}".format(target)]).strip()
+        for line in read_pipe_lines(["git", "rev-list", "--format=%H %T",
                                      "--no-merges", parent]):
-            blob = blob.strip()
-            if len(read_pipe(["git", "diff-tree", blob, target])) == 0:
-                parentFound = True
+            if line.startswith("commit "):
+                continue
+            commit, tree = line.strip().split(" ")
+            if tree == targetTree:
                 if self.verbose:
-                    print("Found parent of %s in commit %s" % (branch, blob))
-                break
-        if parentFound:
-            return blob
-        else:
-            return None
+                    print("Found parent of %s in commit %s" % (branch, commit))
+                return commit
+        return None
 
     def importChanges(self, changes, origin_revision=0):
         cnt = 1
-- 
gitgitgadget
