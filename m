From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 3/3] Add a performance test for git-grep
Date: Thu, 16 Feb 2012 22:41:15 +0100
Message-ID: <9186cd4a628dc240f8519cddd3ca4e6fad0fce9f.1329428159.git.trast@student.ethz.ch>
References: <cover.1329428159.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 16 22:41:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry95B-0003HQ-JW
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 22:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab2BPVlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 16:41:39 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:3125 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062Ab2BPVlg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 16:41:36 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 16 Feb
 2012 22:41:29 +0100
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 16 Feb
 2012 22:41:32 +0100
X-Mailer: git-send-email 1.7.9.1.334.gd1409
In-Reply-To: <cover.1329428159.git.trast@student.ethz.ch>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190912>

The only catch is that we don't really know what our repo contains, so
we have to ignore any possible "not found" status from git-grep.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/p7810-grep.sh |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100755 t/perf/p7810-grep.sh

diff --git a/t/perf/p7810-grep.sh b/t/perf/p7810-grep.sh
new file mode 100755
index 0000000..9f4ade6
--- /dev/null
+++ b/t/perf/p7810-grep.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description="git-grep performance in various modes"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+test_perf 'grep worktree, cheap regex' '
+	git grep some_nonexistent_string || :
+'
+test_perf 'grep worktree, expensive regex' '
+	git grep "^.* *some_nonexistent_string$" || :
+'
+test_perf 'grep --cached, cheap regex' '
+	git grep --cached some_nonexistent_string || :
+'
+test_perf 'grep --cached, expensive regex' '
+	git grep --cached "^.* *some_nonexistent_string$" || :
+'
+
+test_done
-- 
1.7.9.1.334.gd1409
