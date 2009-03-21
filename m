From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 01/16] test-lib: Work around incompatible sort and find on Windows
Date: Sat, 21 Mar 2009 22:26:24 +0100
Message-ID: <f17e9fbbe919bc1f4ecaa35a9cb0869a5ec47fc0.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8kG-0003u8-VC
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbZCUV1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbZCUV1F
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:05 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27932 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BB68510015;
	Sat, 21 Mar 2009 22:26:54 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8FDF140009;
	Sat, 21 Mar 2009 22:26:54 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114059>

If the PATH lists the Windows system directories before the MSYS
directories, Windows's own incompatible sort and find commands would be
picked up. We implement these commands as functions and call the real
tools by absolute path.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  BTW, we have the same thing in git-sh-setup.sh

 t/test-lib.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 638cca4..4eda5ab 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -635,3 +635,16 @@ do
 		test_done
 	esac
 done
+
+# Fix some commands on Windows
+case $(uname -s) in
+*MINGW*)
+	# Windows has its own (incompatible) sort and find
+	sort () {
+		/usr/bin/sort "$@"
+	}
+	find () {
+		/usr/bin/find "$@"
+	}
+	;;
+esac
-- 
1.6.2.1.224.g2225f
