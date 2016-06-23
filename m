Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C15A1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 17:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbcFWRkU (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:40:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:59221 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751141AbcFWRkS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 13:40:18 -0400
Received: (qmail 30287 invoked by uid 102); 23 Jun 2016 17:40:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:40:18 -0400
Received: (qmail 12946 invoked by uid 107); 23 Jun 2016 17:40:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:40:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 13:40:16 -0400
Date:	Thu, 23 Jun 2016 13:40:16 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Simon Courtois <scourtois@cubyx.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/7] color: support strike-through attribute
Message-ID: <20160623174015.GG15774@sigill.intra.peff.net>
References: <20160623173048.GA19923@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623173048.GA19923@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is the only remaining attribute that is commonly
supported (at least by xterm) that we don't support. Let's
add it for completeness.

Signed-off-by: Jeff King <peff@peff.net>
---
This was mostly for fun.  I can't think of a way in which it would be
useful, and I'm not sure how compelling completionism is as an argument
for inclusion. I'm OK if we drop this one.

 Documentation/config.txt | 5 +++--
 color.c                  | 3 ++-
 color.h                  | 4 ++--
 t/t4026-color.sh         | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c7818ff..b10e49d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -163,8 +163,9 @@ Colors may also be given as numbers between 0 and 255; these use ANSI
 your terminal supports it, you may also specify 24-bit RGB values as
 hex, like `#ff0ab3`.
 +
-The accepted attributes are `bold`, `dim`, `ul`, `blink`, `reverse`, and
-`italic`.  The position of any attributes with respect to the colors
+The accepted attributes are `bold`, `dim`, `ul`, `blink`, `reverse`,
+`italic`, and `strike` (for crossed-out or "strikethrough" letters).
+The position of any attributes with respect to the colors
 (before, after, or in between), doesn't matter. Specific attributes may
 be turned off by prefixing them with `no` or `no-` (e.g., `noreverse`,
 `no-ul`, etc).
diff --git a/color.c b/color.c
index dcfaea8..eb028bd 100644
--- a/color.c
+++ b/color.c
@@ -136,7 +136,8 @@ static int parse_attr(const char *name, size_t len)
 		ATTR("italic",    3, 23),
 		ATTR("ul",        4, 24),
 		ATTR("blink",     5, 25),
-		ATTR("reverse",   7, 27)
+		ATTR("reverse",   7, 27),
+		ATTR("strike",    9, 29)
 #undef ATTR
 	};
 	int negate = 0;
diff --git a/color.h b/color.h
index 3af01a6..6cae166 100644
--- a/color.h
+++ b/color.h
@@ -17,9 +17,9 @@ struct strbuf;
  * The space for attributes is also slightly overallocated, as
  * the negation for some attributes is the same (e.g., nobold and nodim).
  *
- * We allocate space for 6 attributes.
+ * We allocate space for 7 attributes.
  */
-#define COLOR_MAXLEN 70
+#define COLOR_MAXLEN 75
 
 /*
  * IMPORTANT: Due to the way these color codes are emulated on Windows,
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 13690f7..ec78c5e 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -61,8 +61,8 @@ test_expect_success 'long color specification' '
 test_expect_success 'absurdly long color specification' '
 	color \
 	  "#ffffff #ffffff bold nobold dim nodim italic noitalic
-	   ul noul blink noblink reverse noreverse" \
-	  "[1;2;3;4;5;7;22;23;24;25;27;38;2;255;255;255;48;2;255;255;255m"
+	   ul noul blink noblink reverse noreverse strike nostrike" \
+	  "[1;2;3;4;5;7;9;22;23;24;25;27;29;38;2;255;255;255;48;2;255;255;255m"
 '
 
 test_expect_success '0-7 are aliases for basic ANSI color names' '
-- 
2.9.0.209.g845fbc1
