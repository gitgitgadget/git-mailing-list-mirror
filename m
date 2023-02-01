Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC21EC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 11:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjBALjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 06:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjBALja (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 06:39:30 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC13E3A846
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 03:39:27 -0800 (PST)
Received: (qmail 31518 invoked by uid 109); 1 Feb 2023 11:39:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 11:39:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19405 invoked by uid 111); 1 Feb 2023 11:39:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 06:39:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 06:39:26 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>
Subject: [PATCH 4/4] t/lib-httpd: increase ssl key size to 2048 bits
Message-ID: <Y9pPbqT8wkysK5Ko@coredump.intra.peff.net>
References: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent versions of openssl will refuse to work with 1024-bit RSA keys,
as they are considered insecure. I didn't track down the exact version
in which the defaults were tightened, but the Debian-package openssl 3.0
on my system yields:

  $ LIB_HTTPD_SSL=1 ./t5551-http-fetch-smart.sh -v -i
  [...]
  SSL Library Error: error:0A00018F:SSL routines::ee key too small
  1..0 # SKIP web server setup failed

This could probably be overcome with configuration, but that's likely
to be a headache (especially if it requires touching /etc/openssl).
Let's just pick a key size that's less outrageously out of date.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd/ssl.cnf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-httpd/ssl.cnf b/t/lib-httpd/ssl.cnf
index 6dab2579cb..812e8253f0 100644
--- a/t/lib-httpd/ssl.cnf
+++ b/t/lib-httpd/ssl.cnf
@@ -1,7 +1,7 @@
 RANDFILE                = $ENV::RANDFILE_PATH
 
 [ req ]
-default_bits            = 1024
+default_bits            = 2048
 distinguished_name      = req_distinguished_name
 prompt                  = no
 [ req_distinguished_name ]
-- 
2.39.1.767.gb4615b3bd3
