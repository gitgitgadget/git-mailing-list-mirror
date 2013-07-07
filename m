From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 21/22] update-index.c: rewrite index when index-version is given
Date: Sun,  7 Jul 2013 10:11:59 +0200
Message-ID: <1373184720-29767-22-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:14:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk6b-0006rv-Hb
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185Ab3GGINs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:48 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:64213 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab3GGINo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:13:44 -0400
Received: by mail-ee0-f51.google.com with SMTP id e52so2140022eek.38
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SrYGXECGQzv7fBv/ttJMuQ+QHgsIAD1JBsUyTjTFxYo=;
        b=wYJLH8vP7rUpgbC0ia9LibboPWJ12Z3z3R939ek3i8sPUR0xKX3CaxXAtMbFTaYbAO
         Y+F16dVv3WabT0il3IclSVHbMo60byUMEqZ3J/zDMIdGc8hY57/ZFoFO38OArryaI5tv
         iB/PwZmuax9n1zZ/kcwd1kE+LwyLM/X78QvpPtkq0thkdhaqaJkbTNeI7uyK0dLqjzvD
         VzfXzstiNVjvXcSJEIWXX9+1UArx5b6revgSQyKeY9SND1E2VeCo2VUxmmuD7Qy3/4Ad
         B3HOARi7Om5tInOUpSJkzMtkf9ZE7Mx7TuL9TuG0bjbzVVMYii53BUxxCNhBbNJAU75i
         k2dQ==
X-Received: by 10.14.2.73 with SMTP id 49mr19454782eee.118.1373184822762;
        Sun, 07 Jul 2013 01:13:42 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id n42sm30655439eeh.15.2013.07.07.01.13.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:13:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229752>

Make update-index always rewrite the index when a index-version
is given, even if the index already has the right version.
This option is used for performance testing the writer and
reader.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 03f6426..7954ddb 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "cache-tree.h"
+#include "read-cache.h"
 #include "tree-walk.h"
 #include "builtin.h"
 #include "refs.h"
@@ -863,8 +864,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    preferred_index_format,
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
 
-		if (the_index.version != preferred_index_format)
-			active_cache_changed = 1;
+		active_cache_changed = 1;
 		the_index.version = preferred_index_format;
 	}
 
-- 
1.8.3.453.g1dfc63d
