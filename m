From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 21/24] update-index.c: rewrite index when index-version is given
Date: Sun, 18 Aug 2013 21:42:10 +0200
Message-ID: <1376854933-31241-22-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:49:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8yc-0004Nx-WA
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072Ab3HRTtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:49:23 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:45132 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab3HRTtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:49:22 -0400
Received: by mail-wi0-f181.google.com with SMTP id en1so2347522wid.14
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bOKJ54kOn2MJLnznXZtZYsi1jWi5rl+qZ87SrBl1/HE=;
        b=prjsv/ZtfOi/zFYLpvWkD7bupgXu2Ba0g03BJQN3vGx4js6UK0Tb6ut5gjbxctK+1Q
         /vT0JoskwBO+pDTmLX2kM8sMy1kirAgYaATEMi5mDTMH1OZbvXjAS6hxQFuoywAw9rA6
         LZcJXvXbDK2RavsRWNk8sTzi2W/WIBzNcag81/ZJ6AXuoi7CUs/UhnjlvVdTE0SyIqPt
         n+eZfXdEYpzyLz3wGhlBCwIBlCMLXObqrIEM1plPv2S3R/zUMi9XVvDd4ZEb2NUIw9D2
         m+CLNAYrGrGUCmY0AJzMvhVagTtE1r9e1DkHLK9Ue3vBhDpPlZ97fvomJAbdqi94hEAr
         JaNw==
X-Received: by 10.180.75.164 with SMTP id d4mr5432867wiw.58.1376855361456;
        Sun, 18 Aug 2013 12:49:21 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id l7sm11974263wiw.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:49:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232509>

Make update-index always rewrite the index when a index-version
is given, even if the index already has the right version.
This option is used for performance testing the writer and
reader.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index c5bb889..8b3f7a0 100644
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
@@ -861,8 +862,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    preferred_index_format,
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
 
-		if (the_index.version != preferred_index_format)
-			active_cache_changed = 1;
+		active_cache_changed = 1;
 		change_cache_version(preferred_index_format);
 	}
 
-- 
1.8.3.4.1231.g9fbf354.dirty
