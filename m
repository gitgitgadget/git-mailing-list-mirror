Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DD6A1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 12:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbeGCMik (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 08:38:40 -0400
Received: from thoth.sbs.de ([192.35.17.2]:39899 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752961AbeGCMij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 08:38:39 -0400
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w63CcO2o014657
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 14:38:24 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id w63CcME8008580;
        Tue, 3 Jul 2018 14:38:23 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 5/8] t/t7510: check the validation of the new config gpg.format
Date:   Tue,  3 Jul 2018 14:38:17 +0200
Message-Id: <9fd9d0d2ee3ae549baf8e9a710dfffbc118e66f7.1530616446.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Valid values are already covered by all tests that use GPG, now also
test what happens if we go for an invalid one.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 t/t7510-signed-commit.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 6e2015ed9..cb523513f 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -227,4 +227,14 @@ test_expect_success GPG 'log.showsignature behaves like --show-signature' '
 	grep "gpg: Good signature" actual
 '
 
+test_expect_success GPG 'check gpg config for malformed values' '
+	mv .git/config .git/config.old &&
+	test_when_finished "mv .git/config.old .git/config" &&
+	git config gpg.format malformed &&
+	test_expect_code 128 git commit -S --amend -m "fail" 2>result &&
+	test_i18ngrep "malformed value for gpg.format: malformed" result &&
+	test_i18ngrep "fatal: .*\.git/config" result &&
+	test_i18ngrep "fatal: .*line 2" result
+'
+
 test_done
-- 
2.16.4

