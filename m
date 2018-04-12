Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5AC1F404
	for <e@80x24.org>; Thu, 12 Apr 2018 22:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeDLW5Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 18:57:16 -0400
Received: from ao2.it ([92.243.12.208]:51119 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753064AbeDLW5O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 18:57:14 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6kZd-0008Uv-90; Fri, 13 Apr 2018 00:20:09 +0200
Received: from ao2 by jcn with local (Exim 4.90_1)
        (envelope-from <ao2@ao2.it>)
        id 1f6kad-0001VC-3V; Fri, 13 Apr 2018 00:21:11 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [RFC 02/10] submodule: fix getting custom gitmodule file in fetch command
Date:   Fri, 13 Apr 2018 00:20:39 +0200
Message-Id: <20180412222047.5716-3-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180412222047.5716-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Import the default git configuration before accessing the gitmodules
file.

This is important when a value different from the default one is set via
the 'core.submodulesfile' config.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index dcdfc66f0..d56636f74 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1428,8 +1428,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
-	config_from_gitmodules(gitmodules_fetch_config, NULL);
 	git_config(git_fetch_config, NULL);
+	config_from_gitmodules(gitmodules_fetch_config, NULL);
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
-- 
2.17.0

