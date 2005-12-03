From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 4/4] New test case: Criss-cross merge
Date: Sat, 3 Dec 2005 11:41:54 +0100
Message-ID: <20051203104154.GE4896@c165.ib.student.liu.se>
References: <20051203103255.GA4896@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 11:43:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiUq5-0004V3-Oy
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 11:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVLCKlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 05:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVLCKlz
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 05:41:55 -0500
Received: from [85.8.31.11] ([85.8.31.11]:53437 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751232AbVLCKly (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 05:41:54 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id B81E04116; Sat,  3 Dec 2005 11:51:44 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EiUq2-0000Kr-00; Sat, 03 Dec 2005 11:41:54 +0100
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20051203103255.GA4896@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13153>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 t/t6021-merge-criss-cross.sh |   92 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100755 t/t6021-merge-criss-cross.sh

0813848ea43ec76a07fd5bf57dfa68332513d930
diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.sh
new file mode 100755
index 0000000..e8606c7
--- /dev/null
+++ b/t/t6021-merge-criss-cross.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Fredrik Kuivinen
+#
+
+# See http://marc.theaimsgroup.com/?l=git&m=111463358500362&w=2 for a
+# nice decription of what this is about.
+
+
+test_description='Test criss-cross merge'
+. ./test-lib.sh
+
+test_expect_success 'prepare repository' \
+'echo "1
+2
+3
+4
+5
+6
+7
+8
+9" > file &&
+git add file && 
+git commit -m "Initial commit" file &&
+git branch A &&
+git branch B &&
+git checkout A &&
+echo "1
+2
+3
+4
+5
+6
+7
+8 changed in B8, branch A
+9" > file &&
+git commit -m "B8" file &&
+git checkout B &&
+echo "1
+2
+3 changed in C3, branch B
+4
+5
+6
+7
+8
+9
+" > file &&
+git commit -m "C3" file &&
+git branch C3 &&
+git merge "pre E3 merge" B A &&
+echo "1
+2
+3 changed in E3, branch B. New file size
+4
+5
+6
+7
+8 changed in B8, branch A
+9
+" > file &&
+git commit -m "E3" file &&
+git checkout A &&
+git merge "pre D8 merge" A C3 &&
+echo "1
+2
+3 changed in C3, branch B
+4
+5
+6
+7
+8 changed in D8, branch A. New file size 2
+9" > file &&
+git commit -m D8 file'
+
+test_expect_success 'Criss-cross merge' 'git merge "final merge" A B'
+
+cat > file-expect <<EOF
+1
+2
+3 changed in E3, branch B. New file size
+4
+5
+6
+7
+8 changed in D8, branch A. New file size 2
+9
+EOF
+
+test_expect_success 'Criss-cross merge result' 'cmp file file-expect'
+
+test_done
-- 
0.99.9.GIT
