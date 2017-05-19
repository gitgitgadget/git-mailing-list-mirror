Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444472021E
	for <e@80x24.org>; Fri, 19 May 2017 12:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755026AbdESM6H (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:58:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:54859 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754602AbdESM6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:58:07 -0400
Received: (qmail 2998 invoked by uid 109); 19 May 2017 12:58:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:58:06 +0000
Received: (qmail 27908 invoked by uid 111); 19 May 2017 12:58:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:58:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:58:05 -0400
Date:   Fri, 19 May 2017 08:58:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 13/15] diff: use the word "path" instead of "name" for blobs
Message-ID: <20170519125804.c23a7ex6i4dfnwe6@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The stuff_change() function makes diff_filespecs out of
blobs. The term we generally use for filespecs is "path",
not "name", so let's be consistent here.  That will make
things less confusing when the next patch starts caring
about the path/name distinction inside the pending object
array.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 8b276ae57..4c0811d6f 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -29,8 +29,8 @@ static void stuff_change(struct diff_options *opt,
 			 const struct object_id *new_oid,
 			 int old_oid_valid,
 			 int new_oid_valid,
-			 const char *old_name,
-			 const char *new_name)
+			 const char *old_path,
+			 const char *new_path)
 {
 	struct diff_filespec *one, *two;
 
@@ -41,16 +41,16 @@ static void stuff_change(struct diff_options *opt,
 	if (DIFF_OPT_TST(opt, REVERSE_DIFF)) {
 		SWAP(old_mode, new_mode);
 		SWAP(old_oid, new_oid);
-		SWAP(old_name, new_name);
+		SWAP(old_path, new_path);
 	}
 
 	if (opt->prefix &&
-	    (strncmp(old_name, opt->prefix, opt->prefix_length) ||
-	     strncmp(new_name, opt->prefix, opt->prefix_length)))
+	    (strncmp(old_path, opt->prefix, opt->prefix_length) ||
+	     strncmp(new_path, opt->prefix, opt->prefix_length)))
 		return;
 
-	one = alloc_filespec(old_name);
-	two = alloc_filespec(new_name);
+	one = alloc_filespec(old_path);
+	two = alloc_filespec(new_path);
 	fill_filespec(one, old_oid->hash, old_oid_valid, old_mode);
 	fill_filespec(two, new_oid->hash, new_oid_valid, new_mode);
 
-- 
2.13.0.219.g63f6bc368

