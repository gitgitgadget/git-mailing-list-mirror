Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6E2C2D0FB
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1DE520675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JB68NXyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbgEMA4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:56:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38264 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731966AbgEMAzV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:55:21 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BECB660D0C;
        Wed, 13 May 2020 00:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331290;
        bh=VVQ0dANHQNwdWuSaocgt9e3EABF8vgKVBdEBtDLaQuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JB68NXyr87VdfTUadG2MV+hcOQb7Tbrd6gz0pm7ST1gZHtxiGUH7tVXkkjQ3hrgiv
         26PfP9Z9i3Ppdox7kSzm2Xcu5GhcStHhTB0DHS9xx6slKsg7gw9GMnr7QUq1JKDO8C
         rmzOi9Gq1IT7Js/F5pV1vWgIGgY8ygFOnNaeNyFnkN4kMHVjYhQacwXX4wT2YXvUzP
         rYjnfLJLQ6FTYDlldhAhBLRvNADCh1a+xtihiFvzqgzNTQq6hmVOWdK1B4TfyMv5Ll
         OXv69TgVidPno4BsTeugxcEHfht5h3r73WN87bS5/6obkguBS6Z46SCzX9vjrfqNfc
         OOcSMyxvAf6ODyy81qk2JfUBDH11vTGVm7Om+QkWLhOLNuVy/3pbOY6jwjooFje67T
         oY7qDXRuC7KvnvcSQPF8mZSczCL4oc6XLi0uMcx4UmkS7eXxrxyMopDmdGQA+oXhuP
         yYAK19VNhazB6dj96ePNHNQ6hA3s/ArcJ7eoDPFvQHnlD2XXexV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 28/44] t1302: expect repo format version 1 for SHA-256
Date:   Wed, 13 May 2020 00:54:08 +0000
Message-Id: <20200513005424.81369-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
