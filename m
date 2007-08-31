From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/2] Fix refresh -es
Date: Thu, 30 Aug 2007 23:04:55 -0400
Message-ID: <20070831030455.22554.75625.stgit@dv.roinet.com>
References: <20070831030449.22554.49699.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 05:05:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQwop-00063G-Bk
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 05:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517AbXHaDE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 23:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756552AbXHaDE5
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 23:04:57 -0400
Received: from c60.cesmail.net ([216.154.195.49]:51574 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756468AbXHaDE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 23:04:56 -0400
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 30 Aug 2007 23:04:55 -0400
Received: from dv.roinet.com (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 97838618FE1;
	Thu, 30 Aug 2007 23:04:55 -0400 (EDT)
In-Reply-To: <20070831030449.22554.49699.stgit@dv.roinet.com>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57108>

Use named arguments to call git.diff() from stack.edit_file().
git.diff() doesn't write to files anymore, do it in the caller.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/stack.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/stgit/stack.py b/stgit/stack.py
index ea22d76..0253348 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -88,7 +88,8 @@ def edit_file(series, line, comment, show_patch = True):
     if show_patch:
        print >> f, __patch_prefix
        # series.get_patch(series.get_current()).get_top()
-       git.diff([], series.get_patch(series.get_current()).get_bottom(), None, f)
+       diff_str = git.diff(rev1 = series.get_patch(series.get_current()).get_bottom())
+       f.write(diff_str)
 
     #Vim modeline must be near the end.
     print >> f, __comment_prefix, 'vi: set textwidth=75 filetype=diff nobackup:'
