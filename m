From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 6/6] Let some commands work with detached HEAD
Date: Mon, 08 Oct 2007 10:55:41 +0200
Message-ID: <20071008085540.9734.60137.stgit@yoghurt>
References: <20071008085430.9734.75797.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 10:57:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeoQ9-0003VA-HX
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 10:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbXJHIzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 04:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbXJHIzr
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 04:55:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2232 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbXJHIzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 04:55:45 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IeoOr-00025r-00; Mon, 08 Oct 2007 09:55:41 +0100
In-Reply-To: <20071008085430.9734.75797.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60306>

add, diff, resolved, and status didn't use the crt_series that was
initialized for them. So don't initialize it, since that means (1)
less work and (2) they won't fail when HEAD is detached.

Note that this doesn't completely fix the problem with detached HEAD:
a number of other commands (e.g. branch) don't always need to refer to
a current series, but currently fails on a detached HEAD even in those
situations.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/add.py      |    2 +-
 stgit/commands/diff.py     |    2 +-
 stgit/commands/resolved.py |    2 +-
 stgit/commands/status.py   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)


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
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index 42e8367..9ffbb4a 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -42,7 +42,7 @@ rev =3D '([patch][//[bottom | top]]) | <tree-ish> | b=
ase'
 If neither bottom nor top are given but a '//' is present, the command
 shows the specified patch (defaulting to the current one)."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(needs_current_series =3D False)
 options =3D [make_option('-r', '--range',
                        metavar =3D 'rev1[..[rev2]]', dest =3D 'revs',
                        help =3D 'show the diff between revisions'),
diff --git a/stgit/commands/resolved.py b/stgit/commands/resolved.py
index c2ef678..8b2aba2 100644
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
index a688f7e..360fabf 100644
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
