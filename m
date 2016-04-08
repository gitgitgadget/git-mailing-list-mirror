From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 06/18] Add testcase for --index-only merges needing an ff update
Date: Thu,  7 Apr 2016 23:58:34 -0700
Message-ID: <1460098726-5958-7-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 09:00:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQOf-0002y6-Cn
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 09:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbcDHG7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33350 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757867AbcDHG7K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id e190so8853473pfe.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pZ2g5zTEkf7/z46zacMuO6mfrP+M4cN3C5J2FgMHJMM=;
        b=t8MaA/Dre60nFCajjfKl0V3wDmx+dCq2En0ZHI6PNdnYfCw6Qf28uO7fLTRSTTceUn
         OLt4/7wEH/fncQ4JOwa3GaZv78vmtp1ruCncx3om8oCAmmfmVBFQwn/gauoivQfr7ClV
         RoDo7u4cuom0d/afgyR7ELwwEyoce2CJ1OUahOkzIyYn1I1yaVVDHUHvqEAHH42hgRr/
         MEL99Fhnmc0HNGUAdb70BcI6CqPsKaNwgDhNLN9EkJ9LU4V7kMnlr1A/w0ldt5T0HL98
         SgnMwuDFR0N/nXlAqMd10KSCabK1dr3n9wIv47y80EAGxUfsEUtnD08nRJEy5W1bm05D
         ZggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pZ2g5zTEkf7/z46zacMuO6mfrP+M4cN3C5J2FgMHJMM=;
        b=nOZiAaKCRmKanddDGOcqkAFtPfnoINoRk70eWpHP/yvAnYHKnSK2uGO4r7opKISH6D
         jKUlvDPHleeD5DJGVxZiOxhEdBAeeYT4Q9DdWrPrqB85fajuq1UCVqFP3Oe7KG+Xf/Xi
         3dBrjGbj73K2AJ5f+xvD2DRZaa5gKk3cHnkKmbrqGpRwIvWP31I6WMr6y8/eNSdz5+ld
         Rya9RuN4nuu9qs1KsdmdQoYIsxvnGiyX14IG51XbYJRz9/i3HKAM+5gfdcXwn7zL0xgL
         mOBCdC4zjsqVT+WKH+e84uS7IrSb40AN0NKle/b/it9UsAmf82ZyQXlJGNmjgMAtefTr
         Hybw==
X-Gm-Message-State: AD7BkJLhFA8PvfxNB3vfLgVwTLk59nM0aaKYRmnpkkRW6SyRQwDECxwafQ1oupoBv/HWZQ==
X-Received: by 10.98.33.74 with SMTP id h71mr10345345pfh.157.1460098744535;
        Thu, 07 Apr 2016 23:59:04 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:03 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291009>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-index-only.sh | 70 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
index b8b22ab..67c8e92 100755
--- a/t/t6043-merge-index-only.sh
+++ b/t/t6043-merge-index-only.sh
@@ -167,4 +167,74 @@ test_expect_failure 'recursive --index-only in bare repo' '
 	)
 '
 
+# Testcase for a simple ff update
+#   A
+#   o-----o E
+#
+#   Commit A: some file a
+#   Commit E: renames a->subdir/a, adds subdir/e
+
+test_expect_success 'setup simple ff update' '
+	git reset --hard &&
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	seq 1 10 >a &&
+	git add a &&
+	test_tick && git commit -m A &&
+
+	git branch A &&
+	git branch E &&
+
+	git checkout E &&
+	mkdir subdir &&
+	git mv a subdir/a &&
+	echo e >subdir/e &&
+	git add subdir &&
+	test_tick && git commit -m E
+'
+
+test_expect_failure '--index-only ff update, non-bare' '
+	git reset --hard &&
+	git checkout A^0 &&
+
+	git merge --index-only --ff-only E^0 &&
+
+	git diff --staged --exit-code E &&
+	test $(git hash-object a) = $(git rev-parse A:a) &&
+	test ! -d subdir
+'
+
+test_expect_failure '--index-only ff update, bare' '
+	git clone --bare . bare.clone &&
+	(cd bare.clone &&
+
+	 git update-ref --no-deref HEAD A &&
+	 git read-tree HEAD &&
+
+	 git merge --index-only --ff-only E^0 &&
+
+	 git diff --staged --exit-code E &&
+	 test ! -f a &&
+	 test ! -d subdir
+	)
+'
+
+test_expect_failure '--index-only ff update, non-bare with uncommitted changes' '
+	git clean -fdx &&
+	git reset --hard &&
+	git checkout A^0 &&
+
+	touch random_file && git add random_file &&
+
+	git merge --index-only --ff-only E^0 &&
+
+	test_must_fail git rev-parse HEAD:random_file &&
+	test "$(git diff --name-only --cached E)" = "random_file" &&
+	test $(git hash-object a) = $(git rev-parse A:a) &&
+	test ! -d subdir
+'
+
 test_done
-- 
2.8.0.18.gc685494
