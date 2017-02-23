Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D262022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbdBWXFx (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:05:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:32966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbdBWXFx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:05:53 -0500
Received: (qmail 26101 invoked by uid 109); 23 Feb 2017 23:05:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 23:05:52 +0000
Received: (qmail 7016 invoked by uid 111); 23 Feb 2017 23:05:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 18:05:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 18:05:50 -0500
Date:   Thu, 23 Feb 2017 18:05:50 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] sha1dc: adjust header includes for git
Message-ID: <20170223230550.7eosg57dzy346jkk@sigill.intra.peff.net>
References: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can replace system includes with git-compat-util.h (and
should make sure it is included in all .c files). We can
drop includes from headers entirely, as every .c file is
supposed to include git-compat-util itself first.

We also use the full "sha1dc/" path for including related
files. This isn't strictly necessary, but makes the expected
resolution more obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1dc/sha1.c      | 9 +++------
 sha1dc/sha1.h      | 2 --
 sha1dc/ubc_check.c | 4 ++--
 sha1dc/ubc_check.h | 2 --
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index ed2010911..762c6fff8 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -5,12 +5,9 @@
 * https://opensource.org/licenses/MIT
 ***/
 
-#include <string.h>
-#include <memory.h>
-#include <stdio.h>
-
-#include "sha1.h"
-#include "ubc_check.h"
+#include "git-compat-util.h"
+#include "sha1dc/sha1.h"
+#include "sha1dc/ubc_check.h"
 
 #define rotate_right(x,n) (((x)>>(n))|((x)<<(32-(n))))
 #define rotate_left(x,n)  (((x)<<(n))|((x)>>(32-(n))))
diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
index 8b522f9d2..ce5390397 100644
--- a/sha1dc/sha1.h
+++ b/sha1dc/sha1.h
@@ -5,8 +5,6 @@
 * https://opensource.org/licenses/MIT
 ***/
 
-#include <stdint.h>
-
 // uses SHA-1 message expansion to expand the first 16 words of W[] to 80 words
 void sha1_message_expansion(uint32_t W[80]);
 
diff --git a/sha1dc/ubc_check.c b/sha1dc/ubc_check.c
index 556aaf3c5..6bccd4f2b 100644
--- a/sha1dc/ubc_check.c
+++ b/sha1dc/ubc_check.c
@@ -22,8 +22,8 @@
 // a directly verifiable version named ubc_check_verify can be found in ubc_check_verify.c
 // ubc_check has been verified against ubc_check_verify using the 'ubc_check_test' program in the tools section
 
-#include <stdint.h>
-#include "ubc_check.h"
+#include "git-compat-util.h"
+#include "sha1dc/ubc_check.h"
 
 static const uint32_t DV_I_43_0_bit 	= (uint32_t)(1) << 0;
 static const uint32_t DV_I_44_0_bit 	= (uint32_t)(1) << 1;
diff --git a/sha1dc/ubc_check.h b/sha1dc/ubc_check.h
index 27285bdf5..05ff944eb 100644
--- a/sha1dc/ubc_check.h
+++ b/sha1dc/ubc_check.h
@@ -21,8 +21,6 @@
 #ifndef UBC_CHECK_H
 #define UBC_CHECK_H
 
-#include <stdint.h>
-
 #define DVMASKSIZE 1
 typedef struct { int dvType; int dvK; int dvB; int testt; int maski; int maskb; uint32_t dm[80]; } dv_info_t;
 extern dv_info_t sha1_dvs[];
-- 
2.12.0.rc2.629.ga7951ed82

