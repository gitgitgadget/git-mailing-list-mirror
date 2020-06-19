Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742C9C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6A120776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AyzawqrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436518AbgFSR5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39524 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404587AbgFSR4k (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:40 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8E6BC60A7D;
        Fri, 19 Jun 2020 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589393;
        bh=2AW4Ophh+GDqfkkvEpKmw/NRFQar3284kGJCZ5OkO5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AyzawqrGLUKR9szMQGA5M0mQsqv6qjHpg+T8yYFx5+rrTkaafSc2jp/UOAgV7uJ8Z
         UwCWKrwm0aL/wiRbp900g9X6PcHwmfAP/I97yd9nYDufPhwe2I/uJy+sxaUAi8lkSh
         Sl2wDMjiav+Mcf1/ygmeb4lI24w1rPw/JazYwjDAJKkJTX9qCsALmhdjwOaJiDH9VX
         E2dILBiaqAdO/gQpoJPJncAertRm2hsCPG5XgG4/a0JYlkOLv1eFpxAazPUDyMuoXY
         y5Ush/jiQdnotejI9C7WVZ3plOkP9JaGw+SbfErvd/kDu06e3DNwy6bATRtCe//VxP
         mJ8G0jVDRQDucpgRpr/bC50RrG0neKJq0rLTX7veGTPi+eKSNLly2WRSNoJycxKcup
         im4IELvzEs0UQHjSbG8lWPtQKFL4LccoDE6Y6818qYknWa02aqoNUwqeOYXlkJAMYG
         r2D5FTUyGTSB99zZADTdeykSBB0Ts2KtEcxT9f1c6Ssdd65vFKY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 38/44] t/helper: initialize the repository for test-sha1-array
Date:   Fri, 19 Jun 2020 17:55:55 +0000
Message-Id: <20200619175601.569856-39-sandals@crustytoothpaste.net>
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

test-sha1-array uses the_hash_algo under the hood. Since t0064 wants to
use the value that is correct for the hash algorithm that we're testing,
make sure the test helper initializes the repository to set
the_hash_algo correctly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/helper/test-oid-array.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index ce9fd5f091..b16cd0b11b 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -12,6 +12,9 @@ int cmd__oid_array(int argc, const char **argv)
 {
 	struct oid_array array = OID_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
+	int nongit_ok;
+
+	setup_git_directory_gently(&nongit_ok);
 
 	while (strbuf_getline(&line, stdin) != EOF) {
 		const char *arg;
