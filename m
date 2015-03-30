From: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: [PATCH/RFC 4/4] t0102: add tests for '-' notation
Date: Mon, 30 Mar 2015 13:41:55 -0400
Message-ID: <1427737315-7229-5-git-send-email-kenny.lee28@gmail.com>
References: <1427737315-7229-1-git-send-email-kenny.lee28@gmail.com>
Cc: gitster@pobox.com, Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 19:43:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycdi9-0002zy-Gu
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 19:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbbC3Rmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 13:42:38 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35097 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbbC3Rme (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 13:42:34 -0400
Received: by ierf6 with SMTP id f6so57039093ier.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MWVjOU8AU0EAn+jvpxfipG8PJA31JYrLfEPR62TxR6U=;
        b=XKi7iDQVWTVCtW6Nw4n4WYl+LqGLwy3kG6HuCOr9Hp+YZeA0KUJD3XllPxY963xIYB
         JMbwsUnkkqNJw/inXTs/cUqIUElOVqkIabf1Dcbo6oFwnF4LayJTJ4SV3IUF1cBVlYG9
         gfDb+XPQqtyXXGirNF08IEvIyNsNmkQSb0hU2+uYHGKeyreLjFRIa/On/a+PHmYCsnhv
         xwTgP8q1qMDLkh0+4ubwBRDzOFPkkC/gHA8mzxNgEUNqTrqY8uxRo8RZpC+WS8omhOhf
         suHkvlwEVnTuxCVZk2GMGPs7kGm4ZzOya9KjMnZOhbXRszKC/L8bGghiq7E2j+pc51Q4
         JzSw==
X-Received: by 10.50.73.99 with SMTP id k3mr19293598igv.21.1427737353867;
        Mon, 30 Mar 2015 10:42:33 -0700 (PDT)
Received: from fujitsu.wireless.concordia.ca ([132.205.236.26])
        by mx.google.com with ESMTPSA id x9sm8246356igl.2.2015.03.30.10.42.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Mar 2015 10:42:33 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.203.g8ffb468.dirty
In-Reply-To: <1427737315-7229-1-git-send-email-kenny.lee28@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266467>

Signed-off-by: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
---
 t/t0102-previous-shorthand.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 t/t0102-previous-shorthand.sh

diff --git a/t/t0102-previous-shorthand.sh b/t/t0102-previous-shorthand.sh
new file mode 100644
index 0000000..919b055
--- /dev/null
+++ b/t/t0102-previous-shorthand.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='previous branch syntax @{-n}'
+
+. ./test-lib.sh
+
+test_expect_success 'branch -d -' '
+	test_commit A &&
+	git checkout -b junk2 &&
+	git checkout - &&
+	test "$(git symbolic-ref HEAD)" = refs/heads/master &&
+	git branch -d - &&
+	test_must_fail git rev-parse --verify refs/heads/junk2
+'
+
+test_expect_success 'merge -' '
+	git checkout A &&
+	test_commit B &&
+	git checkout A &&
+	test_commit C &&
+	test_commit D &&
+	git branch -f master B &&
+	git branch -f other &&
+	git checkout other &&
+	git checkout master &&
+	git merge - &&
+	git cat-file commit HEAD | grep "Merge branch '\''other'\''"
+'
+
+test_expect_success 'merge -~1' '
+	git checkout master &&
+	git reset --hard B &&
+	git checkout other &&
+	git checkout master &&
+	git merge -~1 &&
+	git cat-file commit HEAD >actual &&
+	grep "Merge branch '\''other'\''" actual
+'
+
+test_done
-- 
2.3.3.203.g8ffb468.dirty
