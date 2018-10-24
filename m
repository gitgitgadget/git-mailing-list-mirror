Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE1C1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 07:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeJXQEC (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:04:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:52426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729989AbeJXQEC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:04:02 -0400
Received: (qmail 7402 invoked by uid 109); 24 Oct 2018 07:37:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Oct 2018 07:37:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2203 invoked by uid 111); 24 Oct 2018 07:36:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Oct 2018 03:36:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2018 03:37:06 -0400
Date:   Wed, 24 Oct 2018 03:37:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t5410: use longer path for sample script
Message-ID: <20181024073705.GA31202@sigill.intra.peff.net>
References: <20181024073637.GA31069@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181024073637.GA31069@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t5410 creates a sample script "alternate-refs", and sets
core.alternateRefsCommand to just "alternate-refs". That
shouldn't work, as "." is not in our $PATH, and so we should
not find it.

However, due to a bug in run-command.c, we sometimes find it
anyway! Even more confusing, this bug is only in the
fork-based version of run-command. So the test passes on
Linux (etc), but fails on Windows.

In preparation for fixing the run-command bug, let's use a
more complete path here.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5410-receive-pack-alternates.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
index 457c20c2a5..f00d0da860 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -23,7 +23,7 @@ test_expect_success 'with core.alternateRefsCommand' '
 			--format="%(objectname)" \
 			refs/heads/public/
 	EOF
-	test_config -C fork core.alternateRefsCommand alternate-refs &&
+	test_config -C fork core.alternateRefsCommand ./alternate-refs &&
 	git rev-parse public/branch >expect &&
 	printf "0000" | git receive-pack fork >actual &&
 	extract_haves <actual >actual.haves &&
-- 
2.19.1.1094.gd480080bf6

