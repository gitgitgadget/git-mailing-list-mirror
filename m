From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] hash-object --no-filters
Date: Sun, 3 Aug 2008 09:42:18 +0400
Message-ID: <20080803054218.GM7008@dpotapov.dyndns.org>
References: <200807231544.23472.litvinov2004@gmail.com> <200807311257.49108.litvinov2004@gmail.com> <20080731104529.GE7008@dpotapov.dyndns.org> <200808011023.32139.litvinov2004@gmail.com> <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com> <7vbq0dtawp.fsf@gitster.siamese.dyndns.org> <37fcd2780808010224l68c2c717y5334a34d9de1de8d@mail.gmail.com> <7vmyjwserv.fsf@gitster.siamese.dyndns.org> <20080801220932.GK7008@dpotapov.dyndns.org> <7vmyjvnx76.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 07:43:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPWNN-0007IL-T8
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 07:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbYHCFm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 01:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbYHCFm1
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 01:42:27 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:27162 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbYHCFm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 01:42:26 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1406328fkq.5
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 22:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VLILT748K3SKEiP/mWjsZB2s+u4oxHDchj/c85AlpSI=;
        b=j6448BW2Irfo7087bFwYueq0tZWIxx5koxjZS0IcoWMLX24IDx1FbCsB5uJ17jFTTL
         m3GyNRIssJSLi5GOq89UXTdcQo1+ApdJ/pK22lkXyISYXLci9/WOrV0vV6gLbg2U+ASx
         BYJn3sxhWvSdRYEd05UrWN4L9uVbsv15tn9wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JF4V3DPywqqhYxxtWnOhL2jVRVxIASRcXizT2NnCt4/IUT9rLTZ0igR0+MFyZ1PEpK
         LuJ71W0KcJJSXb5Odummvh5Ln0ql7m84xeHn5RszrB1oXAwFB0g4pZQnpoNUfJSctp16
         IhnrkE6x0i20Nst32wl57b28nDw9PBXh1aqSM=
Received: by 10.180.253.13 with SMTP id a13mr4621593bki.73.1217742143991;
        Sat, 02 Aug 2008 22:42:23 -0700 (PDT)
Received: from localhost ( [85.141.191.110])
        by mx.google.com with ESMTPS id e17sm2544259fke.10.2008.08.02.22.42.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Aug 2008 22:42:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmyjvnx76.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91207>

On Sat, Aug 02, 2008 at 10:28:13AM -0700, Junio C Hamano wrote:
> Dmitry Potapov <dpotapov@gmail.com> writes:
> 
> > The --no-filters option makes git hash-object to work as there were no
> > input filters. This option is useful for importers such as git-svn to
> > put new version of files as is even if autocrlf is set.
> 
> I think this is going in the right direction, but I have to wonder a few
> things.
> 
> First, on hash-object.
> 
>  (1) "hash-object --stdin" always hashes literally.  We may want to be
>      able to say "The contents is this but pretend it came from this path
>      and apply the usual input rules", perhaps with "--path=" option;

It makes sense.

> 
>  (2) "hash-object temporaryfile" may want to honor the same "--path"
>      option;

Agreed.

> 
>  (3) "hash-object --stdin-paths" may want to get pair of paths (i.e. two
>      lines per entry) to do the same.

I cannot come up with a good name for this option.

> 
> If we want to do the above, the existing low-level interface needs to be
> adjusted.
> 
> index_pipe() and index_fd() can learn to take an additional string
> parameter for attribute lookup to implement (1) and (2) above.

index_fd already has the 'path' parameter, which is used as hint for
for blob conversion.

> Perhaps
> the string can be NULL to signal --no-filter behaviour, in which case the
> HASH_OBJECT_LITERALLY change may not be necessary for this codepath.

Sounds like a good idea :)

> 
> By the way, why do we have index_pipe() and index_fd() to begin with?  Is
> it because users of index_pipe() do not know what the path it is hashing
> and also the fd being a pipe we cannot mmap it?

index_fd() does not need the path for anything but to choose filters.
So, if index_pipe supported filters, it would have the same parameter.

There is one more parameter that index_fd() has and index_pipe() does
not. It is 'struct stat'. So I decided to look what this parameter is
used for in index_fd(), and it turned out for two things:
- to determine the size that needs to mmap
- to check whether the file is regular and if it is not then skip
  convert_to_git().

That made me wonder whether index_fd() can be ever called for a non-
regular file? I studied the source code and with the exception to git
hash-object, which can pass anything what it can bed opened, in all
other cases, we always call it for what is know as a regular file. In
fact, it could be otherwise. It won't work for non-regular files. It
is quite obvious that git hash-object for a directory will fail, but
I wondered what would happen if I'd give it something different. For
instance, a named pipe (FIFO)

 $mkfifo fifofile
 $git hash-object
 <wait for the other process to start write to it>
 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

i.e. the same SHA-1 as for an empty file, and here is why: index_fd()
tries to mmap the file descriptor and that obviously fails, but xmmap()
has this particular code:

	if (ret == MAP_FAILED) {
		if (!length)
			return NULL;

apparently, it was workaround for empty files, but because st_size is 0
for pipes, index_fd treats any pipe as empty file!

> 
> If these two are the only reasons, then I wonder if we can:
> 
>  - accept NULL as path and stat parameters for callers without a filename
>    (which automatically implies we are doing a regular blob and we hash
>    literally); and

I like this idea.

> 
>  - first try to mmap(), and if it fails fall back to the "read once into
>    strbuf" codepath to solve mmap-vs-pipe issue.

I have an alternative proposal:

Because we have stat structure given as a parameter, we can always
check whether the file is regular or not. If it is regular, we can use
mmap() and if it is not then use "read once into strbuf" approach.

> I am not sure if such a unification of these two functions is useful,
> though.

I have implemented this unification, and it reduces the code size,
makes git-hash-object to work with named pipes, and makes easier to
add the --path and --no-filters options, because there is no need
to modify the index_fd interface anymore, and there is a single place
where convert_to_git is invoked. So it looks like a good idea.

Here is the patch:

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
 hash-object.c |   29 +++++++++++--------------
 sha1_file.c   |   64 +++++++++++++++++++++++++++-----------------------------
 3 files changed, 44 insertions(+), 50 deletions(-)

git-hash-object before
   text    data     bss     dec     hex filename
 148751    1332   93164  243247   3b62f git-hash-object

and after patch
   text    data     bss     dec     hex filename
 148687    1332   93164  243183   3b5ef git-hash-object


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
index e281c14..765a7e7 100644
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
@@ -2411,8 +2382,35 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 		free(buf);
 		return ret;
 	}
-	if (size)
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
+	}
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
1.6.0.rc1.53.gaeaa.dirty
