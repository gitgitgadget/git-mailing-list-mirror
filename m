From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/4 v2] diff.c: convert builtin funcname patterns to extended
 regular expressions
Date: Wed, 17 Sep 2008 19:33:12 -0500
Message-ID: <GDyYcKTaBR3x9PvTNoIdz93Z3xMLyTRKkKzkucPv-qhrm-KS_3c0QA@cipher.nrlssc.navy.mil>
References: <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd
X-From: git-owner@vger.kernel.org Thu Sep 18 02:36:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg7VB-0006VI-SI
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 02:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbYIRAdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 20:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbYIRAdj
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 20:33:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48793 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbYIRAdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 20:33:38 -0400
Received: by mail.nrlssc.navy.mil id m8I0XC3k012569; Wed, 17 Sep 2008 19:33:12 -0500
In-Reply-To: <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Sep 2008 00:33:12.0370 (UTC) FILETIME=[21D30920:01C91926]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96156>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


The original version changed the cflags parameter from '0' to '1'
rather than to the macro REG_EXTENDED as it should have been.

This version is corrected.

-brandon


 diff.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index ad5e551..8018544 100644
--- a/diff.c
+++ b/diff.c
@@ -1401,23 +1401,24 @@ static struct funcname_pattern_entry {
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
+	{ "bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#\\}\\{~%]*).*$", REG_EXTENDED },
+	{ "html", "^\\s*(<[Hh][1-6]\\s.*>.*)$", REG_EXTENDED },
+	{ "java", "!^[ 	]*(catch|do|for|if|instanceof|"
+			"new|return|switch|throw|while)\n"
+			"^[ 	]*(([ 	]*"
+			"[A-Za-z_][A-Za-z_0-9]*){2,}"
+			"[ 	]*\\([^;]*)$", REG_EXTENDED },
+	{ "pascal", "^((procedure|function|constructor|"
+			"destructor|interface|implementation|"
+			"initialization|finalization)[ \t]*.*)$"
+			"|"
+			"^(.*=[ \t]*(class|record).*)$",
+			REG_EXTENDED },
+	{ "php", "^[\t ]*((function|class).*)", REG_EXTENDED },
+	{ "python", "^\\s*((class|def)\\s.*)$", REG_EXTENDED },
+	{ "ruby", "^\\s*((class|module|def)\\s.*)$", REG_EXTENDED },
+	{ "tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
+		REG_EXTENDED },
 };
 
 static const struct funcname_pattern_entry *funcname_pattern(const char *ident)
-- 
1.6.0.1.244.gdc19
