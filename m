From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] hash-object --no-filters
Date: Sun, 3 Aug 2008 09:56:03 +0400
Message-ID: <20080803055602.GN7008@dpotapov.dyndns.org>
References: <200807311257.49108.litvinov2004@gmail.com> <20080731104529.GE7008@dpotapov.dyndns.org> <200808011023.32139.litvinov2004@gmail.com> <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com> <7vbq0dtawp.fsf@gitster.siamese.dyndns.org> <37fcd2780808010224l68c2c717y5334a34d9de1de8d@mail.gmail.com> <7vmyjwserv.fsf@gitster.siamese.dyndns.org> <20080801220932.GK7008@dpotapov.dyndns.org> <7vmyjvnx76.fsf_-_@gitster.siamese.dyndns.org> <20080803054218.GM7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 07:57:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPWae-0000ep-Rr
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 07:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbYHCF4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 01:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbYHCF4L
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 01:56:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:17109 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbYHCF4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 01:56:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so794062fgg.17
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 22:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ayllRXGhpJ9UwCGcAs8H17SUe3jyKijPcswy+G+j8YU=;
        b=HZwoJIjSEBEVJo7TsWYrSFpl8A4mtd7pxUWQaGYuuXWcfyPrZZCmvMeqNgKv+f4bVW
         TDmUE92o1ekqZj4dnw3LEhnuC5kCouDb3QwqRf8yXYhe3aF71ABnE05pqhytj8jiIUqv
         ozyMQbvat/AFwfoNJJKOnX0vLyW7gr7Qh/0Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=o3BxQ6od2IraExQalNXvqGDn7K+btamE8Onur973nfet8/E1THvh1cY2B6MlSrS4Zx
         YSprurwIPeDcE991lqykiQi+SQ+NG2/txMqDm6D15M3wrKfJXhOkKwrPaS2kKr8f1LTt
         5xxXayrs3ZDObDezefj4jzfj3mZUp3YLujBRo=
Received: by 10.86.80.17 with SMTP id d17mr9129084fgb.33.1217742967942;
        Sat, 02 Aug 2008 22:56:07 -0700 (PDT)
Received: from localhost ( [85.141.191.110])
        by mx.google.com with ESMTPS id d6sm3708786fga.2.2008.08.02.22.56.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Aug 2008 22:56:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080803054218.GM7008@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91208>

On Sun, Aug 03, 2008 at 09:42:18AM +0400, Dmitry Potapov wrote:
> 
> Here is the patch:

I am sorry, I forgot to commit a micro cleanup to my patch:

@@ -2378,10 +2378,8 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 		ret = write_sha1_file(buf, size, typename(type), sha1);
 	else
 		ret = hash_sha1_file(buf, size, typename(type), sha1);
-	if (re_allocated) {
+	if (re_allocated)
 		free(buf);
-		return ret;
-	}
 	return ret;
 }

So, here is the corrected version of my patch:

-- >8 --
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Sun, 3 Aug 2008 08:39:16 +0400
Subject: [PATCH] teach index_fd to work with pipes

index_fd can now work with file descriptors that are not normal files
but any readable file. If the given file descriptor is a regular file
then mmap() is used; for other files, strbuf_read is used.

The path parameter, which has been used as hint for filters, can be
NULL now to indicate that the file should be hashed literally without
any filter.

The index_pipe function is removed as redundant.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 cache.h       |    1 -
 hash-object.c |   29 +++++++++++-------------
 sha1_file.c   |   66 ++++++++++++++++++++++++++------------------------------
 3 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/cache.h b/cache.h
index 2475de9..68ce6e6 100644
--- a/cache.h
+++ b/cache.h
@@ -391,7 +391,6 @@ extern int ie_modified(const struct index_state *, struct cache_entry *, struct
 
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, enum object_type type, const char *path);
-extern int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object);
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
diff --git a/hash-object.c b/hash-object.c
index 46c06a9..ce027b9 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -8,28 +8,25 @@
 #include "blob.h"
 #include "quote.h"
 
