Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8531F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 08:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeGJIxF (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 04:53:05 -0400
Received: from gecko.sbs.de ([194.138.37.40]:43854 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751153AbeGJIxF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 04:53:05 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id w6A8qim0018341
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 10:52:44 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6A8qgGU024364;
        Tue, 10 Jul 2018 10:52:43 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 7/9] gpg-interface: introduce new config to select per gpg format program
Date:   Tue, 10 Jul 2018 10:52:29 +0200
Message-Id: <4905c1907a866c0fd1a4dac978dd6ca3e468ac43.1531208187.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Supporting multiple signing formats we will have the need to configure a
custom program each. Add a new config value to cater for that.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 Documentation/config.txt | 5 +++++
 gpg-interface.c          | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ac373e3f4..c0bd80954 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1832,6 +1832,11 @@ gpg.format::
 	Specifies which key format to use when signing with `--gpg-sign`.
 	Default is "openpgp", that is also the only supported value.
 
+gpg.<format>.program::
+	Use this to customize the program used for the signing format you
+	chose. (see gpg.program) gpg.openpgp.program is a synonym for the
+	legacy gpg.program.
+
 gui.commitMsgWidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
diff --git a/gpg-interface.c b/gpg-interface.c
index ac2df498d..65098430f 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -179,7 +179,7 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 		return git_config_string(&gpg_format, var, value);
 	}
 
-	if (!strcmp(var, "gpg.program"))
+	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
 		return git_config_string(&gpg_formats[PGP_FMT].program, var,
 					 value);
 	return 0;
-- 
2.16.4

