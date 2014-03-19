From: Andrei Dinu <mandrei.dinu@gmail.com>
Subject: [PATCH v2] diff-no-index.c : rewrite read_directory() to use is_dot_or_dotdot().
Date: Wed, 19 Mar 2014 15:29:13 +0200
Message-ID: <1395235753-3285-1-git-send-email-mandrei.dinu@gmail.com>
Cc: Andrei Dinu <mandrei.dinu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 14:29:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQGZ1-0005bq-TE
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 14:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbaCSN3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 09:29:43 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:33176 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964989AbaCSN3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 09:29:42 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so6633732eek.13
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7v9Ci6M1NQYCUDkEhMLvaT9jutLlv1jreRH8OZvBMNM=;
        b=KoglA7LYLT8vTpA7oS12UFj7/nQuOUnqnYrZRet/YKWAjyMDi3jW9EUfENGVVFUZi4
         Qls/PRJVivAQpc418W0YZVI79Kihp/j/Z3Nnnb/SpKtMwKRmZqXqTXAgQMnAD8lLBNOk
         QBPSYpKWSz7QBEBQDq4n95sdC+rRq2fhsluQ3a2ll6r4jz7MtaYAs2Cyq5AxeEDICnn5
         E59BgJF3sfvwYDfs8UAp26y1nvQKY2GtaPPclukXJ14fY1BgHJF1vU8Eakzsz+zx4njJ
         szG1wDmEAPdUhx7/YHikTzeLN3pqhRJjnOEl22FvDtxKRyCGtzXN/hgVqhbICKs3aiK4
         sdUw==
X-Received: by 10.14.126.73 with SMTP id a49mr36198805eei.46.1395235781729;
        Wed, 19 Mar 2014 06:29:41 -0700 (PDT)
Received: from localhost.localdomain (p5.eregie.pub.ro. [141.85.0.105])
        by mx.google.com with ESMTPSA id w6sm54724616eex.9.2014.03.19.06.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 06:29:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244445>

replace manual "."/".." check with is_dot_or_dotdot().

choose to implement my own function because did't find the defined one.

[1]: http://article.gmane.org/gmane.comp.version-control.git/244420

Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>


---
 I plan on applying to GSoc 2014

 diff-no-index.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 83cdbf7..d91ea3b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -19,10 +19,10 @@
 static int is_dot_or_dotdot(const char *path)
 {
     if (path[0] == '.' && path[1] == '\0')
-        return 0;
+        return 1;
     else if (path[0] == '.' && path[1] == '.' && path[2] == '\0')
-        return 0;
-    return 1;
+        return 1;
+    return 0;
 }
 
 static int read_directory(const char *path, struct string_list *list)
@@ -34,7 +34,7 @@ static int read_directory(const char *path, struct string_list *list)
 		return error("Could not open directory %s", path);
 
 	while ((e = readdir(dir)))
-		if (is_dot_or_dotdot(e->d_name))
+		if (!is_dot_or_dotdot(e->d_name))
 			string_list_insert(list, e->d_name);
 
 	closedir(dir);
-- 
1.7.9.5
