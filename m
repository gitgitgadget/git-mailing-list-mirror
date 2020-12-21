Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CDAC433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2024822D49
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgLUSbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgLUSbT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:31:19 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FCDC061282
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:30:38 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x20so25913092lfe.12
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zqcafpKHKxDK3E24G5BLPajTI0iF1/0C2lXgtKLMD60=;
        b=Dx2OeBIv4Bz9O/3ZV8+A3Z6a8tH9ufhzXi/qxyMpe4uqevSaJX2MbSIclL2t7gpfmG
         q7k9pi+bgDpJFTGbmfVqHquq7/EhJ6JhW3eTelX6tt3KkweDLg37QBFgRIsFSCUCTMvA
         bnpsxAK36ILuMP5yStac+8wFGOaU4n/oibSAohAohpc4lSZa4D3YDdX8tQ5DWclLwxIz
         uJeScIWuTbs8xBdqHZ4PfP3oS3dp825JpP9aASj8Vxv8cZwP9cq7IDDG7XciGMlKh/8T
         fSTaXl1vuGLVLlWNVgAwVd/Z/8P2xhrDXFv/9JHO+JkkzQvpoAu/BopHLv01MU/H2WKj
         g+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqcafpKHKxDK3E24G5BLPajTI0iF1/0C2lXgtKLMD60=;
        b=BDZ84ifkSub7gU5bkQiz0gVOv0Gov6m6yDxDLhEPUFLsa1eI/bFHAx0pLgjRUyDEIt
         zjxPxFVAIGRHnEcoATNwVFCuoF0z2uyQst6Izn0b4qMrMKmFbcjIBNB1wRvNgkeCCul0
         69Z7lHzDohPMg59faDsOZL7kacwVifEilygzyko8BRm+G0HJFG40gBo4EVVblVw+OKKo
         wIAZeUQHvcugP7VkUeybfjuCSHiZzOi/43qRJ41YUMy0ujjRUmIjd+RKcs0KqyJvkfmw
         tDOvISXNA/AE98ZwAjUNK7yc8XiOEeF35QH+PVXrLIqVtMlyEoKZBnkxlTDxK5iEkRQx
         RGaw==
X-Gm-Message-State: AOAM531cVtnSvFOsECvIruw65Ok8DR+wcysCqdxBSta0SRtZz8z4bkL8
        KKPhi3FRaOxqLgCnvxsTfzpLFLg4msg=
X-Google-Smtp-Source: ABdhPJwQfEJYYwkABv1EA25HbdwecXkai8XMM2hT+Cv3nATn2Xt18HA2SkojTTXqMQ2bgOTVBehmaw==
X-Received: by 2002:a2e:50b:: with SMTP id 11mr7507022ljf.484.1608564047310;
        Mon, 21 Dec 2020 07:20:47 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:46 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 12/32] diff-merges: introduce revs->first_parent_merges flag
Date:   Mon, 21 Dec 2020 18:19:40 +0300
Message-Id: <20201221152000.13134-13-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
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
index 24f922cf8a0f..fb591a933959 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -73,6 +73,8 @@ void diff_merges_default_to_first_parent(struct rev_info *revs)
 {
 	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
+	if (!revs->combine_merges)		/* No -c/--cc" */
+		revs->first_parent_merges = 1;
 }
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs)
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

