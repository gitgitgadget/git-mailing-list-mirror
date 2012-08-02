From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 16/16] p0002-index.sh: add perf test for the index formats
Date: Thu,  2 Aug 2012 13:02:06 +0200
Message-ID: <1343905326-23790-17-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtBp-0005Lo-3e
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654Ab2HBLDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:03:25 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44602 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab2HBLDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:03:22 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so2331146eei.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=S+3RX31djsKJbiFnO54Tq7EZNfO3EqH0uyCdEly1pRI=;
        b=nSzsAHEQd/HXXrqu4CEIV8HS7vRknqZ56h+BiA5fZQH7iGYe8NAxff+CPM/GIsMWez
         fckO17V3GJ/FifrQl/RNrSTNSz0q8Jvm6JiNWdft8lrjLnHmaOiQzul37LGD+lLFNMep
         16stD3Te1V71bVx1Jf6XfaBEoofvZi1oXqjS0HVsrFms85NHy9jzJQKa4042mFzq9k0W
         kSQDFycugOU5P+2fcV51klWPw3iqSa+hqaAVvLQJgXIVDoYWMAMKlupXE2ASwGGMnIrb
         mdB0MdsFgNjxeAfMRJMoNWOO776Pq1hLpKUWp+/0CyCYaDrK0/qJH+tmU8pw3P2o7hwR
         yfIg==
Received: by 10.14.219.198 with SMTP id m46mr26113656eep.18.1343905401435;
        Thu, 02 Aug 2012 04:03:21 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id h42sm16449363eem.5.2012.08.02.04.03.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:03:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202759>

Add a performance test for index version [23]/4/5 by using
git update-index --force-rewrite, thus testing both the reader
and the writer speed of all index formats.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/perf/p0002-index.sh | 33 +++++++++++++++++++++++++++++++++
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
1.7.10.886.gdf6792c.dirty
