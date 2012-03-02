From: Thomas Rast <trast@student.ethz.ch>
Subject: [git wiki PATCH 1/3] "Improving parallelism in various commands" project
Date: Fri, 2 Mar 2012 12:05:45 +0100
Message-ID: <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch>
References: <20120302091114.GA3984@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:05:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3QJ9-0001E5-Jq
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 12:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208Ab2CBLFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 06:05:50 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:18526 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087Ab2CBLFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 06:05:49 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 12:05:43 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 12:05:47 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <20120302091114.GA3984@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192024>

---
 SoC-2012-Ideas.md |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
index 29a374a..145b379 100644
--- a/SoC-2012-Ideas.md
+++ b/SoC-2012-Ideas.md
@@ -68,3 +68,34 @@ work to be done:
    and only accessed on demand.
 
 Proposed mentor: Jeff King
+
+Improving parallelism in various commands
+-----------------------------------------
+
+Git is mostly written single-threaded, with a few commands having
+bolted-on extensions to support parallel operation (notably git-grep,
+git-pack-objects and the core.preloadIndex feature).
+
+We have recently looked into some of these areas and made a few
+optimizations, but a big roadblock is that pack access is entirely
+single-threaded.  The project would consist of the following steps:
+
+ * In preparation (the half-step): identify commands that could
+   benefit from parallelism.  `git grep --cached` and `git grep
+   COMMIT` come to mind, but most likely also `git diff` and `git log
+   -p`.  You can probably find more.
+
+ * Rework the pack access mechanisms to allow the maximum possible
+   parallel access.
+
+ * Rework the commands found in the first step to use parallel pack
+   access if possible.  Along the way, document the improvements with
+   performance tests.
+
+The actual programming must be done in C using pthreads for obvious
+reasons.  At the very least you should not be scared of low-level
+programming.  Prior experience and access to one or more multi-core
+computers is a plus.
+
+Proposed by: Thomas Rast
+Possible mentor(s): Thomas Rast
-- 
1.7.9.2.467.g7fee4
