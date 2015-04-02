From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 4/4] t1006: add tests for git cat-file --literally
Date: Thu,  2 Apr 2015 16:30:35 +0530
Message-ID: <1427972435-15682-1-git-send-email-karthik.188@gmail.com>
References: <551D1F99.5040306@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 13:01:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydcrq-0002Na-J4
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 13:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbbDBLAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 07:00:54 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36330 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbbDBLAy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 07:00:54 -0400
Received: by pdea3 with SMTP id a3so34863714pde.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 04:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MbFUOqAfB60zFtRSd93rzKBGCCDXYos9/4zZn3hi8Ts=;
        b=tH3XBGZrIps4ierP1neBOXYZu9OsAnmm03HxpK8mE477C2GhbF7gBdAHApnhnAcaXy
         1Vg5UgHXnWxYdkP1wld5sePHC2FyMYzSbPA7ImHUdLIt3fzsbPNgGsyOM+Ohnm35yCza
         iZMfJ3d03lXFzv5xKOqt6I1EFaXLnAmLN4i8e/CeaIViZf8V7V7PuoKeArRe/5t4TJPY
         AxvGNPecS3scoTNk17K9jEng19VLtk/dRWlVcPMbvW9BojmJHUtkYvB8bDJqw/B9vHAJ
         D4ixPiSa6Ha/HY5C9SZ6LSQe+7/hf5eW1gTh8Z1AC+VK8aq0bIw6pl6pVboiltVKthcW
         d61w==
X-Received: by 10.66.154.111 with SMTP id vn15mr24974240pab.59.1427972453678;
        Thu, 02 Apr 2015 04:00:53 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id fc3sm4891542pdb.22.2015.04.02.04.00.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2015 04:00:53 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.172.g04a1281
In-Reply-To: <551D1F99.5040306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266638>

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t1006-cat-file.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index a72e700..3015062 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -47,6 +47,18 @@ $content"
 	test_cmp expect actual
     '
 
+    test_expect_success "Type of $type is correct using --literally" '
+	echo $type >expect &&
+	git cat-file -t --literally $sha1 >actual &&
+	test_cmp expect actual
+    '
+
+    test_expect_success "Size of $type is correct using --literally" '
+	echo $size >expect &&
+	git cat-file -s --literally $sha1 >actual &&
+	test_cmp expect actual
+    '
+
     test -z "$content" ||
     test_expect_success "Content of $type is correct" '
 	maybe_remove_timestamp "$content" $no_ts >expect &&
@@ -296,4 +308,19 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+bogus_type="bogus"
+bogus_sha1=$(git hash-object -t $bogus_type --literally -w --stdin </dev/null)
+
+test_expect_success "Type of broken object is correct" '
+	echo $bogus_type >expect &&
+	git cat-file -t --literally $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "Size of broken object is correct" '
+	echo "0" >expect &&
+	git cat-file -s --literally $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.3.1.172.g04a1281
