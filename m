Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0092C2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866B020B1F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI5JXhvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgKATeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgKATeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:16 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E57DC0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:16 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o13so4348775ljj.11
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRDDXIQHJMdVGOz5ZDp1n4z+Pzgmxph7m92T/ENAeoo=;
        b=tI5JXhvNKW1EU8x8MZ4X9yy8wsjJABHDHMj/BvDdbYwMPS+ADt1ZRrv1/DXWhpyzcM
         NKj9lJ1o2W1Y6bxR95I71kW57z2W6jM26IU7ay7Ibt1ILptN/TU1y6PcBb07nNEWTA/3
         PqZawt+L3FNkJnXhTSWjvvwmnvw8f8nXKdZ2l5/SOevQPWHX8R+2EVRmbWKzBCwBjNJ6
         /2nyFO/1igZA0j7XAj0rdegypzP8KHkrESnfaFgqDgFkHl7xdT8HsmhMIHoKJc/4cF8a
         ez1axVVT5QgmbKB8LZoU1aTg+hDwzztdzFV2adEkLCMMUWzx4shohWDhVTcIIxQQKxLE
         UY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRDDXIQHJMdVGOz5ZDp1n4z+Pzgmxph7m92T/ENAeoo=;
        b=Jg6goUApmZPEH0MxyaSgtp72KVZl1a5bqTrBeatt7KHALhI2KoaVFcQuo3uYrh9mHw
         fkmZJmQBHvtpPlOWROP1R07cq+RvkuZtdsIBBNDJRyh6o0fev6TxSZNIEDnW5eygKr4j
         x5Gch9kzVtd/RgViX2K3ZkgYRoG4S2m9pUsrt3zAbydS9VC5ycu6xqZBFoSIuHVhzCI4
         csO7TmVQDimiFLYWxBqLYM08iHra5a0WZJEuqoUp1Vx2UVEBwvGV8QLZfqKCcWzeZgdD
         sWuPSHOM/cX6qyuLyG5c7NvI23Hw8e+8xTlvLXJBDj/SSblQqWxeaAxA3ZiyVZB7e000
         GAeg==
X-Gm-Message-State: AOAM533aoj9FneAdA7wKbRTSp+moqFsruavnwdC2gm7miIY1RsjoyjO7
        U74+ltee7DqEPA3clKZVapQ=
X-Google-Smtp-Source: ABdhPJySqTLRnSyJs/ZL1q1DxoThhF4n5zTGQxOT5/1Sn+b02K9DJIudsZbcm8puFZjCtRhGF1rjGA==
X-Received: by 2002:a2e:9188:: with SMTP id f8mr5390613ljg.333.1604259254619;
        Sun, 01 Nov 2020 11:34:14 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:14 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 12/26] diff-merges: introduce revs->first_parent_merges flag
Date:   Sun,  1 Nov 2020 22:33:16 +0300
Message-Id: <20201101193330.24775-13-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
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

