From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] t/checkout-last: checkout - doesn't work after rebase -i
Date: Mon, 10 Jun 2013 21:52:10 +0530
Message-ID: <1370881332-9231-2-git-send-email-artagnon@gmail.com>
References: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:20:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um4pd-0005MA-9P
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab3FJQUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 12:20:23 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:43208 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3FJQUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 12:20:22 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so4592061pac.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bwleMKjIWH7sfm39jfOHnaJOmn0UpCfaH7Przerscf4=;
        b=Ebe7dNcZ+WQpcSjCQRfGW092Csi8sku1udkRMHOFiviUGr1EIosUuY4d+Ugh9ejH3r
         y1RyLtBRoozM4BLus9Lz0OctgmGlIn+vzXRNkIsQPGTW1u6Yb2FrYb/f4J4dlPOYn905
         Iz2PUjh4AeoQAWP/S23Km8wQBy4DMkWvUAaPoC8k4ZskFWWUEJtLCT4Y0u0ftQEy5HtE
         4pRmmGGx89m4NxGLX98rgCDRGVPQhKeAZCruIJ3gBmfMmoOcmSP+919YHMfd7a6lDltr
         meUc1lKCGQJuH9qPwMrrEa8X5CQ9u9kE/kVW10zK03Y+CVea+i/N066LCh6OtNMTMrAa
         J3Yw==
X-Received: by 10.68.194.8 with SMTP id hs8mr2410277pbc.84.1370881222158;
        Mon, 10 Jun 2013 09:20:22 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id 6sm10895528pbn.45.2013.06.10.09.20.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 09:20:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.254.g60f9e5b
In-Reply-To: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227316>

The following command

  $ git checkout -

does not work as expected after a 'git rebase -i'.

Add a failing test documenting this bug.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t2012-checkout-last.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index b44de9d..5729487 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -116,4 +116,12 @@ test_expect_success 'master...' '
 	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
 '
 
+test_expect_failure '"checkout -" works after an interactive rebase' '
+	git checkout master &&
+	git checkout other &&
+	git rebase -i master &&
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
 test_done
-- 
1.8.3.254.g60f9e5b
