Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9F61F424
	for <e@80x24.org>; Fri, 13 Apr 2018 08:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeDMIHy (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 04:07:54 -0400
Received: from ao2.it ([92.243.12.208]:53704 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752940AbeDMIHw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 04:07:52 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6tjL-0007hw-OM; Fri, 13 Apr 2018 10:06:47 +0200
Received: from ao2 by jcn with local (Exim 4.90_1)
        (envelope-from <ao2@ao2.it>)
        id 1f6tkM-0001fl-Hn; Fri, 13 Apr 2018 10:07:50 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [RFC 09/10] FIXME: submodule: pass custom gitmodules file to 'test-tool submodule-config'
Date:   Fri, 13 Apr 2018 10:07:32 +0200
Message-Id: <20180413080733.6380-3-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413080733.6380-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
 <20180413080733.6380-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option to 't/helper/test-submodule-config.c' to set a custom
path for the gitmodules file.

In particular this is needed to make 't/t7411-submodule-config.sh' pass.

The option is actually put in use by the script that patches the test
suite.
---
 t/helper/test-submodule-config.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 5c6e4b010..30b4ea3da 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -25,6 +25,13 @@ int cmd__submodule_config(int argc, const char **argv)
 			output_url = 1;
 		if (!strcmp(arg[0], "--name"))
 			lookup_name = 1;
+		if (!strcmp(arg[0], "--submodules_file")) {
+			arg++;
+			my_argc--;
+			submodules_file = expand_user_path(arg[0], 0);
+			if (!submodules_file)
+				die(_("failed to expand user dir in: '%s'"), arg[0]);
+		}
 		arg++;
 		my_argc--;
 	}
-- 
2.17.0

