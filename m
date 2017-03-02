Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4B8020133
	for <e@80x24.org>; Thu,  2 Mar 2017 08:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbdCBI2I (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 03:28:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:37044 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbdCBI2H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 03:28:07 -0500
Received: (qmail 22590 invoked by uid 109); 2 Mar 2017 08:21:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 08:21:25 +0000
Received: (qmail 15200 invoked by uid 111); 2 Mar 2017 08:21:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 03:21:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 03:21:23 -0500
Date:   Thu, 2 Mar 2017 03:21:23 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 1/8] interpret_branch_name: move docstring to header file
Message-ID: <20170302082123.5flyazh5vll4ce7t@sigill.intra.peff.net>
References: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We generally put docstrings with function declarations,
because it's the callers who need to know how the function
works. Let's do so for interpret_branch_name().

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     | 21 +++++++++++++++++++++
 sha1_name.c | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index 80b6372cf..c67995caa 100644
--- a/cache.h
+++ b/cache.h
@@ -1363,6 +1363,27 @@ extern char *oid_to_hex_r(char *out, const struct object_id *oid);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
 
+/*
+ * This reads short-hand syntax that not only evaluates to a commit
+ * object name, but also can act as if the end user spelled the name
+ * of the branch from the command line.
+ *
+ * - "@{-N}" finds the name of the Nth previous branch we were on, and
+ *   places the name of the branch in the given buf and returns the
+ *   number of characters parsed if successful.
+ *
+ * - "<branch>@{upstream}" finds the name of the other ref that
+ *   <branch> is configured to merge with (missing <branch> defaults
+ *   to the current branch), and places the name of the branch in the
+ *   given buf and returns the number of characters parsed if
+ *   successful.
+ *
+ * If the input is not of the accepted format, it returns a negative
+ * number to signal an error.
+ *
+ * If the input was ok but there are not N branch switches in the
+ * reflog, it returns 0.
+ */
 extern int interpret_branch_name(const char *str, int len, struct strbuf *);
 extern int get_oid_mb(const char *str, struct object_id *oid);
 
diff --git a/sha1_name.c b/sha1_name.c
index 9b5d14b4b..28865b3a1 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1238,27 +1238,6 @@ static int interpret_branch_mark(const char *name, int namelen,
 	return len + at;
 }
 
-/*
- * This reads short-hand syntax that not only evaluates to a commit
- * object name, but also can act as if the end user spelled the name
- * of the branch from the command line.
- *
- * - "@{-N}" finds the name of the Nth previous branch we were on, and
- *   places the name of the branch in the given buf and returns the
- *   number of characters parsed if successful.
- *
- * - "<branch>@{upstream}" finds the name of the other ref that
- *   <branch> is configured to merge with (missing <branch> defaults
- *   to the current branch), and places the name of the branch in the
- *   given buf and returns the number of characters parsed if
- *   successful.
- *
- * If the input is not of the accepted format, it returns a negative
- * number to signal an error.
- *
- * If the input was ok but there are not N branch switches in the
- * reflog, it returns 0.
- */
 int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 {
 	char *at;
-- 
2.12.0.367.gb23790f66

