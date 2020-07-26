Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E213AC433EB
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D1A20715
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uJp452WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGZTyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40666 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbgGZTys (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C219C607A2;
        Sun, 26 Jul 2020 19:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793288;
        bh=bkn6gRdFc3a7Wl1a2vTHql6/IoBndbcv3M9Ug3dmdYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uJp452WOrutzPMbpE3i0ZxRCkD1/rgEWLpUbv3OBsnxEl587YDMJQntSLKlMZxdJc
         cAYI58L7CBmjOS8DBbBDGKP/f3q/c3kP9NqoOyk2a9URKsAgNWarCw4SY6X/ZNu+hn
         DqB4pFkZ+Na00vTcc0xuxCSRtuUNTOtb5n4JI1q+2uwcyQuRx7nViTKMeq98plAMUh
         aKmTy7ykkTKDWDQQtgUBsznqsS4dZsyriP76xNCKkkzXrE+5niFbtgEQu3j4149l4o
         qBwz13gleYZzF1TooTb4/8F1O+9885tjnrRNq8ADAREEGLx+JWE/3cKWcS7LmDQm7b
         y+OdbAplAZG6p77d0qyVfX/ZPIkOlFhWcYNot74mGtYT15eyWzbldXE8qLtJOP1Klq
         WuKjfJTO7JYyQTGOJ4E/YN/8HDp3wfFbNLLxF8XhfT+42KAurNVHGf2ALhVs4GVbqO
         phcCB8+WHVnRs9P+FAlMIcVS24VwDAfHb1EDdkwPxElFNe8hqWh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 15/39] t7405: make hash size independent
Date:   Sun, 26 Jul 2020 19:54:00 +0000
Message-Id: <20200726195424.626969-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $ZERO_OID instead of hard-coding a fixed size all-zeros object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7405-submodule-merge.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index aa33978ed2..6a1e5f8232 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -195,7 +195,7 @@ test_expect_success 'git submodule status should display the merge conflict prop
        url = $TRASH_DIRECTORY/sub
 EOF
        cat >expect <<EOF &&
-U0000000000000000000000000000000000000000 sub
+U$ZERO_OID sub
 EOF
        git submodule status > actual &&
        test_cmp expect actual &&
@@ -214,7 +214,7 @@ test_expect_success 'git submodule status should display the merge conflict prop
        url = $TRASH_DIRECTORY/sub
 EOF
        cat >expect <<EOF &&
-U0000000000000000000000000000000000000000 sub
+U$ZERO_OID sub
 EOF
        git submodule status > actual &&
        test_cmp expect actual &&
