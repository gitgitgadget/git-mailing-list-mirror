From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 39/40] Windows: Fix ntohl() related warnings about printf formatting
Date: Wed, 27 Feb 2008 19:55:02 +0100
Message-ID: <1204138503-6126-40-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVb-00022R-Eb
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649AbYB0S4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756679AbYB0S4X
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:23 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40428 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbYB0SzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:13 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 3C2CC97727;
	Wed, 27 Feb 2008 19:55:11 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75284>

From: Steffen Prohaska <prohaska@zib.de>

From: Steffen Prohaska <prohaska@zib.de>

On Windows, ntohl() returns unsigned long.  On Unix it returns
uint32_t.  This makes choosing a suitable printf format string
hard.

This commit introduces a mingw specific helper function
git_ntohl() that casts to unsigned int before returning.  This
makes gcc's printf format check happy.  It should be safe because
we expect ntohl to use 32-bit numbers.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-compat-util.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4a53b3b..5ecdd40 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -631,6 +631,10 @@ pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env);
 void mingw_execvp(const char *cmd, char *const *argv);
 #define execvp mingw_execvp
 
+static inline unsigned int git_ntohl(unsigned int x)
+{ return (unsigned int)ntohl(x); }
+#define ntohl git_ntohl
+
 sig_handler_t mingw_signal(int sig, sig_handler_t handler);
 #define signal mingw_signal
 
-- 
1.5.4.1.126.ge5a7d
