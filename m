From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 5/5] t1006: add tests for git cat-file --allow-unkown-type
Date: Wed, 29 Apr 2015 18:24:25 +0530
Message-ID: <1430312065-23443-1-git-send-email-karthik.188@gmail.com>
References: <5540D397.8020104@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 14:54:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnRVq-0005X3-Ii
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 14:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422884AbbD2Myq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 08:54:46 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33137 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422883AbbD2Myp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 08:54:45 -0400
Received: by pdbnk13 with SMTP id nk13so27614962pdb.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5gFxqtqLLssuM1T9TJjTEVpy4rOsqNR1HV/6YboePk=;
        b=r2M4f6E4US+akcgPDElqJS/4rJO/X0OoTp4YkT3e2yn4krOiBThAmGR2xutOwShjtJ
         t6NvJW+i4Oc34gB4rjVjA+Or/YFauxVXLdh2xwCGuM5r6nCaWo7IJMoHslGM3BPNF9e7
         jGtZETzlx7gTlPEkdsI1Nw+ps81k7QMbGNyUTkcwlFqq1mZA1yD8B2mwtv21h223xci8
         t5QylSB4nCfJDsKLfo+M/hHj8XtdW+XvfeFKs3tKjDq8SJkLKipXPyMIw6dR/LCRvq53
         YvThcYd/sOCXVefpUYZtjJ2PQnc52aAXrSspfygPSEv+4AcWxvOpKBJScSSvACiqOQk7
         X0/g==
X-Received: by 10.68.57.143 with SMTP id i15mr42001455pbq.9.1430312085340;
        Wed, 29 Apr 2015 05:54:45 -0700 (PDT)
Received: from ashley.localdomain ([182.48.234.2])
        by mx.google.com with ESMTPSA id da3sm25468343pdb.8.2015.04.29.05.54.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Apr 2015 05:54:44 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.250.g565e85b
In-Reply-To: <5540D397.8020104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267964>

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t1006-cat-file.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ab36b1e..8362019 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -47,6 +47,18 @@ $content"
 	test_cmp expect actual
     '
 
+    test_expect_success "Type of $type is correct using --allow-unkown-type" '
+	echo $type >expect &&
+    git cat-file -t --allow-unkown-type $sha1 >actual &&
+	test_cmp expect actual
+    '
+
+    test_expect_success "Size of $type is correct using --allow-unkown-type" '
+	echo $size >expect &&
+    git cat-file -s --allow-unkown-type $sha1 >actual &&
+	test_cmp expect actual
+    '
+
     test -z "$content" ||
     test_expect_success "Content of $type is correct" '
 	maybe_remove_timestamp "$content" $no_ts >expect &&
@@ -296,4 +308,21 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+bogus_type="bogus"
+bogus_content="bogus"
+bogus_size=$(strlen "$bogus_content")
+bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
+
+test_expect_success "Type of broken object is correct" '
+	echo $bogus_type >expect &&
+    git cat-file -t --allow-unkown-type $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "Size of broken object is correct" '
+	echo $bogus_size >expect &&
+    git cat-file -s --allow-unkown-type $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.0.rc1.250.g565e85b
