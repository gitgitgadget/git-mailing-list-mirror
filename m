Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7A9202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdJCNpB (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:45:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:59170 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751291AbdJCNpA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:45:00 -0400
Received: (qmail 29580 invoked by uid 109); 3 Oct 2017 13:45:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:45:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7969 invoked by uid 111); 3 Oct 2017 13:44:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:44:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:44:58 -0400
Date:   Tue, 3 Oct 2017 09:44:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 09/12] t7301: use test_terminal to check color
Message-ID: <20171003134458.fl7jnfz4s3tn3gm7@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test wants to confirm that "clean -i" shows color
output. Using test_terminal gives us a more realistic
environment than "color.ui=always", and prepares us for the
behavior of "always" changing in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7301-clean-interactive.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index 556e1850e2..1bf9789c8a 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -3,6 +3,7 @@
 test_description='git clean -i basic tests'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'setup' '
 
@@ -472,10 +473,10 @@ test_expect_success 'git clean -id with prefix and path (ask)' '
 
 '
 
-test_expect_success 'git clean -i paints the header in HEADER color' '
+test_expect_success TTY 'git clean -i paints the header in HEADER color' '
 	>a.out &&
 	echo q |
-	git -c color.ui=always clean -i |
+	test_terminal git clean -i |
 	test_decode_color |
 	head -n 1 >header &&
 	# not i18ngrep
-- 
2.14.2.1079.gce6b466188

