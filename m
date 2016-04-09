From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 09/16] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date: Sun, 10 Apr 2016 00:15:08 +0530
Message-ID: <1460227515-28437-10-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:46:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxtO-0003o8-Hm
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759149AbcDISpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:49 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35697 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759089AbcDISps (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:48 -0400
Received: by mail-ig0-f194.google.com with SMTP id fn8so6500844igb.2
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yeu5fZh8CHXkVdh1/ezj1ofqTWEzW0ylRHbJivHrKKk=;
        b=u+BJEY5MjGoyXQy44CvhIVd4qk/gLZ8B7pJO3nyhM1+42jTkBAAsFkFc/pFF7MZyvi
         Dn2hYqRb4llvVYKic1xBrxsQenIddW3Ce8DG7AYXi3CSuWgLXd/tUIDNw9SCW0uh1NHC
         LSyg6t/Yy6vzVtPRmas7Nm+XoRovt0+8UNKYbpKS8g/BSaWzp8c0NSx2/1DR7L9g2yQq
         F8Ca5guhihD4MjXIhohisUsCY5qWU0H6pm1gnOYncOWvCJOW5t1e4AgvCew6J8Nf8M1P
         IIKzzI8O/2fjFlQwM7pQ7ZcQVXOqSrp+6VIkqvlDbmHhZGMtMSIwC+ncE4bBPAKiaV1W
         eZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yeu5fZh8CHXkVdh1/ezj1ofqTWEzW0ylRHbJivHrKKk=;
        b=Scej3ZWvO24d11p7vkCjDdpiRFt0pvGUKeTDQ9jHeQZFlW8W8qVNTzI4sH12uj08+K
         rz9IzVVWGWVgkOaXO+8IASaVh5LJNz2CbDrQt/HgwdXJltNq4ZUbka1hGBqgxsStssJI
         1uqULDyid9okuy+VsW1i9Wl61NipeFq820VAKn0eOMDqtiDBdNIBu5sT/7Nu5caAeSyQ
         zTL8sCbqa5om9ltC5O2wtDGQaoi6VwPX/i3l/yyaSqNA/lLAXlENQBglfJTmX4GKy/oM
         u6y3hGHgca86SrjdUOxEPjuRxSd8H0PpiGTIBT6DJlgR7eHAFvTiD/3S67GpxPb3MEBu
         AXww==
X-Gm-Message-State: AD7BkJK/e2i5OBT0leyfTHxC4kRQH5CA/R0oheFwI2bpdQ9Zj/l7YT7APYDAt80P9qOTiQ==
X-Received: by 10.50.2.97 with SMTP id 1mr10414707igt.43.1460227542706;
        Sat, 09 Apr 2016 11:45:42 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:42 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291119>

The "%(symref)" atom doesn't work when used with the ':short' modifier
because we strictly match only 'symref' for setting the 'need_symref'
indicator. Fix this by using comparing with valid_atom rather than used_atom.

Add tests for %(symref) and %(symref:short) while we're here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c            |  2 +-
 t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8c97cdb..5c59b17 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -338,7 +338,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(used_atom[at].name, "symref"))
+	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
 	return at;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2c5f177..b06ea1c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -38,6 +38,7 @@ test_atom() {
 	case "$1" in
 		head) ref=refs/heads/master ;;
 		 tag) ref=refs/tags/testtag ;;
+		 sym) ref=refs/heads/sym ;;
 		   *) ref=$1 ;;
 	esac
 	printf '%s\n' "$3" >expected
@@ -565,4 +566,27 @@ test_expect_success 'Verify sort with multiple keys' '
 		refs/tags/bogo refs/tags/master > actual &&
 	test_cmp expected actual
 '
+
+test_expect_success 'Add symbolic ref for the following tests' '
+	git symbolic-ref refs/heads/sym refs/heads/master
+'
+
+cat >expected <<EOF
+refs/heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref) atom' '
+	git for-each-ref --format="%(symref)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref:short) atom' '
+	git for-each-ref --format="%(symref:short)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.8.0
