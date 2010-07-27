From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] hash: Remove useless init_hash()
Date: Mon, 26 Jul 2010 22:36:10 -0700
Message-ID: <1280208970-23394-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 07:36:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odcq6-0005tR-TX
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 07:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571Ab0G0FgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 01:36:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50731 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab0G0FgY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 01:36:24 -0400
Received: by gyg10 with SMTP id 10so1118353gyg.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 22:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=VWxb6wHGh1S91MB3QRLhMKYXOPKF4hPYR0tPpHF/OdI=;
        b=YiJ4NtqLit7FsipBu5mz+bf+ujufQnZ6+ZwERB5Da2UufW+xzbB5KNUy+ANQbph9Q/
         O5ut4uc2ZgGjiniTqBdci7dLKPgMkQrXEfoowH3KSwux8bxeYruRiU6IPQAhEJFU4T/J
         Dtl40m6gceyBADXfj0meGuL3DX8cFNQgop6ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Hlh0yAMLOfFL5cDrgFFno/45O3PDuZhPi5OlBY5RL8z78ZvrzSu7m//D+wD1FUN5d6
         elrBRsydimYjOLYy4JyX+oRAvXFan/KKFdhcpXsPS+OsjRsGxAsvJXgKIXIw67vH7dTj
         EkKHWw7YSn8i9eBJJGyeDIetvrzbsGb3QLj+k=
Received: by 10.100.143.6 with SMTP id q6mr1398085and.221.1280208982177;
        Mon, 26 Jul 2010 22:36:22 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id l6sm7945916ang.38.2010.07.26.22.36.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 22:36:21 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 26 Jul 2010 22:36:10 -0700
X-Mailer: git-send-email 1.7.2.19.g9a302
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151910>

init_hash() is essentially a memset() so just use that.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/technical/api-hash.txt |    4 ----
 diffcore-rename.c                    |    2 +-
 hash.h                               |    7 -------
 3 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/Documentation/technical/api-hash.txt b/Documentation/technical/api-hash.txt
index e5061e0..7cf64ec 100644
--- a/Documentation/technical/api-hash.txt
+++ b/Documentation/technical/api-hash.txt
@@ -23,10 +23,6 @@ Data Structures
 Functions
 ---------
 
-`init_hash`::
-
-	Initialize the hash table.
-
 `free_hash`::
 
 	Release memory associated with the hash table.
diff --git a/diffcore-rename.c b/diffcore-rename.c
index df41be5..b355520 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -382,7 +382,7 @@ static int find_exact_renames(void)
 	int i;
 	struct hash_table file_table;
 
-	init_hash(&file_table);
+	memset(&file_table, 0, sizeof(file_table));
 	for (i = 0; i < rename_src_nr; i++)
 		insert_file_table(&file_table, -1, i, rename_src[i].one);
 
diff --git a/hash.h b/hash.h
index 69e33a4..418be24 100644
--- a/hash.h
+++ b/hash.h
@@ -33,11 +33,4 @@ extern void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table
 extern int for_each_hash(const struct hash_table *table, int (*fn)(void *));
 extern void free_hash(struct hash_table *table);
 
-static inline void init_hash(struct hash_table *table)
-{
-	table->size = 0;
-	table->nr = 0;
-	table->array = NULL;
-}
-
 #endif
-- 
1.7.2.19.g9a302
