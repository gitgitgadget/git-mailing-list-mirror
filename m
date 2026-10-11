Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3431A3166
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734776; cv=none; b=hpCiwq9vJIDc0t3XetJqPVZNKiijWvkPWvhZ9LHOOtnwKl08JOl4TbICL/6waVyP4jnV9Yw5cwPfkO+QaP5X8GcB+z6aOmMczHWlI0Q7+n+UFIgsX8YVFlaqLsv51dm8GYqYwHriXQnykgA3qYUUsZdCV6wX4u2MI6MN0zx9tqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734776; c=relaxed/simple;
	bh=hLXRhzupQnEezH9SqrFVstMIZ+AuMzAGsa7A1LMNnjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uHCnaSoP0BmtT4FfFBYHC7NJwTsJw5BMYwUVufWBQ7KdKiDkka9f+aDd8p+N1Ewi978N+xYAsmkk+noPk7sN/rlI/XF9BCzNTxlJhVI7cjd/Lsk0Q3JpwI/AlruIvag1le17CDGVO7DHRK3kwOXJRtJcOVsBvwKNbNSCd9oOxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ckaCuSKe; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ckaCuSKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791734765; x=1792339565; i=l.s.r@web.de;
	bh=HPsjVaSE8p79mnNeuwttWwIjS8YBys5Y9vvzYbJk54M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ckaCuSKe7gZ/D0rqh9EGOPPm7nAQeNZEIryhITQq4wDDN/gK+E/ArUV8Gq4YaHvq
	 l1V4NYUsfsfALRbcNIQaJOPJD8fRabWZvbjS7pTmdB6ZsWQDDXGYUheolK7AcjHbc
	 oAwGA83mQWLv5q2URvC4NFljkdgelR+5RvSjNXoIV6/2oVD1KvnOOeyxWvr7JI+gx
	 xRA5KD4dy9kfpg8hzIZjtcb1RlcOjFzZjfE+FGy79f2k0k7PloDPcr3nngDHBuR8q
	 0LAEIohTs6nWnOjYUTh7eB6sVuY+ChbgJlUi+f94FwzBoftGrQd53ZI6jsB3VPfV2
	 KgK9Ce8mLm0/wkNX1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M43GU-1xFw3o4A40-000ke6; Sun, 11
 Oct 2026 18:06:05 +0200
Message-ID: <595dafac-33c7-4c45-9cac-c868cf1f8bb0@web.de>
Date: Sun, 11 Oct 2026 18:06:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] archive-zip: omit UT extra field if mtime is out of range
To: "Matthew E. Luallen" <m@sph3r3.com>, git@vger.kernel.org
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wOjTwWANGNF+Fh10xszh2gpxlwMrR5a6adF589NLHTxWaRgSraD
 2HrtJsfXMBpviQLRNyjMiG6fnspzc01ywcGwGnWXLGZbrhJ6Uf+/xIERmFUGe0VD6iMUU4M
 Z3X0DLQSkf1UC30cnqGlgvB8KjqxT6nFkNZ0g7Ud9uZVpVP5qve0w/+LAAyuecIqR9Xrddf
 46VpEr5g1hPkzbIwJg5TA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/cyg1d0Gz+4=;BfUMuLnFQauf06N1z9Uj+hIIjZu
 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

