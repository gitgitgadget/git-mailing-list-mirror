Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268F1C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 13:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9AC2070A
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 13:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEbpNv7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgCTNJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:09:27 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:35447 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCTNJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 09:09:27 -0400
Received: by mail-pj1-f45.google.com with SMTP id j20so2441947pjz.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rxwl/aCDnjx0wQl1ATRzJWSp1LfYerWUEOOo7KjlGKA=;
        b=WEbpNv7+gw/IDQsi42KhbEfgJjHltpaaU2BscbLI5PAvGt/lu5D39inHZtJzv085pM
         Oh3BtyAA4mTfE34K9DS7cNXOdbm67/KxgzDpxRD+Pm5xjkI2jmJvk9RQe6qGhwTBlIH0
         AZnmLsqZzPKFmMcksAmY2CTPBgWvCtrtUZkA0mugoXN41+GCbl+eJ1fphrdz1+7lxKi4
         VVUpAAKf5Iir0s8CY8QGTGqlp7+9sa2TilNdqQ4m83c7yLGGIQDWelk1AgIhlRmVsVed
         2PDQUU410rbYSdZIBckUUhw5IRK9gaEHDDuMPdUzpPRG5L4x5dc1mLjwIo1AHaVQEO9D
         unFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxwl/aCDnjx0wQl1ATRzJWSp1LfYerWUEOOo7KjlGKA=;
        b=UPHazcZLT3IMF2p8glmIxzLRbe59PCLtSfahn0vV7SM/y+CMtVL3kTSB9nG4mkAs4t
         AxqxiSYs7azhnViUPWi7B01foISIUZXIXuyeyC96sSKi6ADatzDhRcajfy72brnzyvT+
         HYnLDA1HIsbDMNrElEfT1I+QySdN/T+3VSELNZxUfE35A11DA1bIsMBhU245jRBJ21Nt
         tAWTvZ3FcLwgggZ5uDELEBPLHNPrb3Pi6JTrMXg2RS1DD+SRoTJBBr3AhadBfayTBv52
         SiOo6jDZ+edqslVZkFWEvC6Lt8t9Af6o+n3rNE1IXCo4mJYiqgwfrk2mnP53zOqM1yNy
         sRJA==
X-Gm-Message-State: ANhLgQ14SvG+vs9urpty8sllEZ8mhp1Ao7/Jika2o5GgkP6NmR/gdhjN
        ooxdHZetYam3Y0bQ8HFCfpo=
X-Google-Smtp-Source: ADFU+vvpIuPUdsyDI/BY1L3NJdhaLU4uCvfJ/0FnwJchZf6Mu78uhCnvrRRkPq33mCLfmeMeMjndFw==
X-Received: by 2002:a17:90a:37ea:: with SMTP id v97mr9625664pjb.26.1584709764584;
        Fri, 20 Mar 2020 06:09:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:4052:817:5e21:ec32:affe:2929:752d])
        by smtp.gmail.com with ESMTPSA id l7sm5433176pff.204.2020.03.20.06.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Mar 2020 06:09:24 -0700 (PDT)
From:   Harshit Jain <harshitjain1371999@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, harshitjain1371999@gmail.com,
        shouryashukla.oo@gmail.com
Subject: [PATCH 2/2] t4131: use helper function to replace 'test -f'
Date:   Fri, 20 Mar 2020 18:38:45 +0530
Message-Id: <20200320130845.23257-3-harshitjain1371999@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200320130845.23257-1-harshitjain1371999@gmail.com>
References: <xmqq1rpodn25.fsf@gitster.c.googlers.com>
 <20200320130845.23257-1-harshitjain1371999@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace 'test -f' with the helper function 'test_path_is_file' as the
helper function improves the code readability and also gives better
error messages.

Signed-off-by: Harshit Jain <harshitjain1371999@gmail.com>
---
 t/t4131-apply-fake-ancestor.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4131-apply-fake-ancestor.sh b/t/t4131-apply-fake-ancestor.sh
index 828d1a355b..21ee359632 100755
--- a/t/t4131-apply-fake-ancestor.sh
+++ b/t/t4131-apply-fake-ancestor.sh
@@ -33,7 +33,7 @@ test_expect_success 'apply --build-fake-ancestor in a subdirectory' '
 	(
 		cd sub &&
 		git apply --build-fake-ancestor 3.ancestor ../3.patch &&
-		test -f 3.ancestor
+		test_path_is_file 3.ancestor
 	) &&
 	git apply --build-fake-ancestor 3.ancestor 3.patch &&
 	test_cmp sub/3.ancestor 3.ancestor
-- 
2.26.0.rc2

