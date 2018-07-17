Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F4D81F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbeGQNXD (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 09:23:03 -0400
Received: from thoth.sbs.de ([192.35.17.2]:58835 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbeGQNXD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 09:23:03 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w6HCoELj004775
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 14:50:14 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6HCoEZW005172;
        Tue, 17 Jul 2018 14:50:14 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 2/7] t/t7510: check the validation of the new config gpg.format
Date:   Tue, 17 Jul 2018 14:50:08 +0200
Message-Id: <2f806c4fa4454af59344f0f0e77d1ae8048aa841.1531831244.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531831244.git.henning.schild@siemens.com>
References: <cover.1531831244.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531831244.git.henning.schild@siemens.com>
References: <cover.1531831244.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test setting gpg.format to both invalid and valid values.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 t/t7510-signed-commit.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 6e2015ed9..7bdad570c 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -227,4 +227,13 @@ test_expect_success GPG 'log.showsignature behaves like --show-signature' '
 	grep "gpg: Good signature" actual
 '
 
+test_expect_success GPG 'check config gpg.format values' '
+	test_config gpg.format openpgp &&
+	git commit -S --amend -m "success" &&
+	test_config gpg.format OpEnPgP &&
+	test_must_fail git commit -S --amend -m "fail" &&
+	test_config gpg.format malformed &&
+	test_must_fail git commit -S --amend -m "fail"
+'
+
 test_done
-- 
2.16.4

