From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 1/2] git-p4.py: support Python 2.5
Date: Sat, 26 Jan 2013 11:14:32 -0800
Message-ID: <1359227673-5673-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <pw@padd.com>, <git@vger.kernel.org>, <esr@thyrsus.com>,
	<john@keeping.me.uk>, Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 20:15:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzBDb-000824-A8
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 20:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737Ab3AZTOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 14:14:46 -0500
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8868 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab3AZTOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 14:14:44 -0500
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B51042c200000>; Sat, 26 Jan 2013 11:18:56 -0800
Received: from hqemhub01.nvidia.com ([172.17.108.22])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Sat, 26 Jan 2013 11:14:19 -0800
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Sat, 26 Jan 2013 11:14:19 -0800
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.297.1; Sat, 26 Jan 2013
 11:14:35 -0800
X-Mailer: git-send-email 1.8.1.1.442.g413e803
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214633>

From: Brandon Casey <drafnel@gmail.com>

Python 2.5 and older do not accept None as the first argument to
translate() and complain with:

   TypeError: expected a character buffer object

As suggested by Pete Wyckoff, let's just replace the call to translate()
with a regex search which should be more clear and more portable.

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
index 2da5649..de1a0b9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -768,7 +768,8 @@ def wildcard_encode(path):
     return path
 
 def wildcard_present(path):
-    return path.translate(None, "*#@%") != path
+    m = re.search("[*#@%]", path)
+    return m is not None
 
 class Command:
     def __init__(self):
-- 
1.8.1.1.442.g413e803


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
