Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA43C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38B62342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgLPSvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbgLPSvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:51 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FBC0611CB
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:40 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a12so50989239lfl.6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vsnXzJS5eiuSe81pBgFKgcgEe/GVj5jNtbJuSpzYSDk=;
        b=T3IGEb1u9GzttcZxw0l3zk/PO3NyjNCRWry/V2A1UZqKETEyrDvDQj1QsEACWqGK7/
         Y1xrw+rw9ev99aOjuuYWm+4BRoDF1Oqd2BnVRiqYCvAiSNh2+J8oTGY1B7sD/hEji4f3
         oLw4bwMhGf0SQ/DX37nMudBXy6HTBKUjnTJ8umCylgMAucnwoj6pdXpd1BYiQ6+kBEPA
         5aecxZMvQUgj5ZTbHGFHdTtH6QYREqr4TK+MyvLbztbOLuhgbLXfYjW8I47i/0KAx5rp
         8a+SxCRswHYg0fSwK1qZlF/csAtGP+F782SoQmLB47FBws/FcHHGz8+7JxJs4vtZoBD0
         kFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vsnXzJS5eiuSe81pBgFKgcgEe/GVj5jNtbJuSpzYSDk=;
        b=nmO2TNJz8W/BLS/f35ZSppyrLZ+zC08KXYO8inWXFCwcIkqh7AuaLivQfHKDdAJtPX
         6wwbwumToLBPAcfeIRFK91DWAMU4AP32OmfXnNADnTw7h8lsnCn5SRrnYnRdgerZedr1
         JUHV9LHAQHWM20Nhp26dGE/jqcGnGjBWAv+QuC1r1nlh3dz8WzAb6LSvZZznJcQwfjm/
         P1egyQToYe4EkKSDkHGFEAl/kYUvAOY3Ueb01kyWZIq7wv/vHCjGuoT0GM84Vvrf40sZ
         msS8o4RDU4dXLmqlxoCS3nue8wrvWlt/uOgx6P2cwfR5F16imyil203Lj9nenQ8pIOJY
         +Efg==
X-Gm-Message-State: AOAM532HOP6dmXmtjiMS21KGAD7fPVBwjuq1CUsYNQLqFyZhtNw+xNa3
        FR1bAQstlHgjhTh0ysdGxBM=
X-Google-Smtp-Source: ABdhPJyC2fij8uKydENF8trEMMQ8bL5/+MQERGvcSfstiXEHM1STXydWwlvC/45XYfx4TCntrWci5g==
X-Received: by 2002:a19:be0c:: with SMTP id o12mr13432617lff.479.1608144638473;
        Wed, 16 Dec 2020 10:50:38 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:37 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 12/33] diff-merges: introduce revs->first_parent_merges flag
Date:   Wed, 16 Dec 2020 21:49:08 +0300
Message-Id: <20201216184929.3924-13-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
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
index 899f9e905d3c..c99d77a318dc 100644
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

