From: Brian Bourn <ba.bourn@gmail.com>
Subject: [PATCH v3 2/2][GSoC] diff-no-index: replace manual "."/".." check with is_dot_or_dotdot()
Date: Wed, 19 Mar 2014 11:58:22 -0400
Message-ID: <1395244702-659-2-git-send-email-ba.bourn@gmail.com>
References: <1395244702-659-1-git-send-email-ba.bourn@gmail.com>
Cc: Brian Bourn <ba.bourn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 16:58:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQItJ-0003U4-8i
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 16:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759303AbaCSP6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 11:58:45 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:45215 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759279AbaCSP6o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 11:58:44 -0400
Received: by mail-ob0-f172.google.com with SMTP id wm4so8352888obc.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F6rq5jS1J5Tf5LmSbiY+K+DTR3kREOo0BkWG1z+8NNM=;
        b=h9uQDhGmXjhsRfOHjanOyeWpMJlboFsWDQ3qsxjgR+5tYzI8DHKoMzTmbwn6xz2XAp
         tqGTpczC3uS3pJRDN36z/+a4PKukdBmMQK+rh3iYEto13fhECigJDcfUPaR/m7lTqs4v
         nQu8hnSdbKu4blVT/FzBTIPHrAWwnLJFrA7YZxPYqSfoeB8EDOd1jNgJuWxIivDYBUNU
         YHxzBE6UIIPLaQjPyg4boGwSFpWf2jsgzGpEaq9IeFvdNaz2mkEBR1z3DOahIjhkpIqD
         cvhV6D4Muu9S9Ae9F0WUwqpGi/LD19MX4j7W6c12osiuWrF5b7APj1leedHoQEUzE4vB
         6RvQ==
X-Received: by 10.182.156.19 with SMTP id wa19mr997601obb.80.1395244723585;
        Wed, 19 Mar 2014 08:58:43 -0700 (PDT)
Received: from localhost.localdomain (230.sub-70-196-198.myvzw.com. [70.196.198.230])
        by mx.google.com with ESMTPSA id m7sm38196053obo.7.2014.03.19.08.58.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Mar 2014 08:58:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395244702-659-1-git-send-email-ba.bourn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244457>

Signed-off-by: Brian Bourn <ba.bourn@gmail.com>
---
Part 2 of my submission for GSoC
 diff-no-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index ec51106..c554691 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -15,6 +15,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "string-list.h"
+#include "dir.h"
 
 static int read_directory_contents(const char *path, struct string_list *list)
 {
@@ -25,7 +26,7 @@ static int read_directory_contents(const char *path, struct string_list *list)
 		return error("Could not open directory %s", path);
 
 	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+		if (!is_dot_or_dotdot(e->d_name))
 			string_list_insert(list, e->d_name);
 
 	closedir(dir);
-- 
1.9.0
