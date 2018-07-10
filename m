Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4031F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 08:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeGJIxL (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 04:53:11 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:53488 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751235AbeGJIxI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 04:53:08 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id w6A8qhsb015874
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 10:52:43 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6A8qgGR024364;
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
Subject: [PATCH v2 4/9] t/t7510: check the validation of the new config gpg.format
Date:   Tue, 10 Jul 2018 10:52:26 +0200
Message-Id: <b02154496033220897f6f773e1149a98b21ccba7.1531208187.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test setting gpg.format to both invalid and valid values.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 t/t7510-signed-commit.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 6e2015ed9..7e1e9caf4 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -227,4 +227,14 @@ test_expect_success GPG 'log.showsignature behaves like --show-signature' '
 	grep "gpg: Good signature" actual
 '
 
+test_expect_success GPG 'check config gpg.format values' '
+	rm .git/config &&
+	test_config gpg.format openpgp &&
+	git commit -S --amend -m "success" &&
+	test_config gpg.format OpEnPgP &&
+	git commit -S --amend -m "success" &&
+	test_config gpg.format malformed &&
+	test_must_fail git commit -S --amend -m "fail" 2>result
+'
+
 test_done
-- 
2.16.4

