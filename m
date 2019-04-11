Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6005120248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDKNsf (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:48:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:54906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726711AbfDKNsf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:48:35 -0400
Received: (qmail 7135 invoked by uid 109); 11 Apr 2019 13:48:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 13:48:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27856 invoked by uid 111); 11 Apr 2019 13:49:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 09:49:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 09:48:33 -0400
Date:   Thu, 11 Apr 2019 09:48:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?546L5YGl5by6?= <jianqiang.wang@securitygossip.com>
Subject: [PATCH 2/4] xdiff: use git-compat-util
Message-ID: <20190411134832.GB9182@sigill.intra.peff.net>
References: <20190411134736.GA28543@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411134736.GA28543@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the xdiff library was not originally part of Git, it does its own
system includes. Let's instead use git-compat-util, which has two
benefits:

  1. It adjusts for any system-specific quirks in how or what we should
     include (though xdiff's needs are light enough that this hasn't
     been a problem in the past).

  2. It lets us use wrapper functions like xmalloc().

Signed-off-by: Jeff King <peff@peff.net>
---
 xdiff/xinclude.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
index f35c4485df..a4285ac0eb 100644
--- a/xdiff/xinclude.h
+++ b/xdiff/xinclude.h
@@ -23,13 +23,7 @@
 #if !defined(XINCLUDE_H)
 #define XINCLUDE_H
 
-#include <ctype.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <limits.h>
-
+#include "git-compat-util.h"
 #include "xmacros.h"
 #include "xdiff.h"
 #include "xtypes.h"
-- 
2.21.0.922.g1a559e573c

