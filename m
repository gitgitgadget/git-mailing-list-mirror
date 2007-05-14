From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH] Fix bash completion after the DAG appliedness patch
Date: Mon, 14 May 2007 21:44:55 +0200
Message-ID: <20070514194444.27742.67117.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 21:45:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HngTw-0002Tc-AO
	for gcvg-git@gmane.org; Mon, 14 May 2007 21:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172AbXENTpD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 14 May 2007 15:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757069AbXENTpB
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 15:45:01 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:39247 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756873AbXENTpA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2007 15:45:00 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:47305 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HngTa-0007nX-5R; Mon, 14 May 2007 21:44:58 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HngTX-0007E8-VY; Mon, 14 May 2007 21:44:56 +0200
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HngTa-0007nX-5R.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HngTa-0007nX-5R 1360d55fd10dafffa758f706dd8d193e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47288>

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
index 3c3bf92..2032323 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -70,32 +70,25 @@ _current_branch ()
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
 # List the command options
