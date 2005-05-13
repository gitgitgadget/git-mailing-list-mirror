From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Fri, 13 May 2005 15:59:31 -0700
Message-ID: <7vhdh691gs.fsf@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<20050513224529.GF32232@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 01:14:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWjM2-0006ZE-UT
	for gcvg-git@gmane.org; Sat, 14 May 2005 01:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVEMXNI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 19:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVEMXMl
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 19:12:41 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:51190 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262611AbVEMW7d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 18:59:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050513225932.FKML26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 May 2005 18:59:32 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513224529.GF32232@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 14 May 2005 00:45:29 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

PB> Sorry for replying after so much time, it looks like I missed this and
PB> got here only after checking what change removed the mode: bits...

PB> What do you think?

FYI, here is a demonsrtation of what you have right now.
Temporarily slurp in the test framework patch you hate so much
to get t/test-lib.sh ;-), apply this to get t/t2000-diff.sh, cd
to t and say sh ./t2000-diff.sh

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
jit-diff 1: t/t2000-diff.sh
# - HEAD: Fix git-diff-files for symlinks.
# + (working tree)
Created: t/t2000-diff.sh (mode:100755)
--- /dev/null
+++ b/t/t2000-diff.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Test built-in diff output engine.
+
+'
+. ./test-lib.sh
+
+echo >path0 'Line 1
+Line 2
+line 3'
+cat path0 >path1
+chmod +x path1
+git-update-cache --add path0 path1
+mv path0 path0-
+sed -e 's/line/Line/' <path0- >path0
+chmod +x path0
+rm -f path1
+git-diff-files -p >current
+cat >expected <<\EOF
+Mode changed: path0 (100644->100755)
+--- a/path0
++++ b/path0
+@@ -1,3 +1,3 @@
+ Line 1
+ Line 2
+-line 3
++Line 3
+Deleted: path1
+--- a/path1
++++ /dev/null
+@@ -1,3 +0,0 @@
+-Line 1
+-Line 2
+-line 3
+EOF
+
+test_expect_success 'cmp -s current expected'
+test_done


