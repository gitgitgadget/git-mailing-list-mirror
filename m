Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538DFC35247
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE2E20838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="r8G6f1mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgBGAxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:52 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55594 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727456AbgBGAxl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:41 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EF0F46079D;
        Fri,  7 Feb 2020 00:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036820;
        bh=ZxWWlDBwG50HbjGOuuxKXY/OFxq/zGkGCOfGcXhcKA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=r8G6f1mDAN4EXjl815PMhGl/PEDAVbCIqYFyogZOD0rnPRsqDaDYe9XZUEaCy/L0/
         IP9lNeJzMZWl7IbkN0k5cFjoUa2ecJW5OFPDiFNjmZXE8RKZlQgLQpGwvnTAIUw+hx
         fpekw4b8S7D8TGwyf8REOdwzfoMYQ2R3zOJG2eibLaoAfEJUW3MsinBS3tC4NuSqsR
         jbklp60hFdoEcQA6nYRcy7gFs3Z64HMcQXO30GQ6Dah6jrirlnke5hwdujIUsV6E7A
         XkdzSrBKQBLuke6TTnR6IQNoRa/Tfg2kW78WjM21o5+d6QpK680ttoHm4hpB8nMe9f
         KLLH16Y78wke7pjFV6WaYiQ3JCL8dko2rCuNkUFiGz/u9X6qIEuP+LCgTOneIDOBMI
         9et6qs8jqfxor4qwEkMg2259gx3U4EE/yCzdzyMTcaVD/s+l/TbJesbYui99k1zgw1
         mw0ZnBxCitpoPKWwulSXAWJYCTHotTSHeZybhrHu3MTJUhtBBAM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 16/21] t5318: update for SHA-256
Date:   Fri,  7 Feb 2020 00:52:49 +0000
Message-Id: <20200207005254.1495851-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch two tests to use $ZERO_OID to represent the all-zeros object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5318-commit-graph.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 81cf118cb6..bc95db9e08 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -629,7 +629,7 @@ test_expect_success 'corrupt commit-graph write (broken parent)' '
 		empty="$(git mktree </dev/null)" &&
 		cat >broken <<-EOF &&
 		tree $empty
-		parent 0000000000000000000000000000000000000000
+		parent $ZERO_OID
 		author whatever <whatever@example.com> 1234 -0000
 		committer whatever <whatever@example.com> 1234 -0000
 
@@ -650,7 +650,7 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 		cd repo &&
 		tree="$(git mktree </dev/null)" &&
 		cat >broken <<-EOF &&
-		parent 0000000000000000000000000000000000000000
+		parent $ZERO_OID
 		author whatever <whatever@example.com> 1234 -0000
 		committer whatever <whatever@example.com> 1234 -0000
 
