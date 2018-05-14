Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0B61F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeENK7O (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:59:14 -0400
Received: from ao2.it ([92.243.12.208]:53797 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752553AbeENK7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:59:03 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fIBBq-00075L-Cf; Mon, 14 May 2018 12:58:50 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fIBC1-0002CK-A0; Mon, 14 May 2018 12:59:01 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH 08/10] t7506: cleanup .gitmodules properly before setting up new scenario
Date:   Mon, 14 May 2018 12:58:21 +0200
Message-Id: <20180514105823.8378-9-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514105823.8378-1-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t/t7506-status-submodule.sh at some point a new scenario is set up to
test different things, in particular new submodules are added which are
meant to completely replace the previous ones.

However the code just removes .gitmodules from the work tree, still
leaving it in the index.

This will break when "submodule--helper config" learns to handle
.gitmodules from the index and performs some check when doing that.

Since the test means to get rid of .gitmodules anyways, let's completely
remove it from the index, to actually start afresh in the new scenario.

This is more future-proof without breaking current tests.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 t/t7506-status-submodule.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 9edf6572e..389173294 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -325,7 +325,8 @@ test_expect_success 'setup superproject with untracked file in nested submodule'
 	(
 		cd super &&
 		git clean -dfx &&
-		rm .gitmodules &&
+		git rm .gitmodules &&
+		git commit -m "remove .gitmodules" &&
 		git submodule add -f ./sub1 &&
 		git submodule add -f ./sub2 &&
 		git submodule add -f ./sub1 sub3 &&
-- 
2.17.0

