Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60D01F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 21:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbeKVHoF (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 02:44:05 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:48764 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732609AbeKVHoE (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Nov 2018 02:44:04 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=thomas.baccab.home.arpa); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1gPZUJ-00055p-Nu; Wed, 21 Nov 2018 21:52:43 +0100
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v1 2/2] log -S: Add test which searches in binary files
Date:   Wed, 21 Nov 2018 21:52:28 +0100
Message-Id: <84cbbfbd213b358d1e2d7cce8b4685b09efac3de.1542833244.git.thomas.braun@virtuell-zuhause.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
In-Reply-To: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
References: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1542834484;cba7254a;
X-HE-SMSGID: 1gPZUJ-00055p-Nu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -S <regex> option of log looks for differences that changes the
number of occurrences of the specified string (i.e. addition/deletion)
in a file.

Add a test to ensure that we keep looking into binary files with -S
as changing that would break backwards compatibility in unexpected ways.

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 t/t4209-log-pickaxe.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 42cc8afd8b..d430f6f2f9 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -128,4 +128,15 @@ test_expect_success 'log -G looks into binary files with textconv filter' '
 	test_cmp actual expected
 '
 
+test_expect_success 'log -S looks into binary files' '
+	rm -rf .git &&
+	git init &&
+	printf "a\0b" >data.bin &&
+	git add data.bin &&
+	git commit -m "message" &&
+	git log -S a >actual &&
+	git log >expected &&
+	test_cmp actual expected
+'
+
 test_done
-- 
2.19.0.271.gfe8321ec05.dirty

