X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/2] Regression test for "stg import"
Date: Sun, 12 Nov 2006 22:15:51 +0100
Message-ID: <20061112211551.19362.91978.stgit@localhost>
References: <20061112211434.19362.66077.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 12 Nov 2006 21:16:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061112211434.19362.66077.stgit@localhost>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31278>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjMgX-0007iS-0z for gcvg-git@gmane.org; Sun, 12 Nov
 2006 22:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753194AbWKLVQE convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006 16:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbWKLVQE
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 16:16:04 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:64169 "EHLO
 mxfep01.bredband.com") by vger.kernel.org with ESMTP id S1753194AbWKLVQB
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 16:16:01 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82]) by
 mxfep01.bredband.com with ESMTP id
 <20061112211559.GPZQ9747.mxfep01.bredband.com@ironport.bredband.com> for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 22:15:59 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport.bredband.com with
 ESMTP; 12 Nov 2006 22:15:52 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id DD53A4CC24; Sun, 12 Nov
 2006 22:15:51 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>



Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t1800-import.sh         |   85 +++++++++++++++++++++++++++++++++++++=
+
 t/t1800-import/email-8bit |   37 ++++++++++++++++
 t/t1800-import/email-mbox |  102 +++++++++++++++++++++++++++++++++++++=
++++++++
 t/t1800-import/email-qp   |   37 ++++++++++++++++
 t/t1800-import/git-diff   |   20 +++++++++
 t/t1800-import/gnu-diff   |   19 ++++++++
 t/t1800-import/stg-export |   26 +++++++++++
 7 files changed, 326 insertions(+), 0 deletions(-)

