From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/5] Let "stg new" support more message options
Date: Sun, 10 Feb 2008 21:44:28 +0100
Message-ID: <20080210204420.17683.1504.stgit@yoghurt>
References: <20080210203846.17683.43153.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:45:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJ33-0005Kd-HD
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbYBJUoc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 15:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754602AbYBJUoc
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:44:32 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4238 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbYBJUob (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:44:31 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JOJ2K-0005DD-00; Sun, 10 Feb 2008 20:44:28 +0000
In-Reply-To: <20080210203846.17683.43153.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73408>

Let "stg new" support --file, and --save-template in addition to
--message. This is useful for scripting.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/new.py |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)


diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index d44b8cc..43414f5 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -37,10 +37,8 @@ If no name is given for the new patch, one is genera=
ted from the first
 line of the commit message."""
=20
 directory =3D common.DirectoryHasRepositoryLib()
-options =3D [make_option('-m', '--message',
-                       help =3D 'use MESSAGE as the patch description'=
),
-           ] + (utils.make_author_committer_options()
-                + utils.make_sign_options())
+options =3D (utils.make_author_committer_options()
+           + utils.make_message_options() + utils.make_sign_options())
=20
 def func(parser, options, args):
     """Create a new patch."""
@@ -79,6 +77,10 @@ def func(parser, options, args):
             utils.add_sign_line(cd.message, options.sign_str,
                                 cd.committer.name, cd.committer.email)=
)
=20
+    if options.save_template:
+        options.save_template(cd.message)
+        return utils.STGIT_SUCCESS
+
     # Let user edit the commit message manually.
     if not options.message:
         cd =3D cd.set_message(utils.edit_string(cd.message, '.stgit-ne=
w.txt'))