We write an Extended Timestamp Extra Field (ID 0x5455 =3D "UT") for each
zip entry, like Info-ZIP zip(1) does.  Its time values are signed 32-bit
integers (see e.g. https://libzip.org/specifications/extrafld.txt).
Stop emitting them when the commit time doesn't fit in.

Use a strbuf to prepare the extra field up front.  Keep it empty if the
time value is out of range.  Like for the central zip directory we only
care about the length-limited buffer aspect of the strbuf, not about
NUL-termination.  This simplifies the conditional output by avoiding to
repeat the condition.

Reported-by: Matthew E. Luallen <m@sph3r3.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-zip.c                   | 37 +++++++++++++--------------------
 t/t5004-archive-corner-cases.sh | 28 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 6f73ca6d58..785689584c 100644
=2D-- a/archive-zip.c
+++ b/archive-zip.c
@@ -24,6 +24,7 @@ static int zip_time;
=20
 /* We only care about the "buf" part here. */
 static struct strbuf zip_dir;
+static struct strbuf zip_extra_mtime;
=20
 static uintmax_t zip_offset;
 static uint64_t zip_dir_entries;
@@ -81,14 +82,6 @@ struct zip_dir_trailer {
 	unsigned char _end[1];
 };
=20
-struct zip_extra_mtime {
-	unsigned char magic[2];
-	unsigned char extra_size[2];
-	unsigned char flags[1];
-	unsigned char mtime[4];
-	unsigned char _end[1];
-};
-
 struct zip64_extra {
 	unsigned char magic[2];
 	unsigned char extra_size[2];
@@ -129,9 +122,6 @@ struct zip64_dir_trailer_locator {
 #define ZIP64_DATA_DESC_SIZE	offsetof(struct zip64_data_desc, _end)
 #define ZIP_DIR_HEADER_SIZE	offsetof(struct zip_dir_header, _end)
 #define ZIP_DIR_TRAILER_SIZE	offsetof(struct zip_dir_trailer, _end)
-#define ZIP_EXTRA_MTIME_SIZE	offsetof(struct zip_extra_mtime, _end)
-#define ZIP_EXTRA_MTIME_PAYLOAD_SIZE \
-	(ZIP_EXTRA_MTIME_SIZE - offsetof(struct zip_extra_mtime, flags))
 #define ZIP64_EXTRA_SIZE	offsetof(struct zip64_extra, _end)
 #define ZIP64_EXTRA_PAYLOAD_SIZE \
 	(ZIP64_EXTRA_SIZE - offsetof(struct zip64_extra, size))
@@ -299,9 +289,8 @@ static int write_zip_entry(struct archiver_args *args,
 {
 	struct zip_local_header header;
 	uintmax_t offset =3D zip_offset;
-	struct zip_extra_mtime extra;
 	struct zip64_extra extra64;
-	size_t header_extra_size =3D ZIP_EXTRA_MTIME_SIZE;
+	size_t header_extra_size =3D zip_extra_mtime.len;
 	int need_zip64_extra =3D 0;
 	unsigned long attr2;
 	unsigned long compressed_size;
@@ -315,7 +304,7 @@ static int write_zip_entry(struct archiver_args *args,
 	const char *path_without_prefix =3D path + args->baselen;
 	unsigned int creator_version =3D 0;
 	unsigned int version_needed =3D 10;
-	size_t zip_dir_extra_size =3D ZIP_EXTRA_MTIME_SIZE;
+	size_t zip_dir_extra_size =3D zip_extra_mtime.len;
 	size_t zip64_dir_extra_payload_size =3D 0;
=20
 	crc =3D crc32(0, NULL, 0);
@@ -381,11 +370,6 @@ static int write_zip_entry(struct archiver_args *args=
,
 		}
 	}
=20
-	copy_le16(extra.magic, 0x5455);
-	copy_le16(extra.extra_size, ZIP_EXTRA_MTIME_PAYLOAD_SIZE);
-	extra.flags[0] =3D 1;	/* just mtime */
-	copy_le32(extra.mtime, args->time);
-
 	if (size > 0xffffffff || compressed_size > 0xffffffff)
 		need_zip64_extra =3D 1;
 	if (stream && size > 0x7fffffff)
@@ -412,8 +396,8 @@ static int write_zip_entry(struct archiver_args *args,
 	zip_offset +=3D ZIP_LOCAL_HEADER_SIZE;
 	write_or_die(1, path, pathlen);
 	zip_offset +=3D pathlen;
-	write_or_die(1, &extra, ZIP_EXTRA_MTIME_SIZE);
-	zip_offset +=3D ZIP_EXTRA_MTIME_SIZE;
+	write_or_die(1, zip_extra_mtime.buf, zip_extra_mtime.len);
+	zip_offset +=3D zip_extra_mtime.len;
 	if (need_zip64_extra) {
 		copy_le16(extra64.magic, 0x0001);
 		copy_le16(extra64.extra_size, ZIP64_EXTRA_PAYLOAD_SIZE);
@@ -546,7 +530,7 @@ static int write_zip_entry(struct archiver_args *args,
 	strbuf_add_le(&zip_dir, 4, attr2);
 	strbuf_add_le(&zip_dir, 4, clamp32(offset));
 	strbuf_add(&zip_dir, path, pathlen);
-	strbuf_add(&zip_dir, &extra, ZIP_EXTRA_MTIME_SIZE);
+	strbuf_addbuf(&zip_dir, &zip_extra_mtime);
 	if (zip64_dir_extra_payload_size) {
 		strbuf_add_le(&zip_dir, 2, 0x0001);	/* magic */
 		strbuf_add_le(&zip_dir, 2, zip64_dir_extra_payload_size);
@@ -644,12 +628,21 @@ static int write_zip_archive(const struct archiver *=
ar UNUSED,
 	dos_time(&args->time, &zip_date, &zip_time);
=20
 	strbuf_init(&zip_dir, 0);
+	strbuf_init(&zip_extra_mtime, 0);
+
+	if (args->time <=3D 0x7fffffff) {
+		strbuf_add_le(&zip_extra_mtime, 2, 0x5455); /* magic */
+		strbuf_add_le(&zip_extra_mtime, 2, 1 + 4); /* payload size */
+		strbuf_add_le(&zip_extra_mtime, 1, 1); /* flags; just mtime */
+		strbuf_add_le(&zip_extra_mtime, 4, args->time);
+	}
=20
 	err =3D write_archive_entries(args, write_zip_entry);
 	if (!err)
 		write_zip_trailer(args->commit_oid);
=20
 	strbuf_release(&zip_dir);
+	strbuf_release(&zip_extra_mtime);
=20
 	return err;
 }
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-case=
s.sh
index 768b0ff85d..20bab21048 100755
=2D-- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -227,4 +227,32 @@ test_expect_success 'tar archive with long paths' '
 	git archive -o long_paths.tar $tree
 '
=20
+test_lazy_prereq ZIPINFO_UT_EXTRA '
+	"$ZIPINFO" -v "$TEST_DIRECTORY"/t5004/big-pack.zip |
+	grep "UT extra field modtime"
+'
+
+test_expect_success TIME_IS_64BIT 'zip archive with 32-bit mtime' '
+	blob=3D$(echo foo | git hash-object -w --stdin) &&
+	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
+	git archive --mtime=3D"@2147483647 +0000" -o with_ut_extra.zip $tree
+'
+
+test_expect_success TIME_IS_64BIT 'zip archive with mtime exceeding 32-bi=
t' '
+	blob=3D$(echo foo | git hash-object -w --stdin) &&
+	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
+	git archive --mtime=3D"@2147483648 +0000" -o without_ut_extra.zip $tree
+'
+
+test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA 'UT extra field' '
+	"$ZIPINFO" -v with_ut_extra.zip >actual &&
+	test_grep "UT extra field modtime" actual
+'
+
+test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA \
+	'UT extra field omitted when mtime exceeds 32-bit' '
+	"$ZIPINFO" -v without_ut_extra.zip >actual &&
+	test_grep ! "UT extra field modtime" actual
+'
+
 test_done
=2D-=20
2.56.0
