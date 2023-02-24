Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A407BC677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBXGir (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBXGip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:38:45 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A889752DF8
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:38:44 -0800 (PST)
Received: (qmail 3672 invoked by uid 109); 24 Feb 2023 06:38:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:38:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31098 invoked by uid 111); 24 Feb 2023 06:38:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:38:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:38:43 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/21] http-backend: mark unused parameters in virtual
 functions
Message-ID: <Y/hbc7gsBMXQcpJ+@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The http-backend dispatches requests via a table of virtual functions.
Some of the functions ignore their "arg" parameter, because it's
implicit in the function (e.g., get_info_refs knows that it is
dispatched only for a request to "/info/refs").

Mark these unused parameters to silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index fc3ab97c0f..db963e64d7 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -524,7 +524,7 @@ static int show_text_ref(const char *name, const struct object_id *oid,
 	return 0;
 }
 
-static void get_info_refs(struct strbuf *hdr, char *arg)
+static void get_info_refs(struct strbuf *hdr, char *arg UNUSED)
 {
 	const char *service_name = get_parameter("service");
 	struct strbuf buf = STRBUF_INIT;
@@ -578,7 +578,7 @@ static int show_head_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static void get_head(struct strbuf *hdr, char *arg)
+static void get_head(struct strbuf *hdr, char *arg UNUSED)
 {
 	struct strbuf buf = STRBUF_INIT;
 
@@ -588,7 +588,7 @@ static void get_head(struct strbuf *hdr, char *arg)
 	strbuf_release(&buf);
 }
 
-static void get_info_packs(struct strbuf *hdr, char *arg)
+static void get_info_packs(struct strbuf *hdr, char *arg UNUSED)
 {
 	size_t objdirlen = strlen(get_object_directory());
 	struct strbuf buf = STRBUF_INIT;
-- 
2.39.2.981.g6157336f25

