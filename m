Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BD1C2D0FB
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415F520675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ym6CIXKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbgEMAzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38104 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731930AbgEMAy4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F0ACF60D17;
        Wed, 13 May 2020 00:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331295;
        bh=74qW95Zvoq9O2u0va6v/nSh8paXnLt0Me5nQURj92D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ym6CIXKbbHwiSIlUAGzXK2PNvPls2P2glT6Og0A1Tw8e83i4ajYwN0qjAO31FdrcU
         1C+q+QloxSzg9zgaq84BuibIbWtaJ1dxLG2BUV6C/hyPvJqidF5SDpaJTbMCBsd3n1
         2XnV+AC6w8EgIO831AxyF6ip8ikmeSqDE/y+mTyLj41jSG3aRDfbMrRw20ckGw3+W+
         lGT25QOCKzU92mcSxK9E3FKDFgl8V85r+8++OikeUcL25tdg0TDS5BDk6BDbcQOgkI
         5hHtUViimJ9PjkHeeRv5TmchViJhZJwjw4Di5VoeNlC6gX8IaeKC0Pv6N3m8AJo3hc
         kzv95vd9b0LrVfzX47BIn430dRt79SG6D20Oy+x9kQV2j0B2nRsC0CR1HYZDfuPTkC
         0sq/HbZajraRuYyBjaoXdYdihb//qcYXFgTkxXfpqVOHHo6h3HG3DtTmQCfYq+hqll
         FHMIn4GNN9XtsKArGrD83ItyHvnHkV3h71hCZofkdbTVvrlrok4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 40/44] t5702: offer an object-format capability in the test
Date:   Wed, 13 May 2020 00:54:20 +0000
Message-Id: <20200513005424.81369-41-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make this test work with SHA-256, offer an object-format
capability so that both sides use the same algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5702-protocol-v2.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5039e66dc4..116358b9ac 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -13,6 +13,7 @@ start_git_daemon --export-all --enable=receive-pack
 daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
 
 test_expect_success 'create repo to be served by git-daemon' '
+	test_oid_init &&
 	git init "$daemon_parent" &&
 	test_commit -C "$daemon_parent" one
 '
@@ -394,6 +395,7 @@ test_expect_success 'even with handcrafted request, filter does not work if not
 	# Custom request that tries to filter even though it is not advertised.
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
+	object-format=$(test_oid algo)
 	0001
 	want $(git -C server rev-parse master)
 	filter blob:none
