Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7EF1F428
	for <e@80x24.org>; Fri, 31 Aug 2018 05:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeHaJpY (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 05:45:24 -0400
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:41131 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeHaJpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 05:45:23 -0400
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180831053935.OUGG4136.fed1rmfepo103.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Fri, 31 Aug 2018 01:39:35 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo110.cox.net with cox
        id Vhfa1y00R59yGBo01hfbf9; Fri, 31 Aug 2018 01:39:35 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090205.5B88D497.0013,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=Zc1tDodA c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=x7bEGLp0ZPQA:10 a=dapMudl6Dx4A:10 a=WDhBSedXqNQA:10 a=kviXuzpPAAAA:8
 a=v4sSVgW8i1FpXTb19_wA:9 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 70AF529A0122;
        Thu, 30 Aug 2018 22:39:34 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH 2/3] Add test for commit --dry-run --short.
Date:   Thu, 30 Aug 2018 22:39:20 -0700
Message-Id: <20180831053921.8083-3-ischis2@cox.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831053921.8083-1-ischis2@cox.net>
References: <20180831053921.8083-1-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test for commit with --dry-run --short for a new file of zero
length.

The test demonstrated that the setting of the commitable flag was
broken as was found durning an earlier patch review.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 t/t7501-commit.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 810d4cea7..fc69da816 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -682,4 +682,14 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
 	git commit -m "conflicts fixed from merge."
 '
 
+test_expect_success '--dry-run --short with conflicts fixed from a merge' '
+	# setup two branches with conflicting information
+	# in the same file, resolve the conflict,
+	# call commit with --dry-run --short
+	rm -f test-file &&
+	touch testfile &&
+	git add test-file &&
+	git commit --dry-run --short
+'
+
 test_done
-- 
2.18.0

