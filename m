From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 1/3] daemon: Provide missing argument for logerror() call.
Date: Fri, 03 Feb 2006 20:27:02 +0000
Message-ID: <20060203202702.1895.98868.stgit@metalzone.distorted.org.uk>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Fri Feb 03 21:27:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F57WU-0005RV-Vk
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 21:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWBCU1G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 15:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWBCU1F
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 15:27:05 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:8500 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751449AbWBCU1D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 15:27:03 -0500
Received: (qmail 2098 invoked from network); 3 Feb 2006 20:27:02 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?QYPA8VGOtXhvcvW8Dg+NaCGGT330wa8t?@127.0.0.1)
  by localhost with SMTP; 3 Feb 2006 20:27:02 -0000
To: git@vger.kernel.org
In-Reply-To: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15549>

From: Mark Wooding <mdw@distorted.org.uk>

Could cause a crash if --base-path set.  Unlikely to be a security the
concern: message doesn't go to the client, so we can't leak anything
(except by dumping core), and we've already forked, so it's not a denial
of service.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 daemon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index bb014fa..532bb0c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -147,7 +147,7 @@ static char *path_ok(char *dir)
 		static char rpath[PATH_MAX];
 		if (*dir != '/') {
 			/* Forbid possible base-path evasion using ~paths. */
-			logerror("'%s': Non-absolute path denied (base-path active)");
+			logerror("'%s': Non-absolute path denied (base-path active)", dir);
 			return NULL;
 		}
 		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
