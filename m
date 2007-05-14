From: Dana How <danahow@gmail.com>
Subject: Re: Rebase max-pack-size?
Date: Mon, 14 May 2007 08:47:23 -0700
Message-ID: <4648848B.1030304@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000501050407040409030501"
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:47:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hncls-0004Rd-OY
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbXENPr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbXENPr3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:47:29 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:50860 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbXENPr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:47:27 -0400
Received: by py-out-1112.google.com with SMTP id a29so1543575pyi
        for <git@vger.kernel.org>; Mon, 14 May 2007 08:47:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type;
        b=bzHyfJNBVhFhxyg+5zYL7bzN7lK/daLn3qYhCIWAsKCDnzDbGG7pgNPIlr0frXVOruWvXLB/9czxoIDj2UoOxzX9j601YtiP3SMJPFYzyccFuJiVDS4Ma9N1M5uMFilYH68zwRWVoaooMwHd4X70hD+fMb4iUjv9vlfXCPle/YE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type;
        b=R0WSQAxi34GClcdTvVKd7k3k6MvM3auKLggN+/xtW/N5hd9J7pXx+2pgKnSHoXeInsOJX9aUK5ydyL0phTTHN+Yg0BipdDkBttT2Oe6xMWmv8F1A+I9fTmL7fHfU2syn/THq8APoc2ZolCpDfanD0DBgSWR9LkeodSLeyB14fG0=
Received: by 10.35.90.11 with SMTP id s11mr11270330pyl.1179157647190;
        Mon, 14 May 2007 08:47:27 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id v66sm22627338pyh.2007.05.14.08.47.25;
        Mon, 14 May 2007 08:47:25 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47260>

This is a multi-part message in MIME format.
--------------000501050407040409030501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

"Junio C Hamano" <junkio@cox.net> writes:
> "Dana How" <danahow@gmail.com> writes:
> > Since max-pack-size has appeared, and disappeard, in "pu" twice
> > and never made it into "next",  I'm guessing I should rebase/merge it on
> > top of the other recent pack-objects work.  I may get to this tonight;
> > perhaps I'll send the patchset in one email with multiple attachments?
> I am still holding onto the series on its own topic branch, but
> merging it to 'pu' and resolving conflicts seem pointless while
> I am (and hopefully the rest of the list ought to be ;-)
> primarily concentrating on last-minute bugfixes in preparation
> for v1.5.2.
> 
> A rebase to be queued in 'next' would be good, though.

Yes,  the conflicts were extensive.
The rebased patches are attached.
Let me know if you want them re-sent inline and/or separately.

Thanks

Dana

--------------000501050407040409030501
Content-Type: text/plain;
 name="0001-Alter-sha1close-3rd-argument-to-request-flush-only.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Alter-sha1close-3rd-argument-to-request-flush-only.patch"

>From 781820f147bcb12dae576734585b27f42faca3ea Mon Sep 17 00:00:00 2001
From: Dana L. How <danahow@gmail.com>
Date: Sun, 13 May 2007 11:28:19 -0700
Subject: [PATCH] Alter sha1close() 3rd argument to request flush only

update=0 suppressed writing the final SHA-1 but was not used.
Now final=0 suppresses SHA-1 finalization, SHA-1 writing,
and closing -- in other words,  only flush the buffer.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 csum-file.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 7088f6e..5109342 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -29,18 +29,20 @@ static void sha1flush(struct sha1file *f, unsigned int count)
 	}
 }
 
