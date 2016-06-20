Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74E021FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 21:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbcFTViQ (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 17:38:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:57510 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752060AbcFTViN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 17:38:13 -0400
Received: (qmail 9423 invoked by uid 102); 20 Jun 2016 21:10:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 17:10:32 -0400
Received: (qmail 18090 invoked by uid 107); 20 Jun 2016 21:10:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 17:10:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2016 17:10:29 -0400
Date:	Mon, 20 Jun 2016 17:10:29 -0400
From:	Jeff King <peff@peff.net>
To:	Norbert Kiesel <nkiesel@gmail.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 1/3] t0006: rename test-date's "show" to "relative"
Message-ID: <20160620211029.GA31229@sigill.intra.peff.net>
References: <20160620210901.GE3631@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160620210901.GE3631@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The "show" tests are really only checking relative formats;
we should make that more clear.

This also frees up the "show" name to later check other
formats. We could later fold "relative" into a more generic
"show" command, but it's not worth it.  Relative times are a
special case already because we have to munge the concept of
"now" in our tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-date.c |  8 ++++----
 t/t0006-date.sh      | 26 +++++++++++++-------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 63f3735..8ebcded 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -1,11 +1,11 @@
 #include "cache.h"
 
 static const char *usage_msg = "\n"
-"  test-date show [time_t]...\n"
+"  test-date relative [time_t]...\n"
 "  test-date parse [date]...\n"
 "  test-date approxidate [date]...\n";
 
-static void show_dates(char **argv, struct timeval *now)
+static void show_relative_dates(char **argv, struct timeval *now)
 {
 	struct strbuf buf = STRBUF_INIT;
 
@@ -61,8 +61,8 @@ int main(int argc, char **argv)
 	argv++;
 	if (!*argv)
 		usage(usage_msg);
-	if (!strcmp(*argv, "show"))
-		show_dates(argv+1, &now);
+	if (!strcmp(*argv, "relative"))
+		show_relative_dates(argv+1, &now);
 	else if (!strcmp(*argv, "parse"))
 		parse_dates(argv+1, &now);
 	else if (!strcmp(*argv, "approxidate"))
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index fac0986..fa05269 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -6,26 +6,26 @@ test_description='test date parsing and printing'
 # arbitrary reference time: 2009-08-30 19:20:00
 TEST_DATE_NOW=1251660000; export TEST_DATE_NOW
 
-check_show() {
+check_relative() {
 	t=$(($TEST_DATE_NOW - $1))
 	echo "$t -> $2" >expect
 	test_expect_${3:-success} "relative date ($2)" "
-	test-date show $t >actual &&
+	test-date relative $t >actual &&
 	test_i18ncmp expect actual
 	"
 }
 
-check_show 5 '5 seconds ago'
-check_show 300 '5 minutes ago'
-check_show 18000 '5 hours ago'
-check_show 432000 '5 days ago'
-check_show 1728000 '3 weeks ago'
-check_show 13000000 '5 months ago'
-check_show 37500000 '1 year, 2 months ago'
-check_show 55188000 '1 year, 9 months ago'
-check_show 630000000 '20 years ago'
-check_show 31449600 '12 months ago'
-check_show 62985600 '2 years ago'
+check_relative 5 '5 seconds ago'
+check_relative 300 '5 minutes ago'
+check_relative 18000 '5 hours ago'
+check_relative 432000 '5 days ago'
+check_relative 1728000 '3 weeks ago'
+check_relative 13000000 '5 months ago'
+check_relative 37500000 '1 year, 2 months ago'
+check_relative 55188000 '1 year, 9 months ago'
+check_relative 630000000 '20 years ago'
+check_relative 31449600 '12 months ago'
+check_relative 62985600 '2 years ago'
 
 check_parse() {
 	echo "$1 -> $2" >expect
-- 
2.9.0.167.g9e4667c

