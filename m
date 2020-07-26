Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFABC4345E
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6502065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="E4zRmKyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgGZTzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40782 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728061AbgGZTzQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:55:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E45B361011;
        Sun, 26 Jul 2020 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793285;
        bh=vM3TI4/RbUP1dFvpkiIgLxj2UZc7pmERZjdUoWlLhOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=E4zRmKyKNSiYHQ0bzpHGa1se5ZVhnywv+M9GGJ+lMpbEsiPDpS64Z03w1YR9CKo7Z
         vvb+xjkQKgWIBREeoKNPI2bA33D14socUbDzQYOVb+549K5p0Ct6zn9HGny/47DmKy
         gH8CljqP472oqEs6z2zrrGhTuO6F30cKkalyvRS1kFpHqqDz/YLI1uiVJMCtLsjtCu
         0NCrL5XGhBP0UOed2g1kWwREFdcv0wmYD6/+GIPvwYN9EXTB+VkxvG0w4Yk0uU8RiT
         J0rlhJcghsd3EH8IFBskI1AGGw8Lw+29847JvlANt750OPJHjOBkNQbazor4kY5YNu
         U2gwdh6gi7o6RiTvUf0mEk9gi9OxySGeCOdvTJSPUVZObVppfEK0jFLwG3xfaXwmYd
         Ns4LUcOBCvJKm531yNK9ikB/nMmwPzuXTtt35HeVwQmiEVU5Gy+vKn/WMbJ9t/YgiS
         jRTEgJWn7FykYCYYJWDg8Q02UQILV/7Nar5qYGLuelAnvxQasbf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 10/39] t7003: compute appropriate length constant
Date:   Sun, 26 Jul 2020 19:53:55 +0000
Message-Id: <20200726195424.626969-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a specific invalid hard-coded object ID, look one
up from the translation table.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7003-filter-branch.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e23de7d0b5..beeb2b855a 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -5,6 +5,7 @@ test_description='git filter-branch'
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success 'setup' '
+	test_oid_init &&
 	test_commit A &&
 	GIT_COMMITTER_DATE="@0 +0000" GIT_AUTHOR_DATE="@0 +0000" &&
 	test_commit --notick B &&
@@ -463,10 +464,11 @@ test_expect_success 'rewrite submodule with another content' '
 '
 
 test_expect_success 'replace submodule revision' '
+	invalid=$(test_oid numeric) &&
 	git reset --hard original &&
 	git filter-branch -f --tree-filter \
 	    "if git ls-files --error-unmatch -- submod > /dev/null 2>&1
-	     then git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 submod
+	     then git update-index --cacheinfo 160000 $invalid submod
 	     fi" HEAD &&
 	test $orig_head != $(git show-ref --hash --head HEAD)
 '
