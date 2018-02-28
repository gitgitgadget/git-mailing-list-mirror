Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4502F1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933320AbeB1TIm (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:08:42 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54016 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933198AbeB1TIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:08:25 -0500
Received: by mail-wm0-f67.google.com with SMTP id t74so7114171wme.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sf/0JRipMIvQtGg+TlUaVLiKDUPNiuju8T5nMs/Q+vs=;
        b=oD6Xj0l41y3gwEM6X9Cqf/v9gi3LIKPVBnxUIncY0/xMByuF78JRzoz9DXU4IMM191
         qGft4XAsWM2BWHFcPKHA8ieAAYQ52656PzZPKVf5H584/sxidbpGYviGXA0QMorl6SbH
         wCNXpl4cD+0MAIFgONCoaaKSMTzMZsvIdSckArYVxl8xZQl3/k/bgGRytcdSh5LIyhPq
         yGikYDMq2oQU8vr00/B39apBiS1iGE8c3s09hnblNTiSCiP2h/d67EWRzLAd61RJ+1f4
         0uaRRyHWmyCjYnvSaLMAO+mDhm5LFKZQ34ZlSLX6KzOxTF12VseVLVGsjlanTbr9DpXa
         dpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sf/0JRipMIvQtGg+TlUaVLiKDUPNiuju8T5nMs/Q+vs=;
        b=TvOQ/5jFbwyG/wVLPb1RNYcECCLfBKytQlGUn2o550jY6vPC2ekJLqFEJRUijV/4s4
         M+yT8n0hTiO1PPQUg2bZ8hKkQ3bdIR1DlFRJmw7mFtAMjBNnrxTawVCqHj0Ie1ZM4biS
         ej5kYTYVZNLpdlBzEygFPbbJJ6Jz2KKsjOEHrNryeKaNfr2vctjNv9xjRcNGqNxGRlML
         J0fXxKGjb7hzojac4oBbyWseU+43O/8JX+roDUnyCnvZUCpPjB27AfrfY1yihhTM/rIG
         T3tc61WLQXg3CIaA8WH6B8UlULOPiRixkKXnUqnKF6g9Eq5SzR/HV6IA8WpO2JReTSix
         iGLg==
X-Gm-Message-State: APf1xPCfkJS5nnVQVy6VvDYthibVbosguWazFIGdss42ds5bVUcEb/wN
        k6hWnxf9BXGdM6E8oYoLMu/1SJpE
X-Google-Smtp-Source: AG47ELvqfVvXCHqjF5TBOxr2RyjSw75bYfN27ZJFXW/InZynjNCptEmz75CLjBuGMopqHGsRXRj2GQ==
X-Received: by 10.28.54.150 with SMTP id y22mr13949292wmh.74.1519844903434;
        Wed, 28 Feb 2018 11:08:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p76sm2832609wmb.19.2018.02.28.11.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 11:08:22 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 4/5] merge: always roll back lock in `checkout_fast_forward()`
Date:   Wed, 28 Feb 2018 20:07:57 +0100
Message-Id: <45540e492e4b6498254f61601779076ff6d21d1d.1519843916.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519843916.git.martin.agren@gmail.com>
References: <CAN0heSqmWAN=rCO8busGtb0xNPiB5H_jkL664qH8xasPq1Sy0A@mail.gmail.com> <cover.1519843916.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function originated in builtin/merge.c. It was moved to merge.c in
commit db699a8a1f (Move try_merge_command and checkout_fast_forward to
libgit.a, 2012-10-26), but was used from sequencer.c even before that.

If a problem occurs, the function returns without rolling back the
lockfile. Teach it to do so.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 merge.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/merge.c b/merge.c
index 195b578700..f06a4773d4 100644
--- a/merge.c
+++ b/merge.c
@@ -113,17 +113,23 @@ int checkout_fast_forward(const struct object_id *head,
 	setup_unpack_trees_porcelain(&opts, "merge");
 
 	trees[nr_trees] = parse_tree_indirect(head);
-	if (!trees[nr_trees++])
+	if (!trees[nr_trees++]) {
+		rollback_lock_file(&lock_file);
 		return -1;
+	}
 	trees[nr_trees] = parse_tree_indirect(remote);
-	if (!trees[nr_trees++])
+	if (!trees[nr_trees++]) {
+		rollback_lock_file(&lock_file);
 		return -1;
+	}
 	for (i = 0; i < nr_trees; i++) {
 		parse_tree(trees[i]);
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
-	if (unpack_trees(nr_trees, t, &opts))
+	if (unpack_trees(nr_trees, t, &opts)) {
+		rollback_lock_file(&lock_file);
 		return -1;
+	}
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
 	return 0;
-- 
2.16.2.246.ga4ee44448f

