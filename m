From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 2/2] git-C: Add test to check "git -C ''"
Date: Thu,  5 Mar 2015 16:27:11 +0530
Message-ID: <1425553031-22264-1-git-send-email-karthik.188@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 11:57:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTTTH-0000jM-S0
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 11:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbbCEK5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 05:57:32 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:40109 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbbCEK53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 05:57:29 -0500
Received: by pdbfp1 with SMTP id fp1so28300015pdb.7
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 02:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bZ6ow6zzJjUtN7FUe/hmtmIOSiNXC3SQCjWVVfcE7J0=;
        b=bjKLlU5XmkUofK4bqSmVuUpv7wlFjmF8W6WMSllqocb44eMcFmUZwBn/knpFEdlsAR
         EOYxXZWcQoOHYvRsN/E+Fv2euzx7Y3Sqx5D7XEkhjkj6Qc5S0QFvrsKRBmmGbiBXnKYD
         ZCsDIGVgL8lw9BDqsB7SFn5vgi0ttSA4457fL7tDbFEPlHxzrQJbgE1uPO/bvKMV5VLl
         kN7T99JZWh4Qgai5gMaCZ8b3x6Qkt0MBGlw8y0zJmnrRdhHzY1UypTMhkAFnif0mm18b
         Wq68u0idlBSCyjuo3CEXDXevDDjYQhp/DVlQfylsnwc7m9T2yHsa+3KYQmXysFngdWra
         Xxwg==
X-Received: by 10.68.245.196 with SMTP id xq4mr14959841pbc.124.1425553048946;
        Thu, 05 Mar 2015 02:57:28 -0800 (PST)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id go1sm6557917pbd.75.2015.03.05.02.57.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2015 02:57:28 -0800 (PST)
X-Mailer: git-send-email 2.3.1.169.g2532f2d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264829>

Add a test to check whether "git -C ''" works
without giving an error. This is achieved by
adding a commit and checking the log using
"git -C ''" and comparing the log message with
the commit message.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t0056-git-C.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
index 99c0377..1cefd4a 100755
--- a/t/t0056-git-C.sh
+++ b/t/t0056-git-C.sh
@@ -1,3 +1,4 @@
+
 #!/bin/sh
 
 test_description='"-C <path>" option and its effects on other path-related options'
@@ -81,4 +82,13 @@ test_expect_success 'Relative followed by fullpath: "-C ./here -C /there" is equ
 	test_cmp expected actual
 '
 
+test_expect_success 'Should not barf when "git -C "" cmd" is used' '
+	echo 1 > a.txt &&
+	msg="initial a.txt" &&
+	(git add a.txt && git commit -m "$msg") &&
+	echo "$msg" >expected &&
+	git -C "" log --format=%s >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.3.1.167.g7f4ba4b.dirty
