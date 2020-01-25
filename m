Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47CEC35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9622071E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AnME5fj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAYXAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46816 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727925AbgAYXAs (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:48 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ED1B860FCA;
        Sat, 25 Jan 2020 23:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993247;
        bh=1MOOFACdi6walbZenN3/PtmmpgSl97nBTVUJrzTxn5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AnME5fj5hFPhaw9jZfVpTL6L8cEcRUUy3KrMKFgWFYeqtbAVYWkc7DXkKRX54W+e3
         oh6mXlEvvqhWbnmLypQiPTOWusMb06PfVVXOvfGTpP14aQgOXaSjyu5bN/PVLy9I50
         5sG5cbKgdIioz1cM3jIxNqprNj9gjyrN+eVVx7Z6Z7T9c+0KBTR5AVfTSdtnZ7mC6D
         CbaJ/5kv6wt5bg4x1PcaHkNk5mHnCUBbhsqmR6D+BJfB6hl6U6q3mle9r+7JK/Ntfl
         +N45eyaEiwycsrdboXABkj5YQQSyAer2F00R+3iR0ieXvY6rqLf3P+psp018+jNR63
         ZgvJG5wtGG8mYamV2jcJQVl7X7GT7CzEFxSEuaXmYH2w+zojV077vmc8OQZyI61YyH
         lejkE+4NrbwkVzLU67qexnbXJsty74dN0OOepmnbMB3J6X14V3ReWMwuqIVz328hX8
         yVKSjnLm7+mYdtNWsEZdnmD551ghiIcTyqJinprtG5SErDJSHAQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 14/22] t5321: make test hash independent
Date:   Sat, 25 Jan 2020 23:00:20 +0000
Message-Id: <20200125230035.136348-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the proper pack constants defined in lib-pack.sh to make this test
work with SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5321-pack-large-objects.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5321-pack-large-objects.sh b/t/t5321-pack-large-objects.sh
index a75eab87d3..8a56d98a0e 100755
--- a/t/t5321-pack-large-objects.sh
+++ b/t/t5321-pack-large-objects.sh
@@ -10,8 +10,8 @@ test_description='git pack-object with "large" deltas
 . "$TEST_DIRECTORY"/lib-pack.sh
 
 # Two similar-ish objects that we have computed deltas between.
-A=01d7713666f4de822776c7622c10f1b07de280dc
-B=e68fe8129b546b101aee9510c5328e7f21ca1d18
+A=$(test_oid packlib_7_0)
+B=$(test_oid packlib_7_76)
 
 test_expect_success 'setup' '
 	clear_packs &&
