Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1C31F453
	for <e@80x24.org>; Thu, 24 Jan 2019 13:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfAXNLo (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 08:11:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:47184 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726105AbfAXNLo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 08:11:44 -0500
Received: (qmail 27428 invoked by uid 109); 24 Jan 2019 13:11:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 13:11:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28247 invoked by uid 111); 24 Jan 2019 13:11:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 08:11:48 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 08:11:42 -0500
Date:   Thu, 24 Jan 2019 08:11:42 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/8] apply: drop unused "def" parameter from find_name_gnu()
Message-ID: <20190124131142.GB22398@sigill.intra.peff.net>
References: <20190124131104.GA24017@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124131104.GA24017@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use the "def" parameter in find_name_common() for some heuristics,
but they are not necessary with the less-ambiguous GNU format. Let's
drop this unused parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 apply.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index 3703bfc8d0..ccab7e7907 100644
--- a/apply.c
+++ b/apply.c
@@ -467,7 +467,6 @@ static char *squash_slash(char *name)
 
 static char *find_name_gnu(struct apply_state *state,
 			   const char *line,
-			   const char *def,
 			   int p_value)
 {
 	struct strbuf name = STRBUF_INIT;
@@ -714,7 +713,7 @@ static char *find_name(struct apply_state *state,
 		       int terminate)
 {
 	if (*line == '"') {
-		char *name = find_name_gnu(state, line, def, p_value);
+		char *name = find_name_gnu(state, line, p_value);
 		if (name)
 			return name;
 	}
@@ -731,7 +730,7 @@ static char *find_name_traditional(struct apply_state *state,
 	size_t date_len;
 
 	if (*line == '"') {
-		char *name = find_name_gnu(state, line, def, p_value);
+		char *name = find_name_gnu(state, line, p_value);
 		if (name)
 			return name;
 	}
-- 
2.20.1.842.g8986705066

