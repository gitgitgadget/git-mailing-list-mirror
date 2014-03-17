From: Hiroyuki Sano <sh19910711@gmail.com>
Subject: [PATCH 2/3][GSOC] diff: use is_dot_or_dotdot() instead of strcmp()
Date: Tue, 18 Mar 2014 06:30:24 +0900
Message-ID: <1395091825-8330-2-git-send-email-sh19910711@gmail.com>
References: <1395091825-8330-1-git-send-email-sh19910711@gmail.com>
Cc: Hiroyuki Sano <sh19910711@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 22:30:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPf7V-0005NI-AA
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 22:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbaCQVam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 17:30:42 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:61088 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbaCQVal (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 17:30:41 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so6293220pbb.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6QAkwX13POwjOp1ZR/KWOASt/2MZcIc5YxBHPkxF6c=;
        b=p9zrS/n/WD7W8jhVDKn8h+Gy/OgQHN/NoQ9FJu14h0NFBxYp16UCkj4fFCoWQgccql
         sS9wCBAbmAsXoBPMLdK73ai3V2a933HimYYWdZLdqcGKAH1G/rpQNCnc503vG+8yN4ya
         GcMwuE0AFDIQ3hvDrCylYSiBkhdTbWQYii/CSVDyB9gsMkqnYRIJ5oHNTl19/uw9fMkN
         JeWjBg0yWgWNrv+yYscFhT2EXgNL54P6K0rgnI8OYbVlYOZzX42hV8vSRL20m5k3dQnj
         q7WwOIxj55MldG0bPPrYSCGH9fjbqs0g3ReHMzQKVuTo5q8fBik7DkH1gaYl2nr/IJa1
         qJuw==
X-Received: by 10.68.136.133 with SMTP id qa5mr28350265pbb.63.1395091840602;
        Mon, 17 Mar 2014 14:30:40 -0700 (PDT)
Received: from localhost (ntfkok023001.fkok.nt.adsl.ppp.infoweb.ne.jp. [218.217.179.1])
        by mx.google.com with ESMTPSA id my6sm46155277pbc.36.2014.03.17.14.30.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Mar 2014 14:30:39 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395091825-8330-1-git-send-email-sh19910711@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244287>

The is_dot_or_dotdot() is used to check if the string is either "." or "..".

Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
---
 diff-no-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 1ed5c9d..ccd9270 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -11,6 +11,7 @@
 #include "tag.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "dir.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
@@ -25,7 +26,7 @@ static int get_directory_list(const char *path, struct string_list *list)
 		return error("Could not open directory %s", path);
 
 	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+		if (!is_dot_or_dotdot(e->d_name))
 			string_list_insert(list, e->d_name);
 
 	closedir(dir);
-- 
1.9.0
