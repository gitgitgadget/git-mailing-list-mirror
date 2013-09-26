From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/10] count-objects: report pack v4 usage
Date: Thu, 26 Sep 2013 09:26:49 +0700
Message-ID: <1380162409-18224-11-git-send-email-pclouds@gmail.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:28:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1JI-0003EA-70
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab3IZC2C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 22:28:02 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:42213 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3IZC2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:28:00 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so471396pbc.35
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QM6HFMs3Ne4dntXlWXjBMeRmXfY6OxJ9TggZOgKZ5NE=;
        b=i5UmbZUZv65M7xDLFpDfS1b+xEmD4i1kw7XCb7p6X4hs40D4+TsboiJ8SwcoO87TEN
         QTzFh1/QsSmQj8kBum12KJMYVKGFLWD/bB59rd5hQkkS5UuxPhV2HRHnzEysmkUpZi6V
         CY7l0p9t9Au8Ju0bK9dV4z7ySH6d2kUTKschGxHaSp0Efe1WQzeeIwitZ5xgZW+pkDsn
         LYzquO3/D8LAWLladepWSY2tAxZ/C6chNoHBdbXGH8XtO3nyokDMitm41Pceowb5vzo0
         +aCQ1GcStak/uhiGzmiOls2yXCwbPeL219072z+5JceKiWcxwFVC+6mcQS6gH7Myx0cn
         bwzA==
X-Received: by 10.66.226.46 with SMTP id rp14mr2409208pac.133.1380162479862;
        Wed, 25 Sep 2013 19:27:59 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id os4sm50815218pbb.25.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 19:27:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Sep 2013 09:27:54 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235397>

An ideal repository is v4 only, no v2 packs. Show pack v4 statistics
so people know if the repository is mixed with v2 and repack it. Note
that "in-pack" and "size-pack" include all pack versions, not just v2.

Only display v4 info when there are v4 packs. It's still experimental
so don't polute the output with v4 that's never used by 99.99% of
users. We can make it unconditional later when v4 is officially
supported and recommended.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-count-objects.txt |  4 ++++
 builtin/count-objects.c             | 23 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-co=
unt-objects.txt
index b300e84..d15b4dc 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -28,8 +28,12 @@ size: disk space consumed by loose objects, in KiB (=
unless -H is specified)
 +
 in-pack: the number of in-pack objects
 +
+in-packv4: the number of objects in packs version 4
++
 size-pack: disk space consumed by the packs, in KiB (unless -H is spec=
ified)
 +
+size-packv4: disk space consumed by the packs version 4
++
 prune-packable: the number of loose objects that are also present in
 the packs. These objects could be pruned using `git prune-packed`.
 +
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a7f70cb..db73ce7 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -89,7 +89,7 @@ int cmd_count_objects(int argc, const char **argv, co=
nst char *prefix)
 	const char *objdir =3D get_object_directory();
 	int len =3D strlen(objdir);
 	char *path =3D xmalloc(len + 50);
-	unsigned long loose =3D 0, packed =3D 0, packed_loose =3D 0;
+	unsigned long loose =3D 0, packed_loose =3D 0;
 	off_t loose_size =3D 0;
 	struct option opts[] =3D {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -119,10 +119,12 @@ int cmd_count_objects(int argc, const char **argv=
, const char *prefix)
 	}
 	if (verbose) {
 		struct packed_git *p;
-		unsigned long num_pack =3D 0;
-		off_t size_pack =3D 0;
+		unsigned long num_pack =3D 0, num_pack_v4 =3D 0;
+		unsigned long packed =3D 0, packed_v4 =3D 0;
+		off_t size_pack =3D 0, size_pack_v4 =3D 0;
 		struct strbuf loose_buf =3D STRBUF_INIT;
 		struct strbuf pack_buf =3D STRBUF_INIT;
+		struct strbuf pack_buf_v4 =3D STRBUF_INIT;
 		struct strbuf garbage_buf =3D STRBUF_INIT;
 		if (!packed_git)
 			prepare_packed_git();
@@ -134,17 +136,25 @@ int cmd_count_objects(int argc, const char **argv=
, const char *prefix)
 			packed +=3D p->num_objects;
 			size_pack +=3D p->pack_size + p->index_size;
 			num_pack++;
+			if (p->version =3D=3D 4) {
+				packed_v4 +=3D p->num_objects;
+				size_pack_v4 +=3D p->pack_size + p->index_size;
+				num_pack_v4++;
+			}
 		}
=20
 		if (human_readable) {
 			strbuf_humanise_bytes(&loose_buf, loose_size);
 			strbuf_humanise_bytes(&pack_buf, size_pack);
+			strbuf_humanise_bytes(&pack_buf_v4, size_pack_v4);
 			strbuf_humanise_bytes(&garbage_buf, size_garbage);
 		} else {
 			strbuf_addf(&loose_buf, "%lu",
 				    (unsigned long)(loose_size / 1024));
 			strbuf_addf(&pack_buf, "%lu",
 				    (unsigned long)(size_pack / 1024));
+			strbuf_addf(&pack_buf_v4, "%lu",
+				    (unsigned long)(size_pack_v4 / 1024));
 			strbuf_addf(&garbage_buf, "%lu",
 				    (unsigned long)(size_garbage / 1024));
 		}
@@ -152,13 +162,20 @@ int cmd_count_objects(int argc, const char **argv=
, const char *prefix)
 		printf("count: %lu\n", loose);
 		printf("size: %s\n", loose_buf.buf);
 		printf("in-pack: %lu\n", packed);
+		if (num_pack_v4)
+			printf("in-packv4: %lu\n", packed_v4);
 		printf("packs: %lu\n", num_pack);
+		if (num_pack_v4)
+			printf("v4-packs: %lu\n", num_pack_v4);
 		printf("size-pack: %s\n", pack_buf.buf);
+		if (num_pack_v4)
+			printf("size-packv4: %s\n", pack_buf_v4.buf);
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 		printf("size-garbage: %s\n", garbage_buf.buf);
 		strbuf_release(&loose_buf);
 		strbuf_release(&pack_buf);
+		strbuf_release(&pack_buf_v4);
 		strbuf_release(&garbage_buf);
 	} else {
 		struct strbuf buf =3D STRBUF_INIT;
--=20
1.8.2.82.gc24b958
