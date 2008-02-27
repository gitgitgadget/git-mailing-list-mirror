From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 08/40] Windows: always chmod(, 0666) before unlink().
Date: Wed, 27 Feb 2008 19:54:31 +0100
Message-ID: <1204138503-6126-9-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 19:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVK-00022R-Gx
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbYB0Sz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756058AbYB0SzY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:24 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40429 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbYB0SzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:07 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 520DB97571;
	Wed, 27 Feb 2008 19:55:05 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75252>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

On Windows, a read-only files cannot be deleted. To make sure that
deletion does not fail because of this, always call chmod() before
unlink().

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-compat-util.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 672c074..06ac2c1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -551,6 +551,14 @@ static inline int mingw_mkdir(const char *path, int mode)
 }
 #define mkdir mingw_mkdir
 
+static inline int mingw_unlink(const char *pathname)
+{
+	/* read-only files cannot be removed */
+	chmod(pathname, 0666);
+	return unlink(pathname);
+}
+#define unlink mingw_unlink
+
 static inline int waitpid(pid_t pid, unsigned *status, unsigned options)
 {
 	if (options == 0)
-- 
1.5.4.1.126.ge5a7d
