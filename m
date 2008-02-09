From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] daemon: Set up PATH properly on startup.
Date: Sat,  9 Feb 2008 11:17:53 +0000
Organization: Straylight/Edgeware
Message-ID: <1202555873-8099-1-git-send-email-mdw@distorted.org.uk>
Cc: Mark Wooding <mdw@distorted.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 12:25:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNnpi-00084F-Qd
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 12:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbYBILYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 06:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757016AbYBILYh
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 06:24:37 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:44809 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752195AbYBILYg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 06:24:36 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Feb 2008 06:24:35 EST
Received: (qmail 8122 invoked by uid 1000); 9 Feb 2008 11:17:53 -0000
X-Mailer: git-send-email 1.5.4.rc5.5.gab98-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73212>

Since exec_cmd.c changed (511707d42b3b3e57d9623493092590546ffeae80) to
just use the PATH variable for finding Git binaries, the daemon has been
broken for people with picky inetds (such as the OpenBSD one) which
launder the environment on startup.  The result is that the daemon
mysteriously fails to do anything useful.

One line fix: call setup_paths() in main before doing anything.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---
 daemon.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

	I've not addressed the other problem with git-daemon which this
	bug brought to my attention, which is that it doesn't log any
	kind of error if it fails to exec.

diff --git a/daemon.c b/daemon.c
index 41a60af..cfd6124 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1149,6 +1149,7 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}
 
+	setup_path(NULL);
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
 
-- 
1.5.4.rc5.5.gab98-dirty
