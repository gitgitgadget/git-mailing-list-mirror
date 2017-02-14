Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D33F1FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 06:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdBNGDs (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 01:03:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:54882 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbdBNGDr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 01:03:47 -0500
Received: (qmail 11620 invoked by uid 109); 14 Feb 2017 06:03:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 06:03:47 +0000
Received: (qmail 697 invoked by uid 111); 14 Feb 2017 06:03:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 01:03:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 01:03:45 -0500
Date:   Tue, 14 Feb 2017 01:03:45 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 3/7] t7810: make "--no-index --" test more robust
Message-ID: <20170214060344.6tybrzjri5e5q6li@sigill.intra.peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes sure that we actually use the pathspecs after
"--" correctly (as opposed to just seeing if grep errored
out).

Signed-off-by: Jeff King <peff@peff.net>
---
This could be squashed into the previous patch.

I didn't end up using the "nongit" helper, because we actually have to
do some other setup inside the subshell (this is the reason the earlier
tests in this script don't use the helper, either).

 t/t7810-grep.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 29202f0e7..2c1f7373e 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -990,7 +990,10 @@ test_expect_success 'grep --no-index pattern -- path' '
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		echo hello >hello &&
-		git grep --no-index o -- .
+		echo goodbye >goodbye &&
+		echo hello:hello >expect &&
+		git grep --no-index o -- hello >actual &&
+		test_cmp expect actual
 	)
 '
 
-- 
2.12.0.rc1.471.ga79ec8999

