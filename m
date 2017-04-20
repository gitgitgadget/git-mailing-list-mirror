Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E697C207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947610AbdDTVI3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:08:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:37254 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947595AbdDTVI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:08:28 -0400
Received: (qmail 2021 invoked by uid 109); 20 Apr 2017 21:08:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 21:08:28 +0000
Received: (qmail 9637 invoked by uid 111); 20 Apr 2017 21:08:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 17:08:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:08:25 -0400
Date:   Thu, 20 Apr 2017 17:08:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] bisect: add git_path_bisect_terms helper
Message-ID: <20170420210825.lr55sl7se4uloncf@sigill.intra.peff.net>
References: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This avoids using the dangerous git_path(). Right now
there's only one call site (because the writing half is
still part of the shell script), but it may come in handy in
the future as more of bisect is written in C. It also
matches how we access the other BISECT_* files.

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 03af06c66..08c9fb726 100644
--- a/bisect.c
+++ b/bisect.c
@@ -432,6 +432,7 @@ static int read_bisect_refs(void)
 
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
+static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 
 static void read_bisect_paths(struct argv_array *array)
 {
@@ -906,7 +907,7 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 void read_bisect_terms(const char **read_bad, const char **read_good)
 {
 	struct strbuf str = STRBUF_INIT;
-	const char *filename = git_path("BISECT_TERMS");
+	const char *filename = git_path_bisect_terms();
 	FILE *fp = fopen(filename, "r");
 
 	if (!fp) {
-- 
2.13.0.rc0.363.g8726c260e

