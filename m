From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] diff: Support visibility modifiers in the PHP hunk header
 regexp
Date: Sun, 23 May 2010 20:05:40 +0200
Message-ID: <20100523180540.GA29729@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 23 20:05:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGFYf-0002UB-OF
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 20:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab0EWSFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 May 2010 14:05:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:57864 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752881Ab0EWSFp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 14:05:45 -0400
Received: (qmail invoked by alias); 23 May 2010 18:05:43 -0000
Received: from i59F570AF.versanet.de (EHLO atjola.homenet) [89.245.112.175]
  by mail.gmx.net (mp055) with SMTP; 23 May 2010 20:05:43 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+Zr2t+AqaZ+84uKwJT+z1EHu39qpLdP3WoWWGwT3
	xe6N27jVQ2YPnz
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147580>

Starting with PHP5, class methods can have a visibility modifier, which
caused the methods not to be matched by the existing regexp, so extend
the regexp to match those modifiers. And while we're at it, allow the
"static" modifier as well.

Since the "static" modifier can appear either before or after the
visibility modifier, let's just allow any number of modifiers to appear
in any order, as that simplifies the regexp and shouldn't cause any
false positives.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 userdiff.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 67003fb..c49cc1b 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -45,7 +45,9 @@ PATTERNS("pascal",
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
 	 "|<>|<=3D|>=3D|:=3D|\\.\\."
 	 "|[^[:space:]]|[\x80-\xff]+"),
-PATTERNS("php", "^[\t ]*((function|class).*)",
+PATTERNS("php",
+	 "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
+	 "^[\t ]*(class.*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
--=20
1.7.1.227.g12cb1
