From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] clone: use OPT_STRING_LIST for --reference
Date: Thu, 21 May 2015 00:15:19 -0400
Message-ID: <20150521041519.GA5196@peff.net>
References: <20150521041435.GA18978@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:15:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvHtG-0007rY-OD
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbbEUEPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:15:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:33627 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751215AbbEUEPW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:15:22 -0400
Received: (qmail 622 invoked by uid 102); 21 May 2015 04:15:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:15:22 -0500
Received: (qmail 30761 invoked by uid 107); 21 May 2015 04:15:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:15:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:15:19 -0400
Content-Disposition: inline
In-Reply-To: <20150521041435.GA18978@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269538>

Not only does this save us having to implement a custom
callback, but it handles "--no-reference" in the usual way
(to clear the list).

The generic callback does copy the string, which we don't
technically need, but that should not hurt anything.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 166a645..1426ef5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -51,15 +51,6 @@ static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
 
-static int opt_parse_reference(const struct option *opt, const char *arg, int unset)
-{
-	struct string_list *option_reference = opt->value;
-	if (!arg)
-		return -1;
-	string_list_append(option_reference, arg);
-	return 0;
-}
-
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
@@ -83,8 +74,8 @@ static struct option builtin_clone_options[] = {
 		    N_("initialize submodules in the clone")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
 		   N_("directory from which templates will be used")),
-	OPT_CALLBACK(0 , "reference", &option_reference, N_("repo"),
-		     N_("reference repository"), &opt_parse_reference),
+	OPT_STRING_LIST(0, "reference", &option_reference, N_("repo"),
+			N_("reference repository")),
 	OPT_STRING('o', "origin", &option_origin, N_("name"),
 		   N_("use <name> instead of 'origin' to track upstream")),
 	OPT_STRING('b', "branch", &option_branch, N_("branch"),
-- 
2.4.1.528.g00591e3
