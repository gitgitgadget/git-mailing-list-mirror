From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 4/4] t1006: add tests for git cat-file --literally
Date: Wed, 15 Apr 2015 22:30:32 +0530
Message-ID: <1429117232-5102-1-git-send-email-karthik.188@gmail.com>
References: <552E9816.6040502@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 19:00:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQgG-0007qx-2g
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 19:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805AbbDORAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 13:00:45 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35215 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756803AbbDORAn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 13:00:43 -0400
Received: by pabli10 with SMTP id li10so14291647pab.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Syl0KRg1BhV6pl8q1Fb1LGqrz8MfCQ42ByuIPZqmqJo=;
        b=aqmELhoYX7LJH+54j0IgIPIm1+sCPVo7pDNPZ5S49GK+JpB5nkPPjmmF8ipmakiaBC
         SaY+xsglf5640nz1zNVZoBEsEuv+Z1uSB/wYy6cHi5s1HCgG4cVzGmlR25BtZtt5tRv4
         PcyPk6H37ohRZt0vsVGLgBBSHO41aWONDPAwPZHIat7wzGpfYpNxpruM5UAdlgIVrxKZ
         d4FSLXevkN+pGZWBtgDrOkgU4Gsay9SM4QOrRO1+wsyN4jv88NrSeEtC+K/rrkf2M8dv
         /DeBMxCjEcDso8rmE1lll1EZ3EmjiR+MTuccSNo5r1VaGgKtqd96i1K+7xQB+VN7C+SL
         kd6w==
X-Received: by 10.66.249.101 with SMTP id yt5mr48016527pac.116.1429117242960;
        Wed, 15 Apr 2015 10:00:42 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id fh9sm4679991pdb.17.2015.04.15.10.00.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Apr 2015 10:00:42 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.249.g1310741
In-Reply-To: <552E9816.6040502@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267218>

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t1006-cat-file.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ab36b1e..61fab78 100755
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
@@ -296,4 +308,21 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+bogus_type="bogus"
+bogus_content="bogus"
+bogus_size=$(strlen $bogus_content)
+bogus_sha1=$(printf $bogus_content | git hash-object -t $bogus_type --literally -w --stdin)
+
+test_expect_success "Type of broken object is correct" '
+	echo $bogus_type >expect &&
+	git cat-file -t --literally $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "Size of broken object is correct" '
+    echo $bogus_size >expect &&
+	git cat-file -s --literally $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.0.rc1.249.gb598846