-int sha1close(struct sha1file *f, unsigned char *result, int update)
+int sha1close(struct sha1file *f, unsigned char *result, int final)
 {
 	unsigned offset = f->offset;
 	if (offset) {
 		SHA1_Update(&f->ctx, f->buffer, offset);
 		sha1flush(f, offset);
+		f->offset = 0;
 	}
+	if (!final)
+		return 0;	/* only want to flush (no checksum write, no close) */
 	SHA1_Final(f->buffer, &f->ctx);
 	if (result)
 		hashcpy(result, f->buffer);
-	if (update)
-		sha1flush(f, 20);
+	sha1flush(f, 20);
 	if (close(f->fd))
 		die("%s: sha1 file error on close (%s)", f->name, strerror(errno));
 	free(f);
-- 
1.5.2.rc3.726.g279d


--------------000501050407040409030501
Content-Type: text/plain;
 name="0001-git-repack-max-pack-size-new-file-statics-and-cod.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-git-repack-max-pack-size-new-file-statics-and-cod.patch"

>From 0c75fd66aa6a758e245d85b9304e85a38e977f94 Mon Sep 17 00:00:00 2001
From: Dana L. How <danahow@gmail.com>
Date: Sun, 13 May 2007 11:34:56 -0700
Subject: [PATCH 1/4] git-repack --max-pack-size: new file statics and code restructuring

Add "pack_size_limit", the limit specified by --max-pack-size,
"written_list", the list of objects written to the current pack,
and "nr_written", the number of objects in written_list.
Put "base_name" at file scope again and add forward declarations.
Move write_index_file() call from cnd_pack_objects() to
write_pack_file() since only the latter will know how
many times to call write_index_file().

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |   68 +++++++++++++++++++++++++----------------------
 1 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d165f10..7c17ea0 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -52,7 +52,8 @@ struct object_entry {
  * nice "minimum seek" order.
  */
 static struct object_entry *objects;
-static uint32_t nr_objects, nr_alloc, nr_result;
+static struct object_entry **written_list;
+static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
 
 static int non_empty;
 static int no_reuse_delta, no_reuse_object;
@@ -61,9 +62,11 @@ static int incremental;
 static int allow_ofs_delta;
 static const char *pack_tmp_name, *idx_tmp_name;
 static char tmpname[PATH_MAX];
+static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
 static int window = 10;
+static uint32_t pack_size_limit;
 static int depth = 50;
 static int pack_to_stdout;
 static int num_preferred_base;
@@ -501,7 +504,11 @@ static int open_object_dir_tmp(const char *path)
     return mkstemp(tmpname);
 }
 
-static off_t write_pack_file(void)
+/* forward declarations for write_pack_file */
+static void write_index_file(off_t last_obj_offset, unsigned char *sha1);
+static int adjust_perm(const char *path, mode_t mode);
+
+static void write_pack_file(void)
 {
 	uint32_t i;
 	struct sha1file *f;
@@ -543,7 +550,32 @@ static off_t write_pack_file(void)
 		die("wrote %u objects while expecting %u", written, nr_result);
 	sha1close(f, pack_file_sha1, 1);
 
-	return last_obj_offset;
+	if (!pack_to_stdout) {
+			unsigned char object_list_sha1[20];
+			mode_t mode = umask(0);
+
+			umask(mode);
+			mode = 0444 & ~mode;
+
+			write_index_file(last_obj_offset, object_list_sha1);
+			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
+				 base_name, sha1_to_hex(object_list_sha1));
+			if (adjust_perm(pack_tmp_name, mode))
+				die("unable to make temporary pack file readable: %s",
+				    strerror(errno));
+			if (rename(pack_tmp_name, tmpname))
+				die("unable to rename temporary pack file: %s",
+				    strerror(errno));
+			snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
+				 base_name, sha1_to_hex(object_list_sha1));
+			if (adjust_perm(idx_tmp_name, mode))
+				die("unable to make temporary index file readable: %s",
+				    strerror(errno));
+			if (rename(idx_tmp_name, tmpname))
+				die("unable to rename temporary index file: %s",
+				    strerror(errno));
+			puts(sha1_to_hex(object_list_sha1));
+	}
 }
 
 static int sha1_sort(const void *_a, const void *_b)
