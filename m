From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 3/4] Don't traverse the whole DAG when looking for
	uninteresting commits
Date: Mon, 13 Aug 2007 23:01:36 +0200
Message-ID: <20070813210136.25929.95213.stgit@yoghurt>
References: <20070813205801.25929.34925.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:03:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKh4F-0006Rq-KZ
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 23:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S942551AbXHMVCT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 13 Aug 2007 17:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967393AbXHMVCQ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 17:02:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3339 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S970295AbXHMVBk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 17:01:40 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IKh2f-0008Q2-00; Mon, 13 Aug 2007 22:01:37 +0100
In-Reply-To: <20070813205801.25929.34925.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55785>

It's sufficient to look at the part of the DAG that's reachable from
the patches. This might be a large subset, of course, but it could
still be a significant improvement in some cases, especially when
there is only one patch.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/stack.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 8f1c0ee..dbb27eb 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -459,7 +459,8 @@ class UninterestingCache:
         # Iterate over all commits. We are guaranteed to see each
         # commit before any of its children.
         for line in git._output_lines(
-            'git-rev-list --topo-order --reverse --parents --all'):
+            'git-rev-list --topo-order --reverse --parents --stdin',
+            ['%s\n' % p for p in patches]):
             commits =3D line.split()
             commit, parents =3D commits[0], Set(commits[1:])
=20
