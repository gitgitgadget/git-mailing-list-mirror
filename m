Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE5C2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DAD20753
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kbb6rto2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbgEMAyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38158 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731882AbgEMAyt (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E1C3660D09;
        Wed, 13 May 2020 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331288;
        bh=MMfJEd2BJ7WjAZeGiNm4voySOTAFCGpDlJvsq+dHUZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kbb6rto2m9vTit12xDHRzkqNRzYtHtxeMCjk1UF76REQWpt/lWxWXjtYH2dHHXGEW
         vWO8CBliEKve0HvAu6jg9beKxA52MKC5aeVfu6+GbM+lXAsraWkoRBHlk2MHIxwtHE
         l79bRrfAW3VriojOXdjjsBR61dFkD0YatAdXIJ3noRRp9Ih3hSUZMy3cr3WdybhA3I
         WaeOQDXvfiZia9ybzdky9KAuuzBxW7AfrN+XUZEGEp5MzovKi6xP53rNYr3XZ686tP
         YGi4GAC6ECeYQ5QoX0jG2P3z2Mx8spUXtbNCGy+tb+BD5q9SWTDnnMUhPrqhznW8jv
         3qo4JCNl5TLNEAbZXWblPL1thDupHeJlfzMKa+rPicD/8R1VZzEcwVR/jRiyWoLs7X
         GBeNzkmnYarEpjeUaQ0w1VWneOeeeWWap6SGOvO4jJ64Pg8Vns50/tlgXjdKZgIAkC
         0dPl6e9wt5b34gGuWnRHiGZtQMhb9or77VFd+iy29I+31/4obL7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 24/44] t3200: mark assertion with SHA1 prerequisite
Date:   Wed, 13 May 2020 00:54:04 +0000
Message-Id: <20200513005424.81369-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the test assertions in this test checks that git branch -m works
even without a .git/config file.  However, if the repository requires
configuration extensions, such as because it uses a non-SHA-1 algorithm,
this assertion will fail.  Mark the assertion as requiring SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 411a70b0ce..2a3fedc6b0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -402,7 +402,7 @@ EOF
 
 mv .git/config .git/config-saved
 
-test_expect_success 'git branch -m q q2 without config should succeed' '
+test_expect_success SHA1 'git branch -m q q2 without config should succeed' '
 	git branch -m q q2 &&
 	git branch -m q2 q
 '
