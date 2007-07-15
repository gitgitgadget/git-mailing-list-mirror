From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH] Revert 'Disallow non-patch args to "stg show" (gna
	#8453).'
Date: Sun, 15 Jul 2007 23:32:11 +0200
Message-ID: <20070715213211.6855.69618.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 23:32:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IABi4-0002dS-FI
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 23:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbXGOVcv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 17:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbXGOVcv
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 17:32:51 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:47876 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbXGOVcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 17:32:51 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C5C7D5A24C;
	Sun, 15 Jul 2007 23:32:49 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 403D020D9;
	Sun, 15 Jul 2007 23:32:12 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52588>

This patch has a lot of side-effects that will break people's
expectations.  There is much more that just this to do if we want to
sanitize patch/commit/range addressing on the command-line, so that
will wait till after 0.13.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/show.py |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index 2b22744..45ca253 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -55,7 +55,12 @@ def func(parser, options, args):
     elif len(args) == 0:
         patches = ['HEAD']
     else:
-        patches = parse_patches(args, applied + unapplied +\
+        if len(args) == 1 and args[0].find('..') == -1 \
+               and not crt_series.patch_exists(args[0]):
+            # it might be just a commit id
+            patches = args
+        else:
+            patches = parse_patches(args, applied + unapplied +\
                                 crt_series.get_hidden(), len(applied))
 
     if options.diff_opts:
