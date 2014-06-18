From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 3/5] unpack-trees.c: remove name_compare() function
Date: Wed, 18 Jun 2014 11:45:15 -0700
Message-ID: <1403117117-10384-4-git-send-email-jmmahler@gmail.com>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 20:46:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxKsJ-0007SQ-U6
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 20:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbaFRSqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 14:46:12 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:44886 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaFRSqI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 14:46:08 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so1035051pad.9
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B3Ry6gg64Sp7SuqOsNVnMN8KCdHnLTGdetVtCREmpOQ=;
        b=F90Lfcrh9KcTc/1sqjuvkii4IQWG7gX5BSD0+8PVGYczEo6YmMKPvM8XWmhi3TX3nE
         VyL5aMI3FNF7lWVHhkkx95N30Xi3gWAZtnhe0VrbaZXtNDHbKGiINTZ2MCRzDJFehbe5
         XNZFevec2UaVlpw22zhPz/yAPmKFOEKScGQI/4VTVlKU6vgRQ7+tZfAZjbhA/IkG7KsF
         11s81O4xXZzKlJaTxtPFtSYIEGJ4FPytklyJqbBBfeTWNMb4/9cwVbq0a5hCHpvOBovz
         0pPcFXTyvuhm8tRWA9LeH5yYBKMqbnDy8avqLK8xtQQrOx9SWstlf5AbGgryD6gtOqzo
         AELg==
X-Received: by 10.68.102.3 with SMTP id fk3mr4414592pbb.95.1403117168063;
        Wed, 18 Jun 2014 11:46:08 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id jq6sm4647227pbb.76.2014.06.18.11.46.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jun 2014 11:46:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.697.g57b47e0
In-Reply-To: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252024>

Remove the duplicate name_compare() function and use the one provided by
read-cache.c.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---

Notes:
    There is one small difference between the old function and the new one.
    The old one returned -N and +N whereas the new one returns -1 and +1.
    However, there is no place where the magnitude was needed, so this
    change will not alter its behavior.

 unpack-trees.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4a9cdf2..c4a97ca 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -629,17 +629,6 @@ static int unpack_failed(struct unpack_trees_options *o, const char *message)
 	return -1;
 }
 
-/* NEEDSWORK: give this a better name and share with tree-walk.c */
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
 /*
  * The tree traversal is looking at name p.  If we have a matching entry,
  * return it.  If name p is a directory in the index, do not return
-- 
2.0.0
