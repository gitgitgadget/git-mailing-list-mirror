Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDD41F453
	for <e@80x24.org>; Thu, 25 Oct 2018 16:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJZAwN (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:52:13 -0400
Received: from mail.ao2.it ([92.243.12.208]:44398 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJZAwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=TN22J56l2H4rQyDtuTA3VhO12eJtQV1h9Ex0JuZS0fg=;
        b=PkQ9myTeyHpUsKjk0EkhKW8h6e4KK4QDxY9qvBthIy1099hph1MRe5A6lsyoVPKidFsMpiIOoN6WjZrwlFD26AiVQmdsKni7C2p0DzNNsKVkBbmPO1fwqhdcwYgHutz6krqeeB3sNgGgCxt1YlQqi3vIagywKA5Gl4RnH+U/5Qd9GueBFXASIim/uc1CIjpfLTkDB/EJcIss4ubuKGskYHcLl8hBvxDtu03ME8Ade1KZ82NX6VF4B4yEBaHRTWnoQv4ppV8/JjFt2m/Pi7rV0aWjWktb14FtH5SiANflRVH4hRdcwbWdeeKLr0ZfDjw5J59TsytpAFzLwSi0tluE0A==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1gFiKn-0003Ks-Ra; Thu, 25 Oct 2018 18:18:09 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1gFiL5-0004VF-7H; Thu, 25 Oct 2018 18:18:27 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v7 03/10] t7411: merge tests 5 and 6
Date:   Thu, 25 Oct 2018 18:18:06 +0200
Message-Id: <20181025161813.17252-4-ao2@ao2.it>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025161813.17252-1-ao2@ao2.it>
References: <20181025161813.17252-1-ao2@ao2.it>
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
2.19.1

