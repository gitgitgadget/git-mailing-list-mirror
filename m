Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ECA51FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 03:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbdD0D2f (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 23:28:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:40975 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751410AbdD0D2d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 23:28:33 -0400
Received: (qmail 13955 invoked by uid 109); 27 Apr 2017 03:28:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 03:28:33 +0000
Received: (qmail 3079 invoked by uid 111); 27 Apr 2017 03:28:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Apr 2017 23:28:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Apr 2017 23:28:31 -0400
Date:   Wed, 26 Apr 2017 23:28:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] am: shorten ident_split variable name in
 get_commit_info()
Message-ID: <20170427032830.sushxlvqb44px7lx@sigill.intra.peff.net>
References: <20170427032503.rgz3bnctnxdn3hin@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427032503.rgz3bnctnxdn3hin@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The local ident_split variable is often mentioned three
times per line when dealing with its begin/end pointer
pairs. Let's use a shorter name which lets us get rid of
some long lines.  Since this is a short self-contained
function, readability doesn't suffer.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e08f03326..2aed3ef01 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1382,33 +1382,31 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 {
 	const char *buffer, *ident_line, *msg;
 	size_t ident_len;
-	struct ident_split ident_split;
+	struct ident_split id;
 
 	buffer = logmsg_reencode(commit, NULL, get_commit_output_encoding());
 
 	ident_line = find_commit_header(buffer, "author", &ident_len);
 
-	if (split_ident_line(&ident_split, ident_line, ident_len) < 0)
+	if (split_ident_line(&id, ident_line, ident_len) < 0)
 		die(_("invalid ident line: %.*s"), (int)ident_len, ident_line);
 
 	assert(!state->author_name);
-	if (ident_split.name_begin) {
+	if (id.name_begin)
 		state->author_name =
-			xmemdupz(ident_split.name_begin,
-				 ident_split.name_end - ident_split.name_begin);
-	} else
+			xmemdupz(id.name_begin, id.name_end - id.name_begin);
+	else
 		state->author_name = xstrdup("");
 
 	assert(!state->author_email);
-	if (ident_split.mail_begin) {
+	if (id.mail_begin)
 		state->author_email =
-			xmemdupz(ident_split.mail_begin,
-				 ident_split.mail_end - ident_split.mail_begin);
-	} else
+			xmemdupz(id.mail_begin, id.mail_end - id.mail_begin);
+	else
 		state->author_email = xstrdup("");
 
 	assert(!state->author_date);
-	state->author_date = xstrdup(show_ident_date(&ident_split, DATE_MODE(NORMAL)));
+	state->author_date = xstrdup(show_ident_date(&id, DATE_MODE(NORMAL)));
 
 	assert(!state->msg);
 	msg = strstr(buffer, "\n\n");
-- 
2.13.0.rc0.465.ga1e654229
