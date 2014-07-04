From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 5/5] Add a little script to compare two make perf runs
Date: Fri,  4 Jul 2014 16:43:52 -0700
Message-ID: <1404517432-25185-6-git-send-email-andi@firstfloor.org>
References: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 01:45:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3DA9-0006Io-Oj
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jul 2014 01:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760312AbaGDXo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 19:44:58 -0400
Received: from one.firstfloor.org ([193.170.194.197]:53378 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760289AbaGDXow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 19:44:52 -0400
Received: from basil.firstfloor.org (184-100-237-164.ptld.qwest.net [184.100.237.164])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id ABCCB8677E;
	Sat,  5 Jul 2014 01:44:50 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 4E491A18AE; Fri,  4 Jul 2014 16:43:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252909>

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 diff-res | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 diff-res

diff --git a/diff-res b/diff-res
new file mode 100755
index 0000000..90d57be
--- /dev/null
+++ b/diff-res
@@ -0,0 +1,26 @@
+#!/usr/bin/python
+# compare two make perf output file
+# this should be the results only without any header
+import argparse
+import math, operator
+from collections import OrderedDict
+
+ap = argparse.ArgumentParser()
+ap.add_argument('file1', type=argparse.FileType('r'))
+ap.add_argument('file2', type=argparse.FileType('r'))
+args = ap.parse_args()
+
+cmp = (OrderedDict(), OrderedDict())
+for f, k in zip((args.file1, args.file2), cmp):
+    for j in f:
+        num = j[59:63]
+        name = j[:59]
+        k[name] = float(num)
+
+for j in cmp[0].keys():
+    print j, cmp[1][j] - cmp[0][j]
+
+def geomean(l):
+   return math.pow(reduce(operator.mul, filter(lambda x: x != 0.0, l)), 1.0 / len(l))
+
+print "geomean %.2f -> %.2f" % (geomean(cmp[0].values()), geomean(cmp[1].values()))
-- 
2.0.1
