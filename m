From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fetch--tool: fix uninitialized buffer when reading from
 stdin
Date: Mon, 26 Feb 2007 13:08:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702261306140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Feb 26 13:08:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLeeR-0002av-K1
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 13:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbXBZMIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 07:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbXBZMIM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 07:08:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:45939 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750989AbXBZMIL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 07:08:11 -0500
Received: (qmail invoked by alias); 26 Feb 2007 12:08:10 -0000
X-Provags-ID: V01U2FsdGVkX19qu3x7EWlqC/OeYCY5pabB3egwhAFjjeloeiYMlW
	9SEw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40619>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-fetch--tool.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 48de08d..e5bb560 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -14,6 +14,10 @@ static char *get_stdin(void)
 		data = xrealloc(data, offset + CHUNK_SIZE);
 		read = xread(0, data + offset, CHUNK_SIZE);
 	}
+	if (read > 0 && data[read - 1] == '\n')
+		data[read - 1] = '\0';
+	else
+		data[read] = '\0';
 	return data;
 }
 
-- 
1.5.0.1.2424.g39563
