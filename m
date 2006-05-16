From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 2/2] Tests for branch names with slashes
Date: Tue, 16 May 2006 08:37:16 +0200
Message-ID: <20060516063716.GA11230@backpacker.hemma.treskal.com>
References: <20060515105810.GA27077@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wartan Hachaturow <wartan.hachaturow@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 08:37:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FftBL-0007SO-AM
	for gcvg-git@gmane.org; Tue, 16 May 2006 08:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWEPGhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 May 2006 02:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWEPGhU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 02:37:20 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:21654 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751530AbWEPGhT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 02:37:19 -0400
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060516063717.OPHY19930.mxfep01.bredband.com@backpacker.hemma.treskal.com>;
          Tue, 16 May 2006 08:37:17 +0200
Received: by backpacker.hemma.treskal.com (Postfix, from userid 1000)
	id 9CB3F2527; Tue, 16 May 2006 08:37:16 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060515105810.GA27077@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20105>

Test a number of operations on a repository that has branch names
containing slashes (that is, branches living in a subdirectory of
=2Egit/refs/heads).

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>


---

The test also had to be changed to use % instead of #.

 t/t0001-subdir-branches.sh |   59 ++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 t/t0001-subdir-branches.sh

2278d3988ae3fee7624aac6db6bd92677173749f
diff --git a/t/t0001-subdir-branches.sh b/t/t0001-subdir-branches.sh
new file mode 100644
index 0000000..64f583c
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
+   stg id foo% &&
+   stg id foo/ &&
+   stg id foo%top &&
+   stg id foo/top &&
+   stg id foo@master &&
+   stg id foo@master%top &&
+   stg id foo@master/top'
+
+test_expect_success 'Clone branch to slashier name' \
+  'stg branch --clone x/y/z'
+
+test_expect_success 'Try new form of id with slashy branch' \
+  'stg id foo &&
+   stg id foo% &&
+   stg id foo%top &&
+   stg id foo@x/y/z &&
+   stg id foo@x/y/z%top'
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
