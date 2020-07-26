Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7190BC43446
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45DE02065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="C5MLjFEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGZTy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40740 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbgGZTyz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:55 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CE471607A2;
        Sun, 26 Jul 2020 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793294;
        bh=09rgrcCD/TLi0jQrtn9n+YVsuADBEadhXt5jrJbIyoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=C5MLjFEWNn56ZeTzJHIaQiw5Tyysi9CATaSg1L0cZqKUgynjwAZansTqk5HkHg38r
         WEMhgTlO3VwOPOMMnXsB6X6YkEqXLilb7yVSXej3VnuY2bRwXGO1Q0BwiESLKl4W37
         QG8LjROdRZkvdTVaBWyWWTtWnFzuLruGwFdR3qjkSYagdcqZYJaess2bmhJGd1uKhK
         uqGt7VVu3dCCd118xE4BkkwjOK9mlaKk81EosB3vlU0dO99xqbS7k33akz/HnmObnb
         3XORhcE4vP5S+2YDGz6orhzpReykcjBvjriCS4AsXhMzXSZRyq4oZmQ+kOvulJauZ1
         bIXR5VetlVZhhKPa3rbeeUdSYlqm8iF6HIl03fmLRktw/q0ETH8uEvKJ2oEms63ThN
         zwgraxW99W7NN0dcW2APW2FM9o3Xtng6UIJSJ574mQDJ9yegK6cDH7PG79wLUuLwhn
         n0AGsYLtsWA0du9Wfgb5ctX2Y7PANlVDwjZZu/hzYVG2VuWKdRw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 28/39] t0410: mark test with SHA1 prerequisite
Date:   Sun, 26 Jul 2020 19:54:13 +0000
Message-Id: <20200726195424.626969-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests try to check that we behave properly if we encounter a
repository with version 0 but an extension.  This is a laudable goal,
but the test cannot work with SHA-256, since SHA-256 repositories always
have an existing extension and are never version 0.

Add a SHA1 prerequisite to these tests.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0410-partial-clone.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 6aa0f313bd..a5ebdf9ff3 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -42,7 +42,7 @@ test_expect_success 'convert shallow clone to partial clone' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
 
-test_expect_success 'convert to partial clone with noop extension' '
+test_expect_success SHA1 'convert to partial clone with noop extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
@@ -53,7 +53,7 @@ test_expect_success 'convert to partial clone with noop extension' '
 	git -C client fetch --unshallow --filter="blob:none"
 '
 
-test_expect_success 'converting to partial clone fails with unrecognized extension' '
+test_expect_success SHA1 'converting to partial clone fails with unrecognized extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
