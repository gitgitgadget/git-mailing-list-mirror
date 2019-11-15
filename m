Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D007A1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfKOJF6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:05:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:48236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725829AbfKOJF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:05:58 -0500
Received: (qmail 31639 invoked by uid 109); 15 Nov 2019 09:05:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Nov 2019 09:05:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16391 invoked by uid 111); 15 Nov 2019 09:09:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Nov 2019 04:09:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Nov 2019 04:05:56 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     NAKAYAMA DAISUKE <nakyamad@icloud.com>
Subject: [PATCH 1/4] t9502: pass along all arguments in xss helper
Message-ID: <20191115090556.GA21987@sigill.intra.peff.net>
References: <20191115090545.GA30971@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115090545.GA30971@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is just a thin wrapper around gitweb_run(), which takes
multiple arguments. But we only pass along "$1". Let's pass everything
we get, which will let a future patch add an XSS test that affects
PATH_INFO (which gitweb_run() takes as $2).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9502-gitweb-standalone-parse-output.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 0796a438bc..1b04c29037 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -188,8 +188,8 @@ test_expect_success 'forks: project_index lists all projects (incl. forks)' '
 '
 
 xss() {
-	echo >&2 "Checking $1..." &&
-	gitweb_run "$1" &&
+	echo >&2 "Checking $*..." &&
+	gitweb_run "$@" &&
 	if grep "$TAG" gitweb.body; then
 		echo >&2 "xss: $TAG should have been quoted in output"
 		return 1
-- 
2.24.0.739.gb5632e4929

