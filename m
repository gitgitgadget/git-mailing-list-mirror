From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 4/4] Add a performance test for git-grep
Date: Wed, 14 Dec 2011 16:23:32 +0100
Message-ID: <370de2c5c277513098480baf47f73ca6077787b0.1323876121.git.trast@student.ethz.ch>
References: <cover.1323876121.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 16:24:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raqgh-0001dG-Su
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 16:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345Ab1LNPXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 10:23:47 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:21952 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757302Ab1LNPXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 10:23:41 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 16:23:30 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 16:23:33 +0100
X-Mailer: git-send-email 1.7.8.304.ge42e4
In-Reply-To: <cover.1323876121.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187131>

The only catch is that we don't really know what our repo contains, so
we have to ignore any possible "not found" status from git-grep.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/p7810-grep.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
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
1.7.8.304.ge42e4
