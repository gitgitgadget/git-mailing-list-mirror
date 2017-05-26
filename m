Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E5861FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759831AbdEZTHA (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:07:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:58598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755629AbdEZTGt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:06:49 -0400
Received: (qmail 21566 invoked by uid 109); 26 May 2017 19:06:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 19:06:44 +0000
Received: (qmail 32113 invoked by uid 111); 26 May 2017 19:07:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 15:07:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 May 2017 15:06:41 -0400
Date:   Fri, 26 May 2017 15:06:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/6] t4208: add check for ":/" without matching file
Message-ID: <20170526190641.s4pwrb4ty7zfdmcd@sigill.intra.peff.net>
References: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The DWIM magic in check_filename() doesn't just recognize
":/". It actually makes sure that the file it points to
exists. t4208 checks only the case where the path is
present, not the opposite. Since the next patches will be
touching this area, let's add a test to make sure it
continues working.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4208-log-magic-pathspec.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 001343e2f..70bc64100 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -29,6 +29,12 @@ test_expect_success '"git log -- :/a" should not be ambiguous' '
 	git log -- :/a
 '
 
+# This differs from the ":/a" check above in that :/in looks like a pathspec,
+# but doesn't match an actual file.
+test_expect_success '"git log :/in" should not be ambiguous' '
+	git log :/in
+'
+
 test_expect_success '"git log :" should be ambiguous' '
 	test_must_fail git log : 2>error &&
 	test_i18ngrep ambiguous error
-- 
2.13.0.496.ge44ba89db

