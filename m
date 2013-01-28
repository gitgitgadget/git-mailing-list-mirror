From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] fixup! mergetools: simplify how we handle "vim" and
 "defaults"
Date: Mon, 28 Jan 2013 19:28:56 +0000
Message-ID: <20130128192856.GA7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 20:29:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzuOW-00012c-TK
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 20:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab3A1T3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 14:29:07 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:39139 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab3A1T3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 14:29:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id E2DAE22F0A;
	Mon, 28 Jan 2013 19:29:04 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P6JME8LTlBVQ; Mon, 28 Jan 2013 19:29:03 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id E88931FC75;
	Mon, 28 Jan 2013 19:28:58 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214858>

---
Junio, please can you squash this into f9924e5 on jk/mergetool,
providing that David is OK with that?

The original change breaks custom mergetool by making changing the logic
around default functions so that they are now only defined when the tool
file exists in $MERGE_TOOLS_DIR but we need the default implementations
when a custom tool is in use, which by definition means that the file
doesn't exist in $MERGE_TOOLS_DIR.

 git-mergetool--lib.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 1d0fb12..211ffe5 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -48,15 +48,6 @@ valid_tool () {
 setup_tool () {
 	tool="$1"
 
-	if ! test -f "$MERGE_TOOLS_DIR/$tool"
-	then
-		# Use a special return code for this case since we want to
-		# source "defaults" even when an explicit tool path is
-		# configured since the user can use that to override the
-		# default path in the scriptlet.
-		return 2
-	fi
-
 	# Fallback definitions, to be overriden by tools.
 	can_merge () {
 		return 0
@@ -80,6 +71,15 @@ setup_tool () {
 		echo "$1"
 	}
 
+	if ! test -f "$MERGE_TOOLS_DIR/$tool"
+	then
+		# Use a special return code for this case since we want to
+		# source "defaults" even when an explicit tool path is
+		# configured since the user can use that to override the
+		# default path in the scriptlet.
+		return 2
+	fi
+
 	# Load the redefined functions
 	. "$MERGE_TOOLS_DIR/$tool"
 
-- 
1.8.1.1
