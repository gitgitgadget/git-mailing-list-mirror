From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH 4/5] Add the -p option to fold
Date: Wed, 16 Sep 2009 22:41:10 +0100
Message-ID: <20090916214110.6622.12748.stgit@toshiba-laptop>
References: <20090916214049.6622.44662.stgit@toshiba-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 23:48:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo2Mk-0003lJ-K5
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 23:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760174AbZIPVsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 17:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760170AbZIPVsa
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 17:48:30 -0400
Received: from cpc3-cmbg12-0-0-cust617.cmbg.cable.ntl.com ([86.9.126.106]:47223
	"EHLO toshiba-laptop" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760160AbZIPVs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 17:48:28 -0400
Received: by toshiba-laptop (Postfix, from userid 1000)
	id CF13E1C07A0; Wed, 16 Sep 2009 22:41:10 +0100 (BST)
In-Reply-To: <20090916214049.6622.44662.stgit@toshiba-laptop>
User-Agent: StGit/0.15-rc3-5-g9f71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128680>

This option was added to import, so it makes sense for fold to have it
as well.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/fold.py |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/fold.py b/stgit/commands/fold.py
index 28e824c..ce0459e 100644
--- a/stgit/commands/fold.py
+++ b/stgit/commands/fold.py
@@ -39,6 +39,8 @@ options = [
         short = 'Perform a three-way merge with the current patch'),
     opt('-b', '--base', args = [argparse.commit],
         short = 'Use BASE instead of HEAD when applying the patch'),
+    opt('-p', '--strip', type = 'int', metavar = 'N',
+        short = 'Remove N leading slashes from diff paths (default 1)'),
     opt('--reject', action = 'store_true',
         short = 'Leave the rejected hunks in corresponding *.rej files')]
 
@@ -75,11 +77,13 @@ def func(parser, options, args):
         crt_patch = crt_series.get_patch(current)
         bottom = crt_patch.get_bottom()
         git.apply_patch(filename = filename, base = bottom,
-                        reject = options.reject)
+                        strip = options.strip, reject = options.reject)
     elif options.base:
         git.apply_patch(filename = filename, reject = options.reject,
+                        strip = options.strip,
                         base = git_id(crt_series, options.base))
     else:
-        git.apply_patch(filename = filename, reject = options.reject)
+        git.apply_patch(filename = filename, strip = options.strip,
+                        reject = options.reject)
 
     out.done()
