Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DEB1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbfBSAFk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:05:40 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34582 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbfBSAFk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:40 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C918060489;
        Tue, 19 Feb 2019 00:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534739;
        bh=ZFRPsfG+yT0mApt1qAPwTtLm8ysGF/Ohp04syb0QkcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MkIVIv3yqNHSEBm0apOdpkJCrWGZVvmHDJPjYI0b1BUMP5wx2ayV1Hg9UqRVI0dOU
         HKSfI7D7JNqsOBj2SLsOm+NL1erSqVBxmMInJvrLOe0NZ+NwymX07cwtC1zlrUOzC1
         ifl/ilFQhrAu/cJcFq+P1xzzJpq8fYY2KIyJIFlpYJ+X8PzUtJw6AcmW/EkLHGHejx
         yy7MtbWdtw6LPUFEiubM7cM0iEBNE+UuZRtHBsq47FS80Nxmx5qt4yetBUDIkVdgBf
         10DHZ7GgWB2np5Xw0KSPD/Qj3S/m2bhw12C+/Dj5XufxovHIIixzbLxPQ6/u5D+EzC
         edQqk85sodl1gGwUddKZt4KuGWm025d/r3a1ATmZsODS/OcoENydpHKldZVNJ4Ljqf
         FoMyldfWZMw0I2HD9VwU+AHhnnkW6ItdXa6N+uNVj6l+ZlMNUjcxhtFuylLxq70nvw
         BZleIj9hk6DQR1x9ur0DP12uzDwfLL67HOtcPQUQgxKWWkM+IYW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 01/35] t/lib-submodule-update: use appropriate length constant
Date:   Tue, 19 Feb 2019 00:04:52 +0000
Message-Id: <20190219000526.476553-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a specific invalid hard-coded object ID, produce one
of the appropriate length by using test_oid.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/lib-submodule-update.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 5b56b23166..1dd17fc03e 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -139,7 +139,7 @@ create_lib_submodule_repo () {
 		git revert HEAD &&
 
 		git checkout -b invalid_sub1 add_sub1 &&
-		git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 sub1 &&
+		git update-index --cacheinfo 160000 $(test_oid numeric) sub1 &&
 		git commit -m "Invalid sub1 commit" &&
 		git checkout -b valid_sub1 &&
 		git revert HEAD &&
@@ -196,6 +196,7 @@ test_git_directory_exists() {
 # the submodule repo if it doesn't exist and configures the most problematic
 # settings for diff.ignoreSubmodules.
 prolog () {
+	test_oid_init &&
 	(test -d submodule_update_repo || create_lib_submodule_repo) &&
 	test_config_global diff.ignoreSubmodules all &&
 	test_config diff.ignoreSubmodules all
