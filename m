From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to non-GNU
 extended regex syntax
Date: Thu, 18 Sep 2008 17:47:18 -0500
Message-ID: <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 00:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgSJf-0007u1-Cf
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 00:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbYIRWsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 18:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbYIRWsb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 18:48:31 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58916 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968AbYIRWsa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 18:48:30 -0400
Received: by mail.nrlssc.navy.mil id m8IMlJlb002036; Thu, 18 Sep 2008 17:47:19 -0500
In-Reply-To: <7vskry1485.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 18 Sep 2008 22:47:19.0460 (UTC) FILETIME=[819BA640:01C919E0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96250>

The 'non-GNU' part of this basic RE to extended RE conversion means '\\s' was
converted to ' '.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 diff.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 9d8fd2b..c74f1a3 100644
--- a/diff.c
+++ b/diff.c
@@ -1404,23 +1404,24 @@ static const struct funcname_pattern_entry *funcname_pattern(const char *ident)
 }
 
 static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
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
+	{ "html", "^ *(<[Hh][1-6] .*>.*)$", REG_EXTENDED },
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
+	{ "python", "^ *((class|def)\\s.*)$", REG_EXTENDED },
+	{ "ruby", "^ *((class|module|def) .*)$", REG_EXTENDED },
+	{ "tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
+		REG_EXTENDED },
 };
 
 static const struct funcname_pattern_entry *diff_funcname_pattern(struct diff_filespec *one)
-- 
1.6.0.1.244.gdc19
