From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/4] diff.c: convert builtin funcname patterns to extended
 regular expressions
Date: Wed, 17 Sep 2008 19:21:47 -0500
Message-ID: <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd
X-From: git-owner@vger.kernel.org Thu Sep 18 02:24:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg7Jo-0002Et-Ba
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 02:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbYIRAXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 20:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbYIRAXQ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 20:23:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40601 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYIRAXP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 20:23:15 -0400
Received: by mail.nrlssc.navy.mil id m8I0Llwd009601; Wed, 17 Sep 2008 19:21:48 -0500
In-Reply-To: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Sep 2008 00:21:47.0962 (UTC) FILETIME=[89E2A9A0:01C91924]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96155>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This is a blind conversion removing \\ before ( and { etc.
and adding \\ before naked ( and { etc.

I hope the authors who last touched these patterns will help with testing:

bibtex: Johan Herland
  html: Johan Herland
  java: Junio Hamano, Jeff King
pascal: Avery Pennarun
   php: Andreas Ericsson
python: Kirill Smelkov
  ruby: Giuseppe Bilotta
   tex: Johan Herland

thanks,
-brandon


 diff.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index ad5e551..25d2259 100644
--- a/diff.c
+++ b/diff.c
@@ -1401,23 +1401,23 @@ static struct funcname_pattern_entry {
 	const char *pattern;
 	const int cflags;
 } builtin_funcname_pattern[] = {
-	{ "bibtex", "\\(@[a-zA-Z]\\{1,\\}[ \t]*{\\{0,1\\}[ \t]*[^ \t\"@',\\#}{~%]*\\).*$", 0 },
-	{ "html", "^\\s*\\(<[Hh][1-6]\\s.*>.*\\)$", 0 },
-	{ "java", "!^[ 	]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
-			"new\\|return\\|switch\\|throw\\|while\\)\n"
-			"^[ 	]*\\(\\([ 	]*"
-			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
-			"[ 	]*([^;]*\\)$", 0 },
-	{ "pascal", "^\\(\\(procedure\\|function\\|constructor\\|"
-			"destructor\\|interface\\|implementation\\|"
-			"initialization\\|finalization\\)[ \t]*.*\\)$"
-			"\\|"
-			"^\\(.*=[ \t]*\\(class\\|record\\).*\\)$",
-			0 },
-	{ "php", "^[\t ]*\\(\\(function\\|class\\).*\\)", 0 },
-	{ "python", "^\\s*\\(\\(class\\|def\\)\\s.*\\)$", 0 },
-	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$", 0 },
-	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$", 0 },
+	{ "bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#\\}\\{~%]*).*$", 1 },
+	{ "html", "^\\s*(<[Hh][1-6]\\s.*>.*)$", 1 },
+	{ "java", "!^[ 	]*(catch|do|for|if|instanceof|"
+			"new|return|switch|throw|while)\n"
+			"^[ 	]*(([ 	]*"
+			"[A-Za-z_][A-Za-z_0-9]*){2,}"
+			"[ 	]*\\([^;]*)$", 1 },
+	{ "pascal", "^((procedure|function|constructor|"
+			"destructor|interface|implementation|"
+			"initialization|finalization)[ \t]*.*)$"
+			"|"
+			"^(.*=[ \t]*(class|record).*)$",
+			1 },
+	{ "php", "^[\t ]*((function|class).*)", 1 },
+	{ "python", "^\\s*((class|def)\\s.*)$", 1 },
+	{ "ruby", "^\\s*((class|module|def)\\s.*)$", 1 },
+	{ "tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$", 1 },
 };
 
 static const struct funcname_pattern_entry *funcname_pattern(const char *ident)
-- 
1.6.0.1.244.gdc19
