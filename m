Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EFF202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbdJCNkW (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:40:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:59068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751291AbdJCNkV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:40:21 -0400
Received: (qmail 29166 invoked by uid 109); 3 Oct 2017 13:40:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:40:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7820 invoked by uid 111); 3 Oct 2017 13:40:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:40:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:40:19 -0400
Date:   Tue, 3 Oct 2017 09:40:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 02/12] t4015: prefer --color to -c color.diff=always
Message-ID: <20171003134019.3hmpjpkbm4fes36w@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t4015 contains many color-related tests which need to
override the "is stdout a tty" check. They do so by setting
the color.diff config, but we can accomplish the same with
the --color option. Besides being shorter to type, switching
will prepare us for upcoming changes to "always" when see it
in config.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4015-diff-whitespace.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 12d182dc1b..b9df886e37 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -821,7 +821,7 @@ test_expect_success 'diff that introduces a line with only tabs' '
 	echo "test" >x &&
 	git commit -m "initial" x &&
 	echo "{NTN}" | tr "NT" "\n\t" >>x &&
-	git -c color.diff=always diff | test_decode_color >current &&
+	git diff --color | test_decode_color >current &&
 
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
@@ -851,7 +851,7 @@ test_expect_success 'diff that introduces and removes ws breakages' '
 		echo "2. and a new line "
 	} >x &&
 
-	git -c color.diff=always diff |
+	git diff --color |
 	test_decode_color >current &&
 
 	cat >expected <<-\EOF &&
@@ -923,15 +923,15 @@ test_expect_success 'ws-error-highlight test setup' '
 
 test_expect_success 'test --ws-error-highlight option' '
 
-	git -c color.diff=always diff --ws-error-highlight=default,old |
+	git diff --color --ws-error-highlight=default,old |
 	test_decode_color >current &&
 	test_cmp expect.default-old current &&
 
-	git -c color.diff=always diff --ws-error-highlight=all |
+	git diff --color --ws-error-highlight=all |
 	test_decode_color >current &&
 	test_cmp expect.all current &&
 
-	git -c color.diff=always diff --ws-error-highlight=none |
+	git diff --color --ws-error-highlight=none |
 	test_decode_color >current &&
 	test_cmp expect.none current
 
@@ -939,15 +939,15 @@ test_expect_success 'test --ws-error-highlight option' '
 
 test_expect_success 'test diff.wsErrorHighlight config' '
 
-	git -c color.diff=always -c diff.wsErrorHighlight=default,old diff |
+	git -c diff.wsErrorHighlight=default,old diff --color |
 	test_decode_color >current &&
 	test_cmp expect.default-old current &&
 
-	git -c color.diff=always -c diff.wsErrorHighlight=all diff |
+	git -c diff.wsErrorHighlight=all diff --color |
 	test_decode_color >current &&
 	test_cmp expect.all current &&
 
-	git -c color.diff=always -c diff.wsErrorHighlight=none diff |
+	git -c diff.wsErrorHighlight=none diff --color |
 	test_decode_color >current &&
 	test_cmp expect.none current
 
@@ -955,18 +955,18 @@ test_expect_success 'test diff.wsErrorHighlight config' '
 
 test_expect_success 'option overrides diff.wsErrorHighlight' '
 
-	git -c color.diff=always -c diff.wsErrorHighlight=none \
-		diff --ws-error-highlight=default,old |
+	git -c diff.wsErrorHighlight=none \
+		diff --color --ws-error-highlight=default,old |
 	test_decode_color >current &&
 	test_cmp expect.default-old current &&
 
-	git -c color.diff=always -c diff.wsErrorHighlight=default \
-		diff --ws-error-highlight=all |
+	git -c diff.wsErrorHighlight=default \
+		diff --color --ws-error-highlight=all |
 	test_decode_color >current &&
 	test_cmp expect.all current &&
 
-	git -c color.diff=always -c diff.wsErrorHighlight=all \
-		diff --ws-error-highlight=none |
+	git -c diff.wsErrorHighlight=all \
+		diff --color --ws-error-highlight=none |
 	test_decode_color >current &&
 	test_cmp expect.none current
 
-- 
2.14.2.1079.gce6b466188

