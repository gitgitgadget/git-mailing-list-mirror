Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DBAC25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 08:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347720AbiHSIzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347658AbiHSIzR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 04:55:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A708D3E68
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 01:55:03 -0700 (PDT)
Received: (qmail 17558 invoked by uid 109); 19 Aug 2022 08:55:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 08:55:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 457 invoked by uid 111); 19 Aug 2022 08:55:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 04:55:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 04:55:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] reflog: assert PARSE_OPT_NONEG in parse-options callbacks
Message-ID: <Yv9P5l6ku3ZyG6yR@coredump.intra.peff.net>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the spirit of 517fe807d6 (assert NOARG/NONEG behavior of
parse-options callbacks, 2018-11-05), this asserts that our callbacks
were invoked using the right flags (since otherwise they'd segfault on
the NULL arg). Both cases are already correct here, so this is mostly
about annotating the functions, and appeasing -Wunused-parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/reflog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4dd297dce8..8123956847 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -193,6 +193,8 @@ static int expire_unreachable_callback(const struct option *opt,
 {
 	struct cmd_reflog_expire_cb *cmd = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (parse_expiry_date(arg, &cmd->expire_unreachable))
 		die(_("invalid timestamp '%s' given to '--%s'"),
 		    arg, opt->long_name);
@@ -207,6 +209,8 @@ static int expire_total_callback(const struct option *opt,
 {
 	struct cmd_reflog_expire_cb *cmd = opt->value;
 
+	BUG_ON_OPT_NEG(unset);
+
 	if (parse_expiry_date(arg, &cmd->expire_total))
 		die(_("invalid timestamp '%s' given to '--%s'"),
 		    arg, opt->long_name);
-- 
2.37.2.928.g0821088f4a
