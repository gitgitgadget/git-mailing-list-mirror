From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 38/40] Windows: TMP and TEMP environment variables specify a temporary directory.
Date: Wed, 27 Feb 2008 19:55:01 +0100
Message-ID: <1204138503-6126-39-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVc-00022R-3X
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007AbYB0S40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbYB0S4Y
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:24 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40440 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682AbYB0SzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:13 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 170E197725;
	Wed, 27 Feb 2008 19:55:11 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75258>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 path.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/path.c b/path.c
index 4260952..7f18539 100644
--- a/path.c
+++ b/path.c
@@ -75,6 +75,13 @@ int git_mkstemp(char *path, size_t len, const char *template)
 	size_t n;
 
 	tmp = getenv("TMPDIR");
+#ifdef __MINGW32__
+	/* on Windows it is TMP and TEMP */
+	if (!tmp)
+	    tmp = getenv("TMP");
+	if (!tmp)
+	    tmp = getenv("TEMP");
+#endif
 	if (!tmp)
 		tmp = "/tmp";
 	n = snprintf(path, len, "%s/%s", tmp, template);
-- 
1.5.4.1.126.ge5a7d