diff --git a/t/t1800-import.sh b/t/t1800-import.sh
new file mode 100755
index 0000000..0c1baa3
--- /dev/null
+++ b/t/t1800-import.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+# Copyright (c) 2006 Karl Hasselstr=C3=B6m
+test_description=3D'Test the import command'
+. ./test-lib.sh
+
+test_expect_success \
+    'Initialize the StGIT repository' \
+    '
+    for x in {do,di,da}{be,bi,bo}{dam,dim,dum}; do
+      echo $x
+    done > foo.txt &&
+    git add foo.txt &&
+    git commit -a -m "initial version" &&
+    stg init
+    '
+
+test_expect_success \
+    'Apply a patch created with "git diff"' \
+    '
+    stg import ../t1800-import/git-diff &&
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") =3D=
=3D 1 ] &&
+    stg delete ..
+    '
+
+test_expect_success \
+    'Apply a patch created with GNU diff' \
+    '
+    stg import ../t1800-import/gnu-diff &&
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") =3D=
=3D 1 ] &&
+    stg delete ..
+    '
+
+test_expect_success \
+    'Apply a patch created with "stg export"' \
+    '
+    stg import ../t1800-import/stg-export &&
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") =3D=
=3D 1 ] &&
+    stg delete ..
+    '
+
+test_expect_success \
+    'Apply a patch from an 8bit-encoded e-mail' \
+    '
+    stg import -m ../t1800-import/email-8bit &&
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "tree 030be42660323ff2a1958f9ee79589a4f3fbee2f") =3D=
=3D 1 ] &&
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D=3D 1 =
] &&
+    stg delete ..
+    '
+
+test_expect_success \
+    'Apply a patch from a QP-encoded e-mail' \
+    '
+    stg import -m ../t1800-import/email-qp &&
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "tree 030be42660323ff2a1958f9ee79589a4f3fbee2f") =3D=
=3D 1 ] &&
+    [ $(git cat-file -p $(stg id) \
+        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D=3D 1 =
] &&
+    stg delete ..
+    '
+
+test_expect_success \
+    'Apply several patches from an mbox file' \
+    '
+    stg import -M ../t1800-import/email-mbox &&
+    [ $(git cat-file -p $(stg id change-1) \
+        | grep -c "tree 401bef82cd9fb403aba18f480a63844416a2e023") =3D=
=3D 1 ] &&
+    [ $(git cat-file -p $(stg id change-1) \
+        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D=3D 1 =
] &&
+    [ $(git cat-file -p $(stg id change-2) \
+        | grep -c "tree e49dbce010ec7f441015a8c64bce0b99108af4cc") =3D=
=3D 1 ] &&
+    [ $(git cat-file -p $(stg id change-2) \
+        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D=3D 1 =
] &&
+    [ $(git cat-file -p $(stg id change-3) \
+        | grep -c "tree 166bbaf27a44aee21ba78c98822a741e6f7d78f5") =3D=
=3D 1 ] &&
+    [ $(git cat-file -p $(stg id change-3) \
+        | grep -c "author Inge Str=C3=B6m <inge@power.com>") =3D=3D 1 =
] &&
+    stg delete ..
+    '
+
+test_done
diff --git a/t/t1800-import/email-8bit b/t/t1800-import/email-8bit
new file mode 100644
index 0000000..316fe27
--- /dev/null
+++ b/t/t1800-import/email-8bit
@@ -0,0 +1,37 @@
+From: Inge =3D?utf-8?q?Str=3DC3=3DB6m?=3D <inge@power.com>
+Subject: [PATCH] test patch
+To: Upstream <foo@bar.baz>
+Date: Sat, 11 Nov 2006 11:58:14 +0100
+Message-ID: <20061111105814.23209.46952.stgit@localhost>
+User-Agent: StGIT/0.11
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3D"utf-8"
+Content-Transfer-Encoding: 8bit
+
+Signed-off-by: Inge Str=C3=B6m <inge@power.com>
+---
+
+ foo.txt |    2 ++
+ 1 files changed, 2 insertions(+), 0 deletions(-)
+
+diff --git a/foo.txt b/foo.txt
+index ad01662..d3cd5b6 100644
+--- a/foo.txt
++++ b/foo.txt
+@@ -3,6 +3,7 @@ dobedim
+ dobedum
+ dobidam
+ dobidim
++pum-p=C3=B6ddelip=C3=A5m
+ dobidum
+ dobodam
+ dobodim
+@@ -20,6 +21,7 @@ dabedam
+ dabedim
+ dabedum
+ dabidam
++pum-d=C3=A4ddelidum
+ dabidim
+ dabidum
+ dabodam
+
diff --git a/t/t1800-import/email-mbox b/t/t1800-import/email-mbox
new file mode 100644
index 0000000..e4103e5
--- /dev/null
+++ b/t/t1800-import/email-mbox
@@ -0,0 +1,102 @@
+From nobody Sat Nov 11 12:45:27 2006
+From: Inge =3D?utf-8?q?Str=3DC3=3DB6m?=3D <inge@power.com>
+Subject: [PATCH 1/3] Change 1
+To: Upstream <foo@bar.baz>
+Date: Sat, 11 Nov 2006 12:45:27 +0100
+Message-ID: <20061111114527.31778.12942.stgit@localhost>
+User-Agent: StGIT/0.11
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3D"utf-8"
+Content-Transfer-Encoding: 8bit
+Status: RO
+Content-Length: 304
+Lines: 19
+
+Signed-off-by: Inge Str=C3=B6m <inge@power.com>
+---
+
+ foo.txt |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/foo.txt b/foo.txt
+index ad01662..91527b1 100644
+--- a/foo.txt
++++ b/foo.txt
+@@ -7,7 +7,7 @@ dobidum
+ dobodam
+ dobodim
+ dobodum
+-dibedam
++dibedad
+ dibedim
+ dibedum
+ dibidam
+
+From nobody Sat Nov 11 12:45:27 2006
+From: Inge =3D?utf-8?q?Str=3DC3=3DB6m?=3D <inge@power.com>
+Subject: [PATCH 2/3] Change 2
+To: Upstream <foo@bar.baz>
+Date: Sat, 11 Nov 2006 12:45:27 +0100
+Message-ID: <20061111114527.31778.92851.stgit@localhost>
+In-Reply-To: <20061111114527.31778.12942.stgit@localhost>
+References: <20061111114527.31778.12942.stgit@localhost>
+User-Agent: StGIT/0.11
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3D"utf-8"
+Content-Transfer-Encoding: 8bit
+Status: RO
+Content-Length: 296
+Lines: 18
+
+Signed-off-by: Inge Str=C3=B6m <inge@power.com>
+---
+
+ foo.txt |    1 +
+ 1 files changed, 1 insertions(+), 0 deletions(-)
+
+diff --git a/foo.txt b/foo.txt
+index 91527b1..79922d7 100644
+--- a/foo.txt
++++ b/foo.txt
+@@ -18,6 +18,7 @@ dibodim
+ dibodum
+ dabedam
+ dabedim
++dibedam
+ dabedum
+ dabidam
+ dabidim
+
+From nobody Sat Nov 11 12:45:27 2006
+From: Inge =3D?utf-8?q?Str=3DC3=3DB6m?=3D <inge@power.com>
+Subject: [PATCH 3/3] Change 3
+To: Upstream <foo@bar.baz>
+Date: Sat, 11 Nov 2006 12:45:27 +0100
+Message-ID: <20061111114527.31778.45876.stgit@localhost>
+In-Reply-To: <20061111114527.31778.12942.stgit@localhost>
+References: <20061111114527.31778.12942.stgit@localhost>
+User-Agent: StGIT/0.11
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3D"utf-8"
+Content-Transfer-Encoding: 8bit
+Status: RO
+Content-Length: 278
+Lines: 16
+
+Signed-off-by: Inge Str=C3=B6m <inge@power.com>
+---
+
+ foo.txt |    1 -
+ 1 files changed, 0 insertions(+), 1 deletions(-)
+
+diff --git a/foo.txt b/foo.txt
+index 79922d7..6f978b4 100644
+--- a/foo.txt
++++ b/foo.txt
+@@ -24,5 +24,4 @@ dabidam
+ dabidim
+ dabidum
+ dabodam
+-dabodim
+ dabodum
+
diff --git a/t/t1800-import/email-qp b/t/t1800-import/email-qp
new file mode 100644
index 0000000..1a77c57
--- /dev/null
+++ b/t/t1800-import/email-qp
@@ -0,0 +1,37 @@
+From: Inge =3D?utf-8?q?Str=3DC3=3DB6m?=3D <inge@power.com>
+Subject: [PATCH] test patch
+To: Upstream <foo@bar.baz>
+Date: Sat, 11 Nov 2006 11:58:14 +0100
+Message-ID: <20061111105814.23209.46952.stgit@localhost>
+User-Agent: StGIT/0.11
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3D"utf-8"
+Content-Transfer-Encoding: quoted-printable
+
+Signed-off-by: Inge Str=3DC3=3DB6m <inge@power.com>
+---
+
+ foo.txt |    2 ++
+ 1 files changed, 2 insertions(+), 0 deletions(-)
+
+diff --git a/foo.txt b/foo.txt
+index ad01662..d3cd5b6 100644
+--- a/foo.txt
++++ b/foo.txt
+@@ -3,6 +3,7 @@ dobedim
+ dobedum
+ dobidam
+ dobidim
++pum-p=3DC3=3DB6ddelip=3DC3=3DA5m
+ dobidum
+ dobodam
+ dobodim
+@@ -20,6 +21,7 @@ dabedam
+ dabedim
+ dabedum
+ dabidam
++pum-d=3DC3=3DA4ddelidum
+ dabidim
+ dabidum
+ dabodam
+
diff --git a/t/t1800-import/git-diff b/t/t1800-import/git-diff
new file mode 100644
index 0000000..642e11d
--- /dev/null
+++ b/t/t1800-import/git-diff
@@ -0,0 +1,20 @@
+diff --git a/foo.txt b/foo.txt
+index ad01662..d3cd5b6 100644
+--- a/foo.txt
++++ b/foo.txt
+@@ -3,6 +3,7 @@ dobedim
+ dobedum
+ dobidam
+ dobidim
++dabadadash
+ dobidum
+ dobodam
+ dobodim
+@@ -20,6 +21,7 @@ dabedam
+ dabedim
+ dabedum
+ dabidam
++dadadadash
+ dabidim
+ dabidum
+ dabodam
diff --git a/t/t1800-import/gnu-diff b/t/t1800-import/gnu-diff
new file mode 100644
index 0000000..46b338a
--- /dev/null
+++ b/t/t1800-import/gnu-diff
@@ -0,0 +1,19 @@
+diff -Naur old/foo.txt new/foo.txt
+--- old/foo.txt	2006-11-11 11:26:18.000000000 +0100
++++ new/foo.txt	2006-11-11 11:25:18.000000000 +0100
+@@ -3,6 +3,7 @@
+ dobedum
+ dobidam
+ dobidim
++dabadadash
+ dobidum
+ dobodam
+ dobodim
+@@ -20,6 +21,7 @@
+ dabedim
+ dabedum
+ dabidam
++dadadadash
+ dabidim
+ dabidum
+ dabodam
diff --git a/t/t1800-import/stg-export b/t/t1800-import/stg-export
new file mode 100644
index 0000000..ddcfc3e
--- /dev/null
+++ b/t/t1800-import/stg-export
@@ -0,0 +1,26 @@
+test patch
+---
+
+ foo.txt |    2 ++
+ 1 files changed, 2 insertions(+), 0 deletions(-)
+
+diff --git a/foo.txt b/foo.txt
+index ad01662..d3cd5b6 100644
+--- a/foo.txt
++++ b/foo.txt
+@@ -3,6 +3,7 @@ dobedim
+ dobedum
+ dobidam
+ dobidim
++dabadadash
+ dobidum
+ dobodam
+ dobodim
+@@ -20,6 +21,7 @@ dabedam
+ dabedim
+ dabedum
+ dabidam
++dadadadash
+ dabidim
+ dabidum
