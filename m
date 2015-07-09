From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 01/11] t6302: for-each-ref tests for ref-filter APIs
Date: Thu,  9 Jul 2015 11:33:21 +0530
Message-ID: <1436421801-7781-1-git-send-email-karthik.188@gmail.com>
References: <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 08:03:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD4vi-0002RO-8d
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 08:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbbGIGD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 02:03:26 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36188 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbbGIGDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 02:03:25 -0400
Received: by pddu5 with SMTP id u5so71751312pdd.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 23:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=anXqDM9cRFBZAbdYn0FKFK8yEO/ALhBJgGDMtcsDpUI=;
        b=sTXI35TMwVkn2VD2y3r2ghJ5m0dW+a65AM0BpEJnZPryEDzWzF17FSD48YuL+X7XFt
         MpKsckgCMOU2jKthXRL24+AIk7kybJiL5pqnXTg6kNuWumT41sUwhrLfBLpG/iRyUjAB
         9NoKYE0DvafxjVgcdfK4Bjr83qHP3paVhQaJyOyEJfgC5+e6YcJMtUa59bssyyb7w0IH
         1lP7jSYH7GO7Zg/h2HRqS3X9Af+2QhskDnYno72Qf/7awnIhyiMrydHyGsDf1ji/uf7v
         NZuRrMOfn5IfIB5H+ScfbUeW6kOhOmeGtzlXp2kYsuWfu4H3U2gGkU85g4FNYw+gShb9
         cCww==
X-Received: by 10.66.102.103 with SMTP id fn7mr27976289pab.85.1436421804731;
        Wed, 08 Jul 2015 23:03:24 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id om10sm4489795pbb.58.2015.07.08.23.03.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Jul 2015 23:03:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273727>

Add a test suite for testing the ref-filter APIs used
by for-each-ref. We just intialize the test suite for now.
More tests will be added in the following patches as more
options are added to for-each-ref.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t6302-for-each-ref-filter.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 t/t6302-for-each-ref-filter.sh

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
new file mode 100755
index 0000000..ae75116
--- /dev/null
+++ b/t/t6302-for-each-ref-filter.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='test for-each-refs usage of ref-filter APIs'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
+
+if ! test_have_prereq GPG
+then
+	skip_all="skipping for-each-ref tests, GPG not available"
+	test_done
+fi
+
+test_expect_success 'setup some history and refs' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	git checkout -b side &&
+	test_commit four &&
+	git tag -s -m "A signed tag message" signed-tag &&
+	git tag -s -m "Annonated doubly" double-tag signed-tag &&
+	git checkout master &&
+	git update-ref refs/odd/spot master
+'
+
+test_done
-- 
2.4.5
