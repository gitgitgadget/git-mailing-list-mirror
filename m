From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/8] pack-objects: add --skip and --skip-hash
Date: Fri,  5 Feb 2016 15:57:50 +0700
Message-ID: <1454662677-15137-2-git-send-email-pclouds@gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 09:58:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRcDy-0007Wn-SB
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 09:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbcBEI6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 03:58:16 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35590 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcBEI6O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 03:58:14 -0500
Received: by mail-pf0-f180.google.com with SMTP id 65so65654292pfd.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 00:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nkzCghJ40bqE6EWh5i1bzY11+sI2ojx1eWVyqDO4rn0=;
        b=PcbwToD4gWOEm9Trum6a+UBf2NQvzzxrWoQ1Js/bdvLPrGx8Xv/GPUc+yU/gnuMUEh
         KKarOLH4f8HERHj+shv6bLYU5B/ixkJjkEcxMa0ZPJS7k7alDvWvc/dJyphmoPkjCrdk
         4E8B4vxZqChFvysAnjdWYRFtBOxu834ZoLLxTJBa/aMC8iSJTLXHhLARelRS2JtyPnIC
         G73aZfHZFD+Gu+Vam0eUXSAMWCDHA4a4wlRDalJ3Ykfb8JT0xmS7jrh1UoemeJmeonL+
         mw/D8SrPFTAZFkbJV8CShJ4L74yHI+opJRy11SYca7lbIVCCNRPAuM5n0l20ntLyayTD
         k5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=nkzCghJ40bqE6EWh5i1bzY11+sI2ojx1eWVyqDO4rn0=;
        b=hjFdeYfr0+m9vffbJCsJw9Br2OuXhfSbZ85ioQen22lJGVwWYAQMLICyOKP8pyzeHe
         Z3zx29NHXJDO4arFUo82mahPsj2fwt5+U+uJTE+M+7zvUwunuhlCCCvsMM9yzNYzFJqX
         vNzDyxB+W3Jdyn0YkqLWGTdR8LzYZGfkEdM5deXG/iWsyl2sCPaXaGaMeVdg2KBd2Ua9
         kcMjsiQVTqfbNHa55qeOMdWRZx0rdA66LNL5/KtucctdZeA0OVi5O19YEPzEroRkwrDO
         NJYp3gkMLGEQgQ3n8ioX0NH1ROUhouetJuoqJl4Rf1l7SwVsRqUSi+bOwKycihURJX/Z
         588A==
X-Gm-Message-State: AG10YOSKuFYObk9UZ7aBrWUEec3KFsHoOcSEwz041u8ZVLNlRnRt1iTA/QPZl5v5TUloLg==
X-Received: by 10.98.32.5 with SMTP id g5mr18342683pfg.74.1454662694046;
        Fri, 05 Feb 2016 00:58:14 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id dg1sm22708810pad.18.2016.02.05.00.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 00:58:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 05 Feb 2016 15:58:28 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285559>

The idea is, a pack is requested the first time with --skip=3D0. If pac=
k
transfer is interrupted, the client will ask for the same pack again,
but this time it asks the server not to send what it already has. The
client hashes what it has and sends the SHA-1 to the server. If the
server finds out the skipped part does not match, it can abort early.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 21 ++++++++++++++++++++
 csum-file.c            | 52 ++++++++++++++++++++++++++++++++++++++++++=
++++----
 csum-file.h            |  3 +++
 3 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4dae5b1..417c830 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -75,6 +75,9 @@ static unsigned long cache_max_small_delta_size =3D 1=
000;
=20
 static unsigned long window_memory_limit =3D 0;
=20
+static struct object_id skip_hash;
+static int skip_opt =3D -1;
+
 /*
  * stats
  */
@@ -781,6 +784,11 @@ static void write_pack_file(void)
 		else
 			f =3D create_tmp_packfile(&pack_tmp_name);
=20
+		if (skip_opt > 0) {
+			f->skip =3D skip_opt;
+			hashcpy(f->skip_hash, skip_hash.hash);
+		}
+
 		offset =3D write_pack_header(f, nr_remaining);
=20
 		if (reuse_packfile) {
@@ -2597,6 +2605,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 	struct argv_array rp =3D ARGV_ARRAY_INIT;
 	int rev_list_unpacked =3D 0, rev_list_all =3D 0, rev_list_reflog =3D =
0;
 	int rev_list_index =3D 0;
+	const char *skip_hash_hex =3D NULL;
 	struct option pack_objects_options[] =3D {
 		OPT_SET_INT('q', "quiet", &progress,
 			    N_("do not show progress meter"), 0),
@@ -2669,6 +2678,10 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 			 N_("use a bitmap index if available to speed up counting objects")=
),
 		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
 			 N_("write a bitmap index together with the pack index")),
+		OPT_STRING(0, "skip-hash", &skip_hash_hex, "hash",
+			   N_("hash of the skipped part of the pack")),
+		OPT_INTEGER(0, "skip", &skip_opt,
+			   N_("do not produce the first <n> bytes of the pack")),
 		OPT_END(),
 	};
