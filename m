From: Andrei Dinu <mandrei.dinu@gmail.com>
Subject: [PATCH 2/2] diff-no-index.c: read_directory_path() use is_dot_or_dotdot()
Date: Fri, 21 Mar 2014 21:02:31 +0200
Message-ID: <1395428551-7769-1-git-send-email-mandrei.dinu@gmail.com>
Cc: Andrei Dinu <mandrei.dinu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 20:02:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR4iI-0000L5-60
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 20:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbaCUTCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 15:02:37 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:50587 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbaCUTCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 15:02:36 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so2163851eek.13
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jNc05vjKmRIdDnXVXtQ/fc4Kbic/+oK4cKQDT1gTyCc=;
        b=rXq061eHvSRUP1tPx8cusF/eCCjKFZ3WplRov4p4V8r5UIsOrhqb5iniXO7o7dW2+4
         Wg3RZGsYtAejRYcgjF4haibHAOfBvbgzVsoWLVnwQRdZisdlGrswC4bwvWTEMVE70/KD
         FenVNPvwPDuaFexcNx4eps+5/UcJkPmk8xhpmfYcaVfUaXjHJsovmBTXWNtvOo460v3/
         MnW0ks5D9YEcqRbs6UCgpzBhugZ9RP4tg6ixBX0B8TLb4Po56gaQz2NySdNhN8O4AJus
         bmx/s15PyL4D82Fm8bufZxQmTtf/rOIdjGxW4BGXQuwiT8i9O37NgTLHGuI/v2Qzpd71
         M4PA==
X-Received: by 10.15.49.65 with SMTP id i41mr17066681eew.87.1395428555308;
        Fri, 21 Mar 2014 12:02:35 -0700 (PDT)
Received: from andrei-K52JT.pub.ro ([141.85.219.2])
        by mx.google.com with ESMTPSA id bc51sm13487019eeb.22.2014.03.21.12.02.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 12:02:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244727>

Use is_dot_or_dotdot() instead of manually checking against "." or "..".

Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>

---

 You can check the last version here: 

 http://thread.gmane.org/gmane.comp.version-control.git/244578

 I received the feedback and make the changes.

 I plan on applying to GSoC 2014

 diff-no-index.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 5e4a76c..2d1165f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -15,6 +15,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "string-list.h"
+#include "dir.h"
 
 static int read_directory_path(const char *path, struct string_list *list)
 {
@@ -25,7 +26,7 @@ static int read_directory_path(const char *path, struct string_list *list)
 		return error("Could not open directory %s", path);
 
 	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+		if (!is_dot_or_dotdot(e->d_name))
 			string_list_insert(list, e->d_name);
 
 	closedir(dir);
-- 
1.7.9.5
