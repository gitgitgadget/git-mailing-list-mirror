From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Make sure that the output of "stg status" is sorted
Date: Mon, 24 Sep 2007 01:52:23 +0200
Message-ID: <20070923235212.26396.53222.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 01:52:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZbFa-00064p-5K
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 01:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbXIWXw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2007 19:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755006AbXIWXw2
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 19:52:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1776 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbXIWXw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 19:52:27 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IZbFQ-0006JJ-00; Mon, 24 Sep 2007 00:52:24 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59004>

This simplifies testing, but also makes it easier for the user to find
specific files.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/status.py |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)


diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index bbfb5df..b2835ab 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -91,12 +91,15 @@ def status(files =3D None, modified =3D False, new =
=3D False, deleted =3D False,
             filestat.append('?')
         cache_files =3D [x for x in cache_files if x[0] in filestat]
=20
-    for fs in cache_files:
-        assert files =3D=3D None or fs[1] in files
-        if not filtered:
-            out.stdout('%s %s' % (fs[0], fs[1]))
+    output =3D []
+    for st, fn in cache_files:
+        assert files =3D=3D None or fn in files
+        if filtered:
+            output.append(fn)
         else:
-            out.stdout('%s' % fs[1])
+            output.append('%s %s' % (st, fn))
+    for o in sorted(output):
+        out.stdout(o)
=20
 def func(parser, options, args):
     """Show the tree status