=20
@@ -2689,6 +2702,14 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 	}
 	if (pack_to_stdout !=3D !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
+	if (skip_opt >=3D 0) {
+		if (skip_opt > 0) {
+			if (!skip_hash_hex)
+				die(_("--skip-hash is required if --skip is non-zero"));
+			if (get_oid_hex(skip_hash_hex, &skip_hash))
+				die(_("%s is not SHA-1"), skip_hash_hex);
+		}
+	}
=20
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
diff --git a/csum-file.c b/csum-file.c
index a172199..284847f 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,8 +11,27 @@
 #include "progress.h"
 #include "csum-file.h"
=20
+static void check_skip_hash(struct sha1file *f, off_t old_total)
+{
+	if (old_total < f->skip && f->total > f->skip)
+		die("BUG: flush() must stop at skip boundary");
+
+	if (f->total =3D=3D f->skip) {
+		git_SHA_CTX ctx;
+		unsigned char hash[20];
+
+		ctx =3D f->ctx;
+		git_SHA1_Final(hash, &ctx);
+		if (hashcmp(hash, f->skip_hash))
+			die("skip hash does not match, expected %s got %s",
+			    sha1_to_hex(f->skip_hash), sha1_to_hex(hash));
+	}
+}
+
 static void flush(struct sha1file *f, const void *buf, unsigned int co=
unt)
 {
+	off_t old_total =3D f->total;
+
 	if (0 <=3D f->check_fd && count)  {
 		unsigned char check_buffer[8192];
 		ssize_t ret =3D read_in_full(f->check_fd, check_buffer, count);
@@ -26,7 +45,11 @@ static void flush(struct sha1file *f, const void *bu=
f, unsigned int count)
 	}
=20
 	for (;;) {
-		int ret =3D xwrite(f->fd, buf, count);
+		int ret;
+		if (f->total + count <=3D f->skip)
+			ret =3D count;
+		else
+			ret =3D xwrite(f->fd, buf, count);
 		if (ret > 0) {
 			f->total +=3D ret;
 			display_throughput(f->tp, f->total);
@@ -34,6 +57,8 @@ static void flush(struct sha1file *f, const void *buf=
, unsigned int count)
 			count -=3D ret;
 			if (count)
 				continue;
+			if (f->skip > 0)
+				check_skip_hash(f, old_total);
 			return;
 		}
 		if (!ret)
@@ -45,12 +70,25 @@ static void flush(struct sha1file *f, const void *b=
uf, unsigned int count)
 void sha1flush(struct sha1file *f)
 {
 	unsigned offset =3D f->offset;
+	const unsigned char *buffer =3D f->buffer;
+
+	if (!offset)
+		return;
+
+	if (f->total < f->skip && f->skip < f->total + offset) {
+		unsigned size =3D f->skip - f->total;
+		git_SHA1_Update(&f->ctx, buffer, size);
+		flush(f, buffer, size);
+		buffer +=3D size;
+		offset -=3D size;
+	}
=20
 	if (offset) {
-		git_SHA1_Update(&f->ctx, f->buffer, offset);
-		flush(f, f->buffer, offset);
-		f->offset =3D 0;
+		git_SHA1_Update(&f->ctx, buffer, offset);
+		flush(f, buffer, offset);
 	}
+
+	f->offset =3D 0;
 }
=20
 int sha1close(struct sha1file *f, unsigned char *result, unsigned int =
flags)
@@ -62,6 +100,8 @@ int sha1close(struct sha1file *f, unsigned char *res=
ult, unsigned int flags)
 	if (result)
 		hashcpy(result, f->buffer);
 	if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
+		if (f->skip > f->total)
+			die(_("can't skip in the middle of, or beyond the trailing SHA-1"))=
;
 		/* write checksum and close fd */
 		flush(f, f->buffer, 20);
 		if (flags & CSUM_FSYNC)
@@ -94,6 +134,9 @@ void sha1write(struct sha1file *f, const void *buf, =
unsigned int count)
 		unsigned nr =3D count > left ? left : count;
 		const void *data;
=20
+		if (f->total < f->skip && f->skip - f->total < nr)
+			nr =3D f->skip - f->total;
+
 		if (f->do_crc)
 			f->crc32 =3D crc32(f->crc32, buf, nr);
=20
@@ -149,6 +192,7 @@ struct sha1file *sha1fd_throughput(int fd, const ch=
ar *name, struct progress *tp
 	f->tp =3D tp;
 	f->name =3D name;
 	f->do_crc =3D 0;
+	f->skip =3D 0;
 	git_SHA1_Init(&f->ctx);
 	return f;
 }
diff --git a/csum-file.h b/csum-file.h
index 7530927..5a9475f 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -15,6 +15,9 @@ struct sha1file {
 	int do_crc;
 	uint32_t crc32;
 	unsigned char buffer[8192];
+
+	off_t skip;
+	unsigned char skip_hash[20];
 };
=20
 /* Checkpoint */
--=20
2.7.0.377.g4cd97dd
