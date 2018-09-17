Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C521F404
	for <e@80x24.org>; Mon, 17 Sep 2018 14:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeIQThU (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 15:37:20 -0400
Received: from ao2.it ([92.243.12.208]:50101 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbeIQThU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 15:37:20 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g1uBX-0001bU-9f; Mon, 17 Sep 2018 16:07:31 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1g1uDg-00010t-Ea; Mon, 17 Sep 2018 16:09:44 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v5 3/9] t7411: merge tests 5 and 6
Date:   Mon, 17 Sep 2018 16:09:34 +0200
Message-Id: <20180917140940.3839-4-ao2@ao2.it>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917140940.3839-1-ao2@ao2.it>
References: <20180917140940.3839-1-ao2@ao2.it>
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests 5 and 6 check for the effects of the same commit, merge the two
tests to make it more straightforward to clean things up after the test
has finished.

The cleanup will be added in a future commit.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 t/t7411-submodule-config.sh | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 0bde5850ac..f2cd1f4a2c 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -82,29 +82,21 @@ Submodule name: 'a' for path 'b'
 Submodule name: 'submodule' for path 'submodule'
 EOF
 
-test_expect_success 'error in one submodule config lets continue' '
+test_expect_success 'error in history of one submodule config lets continue, stderr message contains blob ref' '
 	(cd super &&
 		cp .gitmodules .gitmodules.bak &&
 		echo "	value = \"" >>.gitmodules &&
 		git add .gitmodules &&
 		mv .gitmodules.bak .gitmodules &&
 		git commit -m "add error" &&
-		test-tool submodule-config \
-			HEAD b \
-			HEAD submodule \
-				>actual &&
-		test_cmp expect_error actual
-	)
-'
-
-test_expect_success 'error message contains blob reference' '
-	(cd super &&
 		sha1=$(git rev-parse HEAD) &&
 		test-tool submodule-config \
 			HEAD b \
 			HEAD submodule \
-				2>actual_err &&
-		test_i18ngrep "submodule-blob $sha1:.gitmodules" actual_err >/dev/null
+				>actual \
+				2>actual_stderr &&
+		test_cmp expect_error actual &&
+		test_i18ngrep "submodule-blob $sha1:.gitmodules" actual_stderr >/dev/null
 	)
 '
 
-- 
2.19.0

