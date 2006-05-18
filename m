From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 2/2] Tests for branch names with slashes
Date: Thu, 18 May 2006 08:43:21 +0200
Message-ID: <20060518064321.GA10400@backpacker.hemma.treskal.com>
References: <20060516074504.GA27234@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 18 08:43:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgcEH-0003Vi-NO
	for gcvg-git@gmane.org; Thu, 18 May 2006 08:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWERGnX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 18 May 2006 02:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWERGnX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 02:43:23 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:20982 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751252AbWERGnW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 02:43:22 -0400
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060518064321.QBBF19930.mxfep01.bredband.com@backpacker.hemma.treskal.com>;
          Thu, 18 May 2006 08:43:21 +0200
Received: by backpacker.hemma.treskal.com (Postfix, from userid 1000)
	id 31AA5259B; Thu, 18 May 2006 08:43:21 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060516074504.GA27234@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20265>

Test a number of operations on a repository that has branch names
containing slashes (that is, branches living in a subdirectory of
=2Egit/refs/heads).

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>


---

 t/t0001-subdir-branches.sh |   59 ++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 t/t0001-subdir-branches.sh

d54c84917b40b1e8b05081f0c063fd99b2bbb1ad
diff --git a/t/t0001-subdir-branches.sh b/t/t0001-subdir-branches.sh
new file mode 100644
index 0000000..ddde238
--- /dev/null
+++ b/t/t0001-subdir-branches.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Karl Hasselstr=F6m
+#
+
+test_description=3D'Branch names containing slashes
+
+Test a number of operations on a repository that has branch names
+containing slashes (that is, branches living in a subdirectory of
+.git/refs/heads).'
+
+. ./test-lib.sh
+
+test_expect_success 'Create a patch' \
+  'stg init &&
+   echo "foo" > foo.txt &&
+   stg add foo.txt &&
+   stg new foo -m "Add foo.txt" &&
+   stg refresh'
+
+test_expect_success 'Old and new id with non-slashy branch' \
+  'stg id foo &&
+   stg id foo// &&
+   stg id foo/ &&
+   stg id foo//top &&
+   stg id foo/top &&
+   stg id foo@master &&
+   stg id foo@master//top &&
+   stg id foo@master/top'
+
+test_expect_success 'Clone branch to slashier name' \
+  'stg branch --clone x/y/z'
+
+test_expect_success 'Try new form of id with slashy branch' \
+  'stg id foo &&
+   stg id foo// &&
+   stg id foo//top &&
+   stg id foo@x/y/z &&
+   stg id foo@x/y/z//top'
+
+test_expect_failure 'Try old id with slashy branch' \
+  'stg id foo/ ||
+   stg id foo/top ||
+   stg id foo@x/y/z/top'
+
+test_expect_success 'Create patch in slashy branch' \
+  'echo "bar" >> foo.txt &&
+   stg new bar -m "Add another line" &&
+   stg refresh'
+
+test_expect_success 'Rename branches' \
+  'stg branch --rename master goo/gaa &&
+   test ! -e .git/refs/heads/master &&
+   stg branch --rename goo/gaa x1/x2/x3/x4 &&
+   test ! -e .git/refs/heads/goo &&
+   stg branch --rename x1/x2/x3/x4 servant &&
+   test ! -e .git/refs/heads/x1'
+
+test_done
--=20
1.3.2.g639c


--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
