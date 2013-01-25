From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/2] git-p4.py: support Python 2.5
Date: Fri, 25 Jan 2013 12:44:00 -0800
Message-ID: <1359146641-27810-2-git-send-email-drafnel@gmail.com>
References: <1359146641-27810-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <pw@padd.com>, <esr@thyrsus.com>, <john@keeping.me.uk>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:44:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyq8g-0006Cl-Nt
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 21:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab3AYUoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 15:44:20 -0500
Received: from hqemgate04.nvidia.com ([216.228.121.35]:3862 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab3AYUoT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 15:44:19 -0500
Received: from hqnvupgp05.nvidia.com (Not Verified[216.228.121.13]) by hqemgate04.nvidia.com
	id <B5102ee910000>; Fri, 25 Jan 2013 12:44:01 -0800
Received: from hqemhub01.nvidia.com ([172.17.108.22])
  by hqnvupgp05.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2013 12:44:14 -0800
X-PGP-Universal: processed;
	by hqnvupgp05.nvidia.com on Fri, 25 Jan 2013 12:44:14 -0800
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.297.1; Fri, 25 Jan 2013
 12:44:14 -0800
X-Mailer: git-send-email 1.8.1.1.297.gad3d74e
In-Reply-To: <1359146641-27810-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214578>

Python 2.5 and older do not accept None as the first argument to
translate() and complain with:

   TypeError: expected a character buffer object

Satisfy this older python by calling maketrans() to generate an empty
translation table and supplying that to translate().

This allows git-p4 to be used with Python 2.5.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 INSTALL   | 2 +-
 git-p4.py | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 28f34bd..fc723b3 100644
--- a/INSTALL
+++ b/INSTALL
@@ -131,7 +131,7 @@ Issues of note:
 	  use English. Under autoconf the configure script will do this
 	  automatically if it can't find libintl on the system.
 
-	- Python version 2.6 or later is needed to use the git-p4
+	- Python version 2.5 or later is needed to use the git-p4
 	  interface to Perforce.
 
  - Some platform specific issues are dealt with Makefile rules,
diff --git a/git-p4.py b/git-p4.py
index 2da5649..4f95d7a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -768,7 +768,8 @@ def wildcard_encode(path):
     return path
 
 def wildcard_present(path):
-    return path.translate(None, "*#@%") != path
+    from string import maketrans
+    return path.translate(maketrans("",""), "*#@%") != path
 
 class Command:
     def __init__(self):
-- 
1.8.1.1.297.gad3d74e


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
