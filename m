From: Jeff King <peff@peff.net>
Subject: [PATCHv2 6/9] prompt: use git_terminal_prompt
Date: Sat, 10 Dec 2011 05:41:08 -0500
Message-ID: <20111210104108.GF16648@sigill.intra.peff.net>
References: <20111210103943.GA16478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:41:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKMl-0000Gu-No
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab1LJKlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:41:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47060
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab1LJKlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:41:10 -0500
Received: (qmail 14449 invoked by uid 107); 10 Dec 2011 10:47:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:47:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:41:08 -0500
Content-Disposition: inline
In-Reply-To: <20111210103943.GA16478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186753>

Our custom implementation of git_terminal_prompt has many
advantages over regular getpass(), as described in the prior
commit.

This also lets us implement a PROMPT_ECHO flag for callers
who want it.

Signed-off-by: Jeff King <peff@peff.net>
---
 prompt.c |    3 ++-
 prompt.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/prompt.c b/prompt.c
index 2002644..72ab9de 100644
--- a/prompt.c
+++ b/prompt.c
@@ -2,6 +2,7 @@
 #include "run-command.h"
 #include "strbuf.h"
 #include "prompt.h"
+#include "compat/terminal.h"
 
 static char *do_askpass(const char *cmd, const char *prompt)
 {
@@ -50,7 +51,7 @@
 			return do_askpass(askpass, prompt);
 	}
 
-	r = getpass(prompt);
+	r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
 	if (!r)
 		die_errno("could not read '%s'", prompt);
 	return r;
diff --git a/prompt.h b/prompt.h
index 9ab85a7..04f321a 100644
--- a/prompt.h
+++ b/prompt.h
@@ -2,6 +2,7 @@
 #define PROMPT_H
 
 #define PROMPT_ASKPASS (1<<0)
+#define PROMPT_ECHO    (1<<1)
 
 char *git_prompt(const char *prompt, int flags);
 char *git_getpass(const char *prompt);
-- 
1.7.8.rc2.40.gaf387
