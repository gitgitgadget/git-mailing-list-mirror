From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 3/3] Simplify some 'fprintf(stderr); return -1;' by using 'return error()'
Date: Mon,  8 Jun 2009 22:34:31 +0200
Message-ID: <7a02f50b758bfc6b9437f20cecea2d4628a5966a.1244492659.git.j6t@kdbg.org>
References: <cover.1244492658.git.j6t@kdbg.org>
 <e4b190906055eb86077ca3e7257c983befcfb511.1244492659.git.j6t@kdbg.org>
 <8f487369337bdb1c9884b8f6e56530d25de85472.1244492659.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 22:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDlZ9-0005ri-EP
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 22:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbZFHUf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 16:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbZFHUf1
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 16:35:27 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:63497 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335AbZFHUf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 16:35:27 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DB4C5CDF83;
	Mon,  8 Jun 2009 22:35:28 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A54211D0C2;
	Mon,  8 Jun 2009 22:35:28 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
In-Reply-To: <8f487369337bdb1c9884b8f6e56530d25de85472.1244492659.git.j6t@kdbg.org>
In-Reply-To: <cover.1244492658.git.j6t@kdbg.org>
References: <cover.1244492658.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121103>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-help.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index af565fb..6e53b23 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -80,10 +80,9 @@ static int check_emacsclient_version(void)
 	ec_process.argv = argv_ec;
 	ec_process.err = -1;
 	ec_process.stdout_to_stderr = 1;
-	if (start_command(&ec_process)) {
-		fprintf(stderr, "Failed to start emacsclient.\n");
-		return -1;
-	}
+	if (start_command(&ec_process))
+		return error("Failed to start emacsclient.");
+
 	strbuf_read(&buffer, ec_process.err, 20);
 	close(ec_process.err);
 
@@ -94,20 +93,17 @@ static int check_emacsclient_version(void)
 	finish_command(&ec_process);
 
 	if (prefixcmp(buffer.buf, "emacsclient")) {
-		fprintf(stderr, "Failed to parse emacsclient version.\n");
 		strbuf_release(&buffer);
-		return -1;
+		return error("Failed to parse emacsclient version.");
 	}
 
 	strbuf_remove(&buffer, 0, strlen("emacsclient"));
 	version = atoi(buffer.buf);
 
 	if (version < 22) {
-		fprintf(stderr,
-			"emacsclient version '%d' too old (< 22).\n",
-			version);
 		strbuf_release(&buffer);
-		return -1;
+		return error("emacsclient version '%d' too old (< 22).",
+			version);
 	}
 
 	strbuf_release(&buffer);
-- 
1.6.3.17.g1665f
