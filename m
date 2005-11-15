From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Small script to patch .spec for Suse
Date: Tue, 15 Nov 2005 12:30:29 +0100
Message-ID: <200511151230.30030.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 12:32:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebz1b-00030B-PY
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 12:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVKOLaf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 06:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVKOLaf
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 06:30:35 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:59815 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932370AbVKOLae (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 06:30:34 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 60AC2228F;
	Tue, 15 Nov 2005 12:30:31 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11897>

Everytime I update and want to generate RPM packages for
my Suse distribution, I have to patch the git-core.spec.in
Here is the current script for patching. It is only about
package names, so a seperate .spec file would
be overkill and a maintenance problem for me.

Usage: Run contrib/patch-spec-for-suse before "make rpm"

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---
This is handy for Suse users which want to install Git by creating
there own RPM from source. It works for me (on Suse 10.0).
I hope it works for other versions, too.
Perhaps somebody has a better idea how to come up with
corrected .spec files for different distros.

 contrib/patch-spec-for-suse |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100755 contrib/patch-spec-for-suse

applies-to: 4b6dbe856a3e63699b299c76f4f1fc5cb34cbe26
3e0d98b8065c7a23c6b9a16811bb7b066b13bffc
diff --git a/contrib/patch-spec-for-suse b/contrib/patch-spec-for-suse
new file mode 100755
index 0000000..5b9795c
--- /dev/null
+++ b/contrib/patch-spec-for-suse
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+# The git-core.spec for RPM creation in the git source works
+# fine for fedora core, but not other distributions.
+# This script patches some distribution dependent package names
+# to make it work for Suse (at least 10.0)
+#
+# Run it from gits main directory like
+#  contrib/patch-for-suse
+# Note! This changes git-core.spec.in. So if you do git development
+# yourself, do *not* commit the changed file, or revert before with
+#  mv git-core.spec.in.orig git-core.spec.in
+#
+
+[ ! -f git-core.spec.in ] && echo "git-core.spec.in not found!" && exit 1
+cp git-core.spec.in git-core.spec.in.orig
+
+# Updates for Suse:
+#  - no seperate "openssh-clients"
+#  - "expat" contains devel files
+
+cat git-core.spec.in \
+ | sed -e 's/openssh-clients/openssh/' \
+ | sed -e 's/expat-devel/expat/' \
+ > git-core.spec.temp
+
+mv git-core.spec.temp git-core.spec.in
+echo "git-core.spec.in sucessfully patched."
+
---
0.99.9.GIT
