Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E29202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 13:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754762AbdCIN17 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 08:27:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:41255 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754457AbdCIN16 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 08:27:58 -0500
Received: (qmail 19450 invoked by uid 109); 9 Mar 2017 13:27:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 13:27:57 +0000
Received: (qmail 2029 invoked by uid 111); 9 Mar 2017 13:28:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 08:28:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 08:27:55 -0500
Date:   Thu, 9 Mar 2017 08:27:55 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/4] ref-filter: move ref_cbdata definition into ref-filter.c
Message-ID: <20170309132755.x4zp3wtzpjmeyjpb@sigill.intra.peff.net>
References: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an implementation detail of how filter_refs() works,
and does not need to be exposed to the outside world. This
will become more important in future patches as we add new
private data types to it.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 5 +++++
 ref-filter.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1ec0fb839..6546dba73 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1476,6 +1476,11 @@ enum contains_result {
 	CONTAINS_YES = 1
 };
 
+struct ref_filter_cbdata {
+	struct ref_array *array;
+	struct ref_filter *filter;
+};
+
 /*
  * Mimicking the real stack, this stack lives on the heap, avoiding stack
  * overflows.
diff --git a/ref-filter.h b/ref-filter.h
index 154e24c40..e738c5dfd 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -71,11 +71,6 @@ struct ref_filter {
 		verbose;
 };
 
-struct ref_filter_cbdata {
-	struct ref_array *array;
-	struct ref_filter *filter;
-};
-
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
 	{ OPTION_CALLBACK, 0, option, (filter), N_("commit"), (h), \
-- 
2.12.0.445.g818af77e0

