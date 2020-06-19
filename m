Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534E5C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2728D20776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="twwHRfUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394009AbgFSR5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39554 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404437AbgFSR4c (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C75BC60A72;
        Fri, 19 Jun 2020 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589385;
        bh=MMfJEd2BJ7WjAZeGiNm4voySOTAFCGpDlJvsq+dHUZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=twwHRfUeIZvC+/Z1aU2dDbuoKuHDIJJpU8FvtagY1mqw+LZc974gVvussVIrWCIpD
         QkGlL5o/c6SZm5ZLmB51QTcz+0mhwK0YR0Vgo5W9aqhCU4rLN85YEifYzPRbrB7WlW
         DbjJGNlKen+sew4hNM+TDQZxQTculbnBgn9liO5Np19VE6q4fLzvOxSErvQbDwubki
         SRpHZUzW0Vi0j03Wnaq80IlAVzi/kL7G09iocvJ2qKt8PRVVZ4zcAfMOZjYChkjwaz
         Ogu6Coz7VSQuAx2tC1DrLe93GQ2ssf78DtNcrezK2DDQJ07TYi/52yMGZMjflgFr18
         jc5JgVEKViU6JseVc26ncHmVbP/w+8zF0SBQns4kxrwsAjAX0m5/RmvV+mlpvEYDMn
         B3I8RNJ7POr6T3VlEKyf8tYIhyw/SSJmcB9W68B9bQvLFmo4oXaglgpQLz/ho1X0hy
         VAI2nUI+7auKWoZ0OO6VY1G+ZZMw6VuXnZwR0VYJsMqP0pLoSO1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 23/44] t3200: mark assertion with SHA1 prerequisite
Date:   Fri, 19 Jun 2020 17:55:40 +0000
Message-Id: <20200619175601.569856-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
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
