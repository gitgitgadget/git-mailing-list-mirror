From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH 2/5] Add the --reject option to fold
Date: Wed, 16 Sep 2009 22:41:00 +0100
Message-ID: <20090916214100.6622.90078.stgit@toshiba-laptop>
References: <20090916214049.6622.44662.stgit@toshiba-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 23:49:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo2N6-0003tX-TA
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 23:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760165AbZIPVsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 17:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759972AbZIPVsg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 17:48:36 -0400
Received: from cpc3-cmbg12-0-0-cust617.cmbg.cable.ntl.com ([86.9.126.106]:47225
	"EHLO toshiba-laptop" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760165AbZIPVs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 17:48:29 -0400
Received: by toshiba-laptop (Postfix, from userid 1000)
	id A4B681C079C; Wed, 16 Sep 2009 22:41:00 +0100 (BST)
In-Reply-To: <20090916214049.6622.44662.stgit@toshiba-laptop>
User-Agent: StGit/0.15-rc3-5-g9f71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128685>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/fold.py |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/fold.py b/stgit/commands/fold.py
index 66a2dd9..28e824c 100644
--- a/stgit/commands/fold.py
+++ b/stgit/commands/fold.py
@@ -38,7 +38,9 @@ options = [
     opt('-t', '--threeway', action = 'store_true',
         short = 'Perform a three-way merge with the current patch'),
     opt('-b', '--base', args = [argparse.commit],
-        short = 'Use BASE instead of HEAD applying the patch')]
+        short = 'Use BASE instead of HEAD when applying the patch'),
+    opt('--reject', action = 'store_true',
+        short = 'Leave the rejected hunks in corresponding *.rej files')]
 
 directory = DirectoryHasRepository(log = True)
 
@@ -72,11 +74,12 @@ def func(parser, options, args):
     if options.threeway:
         crt_patch = crt_series.get_patch(current)
         bottom = crt_patch.get_bottom()
-        git.apply_patch(filename = filename, base = bottom)
+        git.apply_patch(filename = filename, base = bottom,
+                        reject = options.reject)
     elif options.base:
-        git.apply_patch(filename = filename,
+        git.apply_patch(filename = filename, reject = options.reject,
                         base = git_id(crt_series, options.base))
     else:
-        git.apply_patch(filename = filename)
+        git.apply_patch(filename = filename, reject = options.reject)
 
     out.done()
