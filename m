From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 16/16] p0002-index.sh: add perf test for the index formats
Date: Sun,  5 Aug 2012 23:49:13 +0200
Message-ID: <1344203353-2819-17-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8ix-0001x2-5A
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab2HEVuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:52 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48918 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab2HEVuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:50:16 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so649089eei.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=B8UQLJjYrGua90Ss1Iq47QiKNKlcQalxb7VpS73oIfM=;
        b=FuJS82n6GApZouF8XuAwYlo1YnQx04XwsI0DneR5nIvKg0uGUIMZku8Cc/jxlSbHFK
         JMya4sDSbZ4Sl8cgap13JA6kbzQy4Kty237TetvtdoyEvlqj3ed/fDG1bnzOeSNLR+wE
         xW1ZdAivygvRDFCw13Y3jpN44TiO9pcbYWgi5AE7OMcxDcianZCxQN2UKTkovUlDEkv/
         PLwFotkWJxAIJ7Pipct1g3ky9ZJBu7O3yElRRLU8oANxb4Kxlxa6mlPbSP26JbkWrQX5
         ZDfVptK6sRFvjaSAeen3qvKTDhpAv+bejDaiOzAXpYFPndce6H2P73LUppkXiqKYCN+g
         +32w==
Received: by 10.14.203.73 with SMTP id e49mr7321943eeo.27.1344203415483;
        Sun, 05 Aug 2012 14:50:15 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id h42sm42297026eem.5.2012.08.05.14.50.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:50:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202926>

From: Thomas Rast <trast@student.ethz.ch>

Add a performance test for index version [23]/4/5 by using
git update-index --force-rewrite, thus testing both the reader
and the writer speed of all index formats.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/perf/p0002-index.sh |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100755 t/perf/p0002-index.sh

diff --git a/t/perf/p0002-index.sh b/t/perf/p0002-index.sh
new file mode 100755
index 0000000..2996357
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
+	git update-index --force-rewrite >/dev/null
+'
+
+test_expect_success 'convert to v4' '
+	git update-index --index-version=4
+'
+
+test_perf 'v4: update-index' '
+	git update-index --force-rewrite >/dev/null
+'
+
+test_expect_success 'convert to v5' '
+	git update-index --index-version=5
+'
+
+test_perf 'v5: update-index' '
+	git update-index --force-rewrite >/dev/null
+'
+
+test_done
-- 
1.7.10.GIT
