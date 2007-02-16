From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Create documentation for git-bundle.
Date: Thu, 15 Feb 2007 19:19:55 -0500
Message-ID: <11715851973628-git-send-email-mdl123@verizon.net>
References: <11715851974102-git-send-email-mdl123@verizon.net>
 <11715851972838-git-send-email-mdl123@verizon.net>
 <11715851973802-git-send-email-mdl123@verizon.net>
 <11715851973121-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 01:20:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHqpn-0000rW-Sz
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 01:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422840AbXBPAUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 19:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422845AbXBPAUP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 19:20:15 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:55137 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422840AbXBPAUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 19:20:12 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms042.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDJ00AYQ4XAEFS6@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 15 Feb 2007 18:20:00 -0600 (CST)
In-reply-to: <11715851973121-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.0.rc4.375.gd0938-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39871>

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 Documentation/git-bundle.txt |   87 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-bundle.txt

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
new file mode 100644
index 0000000..aed413f
--- /dev/null
+++ b/Documentation/git-bundle.txt
@@ -0,0 +1,87 @@
+git-bundle(1)
+=============
+
+NAME
+----
+git-bundle - Package objects and refs for a disconnected repository
+
+
+SYNOPSIS
+--------
+'git-bundle' [--output=file] <git-rev-list args>
+
+DESCRIPTION
+-----------
+
+Some workflows require that one or more branches of development on
+one machine be replicated on another machine, but the two machines
+cannot be directly connected so the git-fetch protocol cannot be used.
+This command creates a bundle file containing objects and references
+that can be used to update another repository (using
+gitlink:git-unbundle[1]) without phsyically connecting the two.  As no
+direct connection exists, the user must specify a basis for the bundle
+that is held by the destination repository: the bundle assumes that
+all objects in the basis are already in the destination repository.
+
+OPTIONS
+-------
+
+--output=file::
+	Specifies the name of the bundle file. Default is
+        "bundle.tar" in the current directory.
+
+<git-rev-list args>::
+
+        A list of arguments, accepatble to git-rev-parse and
+        git-rev-list, that specify the specific objects and
+        references to transport. For example,  "master~10..master"
+        causes the current master reference to be packaged along with
+        all objects added since its 10th ancestor commit. There is no
+        explicit limit to the number of references and objects that
+        may be packaged.
+
+
+SPECIFYING REFERENCES
+---------------------
+
+git-bundle will only package references that are shown by
+git-show-ref: this includes heads, tags, and remote heads.  References
+such as master~1 cannot be packaged, but are perfectly suitable for
+defining the basis.  More than one reference may be packaged, and more
+than one basis can be specified.  The objects packaged are those not
+contained in the union of the given bases.  Each basis can be
+specified explicitly (e.g., ^master~10), or implicitly (e.g.,
+master~10..master, master --since=10.days.ago).
+
+It is very important that the basis used be held by the destination.
+It is ok to err on the side of conservatism, causing the bundle file
+to contain objects already in the destination as these are ignored
+when unpacking at the destination.
+
+EXAMPLE
+-------
+
+Assume two repositories exist as R1 on machine A, and R2 on machine B.
+For whatever reason, direct connection between A and B is not allowed,
+but we can move data from A to B via some mechanism (CD, email, etc).
+We want to update R2 with developments made on branch master in R1.
+We set a tag in R1 (lastR2bundle) after the previous such transport,
+and move it afterwards to help build the bundle.
+
+in R1 on A:
+git-bundle master ^lastR2bundle
+git tag -f lastR2bundle master
+
+(move bundle.tar from A to B by some mechanism)
+
+in R2 on B:
+git-unbundle bundle.tar (3)
+
+
+Author
+------
+Written by Mark Levedahl <mdl123@verizon.net>
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.0.34.g6afaa
