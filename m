From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 06/16] sha1_file: export `git_open_noatime`
Date: Tue, 25 Jun 2013 01:23:03 +0200
Message-ID: <1372116193-32762-7-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:23:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG72-00037D-8C
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab3FXXXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:23:53 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62298 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab3FXXXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:23:51 -0400
Received: by mail-wi0-f178.google.com with SMTP id k10so170344wiv.17
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Z/sUaXiUtH+OxSti3sXpPyTeV4nYEO51smHmS8SGCLo=;
        b=TLTkYbBsdnyQKbcuLPzqJHTMQkdfdDtbuUECdjNJkNP1lMKqB/LCFryzKg2dlpIaNK
         2Bl/5N5J/RnLzm49uYX34mQ4hR2kAB5pNSq7xcwu3ICgBh8x2fQKWEqGwBqcGN/X/FHC
         uhcZMfkEPMRSDoIHBN9qE4r7LGuEWuZhDvIfweMNZtLdDFgTXXLCrtyA26uPHwU/kz6P
         P7yXwQjKY5+m9cNbg7jHIaAH6+FCpAxxFOM3hrDXSLqxMd++BV8UVrZcp9S72tI5LsZU
         XLY6lF4QBwNvLbuBF0yt/ETZgbxVN0Ply/AESWlqg1Bii1r7C6jOpiNC4nSNW/6vsmkW
         oOXA==
X-Received: by 10.180.184.12 with SMTP id eq12mr7315713wic.8.1372116229884;
        Mon, 24 Jun 2013 16:23:49 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.23.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:23:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228923>

The `git_open_noatime` helper can be of general interest for other
consumers of git's different on-disk formats.
---
 cache.h     |    1 +
 sha1_file.c |    4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 95ef14d..bbe5e2a 100644
--- a/cache.h
+++ b/cache.h
@@ -769,6 +769,7 @@ extern int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
+extern int git_open_noatime(const char *name);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
diff --git a/sha1_file.c b/sha1_file.c
index 44c7bca..018a847 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -259,8 +259,6 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 struct alternate_object_database *alt_odb_list;
 static struct alternate_object_database **alt_odb_tail;
 
-static int git_open_noatime(const char *name);
-
 /*
  * Prepare alternate object database registry.
  *
@@ -1307,7 +1305,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-static int git_open_noatime(const char *name)
+int git_open_noatime(const char *name)
 {
 	static int sha1_file_open_flag = O_NOATIME;
 
-- 
1.7.9.5
