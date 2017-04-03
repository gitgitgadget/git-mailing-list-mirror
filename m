Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73C32096C
	for <e@80x24.org>; Mon,  3 Apr 2017 18:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbdDCSxc (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 14:53:32 -0400
Received: from siwi.pair.com ([209.68.5.199]:36336 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbdDCSxb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 14:53:31 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7178B84649;
        Mon,  3 Apr 2017 14:53:25 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 4/4] p0002-read-cache: test core.checksumindex
Date:   Mon,  3 Apr 2017 18:53:06 +0000
Message-Id: <20170403185306.36164-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170403185306.36164-1-git@jeffhostetler.com>
References: <20170403185306.36164-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach t/perf/p0002-read-cache to time read_cache() with
and without the index checksum calculation.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p0002-read-cache.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/perf/p0002-read-cache.sh b/t/perf/p0002-read-cache.sh
index 9180ae9..71feacd 100755
--- a/t/perf/p0002-read-cache.sh
+++ b/t/perf/p0002-read-cache.sh
@@ -7,7 +7,13 @@ test_description="Tests performance of reading the index"
 test_perf_default_repo
 
 count=1000
-test_perf "read_cache/discard_cache $count times" "
+test_perf "read_cache/discard_cache checksum=1 $count times" "
+	git config --local core.checksumindex 1 &&
+	test-read-cache $count
+"
+
+test_perf "read_cache/discard_cache checksum=0 $count times" "
+	git config --local core.checksumindex 0 &&
 	test-read-cache $count
 "
 
-- 
2.9.3

