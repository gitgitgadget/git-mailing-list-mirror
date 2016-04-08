From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 08/18] Add testcase for --index-only merges with the octopus strategy
Date: Thu,  7 Apr 2016 23:58:36 -0700
Message-ID: <1460098726-5958-9-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 09:00:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQOi-0002y6-9S
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 09:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbcDHG7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:41 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36279 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757881AbcDHG7M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:12 -0400
Received: by mail-pa0-f67.google.com with SMTP id k3so4759233pav.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ld8ruYLWDuhDOIv9gsTtMJTqHPzOjcLQA61Xc+ODUhg=;
        b=AMNe3ngz4OC8/eldygjrJhyEIiNzj6ac5tkVhNtIcPyG7YekZOblzLdW7t4yECEVfz
         csREI10URJHemAL1h/00Nqlt9nwqqtNCHhm9IVQ0jXvthU8XM+31c8lA7ooaxYlpTCyk
         xGehEeTACSydGL/7cvOM/KEvcPVmUDmm0CLYbF8mK0UEArmH+bGOzDCYMQjz61OnxdJj
         LMJjsjMlcgBnkJO9GVvwV0WHXaCWage/uDC2/NC/BaXoEFRCThdZ2nTdRreC66bxX8kA
         /yBBYakZxD5mnVE0UGGptpGCjP4Kc3KO32DdhtTm8QN65coFXV5UgPxEPWGOVrrsMbGd
         VENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ld8ruYLWDuhDOIv9gsTtMJTqHPzOjcLQA61Xc+ODUhg=;
        b=dxrMcalGtM/SacoZspuP8Zf8otDDJOw1Qb17f2yleRgAplie2R2h0VF/FL3N6qs/DB
         kkGcov5AlwC+wB8wiNbCJK4ANklUuR8i9z/zCDj8pCF6G5MiaXmKZCS0wHnP9xzRpXox
         T9M5qEKT209MJFJh9CFwP6osXvfgaOr9ziQ055IQ1+/1hvJa5sxYxPmCS/XUlvNB+LdP
         DUx3Ui1Dmmo6u660i4+KytSzdAgMRTTOhUApzDV4CFPSUPBVqb/C9eyKAhGyadS6ECfC
         jTxSvvZuTkhrCOjjTYzXDnaS25DbwS+9eGOOciNgueMW6v7Agu4EhAoYfgjdhtC9nmHc
         ahbQ==
X-Gm-Message-State: AD7BkJKjN+LgZWX+sD9f0annBG8q8pEPHY5u53graM8h2JDVrQSqRwmUcArOWbRC1HRI1A==
X-Received: by 10.66.40.236 with SMTP id a12mr2351159pal.58.1460098746730;
        Thu, 07 Apr 2016 23:59:06 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:06 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291014>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-index-only.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
index 4c3c40a..b01bf79 100755
--- a/t/t6043-merge-index-only.sh
+++ b/t/t6043-merge-index-only.sh
@@ -333,4 +333,45 @@ test_expect_failure '--index-only w/ resolve, non-trivial, bare' '
 	)
 '
 
+test_expect_failure '--index-only octopus, non-bare' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	git merge --index-only -s octopus C^0 D^0 &&
+
+	test "$(git rev-list --count HEAD)" -eq 5 &&
+	test $(git rev-parse :a) != $(git rev-parse B:a) &&
+	test $(git rev-parse :a) != $(git rev-parse C:a) &&
+	test $(git rev-parse :a) != $(git rev-parse D:a) &&
+	test $(git rev-parse :b) = $(git rev-parse B:b) &&
+	test $(git rev-parse :c) = $(git rev-parse C:c) &&
+	test $(git rev-parse :d) = $(git rev-parse D:d) &&
+	test $(git hash-object a) = $(git rev-parse B:a) &&
+	test ! -f c &&
+	test ! -f d
+'
+
+test_expect_failure '--index-only octopus, bare' '
+	rm -rf bare.clone &&
+	git clone --bare . bare.clone &&
+	(cd bare.clone &&
+
+	 git update-ref --no-deref HEAD B &&
+	 git read-tree HEAD &&
+
+	 git merge --index-only -s octopus C^0 D^0 &&
+
+	 test "$(git rev-list --count HEAD)" -eq 5 &&
+	 test $(git rev-parse :a) != $(git rev-parse B:a) &&
+	 test $(git rev-parse :a) != $(git rev-parse C:a) &&
+	 test $(git rev-parse :a) != $(git rev-parse D:a) &&
+	 test $(git rev-parse :b) = $(git rev-parse B:b) &&
+	 test $(git rev-parse :c) = $(git rev-parse C:c) &&
+	 test $(git rev-parse :d) = $(git rev-parse D:d) &&
+	 test ! -f a &&
+	 test ! -f c &&
+	 test ! -f d
+	)
+'
+
 test_done
-- 
2.8.0.18.gc685494
