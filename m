From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v3 13/13] p0002-index.sh: add perf test for the index formats
Date: Wed,  8 Aug 2012 13:18:01 +0200
Message-ID: <1344424681-31469-14-git-send-email-t.gummerer@gmail.com>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 13:27:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz4Q4-0005W3-Eg
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 13:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab2HHL0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 07:26:46 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:36953 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756005Ab2HHL02 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 07:26:28 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id B5F3B4EFF7; Wed,  8 Aug 2012 13:18:49 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203079>

From: Thomas Rast <trast@student.ethz.ch>

Add a performance test for index version [23]/4/5 by using
git update-index --update-index=[345], thus testing both the reader
and the writer speed of all index formats.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/perf/p0002-index.sh |   33 +++++++++++++++++++++++++++++++++
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
1.7.10.GIT
