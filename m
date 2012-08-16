From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v4 13/13] p0002-index.sh: add perf test for the index formats
Date: Thu, 16 Aug 2012 11:58:49 +0200
Message-ID: <1345111129-6925-14-git-send-email-t.gummerer@gmail.com>
References: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, pclouds@gmail.com, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 11:59:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1wrW-0008Ge-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 11:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364Ab2HPJ7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 05:59:23 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:48210 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756368Ab2HPJ7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 05:59:18 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id ADF134EFF7; Thu, 16 Aug 2012 11:59:10 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Rast <trast@student.ethz.ch>

Add a performance test for index version [23]/4/5 by using
git update-index --index-version=x, thus testing both the reader
and the writer speed of all index formats.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/perf/p0002-index.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100755 t/perf/p0002-index.sh

diff --git a/t/perf/p0002-index.sh b/t/perf/p0002-index.sh
new file mode 100755
index 0000000..140c7a0
--- /dev/null
+++ b/t/perf/p0002-index.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description="Tests index versions [23]/4/5"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success 'convert to v3' '
+	git update-index --index-version=3
+'
+
+test_perf 'v[23]: update-index' '
+	git update-index --index-version=3 >/dev/null
+'
+
+test_expect_success 'convert to v4' '
+	git update-index --index-version=4
+'
+
+test_perf 'v4: update-index' '
+	git update-index --index-version=4 >/dev/null
+'
+
+test_expect_success 'convert to v5' '
+	git update-index --index-version=5
+'
+
+test_perf 'v5: update-index' '
+	git update-index --index-version=5 >/dev/null
+'
+
+test_done
-- 
1.7.11.2
