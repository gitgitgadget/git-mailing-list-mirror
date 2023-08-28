Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42284C83F17
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjH1VtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjH1Vsf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:48:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7133ECC5
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:48:27 -0700 (PDT)
Received: (qmail 606 invoked by uid 109); 28 Aug 2023 21:48:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:48:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4580 invoked by uid 111); 28 Aug 2023 21:48:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:48:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:48:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 22/22] update-ref: mark unused parameter in parser callbacks
Message-ID: <20230828214826.GV3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parsing of stdin is driven by a table of function pointers; mark
unused parameters in concrete functions to avoid -Wunused-parameter
warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/update-ref.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 242102273e..c0c4e65e6f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -311,8 +311,8 @@ static void report_ok(const char *command)
 	fflush(stdout);
 }
 
-static void parse_cmd_option(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+static void parse_cmd_option(struct ref_transaction *transaction UNUSED,
+			     const char *next, const char *end UNUSED)
 {
 	const char *rest;
 	if (skip_prefix(next, "no-deref", &rest) && *rest == line_termination)
@@ -321,16 +321,16 @@ static void parse_cmd_option(struct ref_transaction *transaction,
 		die("option unknown: %s", next);
 }
 
-static void parse_cmd_start(struct ref_transaction *transaction,
-			    const char *next, const char *end)
+static void parse_cmd_start(struct ref_transaction *transaction UNUSED,
+			    const char *next, const char *end UNUSED)
 {
 	if (*next != line_termination)
 		die("start: extra input: %s", next);
 	report_ok("start");
 }
 
 static void parse_cmd_prepare(struct ref_transaction *transaction,
-			      const char *next, const char *end)
+			      const char *next, const char *end UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -341,7 +341,7 @@ static void parse_cmd_prepare(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_abort(struct ref_transaction *transaction,
-			    const char *next, const char *end)
+			    const char *next, const char *end UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -352,7 +352,7 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_commit(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
-- 
2.42.0.505.g4c6fb48dec
