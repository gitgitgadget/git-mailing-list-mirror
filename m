Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D405BC2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA60F2078C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gHH/IS2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbgEMAzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38162 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731928AbgEMAy4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6943C60D18;
        Wed, 13 May 2020 00:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331294;
        bh=2AW4Ophh+GDqfkkvEpKmw/NRFQar3284kGJCZ5OkO5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gHH/IS2EE+3iJl4GVWPEJMbnoOKbR8Z006bAWnZcxrTlBh95Gyr/IqyQwMGbW4ijG
         nm3N0vpkmi3Z0hjV9wArvBqaeF0IsYURZm31ydjhEhN1xq+sGShajyfeBQZDPutjtH
         VhyE0nSPuXB706oDk9hz6Z4RGvO4PZ+zAS1ig2zKehxsQ9tC3cC6nZs+vJ+wvrI4ni
         tTsZ+xMAsntZDGUVOpyRTjqYIla8LYobHwRsaQKPHKxOXP4jWYpUNrLe+6B5BOpZq1
         G3ShsyHHQARzwfH8Y+IJ4tPzPOTH/zOJMu64wdZ7T3GAqKSAN4fdrrwlPjMruTNR7l
         +uzqqM76aGRzaQtADIIP0FlKHLQDpCmIDrlWEjlbAtVOBKL2uFHQAl9R4dMJlsW5vW
         Aph+HOooQ9sZaHJN5L6MSvSgqlj4fMKaGeRgIhnisDqpeZh3qLDI9iAhAn0/ZNY/SX
         RGbCe0yYg9YmdCeZ72A/Cei9170iuxS6UZbyn4faWaa4ndvvkUI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 39/44] t/helper: initialize the repository for test-sha1-array
Date:   Wed, 13 May 2020 00:54:19 +0000
Message-Id: <20200513005424.81369-40-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
