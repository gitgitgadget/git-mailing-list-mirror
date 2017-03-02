Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4D920133
	for <e@80x24.org>; Thu,  2 Mar 2017 08:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753922AbdCBI2P (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 03:28:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:37045 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbdCBI2O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 03:28:14 -0500
Received: (qmail 22605 invoked by uid 109); 2 Mar 2017 08:21:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 08:21:32 +0000
Received: (qmail 15210 invoked by uid 111); 2 Mar 2017 08:21:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 03:21:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 03:21:30 -0500
Date:   Thu, 2 Mar 2017 03:21:30 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 3/8] strbuf_branchname: add docstring
Message-ID: <20170302082130.ynfctf73qbvwt3qo@sigill.intra.peff.net>
References: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function and its companion, strbuf_check_branch_ref(),
did not have their purpose or semantics explained. Let's do
so.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/strbuf.h b/strbuf.h
index 47df0500d..6b51b2604 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -560,7 +560,22 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 	strbuf_complete(sb, '\n');
 }
 
+/*
+ * Copy "name" to "sb", expanding any special @-marks as handled by
+ * interpret_branch_name(). The result is a non-qualified branch name
+ * (so "foo" or "origin/master" instead of "refs/heads/foo" or
+ * "refs/remotes/origin/master").
+ *
+ * Note that the resulting name may not be a syntactically valid refname.
+ */
 extern void strbuf_branchname(struct strbuf *sb, const char *name);
+
+/*
+ * Like strbuf_branchname() above, but confirm that the result is
+ * syntactically valid to be used as a local branch name in refs/heads/.
+ *
+ * The return value is "0" if the result is valid, and "-1" otherwise.
+ */
 extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
-- 
2.12.0.367.gb23790f66

