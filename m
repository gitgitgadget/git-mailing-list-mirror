From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 02/24] read-cache: use fixed width integer types
Date: Sun, 18 Aug 2013 21:41:51 +0200
Message-ID: <1376854933-31241-3-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8xW-0003br-CO
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab3HRTsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:12 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:50543 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab3HRTsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:09 -0400
Received: by mail-wg0-f51.google.com with SMTP id a12so2837182wgh.6
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GgnM6vV4IuIMr3rtCnA8zHajBK6lpZWfyEy9JXpy+RM=;
        b=ilqiCPSNndkttp3qXaVQXi9Ujj8JQNfn3HIa6+ZKDNocw260we/8oqhHscWJC8jl5s
         X3G68jwVkwNDsXiJnwopuI2cIG8MZaDxQWha/5B+iqb/ACOcZEleqnD/e2BwrE5dqiKH
         6wMUjz+KHFBZGutimF3StGuRzMzVBSggEg5/A3fo1qo04b6dI7ADWVkqv6aX/G9l4TEi
         u1nTK8KFKeobjddaeFt6lS6w3jnjIrMjmUksJJukuYTmswdlLXd/20q+c7sR3amOitlH
         RZyFcxi1XwWh2y4N76RaE8IbzOLlxJ/uDDSIpm+fWolqZE3vMpJhH5Vod9zYulAuypAx
         mulA==
X-Received: by 10.180.38.73 with SMTP id e9mr5548949wik.37.1376855288525;
        Sun, 18 Aug 2013 12:48:08 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id jf9sm12400004wic.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232490>

Use the fixed width integer types uint16_t and uint32_t for ondisk
structures, because unsigned short and unsigned int do not hae a
guaranteed size.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      | 10 +++++-----
 read-cache.c | 30 +++++++++++++++---------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/cache.h b/cache.h
index bd6fb9f..9ef778a 100644
--- a/cache.h
+++ b/cache.h
@@ -101,9 +101,9 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
 
 #define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
 struct cache_header {
-	unsigned int hdr_signature;
-	unsigned int hdr_version;
-	unsigned int hdr_entries;
+	uint32_t hdr_signature;
+	uint32_t hdr_version;
+	uint32_t hdr_entries;
 };
 
 #define INDEX_FORMAT_LB 2
@@ -115,8 +115,8 @@ struct cache_header {
  * check it for equality in the 32 bits we save.
  */
 struct cache_time {
-	unsigned int sec;
-	unsigned int nsec;
+	uint32_t sec;
+	uint32_t nsec;
 };
 
 struct stat_data {
diff --git a/read-cache.c b/read-cache.c
index ceaf207..0df5b31 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1230,14 +1230,14 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 struct ondisk_cache_entry {
 	struct cache_time ctime;
 	struct cache_time mtime;
-	unsigned int dev;
-	unsigned int ino;
-	unsigned int mode;
-	unsigned int uid;
-	unsigned int gid;
-	unsigned int size;
+	uint32_t dev;
+	uint32_t ino;
+	uint32_t mode;
+	uint32_t uid;
+	uint32_t gid;
+	uint32_t size;
 	unsigned char sha1[20];
-	unsigned short flags;
+	uint16_t flags;
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -1249,15 +1249,15 @@ struct ondisk_cache_entry {
 struct ondisk_cache_entry_extended {
 	struct cache_time ctime;
 	struct cache_time mtime;
-	unsigned int dev;
-	unsigned int ino;
-	unsigned int mode;
-	unsigned int uid;
-	unsigned int gid;
-	unsigned int size;
+	uint32_t dev;
+	uint32_t ino;
+	uint32_t mode;
+	uint32_t uid;
+	uint32_t gid;
+	uint32_t size;
 	unsigned char sha1[20];
-	unsigned short flags;
-	unsigned short flags2;
+	uint16_t flags;
+	uint16_t flags2;
 	char name[FLEX_ARRAY]; /* more */
 };
 
-- 
1.8.3.4.1231.g9fbf354.dirty
