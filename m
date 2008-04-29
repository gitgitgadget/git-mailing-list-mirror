From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 2/2] log: print log entry terminator even if the message is empty
Date: Tue, 29 Apr 2008 01:33:00 -0700
Message-ID: <1209457980-19677-2-git-send-email-adam@adamsimpkins.net>
References: <1209457980-19677-1-git-send-email-adam@adamsimpkins.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 10:34:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqlHh-0004m6-0V
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 10:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086AbYD2IdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 04:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbYD2IdG
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 04:33:06 -0400
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:59845 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbYD2IdF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 04:33:05 -0400
Received: from relay1.r1.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay1.r1.iad.emailsrvr.com (SMTP Server) with ESMTP id 4F80544C1C3;
	Tue, 29 Apr 2008 04:33:03 -0400 (EDT)
Received: by relay1.r1.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 2B6E744C182;
	Tue, 29 Apr 2008 04:33:03 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id D96CA14100C0; Tue, 29 Apr 2008 01:33:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1209457980-19677-1-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80668>

This eliminates a special case in the show_log() function, to help
simplify the terminator semantics.  Now show_log() always prints a
newline after the log entry when use_terminator is set, even if the log
message is empty.

This change should only affect the --pretty=tformat output, since that
was the only way to trigger this special case.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 log-tree.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 4c7d7ef..74b79b5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -307,11 +307,9 @@ void show_log(struct rev_info *opt)
 	if (opt->show_log_size)
 		printf("log size %i\n", (int)msgbuf.len);
 
-	if (msgbuf.len) {
-		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
-		if (opt->use_terminator)
-			putchar('\n');
-	}
+	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+	if (opt->use_terminator)
+		putchar('\n');
 	strbuf_release(&msgbuf);
 }
 
-- 
1.5.3.6
