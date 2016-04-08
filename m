From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 10/18] Add testcase for --index-only merges with the subtree strategy
Date: Thu,  7 Apr 2016 23:58:38 -0700
Message-ID: <1460098726-5958-11-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 09:00:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQOe-0002y6-Pt
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 09:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757877AbcDHG7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:12 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35443 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757864AbcDHG7J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:09 -0400
Received: by mail-pa0-f67.google.com with SMTP id zy2so8473038pac.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0IiwNQtzNVd1lTh6yhT70z/zDm4LTV0CWZPh7TDM65A=;
        b=eg2ZhPI6G1AZSnzv/brtk2kimEn1gAa7QkuAAKd0hbkBrdt8eGVy+8TYBezL4lAEMy
         seuHlFwdlQcn9dSKCRiizlGCJp15ex8Kw6JgElyGEH4a+DcHHx0nihVMpQNv7ZesTzqU
         nZHCKiW8Z4KfH/nlIxBQ1+h0WBcHiY0DkkrnshRxg2x8diq4aneV/E0/w7jsXjnjU/Zz
         X+JgDYUuT/sdhSpdJ75rnDfsAJ5b/tqn+QPCGvpmZJhVck5FK0bLC+OPkBFUNrUa4s+l
         eLHlhKb4PAYj+Alk9Toj+I03MqIOykoPlpKrcEDlKs3dOAH1HkHDFo7avOwIm9d6amNE
         A8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0IiwNQtzNVd1lTh6yhT70z/zDm4LTV0CWZPh7TDM65A=;
        b=Ybv8u6WH8nD3LYwe4A443TsMOcdlR0HnbQDQslsp9TpMCaiGwZcnEKajO8mEdjvF6j
         0PRsJ7hWY0+e1MHDq3iYx+VO3/LiBbHYDpt0p4drh/zukpeUauTvojUiFIp7iaK+zm12
         8Ck9cGq7duqzJhH1wSKatYjl70S7lqChaJ5UUkEL4TeJSq9yd07aBdQZRloXbDkXzCoz
         cstrm5fQ5wM9zrPBxKSpzG8TZlc1pMbaw1pM/MuIFLRggWH6LXQtvtZiAo1UNiPsZl1s
         T4DbSfIfxKPVLsM0igZqo0TFeFCGWQKhb2/fxAZ1lrKupGJBb616vIGqUeXYsqwg/uTv
         Ni7Q==
X-Gm-Message-State: AD7BkJIkEsHsgUsMldQr0ZNl4fhBFK0ZvtVnM9x2qqpAs4/LHmWmHLeNYrFmU5E+bQLRXQ==
X-Received: by 10.66.102.104 with SMTP id fn8mr10518125pab.129.1460098748740;
        Thu, 07 Apr 2016 23:59:08 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:08 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291012>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-index-only.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
index 84c6640..5eda6b3 100755
--- a/t/t6043-merge-index-only.sh
+++ b/t/t6043-merge-index-only.sh
@@ -406,4 +406,38 @@ test_expect_failure '--index-only ours, bare' '
 	)
 '
 
+test_expect_failure '--index-only subtree, non-bare' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	git merge --index-only -s subtree E^0 &&
+
+	test "$(git rev-list --count HEAD)" -eq 4 &&
+	test $(git rev-parse :a) = $(git rev-parse B:a) &&
+	test $(git rev-parse :b) = $(git rev-parse B:b) &&
+	test $(git rev-parse :e) = $(git rev-parse E:subdir/e) &&
+	test ! -d subdir &&
+	test ! -f e
+'
+
+test_expect_failure '--index-only subtree, bare' '
+	rm -rf bare.clone &&
+	git clone --bare . bare.clone &&
+	(cd bare.clone &&
+
+	 git update-ref --no-deref HEAD B &&
+	 git read-tree HEAD &&
+
+	 git merge --index-only -s subtree E^0 &&
+
+	 test "$(git rev-list --count HEAD)" -eq 4 &&
+	 test $(git rev-parse :a) = $(git rev-parse B:a) &&
+	 test $(git rev-parse :b) = $(git rev-parse B:b) &&
+	 test $(git rev-parse :e) = $(git rev-parse E:subdir/e) &&
+	 test ! -d subdir &&
+	 test ! -f a &&
+	 test ! -f e
+	)
+'
+
 test_done
-- 
2.8.0.18.gc685494
