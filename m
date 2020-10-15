Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCACC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17ACF206E5
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391688AbgJOTeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:34:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:33394 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbgJOTeN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:34:13 -0400
Received: (qmail 24213 invoked by uid 109); 15 Oct 2020 19:34:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 19:34:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32246 invoked by uid 111); 15 Oct 2020 19:34:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 15:34:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 15:34:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fast-import: remove duplicated option-parsing line
Message-ID: <20201015193411.GA1130491@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 1bdca81641 (fast-import: add options for rewriting submodules,
2020-02-22) accidentally added two lines parsing the option
"rewrite-submodules-from". This didn't do anything in practice, because
they're in an if/else chain and so the second one can never trigger.

Signed-off-by: Jeff King <peff@peff.net>
---
Another tidbit I noticed in my foray into fast-import earlier today.

 builtin/fast-import.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 70d7d25eed..dd4d09cece 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3399,7 +3399,6 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_rewrite_submodules(arg, &sub_marks_to);
 	} else if (skip_prefix(feature, "rewrite-submodules-from=", &arg)) {
 		option_rewrite_submodules(arg, &sub_marks_from);
-	} else if (skip_prefix(feature, "rewrite-submodules-from=", &arg)) {
 	} else if (!strcmp(feature, "get-mark")) {
 		; /* Don't die - this feature is supported */
 	} else if (!strcmp(feature, "cat-blob")) {
-- 
2.29.0.rc1.562.g7bd9bc8902
