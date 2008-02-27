From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 40/40] compat/pread.c: Add foward decl to fix warning
Date: Wed, 27 Feb 2008 19:55:03 +0100
Message-ID: <1204138503-6126-41-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:03:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURYW-0003UN-J8
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353AbYB0TAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 14:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbYB0S4c
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:32 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40473 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbYB0SzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:13 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 5E2C297729;
	Wed, 27 Feb 2008 19:55:11 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75285>

From: Steffen Prohaska <prohaska@zib.de>

From: Steffen Prohaska <prohaska@zib.de>

read_in_full() is used in compat/pread.c.  read_in_full() is
declared in cache.h. But we can't include cache.h because too
many macros are defined there.  Using read_in_full() without
including cache.h is dangerous because we wouldn't recognize if
its prototyp changed.  gcc issues a warning about that.

This commit adds a forward decl to git-compat-util.h.
git-compat-util.h is included by compat/pread.c _and_ cache.h.
Hence, changes in cache.h would be detected.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-compat-util.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5ecdd40..4a8df8e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -168,6 +168,10 @@ extern int git_munmap(void *start, size_t length);
 #define pread git_pread
 extern ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 #endif
+/* Forward decl that will remind us if its twin in cache.h changes.
+   This function in used in compat/pread.c.  But we can't include
+   cache.h there. */
+extern int read_in_full(int fd, void *buf, size_t count);
 
 #ifdef NO_SETENV
 #define setenv gitsetenv
-- 
1.5.4.1.126.ge5a7d
