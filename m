From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/8] Add --ack/--sign options to "stg new"
Date: Mon, 08 Oct 2007 01:17:18 +0200
Message-ID: <20071007231718.12626.20660.stgit@yoghurt>
References: <20071007231446.12626.14259.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefNK-0003IS-4g
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286AbXJGXRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755841AbXJGXRY
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:17:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1360 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076AbXJGXRX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:17:23 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefN9-0000Kf-00; Mon, 08 Oct 2007 00:17:19 +0100
In-Reply-To: <20071007231446.12626.14259.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60239>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/new.py |    6 ++++--
 stgit/stack.py        |   10 +++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)


diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index f192e34..59671ab 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -54,7 +54,8 @@ options =3D [make_option('-m', '--message',
            make_option('--commname',
                        help =3D 'use COMMNAME as the committer name'),
            make_option('--commemail',
-                       help =3D 'use COMMEMAIL as the committer e-mail=
')]
+                       help =3D 'use COMMEMAIL as the committer e-mail=
')
+           ] + make_sign_options()
=20
=20
 def func(parser, options, args):
@@ -79,4 +80,5 @@ def func(parser, options, args):
                          author_email =3D options.authemail,
                          author_date =3D options.authdate,
                          committer_name =3D options.commname,
-                         committer_email =3D options.commemail)
+                         committer_email =3D options.commemail,
+                         sign_str =3D options.sign_str)
diff --git a/stgit/stack.py b/stgit/stack.py
index d889f37..4d1a066 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -847,7 +847,7 @@ class Series(PatchSet):
                   top =3D None, bottom =3D None, commit =3D True,
                   author_name =3D None, author_email =3D None, author_=
date =3D None,
                   committer_name =3D None, committer_email =3D None,
-                  before_existing =3D False):
+                  before_existing =3D False, sign_str =3D None):
         """Creates a new patch, either pointing to an existing commit =
object,
         or by creating a new commit object.
         """
@@ -865,13 +865,17 @@ class Series(PatchSet):
=20
         # TODO: move this out of the stgit.stack module, it is really
         # for higher level commands to handle the user interaction
+        def sign(msg):
+            return add_sign_line(msg, sign_str,
+                                 committer_name or git.committer().nam=
e,
+                                 committer_email or git.committer().em=
ail)
         if not message and can_edit:
             descr =3D edit_file(
-                self, None,
+                self, sign(''),
                 'Please enter the description for the patch above.',
                 show_patch)
         else:
-            descr =3D message
+            descr =3D sign(message)
=20
         head =3D git.get_head()
=20
