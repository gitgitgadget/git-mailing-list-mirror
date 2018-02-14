Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9550B1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161643AbeBNSJB (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:09:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:52296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1161636AbeBNSI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:08:59 -0500
Received: (qmail 29413 invoked by uid 109); 14 Feb 2018 18:08:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 18:08:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31074 invoked by uid 111); 14 Feb 2018 18:09:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 13:09:43 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 13:08:57 -0500
Date:   Wed, 14 Feb 2018 13:08:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] test-hashmap: use "unsigned int" for hash storage
Message-ID: <20180214180857.GF9919@sigill.intra.peff.net>
References: <20180214180322.GA9190@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214180322.GA9190@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The hashmap API always use an unsigned value for storing
and comparing hashes. Whereas this test code uses "int".
This works out in practice since one can typically
round-trip between "int" and "unsigned int". But since this
is essentially reference code for the hashmap API, we should
model using the correct types.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-hashmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 56efff36e8..9ae9281c07 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -30,7 +30,8 @@ static int test_entry_cmp(const void *cmp_data,
 		return strcmp(e1->key, key ? key : e2->key);
 }
 
-static struct test_entry *alloc_test_entry(int hash, char *key, char *value)
+static struct test_entry *alloc_test_entry(unsigned int hash,
+					   char *key, char *value)
 {
 	size_t klen = strlen(key);
 	size_t vlen = strlen(value);
@@ -156,7 +157,7 @@ int cmd_main(int argc, const char **argv)
 	/* process commands from stdin */
 	while (strbuf_getline(&line, stdin) != EOF) {
 		char *cmd, *p1 = NULL, *p2 = NULL;
-		int hash = 0;
+		unsigned int hash = 0;
 		struct test_entry *entry;
 
 		/* break line into command and up to two parameters */
-- 
2.16.1.464.gc4bae515b7
