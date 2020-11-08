Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DA6C388F9
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69D720657
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxL0dETH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgKHVlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgKHVld (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:33 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEAAC0613D2
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:32 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id 23so7825129ljv.7
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRDDXIQHJMdVGOz5ZDp1n4z+Pzgmxph7m92T/ENAeoo=;
        b=MxL0dETH9qM13ivFaHhjsZpDpqFYwiazdLKzjAV1Ybt6mLg9ONVreUBERLx5yajM0z
         eCUVcxEFfF/afsAmCfSduYvOeBnGIL6zNB89ZSTMbcdtSq/5jzlxBF7ZSYGeOmKW8kHp
         WTRDC+ZQfAOt0AzThzCPMsXaa0h+p6QpiBK3XWrCidApkv61Hlphr7+XMXQfPby5DvMd
         KwwS2vW0YiOoa76ZnjQoOdRdpVKf3VJ/0U63/TUdMJOSm9YXn1ejE/eRoLxCuQ7NEEdf
         LfLSfHvKKHZKhVqWdkozUh4XXVl1ksAWybS4siHpROEgPPmL7bzj0jNXBxNxs9P/fJY8
         gbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRDDXIQHJMdVGOz5ZDp1n4z+Pzgmxph7m92T/ENAeoo=;
        b=SIKGG2/HaWSSyTcCwyODSQfJj7rkUPeORUsh3ckD6mEcp1PPtiXqX0DbkON2Jnd1QH
         mnNrUp0jjRJ9VrNHHkBujCCIRjyu3wL4zoua47xejT+kBzAHlLKjHCbiRHnxUaKszWCW
         4EtT0Sp/BQ9afGD7V3SfxJzbJQNngJjAxTubMX8lSA6/csl7mZZuAUagFoUFcl1i5pXr
         GXW1RN2Bap87jC7G6tLfjfpJ8fo2uaBrCv7+rVs5RsjElD99mu1C2qLxmTv/aIbEABFA
         H4uzZCgI6AutTb1PF+/s7ypDtUNzH913aynQtIlHkBqh5bYU16RB6LRJtDuK71LSvgJO
         Yx/g==
X-Gm-Message-State: AOAM532Oo7Bx0IEbj/wHRBnMxmLVwb5RJZPaoDWumZV8k6PECCMrJEyi
        6M0iLaqFIb1M1ZdE0J2fDPI=
X-Google-Smtp-Source: ABdhPJzkj7MiQEzCdEe4GC3nDX02RtE6HdJ2OxTc8dM4dYdHTq9Rj3mRFF8AtUNLxL0fXfvXIL2DMg==
X-Received: by 2002:a2e:9798:: with SMTP id y24mr4513092lji.341.1604871691320;
        Sun, 08 Nov 2020 13:41:31 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:30 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 12/27] diff-merges: introduce revs->first_parent_merges flag
Date:   Mon,  9 Nov 2020 00:38:23 +0300
Message-Id: <20201108213838.4880-13-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new field allows us to separate format of diff for merges from
'first_parent_only' flag which primary purpose is limiting history
traversal.

This change further localizes diff format selection logic into the
diff-merges.c file.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 2 ++
 log-tree.c    | 4 ++--
 revision.h    | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 691aabadbb32..63912ddedc76 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -67,6 +67,8 @@ void diff_merges_suppress(struct rev_info *revs) {
 void diff_merges_default_to_first_parent(struct rev_info *revs) {
 	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
+	if (!revs->combine_merges)		/* No -c/--cc" */
+		revs->first_parent_merges = 1;
 }
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs) {
diff --git a/log-tree.c b/log-tree.c
index 1927f917ce94..3fdc0fc64bfb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -922,7 +922,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			return 0;
 		else if (opt->combine_merges)
 			return do_diff_combined(opt, commit);
-		else if (!opt->first_parent_only) {
+		else if (!opt->first_parent_merges) {
 			/* If we show multiple diffs, show the parent info */
 			log->parent = parents->item;
 		}
@@ -941,7 +941,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 
 		/* Set up the log info for the next parent, if any.. */
 		parents = parents->next;
-		if (!parents || opt->first_parent_only)
+		if (!parents || opt->first_parent_merges)
 			break;
 		log->parent = parents->item;
 		opt->loginfo = log;
diff --git a/revision.h b/revision.h
index f6bf860d19e5..ba2aef79215e 100644
--- a/revision.h
+++ b/revision.h
@@ -194,6 +194,7 @@ struct rev_info {
 			combine_merges:1,
 			combined_all_paths:1,
 			dense_combined_merges:1,
+			first_parent_merges:1,
 			always_show_header:1;
 	int             ignore_merges:2;
 
-- 
2.25.1

