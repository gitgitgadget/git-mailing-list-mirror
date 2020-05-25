Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B877C433E1
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A0A2073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tXzUA+oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390499AbgEYUAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38718 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390457AbgEYUAA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:00 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2BEC460D1A;
        Mon, 25 May 2020 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436799;
        bh=2AW4Ophh+GDqfkkvEpKmw/NRFQar3284kGJCZ5OkO5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tXzUA+oAWCN0wFWm0XkT7uNATTBZF0Ur5JLxIwX4GWrwxiwvH7N1LxMD7evJuztKN
         /A0k7nt3sH12fmxtSyjmJDH1ugQOwaM5dNLpON9+6Kz4tf2SGkPTnUd2zZOKGmBY/q
         mI0K6PfgsUoRkpFZ1ldLnPQqvvMYBxYQXU03GZy+xWDL6OWMBotcjuOnH192CJzSnr
         tcCWaz1TowAO+/0VGAwl9F95Q/U5G0d9x01OKzCDgRp1coW3eSAnKd3q7ne74WdH6K
         CEcJFuYXvn3BZAwRW7Zic1fnelzNZoUUzEJiwxX18YOVFVGderKR6p5UYVQ5Pflegx
         ndRw9+NhI9EM06EJ24FL/XlrqMRZAmfFEVyliUK7MDZljOP+HifOiBLU9TwSwOzVt+
         7x3vNrT79Emmfnon9vn+y9UdazlBZU4VGp8purhGpZ+9dV0P6+56ML3JgfmqvSBLtV
         4JBdmPfbfadkowGylfCxAurzgguRVCfFUZlCgsDghN+WeAZBdq0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 38/44] t/helper: initialize the repository for test-sha1-array
Date:   Mon, 25 May 2020 19:59:24 +0000
Message-Id: <20200525195930.309665-39-sandals@crustytoothpaste.net>
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
