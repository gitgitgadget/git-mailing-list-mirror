Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5226CC6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbjH2XpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbjH2XpK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:45:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A11B3
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:07 -0700 (PDT)
Received: (qmail 14781 invoked by uid 109); 29 Aug 2023 23:45:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19829 invoked by uid 111); 29 Aug 2023 23:45:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 03/22] ref-filter: mark unused parameters in parser
 callbacks
Message-ID: <20230829234506.GA227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are similar to the cases annotated in 5fe9e1ce2f (ref-filter: mark
unused callback parameters, 2023-02-24), but were added after that
commit.

Note that the ahead/behind callback ignores its "atom" parameter, which
is a little unusual, since that struct usually stores the result. But in
this case, the data is stored centrally in ref_array->counts, since we
want to compute all ahead/behinds at once, not per ref.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1bfaf20fbf..88b021dd1d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -549,7 +549,8 @@ static int signature_atom_parser(struct ref_format *format UNUSED,
 	return 0;
 }
 
-static int trailers_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int trailers_atom_parser(struct ref_format *format UNUSED,
+				struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
 	atom->u.contents.trailer_opts.no_divider = 1;
@@ -819,7 +820,7 @@ static int if_atom_parser(struct ref_format *format UNUSED,
 	return 0;
 }
 
-static int rest_atom_parser(struct ref_format *format,
+static int rest_atom_parser(struct ref_format *format UNUSED,
 			    struct used_atom *atom UNUSED,
 			    const char *arg, struct strbuf *err)
 {
@@ -828,7 +829,8 @@ static int rest_atom_parser(struct ref_format *format,
 	return 0;
 }
 
-static int ahead_behind_atom_parser(struct ref_format *format, struct used_atom *atom,
+static int ahead_behind_atom_parser(struct ref_format *format,
+				    struct used_atom *atom UNUSED,
 				    const char *arg, struct strbuf *err)
 {
 	struct string_list_item *item;
-- 
2.42.0.528.g7950723a09