-static void hash_object(const char *path, enum object_type type, int write_object)
+static void hash_fd(int fd, const char *type, int write_object, const char *path)
 {
-	int fd;
 	struct stat st;
 	unsigned char sha1[20];
-	fd = open(path, O_RDONLY);
-	if (fd < 0 ||
-	    fstat(fd, &st) < 0 ||
-	    index_fd(sha1, fd, &st, write_object, type, path))
+	if (fstat(fd, &st) < 0 ||
+	    index_fd(sha1, fd, &st, write_object, type_from_string(type), path))
 		die(write_object
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
 	printf("%s\n", sha1_to_hex(sha1));
 	maybe_flush_or_die(stdout, "hash to stdout");
 }
-
-static void hash_stdin(const char *type, int write_object)
+static void hash_object(const char *path, const char *type, int write_object)
 {
-	unsigned char sha1[20];
-	if (index_pipe(sha1, 0, type, write_object))
-		die("Unable to add stdin to database");
-	printf("%s\n", sha1_to_hex(sha1));
+	int fd;
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		die("Cannot open %s", path);
+	hash_fd(fd, type, write_object, path);
 }
 
 static void hash_stdin_paths(const char *type, int write_objects)
@@ -45,7 +42,7 @@ static void hash_stdin_paths(const char *type, int write_objects)
 				die("line is badly quoted");
 			strbuf_swap(&buf, &nbuf);
 		}
-		hash_object(buf.buf, type_from_string(type), write_objects);
+		hash_object(buf.buf, type, write_objects);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
@@ -116,13 +113,13 @@ int main(int argc, char **argv)
 			}
 
 			if (hashstdin) {
-				hash_stdin(type, write_object);
+				hash_fd(0, type, write_object, NULL);
 				hashstdin = 0;
 			}
 			if (0 <= prefix_length)
 				arg = prefix_filename(prefix, prefix_length,
 						      arg);
-			hash_object(arg, type_from_string(type), write_object);
+			hash_object(arg, type, write_object);
 			no_more_flags = 1;
 		}
 	}
@@ -131,6 +128,6 @@ int main(int argc, char **argv)
 		hash_stdin_paths(type, write_object);
 
 	if (hashstdin)
-		hash_stdin(type, write_object);
+		hash_fd(0, type, write_object, NULL);
 	return 0;
 }
diff --git a/sha1_file.c b/sha1_file.c
index e281c14..fe863f5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2353,51 +2353,22 @@ int has_sha1_file(const unsigned char *sha1)
 	return has_loose_object(sha1);
 }
 
-int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object)
+static int index_mem(unsigned char *sha1, void *buf, size_t size,
+		     int write_object, enum object_type type, const char *path)
 {
-	struct strbuf buf;
-	int ret;
-
-	strbuf_init(&buf, 0);
-	if (strbuf_read(&buf, fd, 4096) < 0) {
-		strbuf_release(&buf);
-		return -1;
-	}
-
-	if (!type)
-		type = blob_type;
-	if (write_object)
-		ret = write_sha1_file(buf.buf, buf.len, type, sha1);
-	else
-		ret = hash_sha1_file(buf.buf, buf.len, type, sha1);
-	strbuf_release(&buf);
-
-	return ret;
-}
-
-int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
-	     enum object_type type, const char *path)
-{
-	size_t size = xsize_t(st->st_size);
-	void *buf = NULL;
 	int ret, re_allocated = 0;
 
-	if (size)
-		buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-	close(fd);
-
 	if (!type)
 		type = OBJ_BLOB;
 
 	/*
 	 * Convert blobs to git internal format
 	 */
-	if ((type == OBJ_BLOB) && S_ISREG(st->st_mode)) {
+	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf;
 		strbuf_init(&nbuf, 0);
 		if (convert_to_git(path, buf, size, &nbuf,
 		                   write_object ? safe_crlf : 0)) {
-			munmap(buf, size);
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
@@ -2407,12 +2378,37 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 		ret = write_sha1_file(buf, size, typename(type), sha1);
 	else
 		ret = hash_sha1_file(buf, size, typename(type), sha1);
-	if (re_allocated) {
+	if (re_allocated)
 		free(buf);
-		return ret;
+	return ret;
+}
+
+int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
+	     enum object_type type, const char *path)
+{
+	size_t size = xsize_t(st->st_size);
+	int ret;
+
+	if (!S_ISREG(st->st_mode))
+	{
+		struct strbuf sbuf;
+		strbuf_init(&sbuf, 0);
+		if (strbuf_read(&sbuf, fd, 4096) >= 0)
+			ret = index_mem(sha1, sbuf.buf, sbuf.len, write_object,
+					type, path);
+		else
+			ret = -1;
+		strbuf_release(&sbuf);
 	}
-	if (size)
+	else if (size)
+	{
+		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		ret = index_mem(sha1, buf, size, write_object, type, path);
 		munmap(buf, size);
+	}
+	else
+		ret = index_mem(sha1, NULL, size, write_object, type, path);
+	close(fd);
 	return ret;
 }
 
-- 
1.6.0.rc1.53.gf8e95
