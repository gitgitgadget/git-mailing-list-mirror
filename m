Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1863AC433F5
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 04:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiAIE5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 23:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiAIE5o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 23:57:44 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8971AC06173F
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 20:57:44 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id f17so8225376qtf.8
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 20:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whPr45EM3mrUiq0nlCUXp2DDFSdTm1EG5P1gsMcYufU=;
        b=jaPJhEwWNXjokv/eOwqAsUbu554H7XceTduZkDbamxyb2HMUioGOcgef67+t8VnY3E
         PeCW+fPDrGKkxoRieRvf9WTHf5OiNy4ufjXspOFlDBII9r+ZErk9PNSgQsQ84IGxtScA
         edYB5v2bkfADMb4eWbtLnQppyfVcxFVTjl4O8ZHMzITCVOhznYFfI4AhvOudULNbAEb1
         H0FTES8D7mEA1aas6bOL94+Caf5+F+zCj9Dnc8jZakyhe8bLaW5MNGph0DihKb6NY6X3
         xynIk40k5Lx5pMA2RWW90X6H4UCEzWYh99RihagAi4lPWgWNcXsxad/3SbMRCVpsFmLP
         JoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whPr45EM3mrUiq0nlCUXp2DDFSdTm1EG5P1gsMcYufU=;
        b=YmFYNaBRRxYDyLxAQnSIg1VZkKeMivoqMD8tCthhZTqDitrNMjgc+rnfnl6cWdumcr
         Wdl3C5LXGfhSOHH/AhebaZuowJov/HFUzsIZmIK4uRBNAivxWU58gMqT/GaCztNSK30w
         inCpX7JrTlet4PnKuqyleDtQs7PcfVoCzSMMFt4LSBBN4GcuIY4NjPcK7YmwI6QUsywN
         Nxq0X45NHQiRpdQrtScAf4lPwGvPAqRGSI6iIhK20q008eCVNfv727BzSoh12rDCO3QU
         +2NsVcA/hv4bjSEZ+t+aiSuUgZYha8RONiMtFs035cheQ6OfDvFeUB1JZc0ng6xqFpAq
         KWmA==
X-Gm-Message-State: AOAM531nrZ1pN4vmcBtgPYd7SxrzXDKBSiIyklEXBxHhw3ZkjEJMbv0Z
        PY3zjaUkmNtx8Flh6gryQe5IpAQN/0Q7ow==
X-Google-Smtp-Source: ABdhPJzWLttHCCKVTxH9Nxkx/5UG3Qrw9Cx9jR4xaJQ7ELJ4MaME42MR/xwimugDb1gHbHn+ER+Rxw==
X-Received: by 2002:ac8:7dc1:: with SMTP id c1mr59821418qte.275.1641704263438;
        Sat, 08 Jan 2022 20:57:43 -0800 (PST)
Received: from iron-rod.attlocal.net ([2600:1700:bae0:2de0::1b])
        by smtp.gmail.com with ESMTPSA id t5sm2118915qtp.60.2022.01.08.20.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 20:57:43 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 1/5] t1011: add testcase demonstrating accidental loss of user modifications
Date:   Sat,  8 Jan 2022 20:57:28 -0800
Message-Id: <20220109045732.2497526-2-newren@gmail.com>
X-Mailer: git-send-email 2.34.1.442.ge63c19bdd2.dirty
In-Reply-To: <20220109045732.2497526-1-newren@gmail.com>
References: <20220109045732.2497526-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user has a file with local modifications that is not marked as
SKIP_WORKTREE, but the sparsity patterns are such that it should be
marked that way, and the user then invokes a command like

   * git checkout -q HEAD^

or

   * git read-tree -mu HEAD^

Then the file will be deleted along with all the users' modifications.
Add a testcase demonstrating this problem.

Note: This bug only triggers if something other than 'HEAD' is given;
if the commands above had specified 'HEAD', then the users' file would
be left alone.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 24092c09a9..1b2395b8a8 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -187,6 +187,27 @@ test_expect_success 'read-tree updates worktree, absent case' '
 	test ! -f init.t
 '
 
+test_expect_success 'read-tree will not throw away dirty changes, non-sparse' '
+	echo "/*" >.git/info/sparse-checkout &&
+	read_tree_u_must_succeed -m -u HEAD &&
+
+	echo dirty >init.t &&
+	read_tree_u_must_fail -m -u HEAD^ &&
+	test_path_is_file init.t &&
+	grep -q dirty init.t
+'
+
+test_expect_failure 'read-tree will not throw away dirty changes, sparse' '
+	echo "/*" >.git/info/sparse-checkout &&
+	read_tree_u_must_succeed -m -u HEAD &&
+
+	echo dirty >init.t &&
+	echo sub/added >.git/info/sparse-checkout &&
+	read_tree_u_must_fail -m -u HEAD^ &&
+	test_path_is_file init.t &&
+	grep -q dirty init.t
+'
+
 test_expect_success 'read-tree updates worktree, dirty case' '
 	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
-- 
2.34.1.442.ge63c19bdd2.dirty

