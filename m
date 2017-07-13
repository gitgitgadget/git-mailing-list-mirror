Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C9A2027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbdGMXto (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:49:44 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59720 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752912AbdGMXti (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jul 2017 19:49:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 22C07280AF;
        Thu, 13 Jul 2017 23:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499989776;
        bh=PB/bMfp3W3hvviYImH4ezKLQGJgbPJ7e4+ZhoQ59W5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xzZ4cJ6qERNVljbrJGsauNLYvi8uam7kiSfB5+JaCDBpKaAbiS2CBxKGQzHGg4wJC
         2BNdbfhXD1GwYtB8N9fNzv9ehYFhecuwm3z6kiRGwMtq0shLj0EGwmv41gNQ6UtzA3
         e5rwJd1jldiNxdmFdH/3OBP1buzkGlNqMeZdHjTdkuFkRABXB9s2ECIT+bfOOB3dcM
         ZD2zITLLxMvjfZrsy30IhAuYlmA8wc8rNw3ZGX1dsb7iYjHy9LKFuJC9WdaAWyqnPd
         aVsIuQGBlYgv1qajCoAkE7blwS7sb/5d5n/3cP6Zd/3KzWPwiZ9MZn5eKDjZlGfp4c
         Rj8cZvWZjZC6wFn9lUWEUbWaJUhoNhwE910z9tYNQOGLYkzpx93c6K6ph5Wz3XFU/N
         zY7+IeDESli+EIxdtLX19Yy5k1TRaWOekEeaUZ7TYPAwym3LhpDbw8HYxoFlEtXIPD
         HN/EltJoXRfgsbedAz/oaao94axuJkFMDHYJv1UOIJZHR11WxTV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 09/13] builtin/verify-tag: convert to struct object_id
Date:   Thu, 13 Jul 2017 23:49:26 +0000
Message-Id: <20170713234930.949612-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170713234930.949612-1-sandals@crustytoothpaste.net>
References: <20170713234930.949612-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/verify-tag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f9a5f7535a..30e4c826ed 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -56,20 +56,20 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	}
 
 	while (i < argc) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *name = argv[i++];
-		if (get_sha1(name, sha1)) {
+		if (get_oid(name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
 			continue;
 		}
 
-		if (gpg_verify_tag(sha1, name, flags)) {
+		if (gpg_verify_tag(oid.hash, name, flags)) {
 			had_error = 1;
 			continue;
 		}
 
 		if (fmt_pretty)
-			pretty_print_ref(name, sha1, fmt_pretty);
+			pretty_print_ref(name, oid.hash, fmt_pretty);
 	}
 	return had_error;
 }