@@ -1537,8 +1569,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int use_internal_rev_list = 0;
 	int thin = 0;
 	uint32_t i;
-	off_t last_obj_offset;
-	const char *base_name = NULL;
 	const char **rp_av;
 	int rp_ac_alloc = 64;
 	int rp_ac;
@@ -1707,33 +1737,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, "Result has %u objects.\n", nr_result);
 	if (nr_result)
 		prepare_pack(window, depth);
-	last_obj_offset = write_pack_file();
-	if (!pack_to_stdout) {
-		unsigned char object_list_sha1[20];
-		mode_t mode = umask(0);
-
-		umask(mode);
-		mode = 0444 & ~mode;
-
-		write_index_file(last_obj_offset, object_list_sha1);
-		snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
-			 base_name, sha1_to_hex(object_list_sha1));
-		if (adjust_perm(pack_tmp_name, mode))
-			die("unable to make temporary pack file readable: %s",
-			    strerror(errno));
-		if (rename(pack_tmp_name, tmpname))
-			die("unable to rename temporary pack file: %s",
-			    strerror(errno));
-		snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
-			 base_name, sha1_to_hex(object_list_sha1));
-		if (adjust_perm(idx_tmp_name, mode))
-			die("unable to make temporary index file readable: %s",
-			    strerror(errno));
-		if (rename(idx_tmp_name, tmpname))
-			die("unable to rename temporary index file: %s",
-			    strerror(errno));
-		puts(sha1_to_hex(object_list_sha1));
-	}
+	write_pack_file();
 	if (progress)
 		fprintf(stderr, "Total %u (delta %u), reused %u (delta %u)\n",
 			written, written_delta, reused, reused_delta);
-- 
1.5.2.rc3.726.g279d


--------------000501050407040409030501
Content-Type: text/plain;
 name="0002-git-repack-max-pack-size-write_-object-one-res.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-git-repack-max-pack-size-write_-object-one-res.patch"

>From 40ac2f294ec68cae27f8a9262db4cab84f1d2257 Mon Sep 17 00:00:00 2001
From: Dana L. How <danahow@gmail.com>
Date: Sun, 13 May 2007 12:06:18 -0700
Subject: [PATCH 2/4] git-repack --max-pack-size: write_{object,one}() respect pack limit

