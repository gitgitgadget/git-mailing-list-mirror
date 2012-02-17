From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 3/3] Add a performance test for git-grep
Date: Fri, 17 Feb 2012 11:25:10 +0100
Message-ID: <95250e73e5610f8415fa0c6a3527b067ec0f75f2.1329472405.git.trast@student.ethz.ch>
References: <cover.1329472405.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 17 11:25:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyL0V-0003kV-N9
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 11:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab2BQKZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 05:25:20 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:33856 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab2BQKZT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 05:25:19 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 17 Feb
 2012 11:25:09 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 17 Feb
 2012 11:25:11 +0100
X-Mailer: git-send-email 1.7.9.1.365.ge223f
In-Reply-To: <cover.1329472405.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190945>

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
1.7.9.1.365.ge223f
