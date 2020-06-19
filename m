Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886E5C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F12220776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IGN/Mtfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405345AbgFSR5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39508 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393389AbgFSR4c (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 18DEC60A76;
        Fri, 19 Jun 2020 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589387;
        bh=VVQ0dANHQNwdWuSaocgt9e3EABF8vgKVBdEBtDLaQuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=IGN/Mtfz9MXEDzUvccEC3EvEZ+JMkb6RavZWs23ZVzUg0D6min4Gc4BioHnwPn1hK
         0yP1pbD6AtLPlDdABgqDRpmd3eBUS4QKzXpX76BqsZg0OueZbno/7vUrg/ngbQorYU
         wgLRyq2poacWHFEUn5jDNulvqemDBPNu6P7HXS2tk6kLLPUxZHXDC865WP00LYuvxk
         +IWnSXK0mXHlUJwo85c6aYPQ+uOIPkmH9+HT6G0/NxeIzIj7GawEGTMAUmyje61yRa
         DPsJJMpvgwDjHF3rOO12rRuqO9vkBBFWDuUW1p7+yOJ4dB8oBjkTN7XCY3WEycUGXh
         Ptcfnyjsu9MLoKY4yNUPERK6XhxaskK0fQA8On7EaSKCrdWQUGIgEUd/METxFLQyZy
         C+37IMYxbmIFuGT4CVXGADW94Ag/0LoI5aKqOfm/S+eYnFTlpyKgkiUqv+IUCKIZr2
         j6bDJu8Q7EjxwIiRK7S+JtZOIcz8vAAZkf09jiZkGB5JMjA3boD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 27/44] t1302: expect repo format version 1 for SHA-256
Date:   Fri, 19 Jun 2020 17:55:44 +0000
Message-Id: <20200619175601.569856-28-sandals@crustytoothpaste.net>
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
