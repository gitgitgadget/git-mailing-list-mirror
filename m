From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/5] Treat filename '-' as stdin/stdout in edit
Date: Fri, 14 Dec 2007 07:25:09 +0100
Message-ID: <20071214062509.29148.23933.stgit@yoghurt>
References: <20071214062251.29148.86191.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33za-0001zI-GX
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbXLNGZP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXLNGZP
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:25:15 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3006 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbXLNGZN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:25:13 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J33yu-0002iT-00; Fri, 14 Dec 2007 06:25:08 +0000
In-Reply-To: <20071214062251.29148.86191.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68237>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/edit.py |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)


diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index ec2c4ae..4d1475f 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -96,7 +96,10 @@ def __update_patch(pname, fname, options):
     bottom =3D patch.get_bottom()
     top =3D patch.get_top()
=20
-    f =3D open(fname)
+    if fname =3D=3D '-':
+        f =3D sys.stdin
+    else:
+        f =3D open(fname)
     message, author_name, author_email, author_date, diff =3D parse_pa=
tch(f)
     f.close()
=20
@@ -171,9 +174,12 @@ def __generate_file(pname, fname, options):
     text =3D tmpl % tmpl_dict
=20
     # write the file to be edited
-    f =3D open(fname, 'w+')
-    f.write(text)
-    f.close()
+    if fname =3D=3D '-':
+        sys.stdout.write(text)
+    else:
+        f =3D open(fname, 'w+')
+        f.write(text)
+        f.close()
=20
 def __edit_update_patch(pname, options):
     """Edit the given patch interactively.
