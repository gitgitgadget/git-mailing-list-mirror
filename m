From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 4/5] Fix bash completion after the DAG appliedness patch
Date: Tue, 07 Aug 2007 04:48:01 +0200
Message-ID: <20070807024801.11373.85323.stgit@yoghurt>
References: <20070807024508.11373.62875.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIF7D-0005J3-T5
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765996AbXHGCsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 22:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765984AbXHGCsG
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:48:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2246 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765969AbXHGCsF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:48:05 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIF74-0002Up-00; Tue, 07 Aug 2007 03:48:02 +0100
In-Reply-To: <20070807024508.11373.62875.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55209>

The bash tab completion used the "applied", "unapplied" and "current"
files to generate completions. Since these don't exist anymore, use
stg applied/unapplied/series to obtain the same info. It's a bit
slower, but not terribly much so.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 contrib/stgit-completion.bash |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.b=
ash
index a843db4..842f0b1 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -70,15 +70,13 @@ _current_branch ()
 # List of all applied patches.
 _applied_patches ()
 {
-    local g=3D$(_gitdir)
-    [ "$g" ] && cat "$g/patches/$(_current_branch)/applied"
+    stg applied 2> /dev/null
 }
=20
 # List of all unapplied patches.
 _unapplied_patches ()
 {
-    local g=3D$(_gitdir)
-    [ "$g" ] && cat "$g/patches/$(_current_branch)/unapplied"
+    stg unapplied 2> /dev/null
 }
=20
 # List of all applied patches.
@@ -91,18 +89,13 @@ _hidden_patches ()
 # List of all patches.
 _all_patches ()
 {
-    local b=3D$(_current_branch)
-    local g=3D$(_gitdir)
-    [ "$g" ] && cat "$g/patches/$b/applied" "$g/patches/$b/unapplied"
+    stg series --noprefix 2> /dev/null
 }
=20
 # List of all patches except the current patch.
 _all_other_patches ()
 {
-    local b=3D$(_current_branch)
-    local g=3D$(_gitdir)
-    [ "$g" ] && cat "$g/patches/$b/applied" "$g/patches/$b/unapplied" =
\
-        | grep -v "^$(cat $g/patches/$b/current 2> /dev/null)$"
+    stg series 2> /dev/null | grep -v '^>' | cut -f 2 -d ' '
 }
=20
 _all_branches ()
