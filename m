From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/1] git-am: provide configuration to enable signoff by default
Date: Wed, 1 Jun 2011 14:12:31 +0530
Message-ID: <1306917751-27999-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Sekhar Nori <nsekhar@ti.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 10:43:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRh12-00052Q-7a
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 10:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162739Ab1FAImv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 04:42:51 -0400
Received: from comal.ext.ti.com ([198.47.26.152]:49849 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161961Ab1FAImj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 04:42:39 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p518gZMf002569
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Jun 2011 03:42:37 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p518gXNg027664;
	Wed, 1 Jun 2011 14:12:33 +0530 (IST)
Received: from dbdp31.itg.ti.com (172.24.170.98) by DBDE70.ent.ti.com
 (172.24.170.148) with Microsoft SMTP Server id 8.3.106.1; Wed, 1 Jun 2011
 14:12:33 +0530
Received: from psplinux051.india.ti.com (psplinux051.india.ti.com
 [172.24.162.244])	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id
 p518gVsj022682;	Wed, 1 Jun 2011 14:12:32 +0530 (IST)
Received: from psplinux051.india.ti.com (localhost [127.0.0.1])	by
 psplinux051.india.ti.com (8.13.1/8.13.1) with ESMTP id p518gVX0028035;	Wed, 1
 Jun 2011 14:12:31 +0530
Received: (from a0875516@localhost)	by psplinux051.india.ti.com
 (8.13.1/8.13.1/Submit) id p518gVAM028032;	Wed, 1 Jun 2011 14:12:31 +0530
X-Mailer: git-send-email 1.6.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174854>

Provide a git config option to enable --signoff a
default when using git-am. This should be handy
for maintainers who regularly apply patches from
mailing lists to send them upstream and want to
be on the sign-off path.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/config.txt |    7 +++++++
 Documentation/git-am.txt |    3 ++-
 git-am.sh                |    5 +++++
 3 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6b93777..5da7ca8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -597,6 +597,13 @@ am.keepcr::
 	by giving '--no-keep-cr' from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
 
+am.signoff::
+	A boolean value which lets you enable the `-s/--signoff` option of
+	am by default. *Note:* Adding the Signed-off-by: line to a patch
+	should be a conscious act and means that you certify you have
+	the rights to submit this work under the same open source license.
+	Please see the 'SubmittingPatches' document for further discussion.
+
 apply.ignorewhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
 	whitespace, in the same way as the '--ignore-space-change'
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 6b1b5af..6b2c51a 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -33,7 +33,8 @@ OPTIONS
 -s::
 --signoff::
 	Add a `Signed-off-by:` line to the commit message, using
-	the committer identity of yourself.
+	the committer identity of yourself. `am.signoff` configuration
+	variable can be used to make this the defaut.
 
 -k::
 --keep::
diff --git a/git-am.sh b/git-am.sh
index 6cdd591..8e2a693 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -328,6 +328,11 @@ then
     keepcr=t
 fi
 
+if test "$(git config --bool --get am.signoff)" = true
+then
+    sign=t
+fi
+
 while test $# != 0
 do
 	case "$1" in
-- 
1.7.3.2
