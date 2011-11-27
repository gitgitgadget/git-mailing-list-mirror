From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] prompt: add PROMPT_ECHO flag
Date: Sun, 27 Nov 2011 03:30:26 -0500
Message-ID: <20111127083025.GD1702@sigill.intra.peff.net>
References: <20111127082744.GA32068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 09:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUa88-00037K-Un
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 09:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab1K0Ia2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 03:30:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53667
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857Ab1K0Ia2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 03:30:28 -0500
Received: (qmail 13150 invoked by uid 107); 27 Nov 2011 08:37:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 27 Nov 2011 03:37:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2011 03:30:26 -0500
Content-Disposition: inline
In-Reply-To: <20111127082744.GA32068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185974>

This will use getpass_echo when set.

Signed-off-by: Jeff King <peff@peff.net>
---
 prompt.c |    5 ++++-
 prompt.h |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/prompt.c b/prompt.c
index 7c8f9aa..c46227f 100644
--- a/prompt.c
+++ b/prompt.c
@@ -2,6 +2,7 @@
 #include "run-command.h"
 #include "strbuf.h"
 #include "prompt.h"
+#include "compat/getpass.h"
 
 static char *do_askpass(const char *cmd, const char *prompt, const char *name)
 {
@@ -48,7 +49,9 @@
 			return do_askpass(askpass, prompt, name);
 	}
 
-	return getpass(prompt);
+	return flags & PROMPT_ECHO ?
+		getpass_echo(prompt) :
+		getpass(prompt);
 }
 
 char *git_getpass(const char *prompt)
diff --git a/prompt.h b/prompt.h
index 18868c2..7201cae 100644
--- a/prompt.h
+++ b/prompt.h
@@ -2,6 +2,7 @@
 #define PROMPT_H
 
 #define PROMPT_ASKPASS (1<<0)
+#define PROMPT_ECHO    (1<<1)
 
 char *git_prompt(const char *prompt, const char *name, int flags);
 char *git_getpass(const char *prompt);
-- 
1.7.7.4.7.g24824
