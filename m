From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] pretty: factor out skip_empty_lines()
Date: Sat, 27 Dec 2008 01:32:49 +0100
Message-ID: <1230337969.8363.84.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 27 01:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGN9f-0003oS-Hz
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 01:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbYL0Ac6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 19:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYL0Ac5
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 19:32:57 -0500
Received: from india601.server4you.de ([85.25.151.105]:36228 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbYL0Ac4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 19:32:56 -0500
Received: from [10.0.1.101] (p57B7F73B.dip.t-dialin.net [87.183.247.59])
	by india601.server4you.de (Postfix) with ESMTPSA id EF2092F8003;
	Sat, 27 Dec 2008 01:32:54 +0100 (CET)
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103970>

The patch after the next one will use it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 pretty.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/pretty.c b/pretty.c
index f6ff312..c43497b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -181,6 +181,20 @@ static int is_empty_line(const char *line, int *len_p)
 	return !len;
 }
 
+static const char *skip_empty_lines(const char *msg)
+{
+	for (;;) {
+		int linelen = get_one_line(msg);
+		int ll = linelen;
+		if (!linelen)
+			break;
+		if (!is_empty_line(msg, &ll))
+			break;
+		msg += linelen;
+	}
+	return msg;
+}
+
 static void add_merge_info(enum cmit_fmt fmt, struct strbuf *sb,
 			const struct commit *commit, int abbrev)
 {
@@ -850,15 +864,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	}
 
 	/* Skip excess blank lines at the beginning of body, if any... */
-	for (;;) {
-		int linelen = get_one_line(msg);
-		int ll = linelen;
-		if (!linelen)
-			break;
-		if (!is_empty_line(msg, &ll))
-			break;
-		msg += linelen;
-	}
+	msg = skip_empty_lines(msg);
 
 	/* These formats treat the title line specially. */
 	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
-- 
1.6.1