With --max-pack-size,  generate the appropriate write limit
for each object and check against it before each group of writes.
Update delta usability rules to handle base being in a previously-
written pack.  Inline sha1write_compress() so we know the
exact size of the written data when it needs to be compressed.
Detect and return write "failure".

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |  131 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 104 insertions(+), 27 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 7c17ea0..3023aac 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -352,16 +352,31 @@ static void copy_pack_data(struct sha1file *f,
 }
 
 static unsigned long write_object(struct sha1file *f,
-				  struct object_entry *entry)
+				  struct object_entry *entry,
+				  off_t write_offset)
 {
 	unsigned long size;
 	enum object_type type;
 	void *buf;
 	unsigned char header[10];
+	unsigned char dheader[10];
 	unsigned hdrlen;
 	off_t datalen;
 	enum object_type obj_type;
 	int to_reuse = 0;
+	/* write limit if limited packsize and not first object */
+	unsigned long limit = pack_size_limit && nr_written ?
+				pack_size_limit - write_offset : 0;
+				/* no if no delta */
+	int usable_delta =	!entry->delta ? 0 :
+				/* yes if unlimited packfile */
+				!pack_size_limit ? 1 :
+				/* no if base written to previous pack */
+				entry->delta->offset == (off_t)-1 ? 0 :
+				/* otherwise double-check written to this
+				 * pack,  like we do below
+				 */
+				entry->delta->offset ? 1 : 0;
 
 	if (!pack_to_stdout)
 		crc32_begin(f);
@@ -372,7 +387,9 @@ static unsigned long write_object(struct sha1file *f,
 	else if (!entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
 	else if (obj_type == OBJ_REF_DELTA || obj_type == OBJ_OFS_DELTA)
-		to_reuse = 1;	/* check_object() decided it for us */
+				/* check_object() decided it for us ... */
+		to_reuse = usable_delta;
+				/* ... but pack split may override that */
 	else if (obj_type != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
 	else if (entry->delta)
@@ -383,24 +400,48 @@ static unsigned long write_object(struct sha1file *f,
 				 */
 
 	if (!to_reuse) {
+		z_stream stream;
+		unsigned long maxsize;
+		void *out;
 		buf = read_sha1_file(entry->sha1, &type, &size);
 		if (!buf)
 			die("unable to read %s", sha1_to_hex(entry->sha1));
 		if (size != entry->size)
 			die("object %s size inconsistency (%lu vs %lu)",
 			    sha1_to_hex(entry->sha1), size, entry->size);
-		if (entry->delta) {
+		if (usable_delta) {
 			buf = delta_against(buf, size, entry);
 			size = entry->delta_size;
 			obj_type = (allow_ofs_delta && entry->delta->offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
+		} else {
+			/*
+			 * recover real object type in case
+			 * check_object() wanted to re-use a delta,
+			 * but we couldn't since base was in previous split pack
+			 */
+			obj_type = type;
 		}
+		/* compress the data to store and put compressed length in datalen */
+		memset(&stream, 0, sizeof(stream));
+		deflateInit(&stream, pack_compression_level);
+		maxsize = deflateBound(&stream, size);
+		out = xmalloc(maxsize);
+		/* Compress it */
+		stream.next_in = buf;
+		stream.avail_in = size;
+		stream.next_out = out;
+		stream.avail_out = maxsize;
+		while (deflate(&stream, Z_FINISH) == Z_OK)
+			/* nothing */;
+		deflateEnd(&stream);
+		datalen = stream.total_out;
+		deflateEnd(&stream);
 		/*
 		 * The object header is a byte of 'type' followed by zero or
 		 * more bytes of length.
 		 */
 		hdrlen = encode_header(obj_type, size, header);
-		sha1write(f, header, hdrlen);
 
 		if (obj_type == OBJ_OFS_DELTA) {
 			/*
@@ -409,21 +450,41 @@ static unsigned long write_object(struct sha1file *f,
 			 * base from this object's position in the pack.
 			 */
 			off_t ofs = entry->offset - entry->delta->offset;
-			unsigned pos = sizeof(header) - 1;
-			header[pos] = ofs & 127;
+			unsigned pos = sizeof(dheader) - 1;
+			dheader[pos] = ofs & 127;
 			while (ofs >>= 7)
-				header[--pos] = 128 | (--ofs & 127);
-			sha1write(f, header + pos, sizeof(header) - pos);
-			hdrlen += sizeof(header) - pos;
+				dheader[--pos] = 128 | (--ofs & 127);
+			if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
+				free(out);
+				free(buf);
+				return 0;
+			}
+			sha1write(f, header, hdrlen);
+			sha1write(f, dheader + pos, sizeof(dheader) - pos);
+			hdrlen += sizeof(dheader) - pos;
 		} else if (obj_type == OBJ_REF_DELTA) {
 			/*
 			 * Deltas with a base reference contain
 			 * an additional 20 bytes for the base sha1.
 			 */
+			if (limit && hdrlen + 20 + datalen + 20 >= limit) {
+				free(out);
+				free(buf);
+				return 0;
+			}
+			sha1write(f, header, hdrlen);
 			sha1write(f, entry->delta->sha1, 20);
 			hdrlen += 20;
+		} else {
+			if (limit && hdrlen + datalen + 20 >= limit) {
+				free(out);
+				free(buf);
+				return 0;
+			}
+			sha1write(f, header, hdrlen);
 		}
-		datalen = sha1write_compressed(f, buf, size, pack_compression_level);
+		sha1write(f, out, datalen);
+		free(out);
 		free(buf);
 	}
 	else {
@@ -438,20 +499,6 @@ static unsigned long write_object(struct sha1file *f,
 			reused_delta++;
 		}
 		hdrlen = encode_header(obj_type, entry->size, header);
-		sha1write(f, header, hdrlen);
-		if (obj_type == OBJ_OFS_DELTA) {
-			off_t ofs = entry->offset - entry->delta->offset;
-			unsigned pos = sizeof(header) - 1;
-			header[pos] = ofs & 127;
-			while (ofs >>= 7)
-				header[--pos] = 128 | (--ofs & 127);
-			sha1write(f, header + pos, sizeof(header) - pos);
-			hdrlen += sizeof(header) - pos;
-		} else if (obj_type == OBJ_REF_DELTA) {
-			sha1write(f, entry->delta->sha1, 20);
-			hdrlen += 20;
-		}
-
 		offset = entry->in_pack_offset;
 		revidx = find_packed_object(p, offset);
 		datalen = revidx[1].offset - offset;
@@ -460,6 +507,29 @@ static unsigned long write_object(struct sha1file *f,
 			die("bad packed object CRC for %s", sha1_to_hex(entry->sha1));
 		offset += entry->in_pack_header_size;
 		datalen -= entry->in_pack_header_size;
+		if (obj_type == OBJ_OFS_DELTA) {
+			off_t ofs = entry->offset - entry->delta->offset;
+			unsigned pos = sizeof(dheader) - 1;
+			dheader[pos] = ofs & 127;
+			while (ofs >>= 7)
+				dheader[--pos] = 128 | (--ofs & 127);
+			if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit)
+				return 0;
+			sha1write(f, header, hdrlen);
+			sha1write(f, dheader + pos, sizeof(dheader) - pos);
+			hdrlen += sizeof(dheader) - pos;
+		} else if (obj_type == OBJ_REF_DELTA) {
+			if (limit && hdrlen + 20 + datalen + 20 >= limit)
+				return 0;
+			sha1write(f, header, hdrlen);
+			sha1write(f, entry->delta->sha1, 20);
+			hdrlen += 20;
+		} else {
+			if (limit && hdrlen + datalen + 20 >= limit)
+				return 0;
+			sha1write(f, header, hdrlen);
+		}
+
 		if (!pack_to_stdout && p->index_version == 1 &&
 		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size))
 			die("corrupt packed object for %s", sha1_to_hex(entry->sha1));
@@ -467,7 +537,7 @@ static unsigned long write_object(struct sha1file *f,
 		unuse_pack(&w_curs);
 		reused++;
 	}
-	if (entry->delta)
+	if (usable_delta)
 		written_delta++;
 	written++;
 	if (!pack_to_stdout)
@@ -486,11 +556,18 @@ static off_t write_one(struct sha1file *f,
 		return offset;
 
 	/* if we are deltified, write out base object first. */
-	if (e->delta)
+	if (e->delta) {
 		offset = write_one(f, e->delta, offset);
+		if (!offset)
+			return 0;
+	}
 
 	e->offset = offset;
-	size = write_object(f, e);
+	size = write_object(f, e, offset);
+	if (!size) {
+		e->offset = 0;
+		return 0;
+	}
 
 	/* make sure off_t is sufficiently large not to wrap */
 	if (offset > offset + size)
-- 
1.5.2.rc3.726.g279d


--------------000501050407040409030501
Content-Type: text/plain;
 name="0003-git-repack-max-pack-size-split-packs-as-asked-by.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0003-git-repack-max-pack-size-split-packs-as-asked-by.patch"

>From 9ec3af1f52f41d0737b6271fded5e94527eb0466 Mon Sep 17 00:00:00 2001
From: Dana L. How <danahow@gmail.com>
Date: Sun, 13 May 2007 12:09:16 -0700
Subject: [PATCH 3/4] git-repack --max-pack-size: split packs as asked by write_{object,one}()

Rewrite write_pack_file() to break to a new packfile
whenever write_object/write_one request it,  and
correct the header's object count in the previous packfile.
Change write_index_file() to write an index
for just the objects in the most recent packfile.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |  120 ++++++++++++++++++++++++++++-------------------
 1 files changed, 71 insertions(+), 49 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 3023aac..ce9eb2d 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -568,6 +568,7 @@ static off_t write_one(struct sha1file *f,
 		e->offset = 0;
 		return 0;
 	}
+	written_list[nr_written++] = e;
 
 	/* make sure off_t is sufficiently large not to wrap */
 	if (offset > offset + size)
@@ -587,47 +588,57 @@ static int adjust_perm(const char *path, mode_t mode);
 
 static void write_pack_file(void)
 {
-	uint32_t i;
+	uint32_t i = 0, j;
 	struct sha1file *f;
-	off_t offset, last_obj_offset = 0;
+	off_t offset, offset_one, last_obj_offset = 0;
 	struct pack_header hdr;
-	int do_progress = progress;
-
-	if (pack_to_stdout) {
-		f = sha1fd(1, "<stdout>");
-		do_progress >>= 1;
-	} else {
-		int fd = open_object_dir_tmp("tmp_pack_XXXXXX");
-		if (fd < 0)
-			die("unable to create %s: %s\n", tmpname, strerror(errno));
-		pack_tmp_name = xstrdup(tmpname);
-		f = sha1fd(fd, pack_tmp_name);
-	}
+	int do_progress = progress >> pack_to_stdout;
+	uint32_t nr_remaining = nr_result;
 
 	if (do_progress)
 		start_progress(&progress_state, "Writing %u objects...", "", nr_result);
+	written_list = xmalloc(nr_objects * sizeof(struct object_entry *));
 
-	hdr.hdr_signature = htonl(PACK_SIGNATURE);
-	hdr.hdr_version = htonl(PACK_VERSION);
-	hdr.hdr_entries = htonl(nr_result);
-	sha1write(f, &hdr, sizeof(hdr));
-	offset = sizeof(hdr);
-	if (!nr_result)
-		goto done;
-	for (i = 0; i < nr_objects; i++) {
-		last_obj_offset = offset;
-		offset = write_one(f, objects + i, offset);
-		if (do_progress)
-			display_progress(&progress_state, written);
-	}
-	if (do_progress)
-		stop_progress(&progress_state);
- done:
-	if (written != nr_result)
-		die("wrote %u objects while expecting %u", written, nr_result);
-	sha1close(f, pack_file_sha1, 1);
+	do {
+		if (pack_to_stdout) {
+			f = sha1fd(1, "<stdout>");
+		} else {
+			int fd = open_object_dir_tmp("tmp_pack_XXXXXX");
+			if (fd < 0)
+				die("unable to create %s: %s\n", tmpname, strerror(errno));
+			pack_tmp_name = xstrdup(tmpname);
+			f = sha1fd(fd, pack_tmp_name);
+		}
 
-	if (!pack_to_stdout) {
+		hdr.hdr_signature = htonl(PACK_SIGNATURE);
+		hdr.hdr_version = htonl(PACK_VERSION);
+		hdr.hdr_entries = htonl(nr_remaining);
+		sha1write(f, &hdr, sizeof(hdr));
+		offset = sizeof(hdr);
+		nr_written = 0;
+		for (; i < nr_objects; i++) {
+			last_obj_offset = offset;
+			offset_one = write_one(f, objects + i, offset);
+			if (!offset_one)
+				break;
+			offset = offset_one;
+			if (do_progress)
+				display_progress(&progress_state, written);
+		}
+
+		/*
+		 * Did we write the wrong # entries in the header?
+		 * If so, rewrite it like in fast-import
+		 */
+		if (pack_to_stdout || nr_written == nr_remaining) {
+			sha1close(f, pack_file_sha1, 1);
+		} else {
+			sha1close(f, pack_file_sha1, 0);
+			fixup_pack_header_footer(f->fd, pack_file_sha1, pack_tmp_name, nr_written);
+			close(f->fd);
+		}
+
+		if (!pack_to_stdout) {
 			unsigned char object_list_sha1[20];
 			mode_t mode = umask(0);
 
@@ -652,7 +663,26 @@ static void write_pack_file(void)
 				die("unable to rename temporary index file: %s",
 				    strerror(errno));
 			puts(sha1_to_hex(object_list_sha1));
+		}
+
+		/* mark written objects as written to previous pack */
+		for (j = 0; j < nr_written; j++) {
+			written_list[j]->offset = (off_t)-1;
+		}
+		nr_remaining -= nr_written;
+	} while (nr_remaining && i < nr_objects);
+
+	free(written_list);
+	if (do_progress)
+		stop_progress(&progress_state);
+	if (written != nr_result)
+		die("wrote %u objects while expecting %u", written, nr_result);
+	for (j = 0; i < nr_objects; i++) {
+		struct object_entry *e = objects + i;
+		j += !e->offset && !e->preferred_base;
 	}
+	if (j)
+		die("wrote %u objects as expected but %u unwritten", written, j);
 }
 
 static int sha1_sort(const void *_a, const void *_b)
@@ -679,18 +709,11 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 	idx_tmp_name = xstrdup(tmpname);
 	f = sha1fd(fd, idx_tmp_name);
 
-	if (nr_result) {
-		uint32_t j = 0;
-		sorted_by_sha =
-			xcalloc(nr_result, sizeof(struct object_entry *));
-		for (i = 0; i < nr_objects; i++)
-			if (!objects[i].preferred_base)
-				sorted_by_sha[j++] = objects + i;
-		if (j != nr_result)
-			die("listed %u objects while expecting %u", j, nr_result);
-		qsort(sorted_by_sha, nr_result, sizeof(*sorted_by_sha), sha1_sort);
+	if (nr_written) {
+		sorted_by_sha = written_list;
+		qsort(sorted_by_sha, nr_written, sizeof(*sorted_by_sha), sha1_sort);
 		list = sorted_by_sha;
-		last = sorted_by_sha + nr_result;
+		last = sorted_by_sha + nr_written;
 	} else
 		sorted_by_sha = list = last = NULL;
 
@@ -728,7 +751,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 	/* Write the actual SHA1 entries. */
 	list = sorted_by_sha;
-	for (i = 0; i < nr_result; i++) {
+	for (i = 0; i < nr_written; i++) {
 		struct object_entry *entry = *list++;
 		if (index_version < 2) {
 			uint32_t offset = htonl(entry->offset);
@@ -743,7 +766,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 		/* write the crc32 table */
 		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
+		for (i = 0; i < nr_written; i++) {
 			struct object_entry *entry = *list++;
 			uint32_t crc32_val = htonl(entry->crc32);
 			sha1write(f, &crc32_val, 4);
@@ -751,7 +774,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 		/* write the 32-bit offset table */
 		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
+		for (i = 0; i < nr_written; i++) {
 			struct object_entry *entry = *list++;
 			uint32_t offset = (entry->offset <= index_off32_limit) ?
 				entry->offset : (0x80000000 | nr_large_offset++);
@@ -776,7 +799,6 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 	sha1write(f, pack_file_sha1, 20);
 	sha1close(f, NULL, 1);
-	free(sorted_by_sha);
 	SHA1_Final(sha1, &ctx);
 }
 
-- 
1.5.2.rc3.726.g279d


--------------000501050407040409030501
Content-Type: text/plain;
 name="0004-git-repack-max-pack-size-add-option-parsing-to-en.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0004-git-repack-max-pack-size-add-option-parsing-to-en.patch"

>From 279d1f9e0e7265c6ccf8759bbe8c5539bf3089fa Mon Sep 17 00:00:00 2001
From: Dana L. How <danahow@gmail.com>
Date: Sun, 13 May 2007 12:47:09 -0700
Subject: [PATCH 4/4] git-repack --max-pack-size: add option parsing to enable feature

Add --max-pack-size parsing and usage messages.
Upgrade git-repack.sh to handle multiple packfile names,
and build packfiles in GIT_OBJECT_DIRECTORY not GIT_DIR.
Update documentation.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 Documentation/git-pack-objects.txt |    5 +++++
 Documentation/git-repack.txt       |    5 +++++
 builtin-pack-objects.c             |    9 ++++++++-
 git-repack.sh                      |   14 ++++++++------
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 2531238..cfe127a 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -85,6 +85,11 @@ base-name::
 	times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
+--max-pack-size=<n>::
+	Maximum size of each output packfile, expressed in MiB.
+	If specified,  multiple packfiles may be created.
+	The default is unlimited.
+
 --incremental::
 	This flag causes an object already in a pack ignored
 	even if it appears in the standard input.
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index cc3b0b2..2847c9b 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -65,6 +65,11 @@ OPTIONS
 	to be applied that many times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
+--max-pack-size=<n>::
+	Maximum size of each output packfile, expressed in MiB.
+	If specified,  multiple packfiles may be created.
+	The default is unlimited.
+
 
 Configuration
 -------------
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ce9eb2d..930b57a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -15,7 +15,7 @@
 #include "progress.h"
 
 static const char pack_usage[] = "\
-git-pack-objects [{ -q | --progress | --all-progress }] \n\
+git-pack-objects [{ -q | --progress | --all-progress }] [--max-pack-size=N] \n\
 	[--local] [--incremental] [--window=N] [--depth=N] \n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
 	[--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
@@ -1713,6 +1713,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			pack_compression_level = level;
 			continue;
 		}
+		if (!prefixcmp(arg, "--max-pack-size=")) {
+			char *end;
+			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
+			if (!arg[16] || *end)
+				usage(pack_usage);
+			continue;
+		}
 		if (!prefixcmp(arg, "--window=")) {
 			char *end;
 			window = strtoul(arg+9, &end, 0);
diff --git a/git-repack.sh b/git-repack.sh
index 8bf66a4..4ea6e5b 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
-USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]'
+USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--depth=N]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
@@ -18,6 +18,7 @@ do
 	-q)	quiet=-q ;;
 	-f)	no_reuse=--no-reuse-object ;;
 	-l)	local=--local ;;
+	--max-pack-size=*) extra="$extra $1" ;;
 	--window=*) extra="$extra $1" ;;
 	--depth=*) extra="$extra $1" ;;
 	*)	usage ;;
@@ -35,7 +36,7 @@ true)
 esac
 
 PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
-PACKTMP="$GIT_DIR/.tmp-$$-pack"
+PACKTMP="$GIT_OBJECT_DIRECTORY/.tmp-$$-pack"
 rm -f "$PACKTMP"-*
 trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
 
@@ -62,11 +63,12 @@ case ",$all_into_one," in
 esac
 
 args="$args $local $quiet $no_reuse$extra"
-name=$(git-pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
+names=$(git-pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
 	exit 1
-if [ -z "$name" ]; then
+if [ -z "$names" ]; then
 	echo Nothing new to pack.
-else
+fi
+for name in $names ; do
 	chmod a-w "$PACKTMP-$name.pack"
 	chmod a-w "$PACKTMP-$name.idx"
 	if test "$quiet" != '-q'; then
@@ -92,7 +94,7 @@ else
 		exit 1
 	}
 	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
-fi
+done
 
 if test "$remove_redundant" = t
 then
-- 
1.5.2.rc3.726.g279d


--------------000501050407040409030501--
