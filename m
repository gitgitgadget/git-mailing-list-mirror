From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/5] Let parse_patch take a string instead of a file
	parameter
Date: Fri, 14 Dec 2007 07:25:15 +0100
Message-ID: <20071214062515.29148.4402.stgit@yoghurt>
References: <20071214062251.29148.86191.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:25:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33zb-0001zI-S5
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbXLNGZX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbXLNGZX
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:25:23 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3011 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbXLNGZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:25:21 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J33z0-0002ig-00; Fri, 14 Dec 2007 06:25:14 +0000
In-Reply-To: <20071214062251.29148.86191.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68239>

This makes it more generally useful, since all future callers may not
have the input in a file.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/common.py |    6 +++---
 stgit/commands/edit.py   |    3 ++-
 stgit/commands/imprt.py  |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)


diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 3840387..7cf700e 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -482,11 +482,11 @@ def parse_mail(msg):
=20
     return (descr, authname, authemail, authdate, diff)
=20
-def parse_patch(fobj):
-    """Parse the input file and return (description, authname,
+def parse_patch(text):
+    """Parse the input text and return (description, authname,
     authemail, authdate, diff)
     """
-    descr, diff =3D __split_descr_diff(fobj.read())
+    descr, diff =3D __split_descr_diff(text)
     descr, authname, authemail, authdate =3D __parse_description(descr=
)
=20
     # we don't yet have an agreed place for the creation date.
diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index 4d1475f..65b54d9 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -100,7 +100,8 @@ def __update_patch(pname, fname, options):
         f =3D sys.stdin
     else:
         f =3D open(fname)
-    message, author_name, author_email, author_date, diff =3D parse_pa=
tch(f)
+    (message, author_name, author_email, author_date, diff
+     ) =3D parse_patch(f.read())
     f.close()
=20
     out.start('Updating patch "%s"' % pname)
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 1c21a74..4a4b792 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -192,7 +192,7 @@ def __import_file(filename, options, patch =3D None=
):
                  parse_mail(msg)
     else:
         message, author_name, author_email, author_date, diff =3D \
-                 parse_patch(f)
+                 parse_patch(f.read())
=20
     if filename:
         f.close()
