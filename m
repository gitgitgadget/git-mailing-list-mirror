Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AE751F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfFTHk4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:40:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:45232 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725872AbfFTHk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:40:56 -0400
Received: (qmail 16434 invoked by uid 109); 20 Jun 2019 07:40:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:40:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12697 invoked by uid 111); 20 Jun 2019 07:41:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:41:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:40:54 -0400
Date:   Thu, 20 Jun 2019 03:40:54 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/17] upload-pack: rename a "sha1" variable to "oid"
Message-ID: <20190620074054.GB3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable is a "struct object_id", but uses the old-style name
"sha1". Let's call it oid to match more modern code (and make it clear
that it can handle any algorithm, since it uses parse_oid_hex()
properly).

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 4d2129e7fc..d9a62adef0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -528,13 +528,13 @@ static int get_reachable_list(struct object_array *src,
 		return -1;
 
 	while ((i = read_in_full(cmd.out, namebuf, hexsz + 1)) == hexsz + 1) {
-		struct object_id sha1;
+		struct object_id oid;
 		const char *p;
 
-		if (parse_oid_hex(namebuf, &sha1, &p) || *p != '\n')
+		if (parse_oid_hex(namebuf, &oid, &p) || *p != '\n')
 			break;
 
-		o = lookup_object(the_repository, sha1.hash);
+		o = lookup_object(the_repository, oid.hash);
 		if (o && o->type == OBJ_COMMIT) {
 			o->flags &= ~TMP_MARK;
 		}
-- 
2.22.0.732.g5402924b4b

