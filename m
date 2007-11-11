From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/5] Let some commands work with detached HEAD
Date: Sun, 11 Nov 2007 20:43:49 +0100
Message-ID: <20071111194349.18868.77565.stgit@yoghurt>
References: <20071111193545.18868.62490.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:44:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIjT-0001bT-73
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbXKKToT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 14:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756842AbXKKToT
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:44:19 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3899 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756881AbXKKToS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:44:18 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IrIik-0004bp-00; Sun, 11 Nov 2007 19:43:50 +0000
In-Reply-To: <20071111193545.18868.62490.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64505>

add, resolved, and status didn't use the crt_series that was
initialized for them. So don't initialize it, since that means (1)
less work and (2) they won't fail when HEAD is detached.

Note that this doesn't completely fix the problem with detached HEAD:
a number of other commands (e.g. branch) don't always need to refer to
a current series, but currently fails on a detached HEAD even in those
situations.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/add.py      |    2 +-
 stgit/commands/resolved.py |    2 +-
 stgit/commands/status.py   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/stgit/commands/add.py b/stgit/commands/add.py
index 264ab9f..ceea188 100644
--- a/stgit/commands/add.py
+++ b/stgit/commands/add.py
@@ -31,7 +31,7 @@ Add the files or directories passed as arguments to t=
he
 repository. When a directory name is given, all the files and
 subdirectories are recursively added."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(needs_current_series =3D False)
 options =3D []
=20
=20
diff --git a/stgit/commands/resolved.py b/stgit/commands/resolved.py
index 236ffd7..011db91 100644
--- a/stgit/commands/resolved.py
+++ b/stgit/commands/resolved.py
@@ -34,7 +34,7 @@ Mark a merge conflict as resolved. The conflicts can =
be seen with the
 'C'. This command also removes any <file>.{ancestor,current,patched}
 files."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(needs_current_series =3D False)
 options =3D [make_option('-a', '--all',
                        help =3D 'mark all conflicts as solved',
                        action =3D 'store_true'),
diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index 5763d09..20614b0 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -40,7 +40,7 @@ under revision control. The files are prefixed as fol=
lows:
 A 'refresh' command clears the status of the modified, new and deleted
 files."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(needs_current_series =3D False)
 options =3D [make_option('-m', '--modified',
                        help =3D 'show modified files only',
                        action =3D 'store_true'),
