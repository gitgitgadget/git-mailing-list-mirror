From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] prompt: use git_terminal_prompt
Date: Thu, 8 Dec 2011 03:33:39 -0500
Message-ID: <20111208083339.GF26409@sigill.intra.peff.net>
References: <20111208082118.GA1507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 09:33:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYZQK-0001pw-Cu
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 09:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab1LHIdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 03:33:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43114
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525Ab1LHIdm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 03:33:42 -0500
Received: (qmail 25854 invoked by uid 107); 8 Dec 2011 08:40:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Dec 2011 03:40:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2011 03:33:39 -0500
Content-Disposition: inline
In-Reply-To: <20111208082118.GA1507@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186542>

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
1.7.8.rc2.8.gf0f4f
