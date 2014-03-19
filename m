From: Hiroyuki Sano <sh19910711@gmail.com>
Subject: [PATCH v2 2/3][GSOC] diff: use is_dot_or_dotdot() instead of strcmp()
Date: Wed, 19 Mar 2014 20:23:49 +0900
Message-ID: <1395228230-10189-2-git-send-email-sh19910711@gmail.com>
References: <1395228230-10189-1-git-send-email-sh19910711@gmail.com>
Cc: Hiroyuki Sano <sh19910711@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 12:24:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQEbl-0004hO-49
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 12:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbaCSLYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 07:24:23 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43566 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbaCSLYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 07:24:22 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so8835361pab.10
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z2VwEcE2lfjXVzyrXHtDoDwJ3yTezHQz5Esc26E/6uw=;
        b=B9E5QvBGKe4GXPJAwPuKF4EZnBz7PMqVflPwwKUepTqH5KNN5rGnQSCg2fiu1lms+5
         hiStx7td/OTvd7jF+iz9/z3iBYLeehElEX8vo8UJ2rIxTiY1bH6Jksm7kY80kBl/YjK/
         xRQQxWFjVETmw0ERkihTMz8Y4PclLLwLir2dBaoUSfI/SZ/eFdb0JYTjAnWNpPJS9eu+
         moBKBMEt4E6iLFP3rrWvN8YTpmtEYkgCa2LtcOTMIu4tD8w0KAC87IulKKZaoQ5V/Cc+
         cBXf0pVhkOeTeeMdOOmsK5DLHay9u5W2TknyDDy4kip2E7FXDdOKo8eoNYfMsPNSLh5x
         54sA==
X-Received: by 10.66.146.229 with SMTP id tf5mr39670322pab.50.1395228262292;
        Wed, 19 Mar 2014 04:24:22 -0700 (PDT)
Received: from localhost (ntfkok023001.fkok.nt.adsl.ppp.infoweb.ne.jp. [218.217.179.1])
        by mx.google.com with ESMTPSA id it4sm61390867pbc.39.2014.03.19.04.24.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Mar 2014 04:24:21 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395228230-10189-1-git-send-email-sh19910711@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244436>

The is_dot_or_dotdot() is used to check if the string is either "." or "..".
Include the "dir.h" header file to use is_dot_or_dotdot().

Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
---
 diff-no-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 20b6a8a..8e642b3 100644
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
@@ -25,7 +26,7 @@ static int get_path_list(const char *path, struct string_list *list)
 		return error("Could not open directory %s", path);
 
 	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+		if (!is_dot_or_dotdot(e->d_name))
 			string_list_insert(list, e->d_name);
 
 	closedir(dir);
-- 
1.9.0
