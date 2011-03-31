From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/4] write_idx_file should use an unsigned nr_objects parameter
Date: Wed, 30 Mar 2011 20:24:31 -0500
Message-ID: <1301534674-31981-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:24:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56cv-0007jk-Bh
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab1CaBYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:24:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61114 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab1CaBYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:24:39 -0400
Received: by gwaa18 with SMTP id a18so783083gwa.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=6Wi6U2iCtVuXCJaUkckzuRPNmavaP9SzfxniM4TlPIU=;
        b=uNaOfUuUbnWdYJJGSTVSd7xALRa8bibYVuYKIhEEVoSWTXnUzlxdD5slz+NYxaQlDW
         UiswuUE06WsHUYRf9d8Cb0sJzzG2tiZmn5jJ9CfrhneX7hokdaO/XIX8BCrVprA4OOGp
         5ad5yEGvkLuoVXnnEkAO/nR2yEn2p7QNGNNaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AiL5taDb0znR5yNRHC/pr5+ICX1+4dlowb+FJSm1rLo4O4UX1qoaojGVff04FTyy/C
         SzMi+5AeoslUbNzMkwwmpWZV/qpxrOGXDA3U+O6k5247DCZreqQ3OehF/aIL5cq8JFEK
         xcCP/pyf/weJ5/BxSa7I8EmbUVsumnRESk5LA=
Received: by 10.91.47.1 with SMTP id z1mr2374712agj.22.1301534678752;
        Wed, 30 Mar 2011 18:24:38 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id 6sm654461anx.20.2011.03.30.18.24.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:24:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170436>

This follows the precedent set in the pack-objects code and being
adjusted for in index-pack and unpack-objects.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 pack-write.c |    6 +++---
 pack.h       |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index a905ca4..c2de03a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -18,15 +18,15 @@ static int sha1_compare(const void *_a, const void *_b)
  * will be sorted by SHA1 on exit.
  */
 const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects,
-			   int nr_objects, unsigned char *sha1)
+			   uint32_t nr_objects, unsigned char *sha1)
 {
 	struct sha1file *f;
 	struct pack_idx_entry **sorted_by_sha, **list, **last;
 	off_t last_obj_offset = 0;
 	uint32_t array[256];
-	int i, fd;
+	uint32_t i, index_version;
+	int fd;
 	git_SHA_CTX ctx;
-	uint32_t index_version;
 
 	if (nr_objects) {
 		sorted_by_sha = objects;
diff --git a/pack.h b/pack.h
index bb27576..c588454 100644
--- a/pack.h
+++ b/pack.h
@@ -55,7 +55,7 @@ struct pack_idx_entry {
 	off_t offset;
 };
 
-extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
+extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, uint32_t nr_objects, unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
 extern int verify_pack(struct packed_git *);
-- 
1.7.4.2
