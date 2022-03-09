Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785D6C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 21:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbiCIVtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbiCIVtp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 16:49:45 -0500
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Mar 2022 13:48:43 PST
Received: from mailproxy05.manitu.net (mailproxy05.manitu.net [IPv6:2a00:1828:1000:1110::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E1755747
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 13:48:43 -0800 (PST)
Received: from localhost (unknown [IPv6:2001:9e8:6a4b:3a00:5701:ed46:2656:7188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy05.manitu.net (Postfix) with ESMTPSA id 886FA1B609FB;
        Wed,  9 Mar 2022 22:41:44 +0100 (CET)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] test-lib: declare local variables as local
Date:   Wed,  9 Mar 2022 22:41:43 +0100
Message-Id: <81f43fbefde84ab7af9ee2ac760845b728a48ab5.1646861976.git.git@grubix.eu>
X-Mailer: git-send-email 2.35.1.604.gdca35cc479
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

131b94a10a ("test-lib.sh: Use GLIBC_TUNABLES instead of MALLOC_CHECK_ on
glibc >= 2.34", 2022-03-04) introduced "local" variables without
declaring them as such. This conflicts with their use in some tests (at
least when running them with dash), leading to test failures in:

t0006-date.sh
t2002-checkout-cache-u.sh
t3430-rebase-merges.sh
t4138-apply-ws-expansion.sh
t4124-apply-ws-rule.sh

Declare those variables as local to let the tests pass again.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 t/test-lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a3b711988c..e3c9822bf3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -548,6 +548,8 @@ then
 	}
 else
 	setup_malloc_check () {
+		local g
+		local t
 		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
 		export MALLOC_CHECK_ MALLOC_PERTURB_
 		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
-- 
2.35.1.604.gdca35cc479

