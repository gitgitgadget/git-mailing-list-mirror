From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 2/2] git-C: Add test to check "git -C ''"
Date: Thu,  5 Mar 2015 16:33:56 +0530
Message-ID: <1425553436-23797-1-git-send-email-karthik.188@gmail.com>
References: <1425552967-22091-1-git-send-email-karthik.188@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 12:04:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTTZg-0006uO-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 12:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbbCELEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 06:04:10 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:41957 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbbCELEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 06:04:09 -0500
Received: by pdno5 with SMTP id o5so65524596pdn.8
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 03:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bZ6ow6zzJjUtN7FUe/hmtmIOSiNXC3SQCjWVVfcE7J0=;
        b=t2p2/PPb8P/V008KBqaW2Isi8x1D0Ka1u1Y2iaiOxZYXzPgODfww0PKcK9JyTT4IKT
         9O8Oq6aYEXLeowSx2erV2VSRoHWWsfYg39dVRlhlybyz2CQsFHU6aVFdm7QVPZdfTuFN
         hBQrb1I/PjK43nmB4rhI4T9kPty6zr2vesa6GG5p+fEI/BG0R7HuPVx+49TXaFpLedUx
         vVL7lmDo7j1hhb4A1PRb8ZcvsqANSGjluAPo0Cu3VnK4IU3tWshhiCz2jT7vgs387ALW
         IfYynHESoKrxuQS/n+g29Irrw8sTAY+uzlVekHQH9+XAo/fiDoRsVmhpb/D51aQG9BN4
         3ESQ==
X-Received: by 10.66.124.227 with SMTP id ml3mr15183272pab.28.1425553448774;
        Thu, 05 Mar 2015 03:04:08 -0800 (PST)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id dp4sm6608531pdb.66.2015.03.05.03.04.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2015 03:04:08 -0800 (PST)
X-Mailer: git-send-email 2.3.1.169.g2532f2d.dirty
In-Reply-To: <1425552967-22091-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264831>

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
