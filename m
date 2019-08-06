Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4B521F731
	for <e@80x24.org>; Tue,  6 Aug 2019 12:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfHFM0q (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 08:26:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:35138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726092AbfHFM0q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 08:26:46 -0400
Received: (qmail 16520 invoked by uid 109); 6 Aug 2019 12:26:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 12:26:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1246 invoked by uid 111); 6 Aug 2019 12:29:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 08:29:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 08:26:45 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] t1309: use short branch name in includeIf.onbranch test
Message-ID: <20190806122645.GA13513@sigill.intra.peff.net>
References: <20190806122601.GA21475@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806122601.GA21475@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 85fe0e800c (config: work around bug with includeif:onbranch and
early config, 2019-07-31) tests that our early config-reader does not
access the file mentioned by includeIf.onbranch:refs/heads/master.path.
But it would never do so even if the feature were implemented, since the
onbranch matching code uses the short refname "master".

The test still serves its purpose, since the bug fixed by 85fe0e800c is
actually that we hit a BUG() before even deciding whether to match the
ref. But let's use the correct name to avoid confusion (and which we'll
eventually want to trigger once we do the "real" fix described in that
commit).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1309-early-config.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 0c37e7180d..eeb60e4143 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -91,7 +91,7 @@ test_expect_failure 'ignore .git/ with invalid config' '
 
 test_expect_success 'early config and onbranch' '
 	echo "[broken" >broken &&
-	test_with_config "[includeif \"onbranch:refs/heads/master\"]path=../broken"
+	test_with_config "[includeif \"onbranch:master\"]path=../broken"
 '
 
 test_done
-- 
2.23.0.rc1.436.g24d2e81391

