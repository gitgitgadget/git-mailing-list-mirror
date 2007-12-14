From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/5] Added --save-template flag to edit command
Date: Fri, 14 Dec 2007 07:25:03 +0100
Message-ID: <20071214062503.29148.84674.stgit@yoghurt>
References: <20071214062251.29148.86191.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33zZ-0001zI-Rc
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbXLNGZL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbXLNGZL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:25:11 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3003 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbXLNGZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:25:09 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J33yo-0002h7-00; Fri, 14 Dec 2007 06:25:02 +0000
In-Reply-To: <20071214062251.29148.86191.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68236>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/edit.py |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)


diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index a4d8f96..ec2c4ae 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -72,6 +72,8 @@ options =3D [make_option('-d', '--diff',
                        help =3D 'annotate the patch log entry'),
            make_option('-m', '--message',
                        help =3D 'replace the patch description with ME=
SSAGE'),
+           make_option('--save-template', metavar =3D 'FILE',
+                       help =3D 'save the patch to FILE in the format =
used by -f'),
            make_option('--author', metavar =3D '"NAME <EMAIL>"',
                        help =3D 'replae the author details with "NAME =
<EMAIL>"'),
            make_option('--authname',
@@ -120,8 +122,8 @@ def __update_patch(pname, fname, options):
     else:
         out.done()
=20
-def __edit_update_patch(pname, options):
-    """Edit the given patch interactively.
+def __generate_file(pname, fname, options):
+    """Generate a file containing the description to edit
     """
     patch =3D crt_series.get_patch(pname)
=20
@@ -168,15 +170,20 @@ def __edit_update_patch(pname, options):
=20
     text =3D tmpl % tmpl_dict
=20
+    # write the file to be edited
+    f =3D open(fname, 'w+')
+    f.write(text)
+    f.close()
+
+def __edit_update_patch(pname, options):
+    """Edit the given patch interactively.
+    """
     if options.diff:
         fname =3D '.stgit-edit.diff'
     else:
         fname =3D '.stgit-edit.txt'
=20
-    # write the file to be edited
-    f =3D open(fname, 'w+')
-    f.write(text)
-    f.close()
+    __generate_file(pname, fname, options)
=20
     # invoke the editor
     call_editor(fname)
@@ -233,6 +240,8 @@ def func(parser, options, args):
                                  log =3D 'edit',
                                  notes =3D options.annotate)
         out.done()
+    elif options.save_template:
+        __generate_file(pname, options.save_template, options)
     elif options.file:
         __update_patch(pname, options.file, options)
     else:
