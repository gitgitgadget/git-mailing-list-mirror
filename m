Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1603202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbdGMPCz (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:02:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:39126 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751200AbdGMPCy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:02:54 -0400
Received: (qmail 24170 invoked by uid 109); 13 Jul 2017 15:02:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:02:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32191 invoked by uid 111); 13 Jul 2017 15:03:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:03:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:02:52 -0400
Date:   Thu, 13 Jul 2017 11:02:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/15] ref-filter: make parse_ref_filter_atom a private
 function
Message-ID: <20170713150252.4xx2nqi2w45s7cu3@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parse_ref_filter_atom() function really shouldn't be
exposed outside of ref-filter.c; its return value is an
integer index into an array that is private in that file.

Since the previous commit removed the sole external caller
(and replaced it with a public function at a more
appropriately level), we can just make this static.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 2 +-
 ref-filter.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 432121219..ee97d7218 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -364,7 +364,7 @@ struct atom_value {
 /*
  * Used to parse format string and sort specifiers
  */
-int parse_ref_filter_atom(const char *atom, const char *ep)
+static int parse_ref_filter_atom(const char *atom, const char *ep)
 {
 	const char *sp;
 	const char *arg;
diff --git a/ref-filter.h b/ref-filter.h
index 67fa6261b..1ffc3ca81 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -104,8 +104,6 @@ struct ref_format {
 int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
-/*  Parse format string and sort specifiers */
-int parse_ref_filter_atom(const char *atom, const char *ep);
 /*  Used to verify if the given format is correct and to parse out the used atoms */
 int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
-- 
2.13.2.1157.gc6daca446

