From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/8] Don't split long and short description in "stg edit"
Date: Mon, 08 Oct 2007 01:17:35 +0200
Message-ID: <20071007231735.12626.81744.stgit@yoghurt>
References: <20071007231446.12626.14259.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:18:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefOU-0003Sh-HL
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645AbXJGXRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbXJGXRk
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:17:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1369 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbXJGXRj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:17:39 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefNQ-0000LI-00; Mon, 08 Oct 2007 00:17:36 +0100
In-Reply-To: <20071007231446.12626.14259.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60242>

"stg edit" used to present the patch information like this:

  Short description

  From: ...
  Date: ...

  Long description

If the project follows the git convention with a single-line short
description and follwed by a blank line and the rest of the
description, this merely looks a little odd. However, for projects
that don't follow that convention, presenting the first line
separately is actively inconvenient; for example, it breaks emacs's
fill-paragraph command.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/edit.py |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)


diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index e968e25..223c628 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -36,12 +36,10 @@ diff.
=20
 The editor is invoked with the following contents:
=20
-  Patch short description
-
   From: A U Thor <author@example.com>
   Date: creation date
=20
-  Patch long description
+  Patch description
=20
 If --diff was specified, the diff appears at the bottom, after a
 separator:
@@ -135,22 +133,15 @@ def __edit_update_patch(pname, options):
=20
     # generate the file to be edited
     descr =3D patch.get_description().strip()
-    descr_lines =3D descr.split('\n')
     authdate =3D patch.get_authdate()
=20
-    short_descr =3D descr_lines[0].rstrip()
-    long_descr =3D reduce(lambda x, y: x + '\n' + y,
-                        descr_lines[1:], '').strip()
-
-    tmpl =3D '%(shortdescr)s\n\n' \
-           'From: %(authname)s <%(authemail)s>\n'
+    tmpl =3D 'From: %(authname)s <%(authemail)s>\n'
     if authdate:
         tmpl +=3D 'Date: %(authdate)s\n'
-    tmpl +=3D '\n%(longdescr)s\n'
+    tmpl +=3D '\n%(descr)s\n'
=20
     tmpl_dict =3D {
-        'shortdescr': short_descr,
-        'longdescr': long_descr,
+        'descr': descr,
         'authname': patch.get_authname(),
         'authemail': patch.get_authemail(),
         'authdate': patch.get_authdate()
