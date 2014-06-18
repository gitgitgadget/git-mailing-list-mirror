From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 2/5] tree-walk.c: remove name_compare() function
Date: Wed, 18 Jun 2014 11:45:14 -0700
Message-ID: <1403117117-10384-3-git-send-email-jmmahler@gmail.com>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 20:46:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxKsY-0007kX-4H
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 20:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbaFRSqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 14:46:06 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34377 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbaFRSqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 14:46:05 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so963774pdi.13
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YiDC6oDB1/dJ28fsnB3McmjGlyV4Us+Z/935bTEhBqQ=;
        b=JWQBP80JTCkZwnxUmsdvyn8yaATLjaU5Db4mYxAWYN95QXlrCjjVpoeP3dhKEqthZU
         hgErWf8LeCq7cyEGtjsc/17WAEkSQDeVAxJ9qfc+r1VRkjHKFd06Bno4pw/8GfzvjC/w
         W3sn4dn+M3GxjOo0v9y6+jkkfwlPpk0tYXWiWw5le83AfKXOUTSisgpK7Fu588XT/Nkg
         dWaOwuKyMRsvO23uhhm/dVL/NtExysuhnmzViHE5O9zcJjr91gc5G3ILfEmo9hgnpAxw
         jBx+DjwZ3HbN87XG7ZoTbPxSWfreJlSPosx002b7pPXFnwuHay4/BybYeD5RO95fPheO
         dJrQ==
X-Received: by 10.68.231.7 with SMTP id tc7mr40627pbc.32.1403117164446;
        Wed, 18 Jun 2014 11:46:04 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id iz2sm4640281pbb.95.2014.06.18.11.46.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jun 2014 11:46:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.697.g57b47e0
In-Reply-To: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252025>

Remove the duplicate name_compare() function and use the one provided by
read-cache.c.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---

Notes:
    There is one small difference between the old function and the new one.
    The old one returned -N and +N whereas the new one returns -1 and +1.
    However, there is no place where the magnitude was needed, so this
    change will not alter its behavior.

 tree-walk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 4dc86c7..5dd9a71 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -144,16 +144,6 @@ struct tree_desc_x {
 	struct tree_desc_skip *skip;
 };
 
-static int name_compare(const char *a, int a_len,
-			const char *b, int b_len)
-{
-	int len = (a_len < b_len) ? a_len : b_len;
-	int cmp = memcmp(a, b, len);
-	if (cmp)
-		return cmp;
-	return (a_len - b_len);
-}
-
 static int check_entry_match(const char *a, int a_len, const char *b, int b_len)
 {
 	/*
-- 
2.0.0
