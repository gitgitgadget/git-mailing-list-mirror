From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Handle commandline parsing errors gracefully
Date: Sun, 20 Apr 2008 15:19:12 +0200
Message-ID: <20080420131847.8824.87769.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 15:20:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnZSo-0004DQ-2R
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 15:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbYDTNT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 09:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbYDTNT1
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 09:19:27 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2092 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbYDTNT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 09:19:26 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JnZRt-0006k2-00; Sun, 20 Apr 2008 14:19:17 +0100
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79956>

The commandline option parser raises SystemExit after having explained
to the user what she did wrong. A recent refactoring introduced a
catch-all "except:" at the top level, which caught the SystemExit and
printed a traceback.

Let's just simply exit instead, like we used to.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

This goes on the "master" branch.

 stgit/main.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/stgit/main.py b/stgit/main.py
index 663fdec..aa1f8ef 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -281,6 +281,10 @@ def main():
         if debug_level > 0:
             traceback.print_exc()
         sys.exit(utils.STGIT_COMMAND_ERROR)
+    except SystemExit:
+        # Triggered by the option parser when it finds bad commandline
+        # parameters.
+        sys.exit(utils.STGIT_COMMAND_ERROR)
     except KeyboardInterrupt:
         sys.exit(utils.STGIT_GENERAL_ERROR)
     except:
