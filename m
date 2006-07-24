From: Alex Riesen <fork0@t-online.de>
Subject: [PATCH] Trivial path optimization test
Date: Tue, 25 Jul 2006 01:23:03 +0200
Message-ID: <20060724232303.GB14792@steel.home>
References: <Pine.LNX.4.64.0607140828250.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jul 25 01:23:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G59ll-0007Ez-Vv
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 01:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWGXXXW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 19:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWGXXXW
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 19:23:22 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:24995 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932326AbWGXXXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 19:23:21 -0400
Received: from fwd32.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1G59lW-0000fG-05; Tue, 25 Jul 2006 01:23:10 +0200
Received: from tigra.home (XHnzV6ZD8eB3lgCN94lb+KfPSHjWFSb8fgqbqQf-BCAD9-Q8E7lrE2@[84.160.82.84]) by fwd32.sul.t-online.de
	with esmtp id 1G59lQ-1q8wgC0; Tue, 25 Jul 2006 01:23:04 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E0759277AF;
	Tue, 25 Jul 2006 01:23:03 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1G59lP-0002iK-PP; Tue, 25 Jul 2006 01:23:03 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607140828250.5623@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-ID: XHnzV6ZD8eB3lgCN94lb+KfPSHjWFSb8fgqbqQf-BCAD9-Q8E7lrE2
X-TOI-MSGID: 92680396-db45-4f78-984e-9ec374b0d996
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24154>


Linus:
    get_pathspec() does turn '.' into an empty string (which is
    correct - git internally does _not_ ever understand the notion of
    "." as the current working directory), but it doesn't ever do the
    optimization of noticing that a pathspec that consists solely of
    an empty string is "equivalent" to an empty pathspec.

The test is to ensure that this behaviour stays.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

 t/t6004-rev-list-path-optim.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/t/t6004-rev-list-path-optim.sh b/t/t6004-rev-list-path-optim.sh
new file mode 100755
index 0000000..5182dbb
--- /dev/null
+++ b/t/t6004-rev-list-path-optim.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='git-rev-list trivial path optimization test'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+echo Hello > a &&
+git add a &&
+git commit -m "Initial commit" a
+'
+
+test_expect_success path-optimization '
+    commit=$(echo "Unchanged tree" | git-commit-tree "HEAD^{tree}" -p HEAD) &&
+    test $(git-rev-list $commit | wc -l) = 2 &&
+    test $(git-rev-list $commit -- . | wc -l) = 1
+'
+
+test_done
-- 
1.4.1.gb944
