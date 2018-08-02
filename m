Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C1C1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbeHBQTJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:19:09 -0400
Received: from ao2.it ([92.243.12.208]:54927 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387454AbeHBQTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:08 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flDv8-0006hv-K8; Thu, 02 Aug 2018 15:45:38 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1flDwQ-0002hB-Rh; Thu, 02 Aug 2018 15:46:58 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH v2 03/12] t7411: be nicer to future tests and really clean things up
Date:   Thu,  2 Aug 2018 15:46:25 +0200
Message-Id: <20180802134634.10300-4-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802134634.10300-1-ao2@ao2.it>
References: <20180802134634.10300-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests 5 and 8 in t/t7411-submodule-config.sh add two commits with
invalid lines in .gitmodules but then only the second commit is removed.

This may affect future subsequent tests if they assume that the
.gitmodules file has no errors.

Since those commits are not needed anymore remove both of them.

The modified line is in the last test of the file, so this does not
change the current behavior, it only affects future tests.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---

Note that test_when_finished is not used here, both to keep the current style
and also because it does not work in sub-shells.

 t/t7411-submodule-config.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 0bde5850ac..248da0bc4f 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -135,7 +135,9 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 			HEAD submodule \
 				>actual &&
 		test_cmp expect_error actual  &&
-		git reset --hard HEAD^
+		# Remove both the commits which add errors to .gitmodules,
+		# the one from this test and the one from a previous test.
+		git reset --hard HEAD~2
 	)
 '
 
-- 
2.18.0

