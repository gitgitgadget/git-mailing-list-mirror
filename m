Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BD1C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADA92073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lf40IDtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390459AbgEYT77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 15:59:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390431AbgEYT75 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7EC8860D0F;
        Mon, 25 May 2020 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436794;
        bh=VVQ0dANHQNwdWuSaocgt9e3EABF8vgKVBdEBtDLaQuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lf40IDtkEP5vng/dKzEZfo5j5c0cN/xUbJqt3FGZoY4s1I8hopWclsx0PtSj1q83h
         DSkzocHKwmnzr7mvot9B3tLUIylCvE6y4/WssxnTfB2FkiosT1uHAe6qZDqKqbWkDp
         fpwQk805kDSKSs+zaE517+WTParCUO2Y+hWn+iIII3v2rmSjQQ2LLjiX6VlDQUKtR8
         Tsi1BTIPOHNzE765KYtZFjX+FQrxNZX5vhxicOvniu0oopwFQ4ui1B8eQpe0qpBI4a
         XJqC31IBNBUKuotzll44/oWp7dfr1qlMISODT7l9QFb/JeenKG06ieHEfunIX7lEqP
         LhR7Tv+rgE7wrSng5nsk7NfkcwgifgD1uqYna1ZORqcsLZMyXORqkimsqTkRZHNExT
         W6Ubraefk9JVb3RFZ4NKFdWCqXJWhx/VIpf1ttGi67Vfa7ZfLiXdVh8JxfUIsqSirU
         tV9cZgCWVMsAStPzPzFrhBJo7hQqsMoUyR3BdpI9z0bAc6voPw6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 27/44] t1302: expect repo format version 1 for SHA-256
Date:   Mon, 25 May 2020 19:59:13 +0000
Message-Id: <20200525195930.309665-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using SHA-256, we need to take advantage of the extensions section
in the config file, so we need to use repository format version 1.
Update the test to look for the correct value.

Note that test_oid produces a value without a trailing newline, so use
echo to ensure we print a trailing newline to compare it correctly
against the actual results.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1302-repo-version.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index ce4cff13bb..d60c042ce8 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -8,6 +8,10 @@ test_description='Test repository version check'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	test_oid_cache <<-\EOF &&
+	version sha1:0
+	version sha256:1
+	EOF
 	cat >test.patch <<-\EOF &&
 	diff --git a/test.txt b/test.txt
 	new file mode 100644
@@ -23,7 +27,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'gitdir selection on normal repos' '
-	echo 0 >expect &&
+	echo $(test_oid version) >expect &&
 	git config core.repositoryformatversion >actual &&
 	git -C test config core.repositoryformatversion >actual2 &&
 	test_cmp expect actual &&
