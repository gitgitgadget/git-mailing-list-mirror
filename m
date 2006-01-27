From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Treat "stg --help cmd" and "stg help cmd" like "stg cmd
	--help"
Date: Fri, 27 Jan 2006 00:17:28 -0500
Message-ID: <1138339048.1801.3.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 27 06:17:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2LzR-0000Oc-OD
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 06:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWA0FRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jan 2006 00:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWA0FRe
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jan 2006 00:17:34 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:32431 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932418AbWA0FRe
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2006 00:17:34 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F2Lyu-0002c9-CR
	for git@vger.kernel.org; Fri, 27 Jan 2006 00:17:08 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F2LzE-0000ak-MF; Fri, 27 Jan 2006 00:17:28 -0500
To: git <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15176>

User's intention is perfectly clear if "-h", "--help" or "help" is
followed by a valid command - show help for that command.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/main.py |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/stgit/main.py b/stgit/main.py
index 2336a43..6d86ee4 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -125,8 +125,12 @@ def main():
     cmd = sys.argv[1]
 
     if cmd in ['-h', '--help', 'help']:
-        print_help()
-        sys.exit(0)
+        if len(sys.argv) == 3 and sys.argv[2] in commands:
+            cmd = sys.argv[2]
+            sys.argv[2] = '--help';
+        else:
+            print_help()
+            sys.exit(0)
     if cmd in ['-v', '--version', 'version']:
         print 'Stacked GIT %s' % version
         os.system('git --version')



-- 
Regards,
Pavel Roskin
