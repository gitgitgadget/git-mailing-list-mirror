From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 18/19] update-index.c: rewrite index when index-version is given
Date: Fri, 12 Jul 2013 19:27:03 +0200
Message-ID: <1373650024-3001-19-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:33:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxhDu-00070h-8L
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218Ab3GLRde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:33:34 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:36074 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813Ab3GLRdd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:33:33 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so9266539pbc.29
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=54ZkFjq7Wru+JpYk13ArVcfBULyrtcVnAiSHgFNUhWI=;
        b=cvlBnWUGX+Nn6+4aHOzUJn9hOAzb1E21Y4wgggMoshyl1C7cMbauVZDfecUnxWenTc
         vFw+am4p1o25w738XvB7lEAqOq4GetjrrrJDxIo9D2RJsScy1p+wjZBWiMdMcdDP0Gho
         MJjltAaSZoItusNi/vF58VJv2i0BIBoWQvoZiHOX8Lxc5luY6+tQEh2LjTSJ+I+KfjlO
         fCu2nIwvdCM6Cf31YmBJrzz4n8QXJsHG9BoL64plaauEI0DMqwQkFRe8EbjyKvt462vm
         EijLbONzpwefPn0vduquaFGc5QpaBrCP9unwc749HiKWHtVrlEZOdRMkaXOLm8FsF9kG
         ZZ1g==
X-Received: by 10.68.226.7 with SMTP id ro7mr32807394pbc.72.1373650413197;
        Fri, 12 Jul 2013 10:33:33 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id ib9sm46396607pbc.43.2013.07.12.10.33.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:33:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230230>

Make update-index always rewrite the index when a index-version
is given, even if the index already has the right version.
This option is used for performance testing the writer and
reader.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 4c6e3a6..7e723c0 100644
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
