From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 4/4] Compile regexp just once
Date: Sun, 26 Aug 2007 22:26:32 +0200
Message-ID: <20070826202632.15933.99722.stgit@yoghurt>
References: <20070826202309.15933.54183.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:27:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOhR-00068z-AJ
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbXHZU0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbXHZU0v
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:26:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3263 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbXHZU0f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:26:35 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOgq-0005tN-00; Sun, 26 Aug 2007 21:26:32 +0100
In-Reply-To: <20070826202309.15933.54183.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56717>

It's a waste of time to recompile the same regexp every time we go
through the loop.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/git.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 1807f69..14b4c81 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -275,8 +275,9 @@ def local_changes(verbose =3D True):
=20
 def get_heads():
     heads =3D []
+    hr =3D re.compile(r'^[0-9a-f]{40} refs/heads/(.+)$')
     for line in _output_lines(['git-show-ref', '--heads']):
-        m =3D re.match('^[0-9a-f]{40} refs/heads/(.+)$', line)
+        m =3D hr.match(line)
         heads.append(m.group(1))
     return heads
=20
