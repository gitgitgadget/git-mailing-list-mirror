From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] diffcore-rename: allow to say "rename this blob to that blob"
Date: Wed, 20 Jan 2016 18:06:07 +0700
Message-ID: <1453287968-26000-7-git-send-email-pclouds@gmail.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 12:07:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLqbW-0003c1-Jg
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 12:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbcATLHF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 06:07:05 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36682 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817AbcATLHD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 06:07:03 -0500
Received: by mail-pa0-f65.google.com with SMTP id a20so250443pag.3
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 03:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=de/Yebyg9JPDdVjaxDNssJZTOlfaPQu+n9WNdHs7zuk=;
        b=xZDINm68Jv4mWuPD8FOHdOhoiUJlIb0jeueM3pvwdzNj/zAh5wejIRIGl6ZCCKJ6Cd
         tUaQUgAtoAaHe3ICKlALLvBOIgSyl1rjzHrf2M9wXnqqSOWD3PPZyA/BOX6bzL4blNv6
         VKRAPt/paH8jHcjo2+o8R6INScsWVKjLR+qGBN/DX5EoZ24qe/jjUaZdKaZOA/r44UXL
         KxXrc7Qy6RzA6aRTk641cpTTXFAz0IuM0m8oZwnMTv8iTWZn53y7P/1Jkupv8sym8nxN
         QXCDlYzXu0E5PIprojtQynMVTYn0LyS6mQM5ee4AjKyfd+pOgP3Am72fudRNSqnWgQK7
         wsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=de/Yebyg9JPDdVjaxDNssJZTOlfaPQu+n9WNdHs7zuk=;
        b=C1aDsAHiuE/o/lUKc5ZU4qS9oZBarwmzNPmui2f6HuqiWtKdIIvg+PLHixBv5RxhkV
         rOFAjRr8XsiOFWGsDZA0T6x/Ii7eXO/+HqKHK5buc61LX9rtuOf5nwOuu/eK4Fvrd8NS
         1XXPuPKiL3/RjYnP+CynYpe0JNjAkDF+pH4E9zaJt2jureUJPBoUYVTMcEZlIy6rys7i
         cdNkKn2TYV07TSJM9wfBDfETLvhHpBZQh9rLcWuHAZY9+eImrNeE6pKNG0Ga/29uHKmO
         blMGOLhSkC5wO47FjhewXxB0hrnbtvIObHTiz99EqjmOvVckH08NE6v/7TQs/DfdNJLg
         vlsg==
X-Gm-Message-State: ALoCoQkNXK0Z9GrW8eZKxzDYeco9O8JItOoCuUedfzum9ZjPot7tf9zqDq1sXiORq/VzdCZ6Ue29BzprT046Fn51VaLbYCsHFA==
X-Received: by 10.66.156.106 with SMTP id wd10mr51789252pab.150.1453288022153;
        Wed, 20 Jan 2016 03:07:02 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id l14sm47989072pfb.73.2016.01.20.03.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2016 03:07:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Jan 2016 18:06:57 +0700
X-Mailer: git-send-email 2.7.0.125.g9eec362
In-Reply-To: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284453>

This will be needed for git-merge, where we do a diff between two
trees far away. We need to translate paths to blobs so that merge can
stll use it.

This patch has another potential use: to reduce processing at rename
detection. We can cache the rename output in a big file with these "blo=
b
to blob" lines. The next diff will be fast because we only need to
compare SHA-1 instead of doing deltas. The naive find_manual_renames()
will have to be rewritten to dealwith large cache file though.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diffcore-rename.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 t/t4001-diff-rename.sh | 25 +++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 79beec8..a06c06a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -358,6 +358,38 @@ static int find_exact_renames(struct diff_options =
*options)
 	return renames;
 }
=20
+static int manual_rename_blob(const char *src, int srclen,
+			      const char *dst, int dstlen)
+{
+	struct object_id oid;
+	int src_index, dst_index;
+
+	if (srclen !=3D GIT_SHA1_HEXSZ || get_oid_hex(src, &oid))
+		return 0;
+
+	for (src_index =3D 0; src_index < rename_src_nr; src_index++) {
+		const unsigned char *sha1 =3D rename_src[src_index].p->one->sha1;
+		if (hashcmp(oid.hash, sha1))
+			break;
+	}
+	if (src_index =3D=3D rename_src_nr)
+		return 0;
+
+	if (dstlen !=3D GIT_SHA1_HEXSZ || get_oid_hex(dst, &oid))
+		return 0;
+
+	for (dst_index =3D 0; dst_index < rename_dst_nr; dst_index++) {
+		const unsigned char *sha1 =3D rename_dst[dst_index].two->sha1;
+		if (hashcmp(oid.hash, sha1))
+			break;
+	}
+	if (dst_index =3D=3D rename_dst_nr)
+		return 0;
+
+	record_rename_pair(dst_index, src_index, MAX_SCORE);
+	return 1;
+}
+
 static int manual_rename(const char *src, int srclen,
 			 const char *dst, int dstlen)
 {
@@ -406,6 +438,14 @@ static int find_manual_renames(struct diff_options=
 *options)
 			continue;
=20
 		dst =3D arrow + strlen(" =3D> ");
+
+		if (skip_prefix(src, "blob ", &src)) {
+			renames +=3D
+				manual_rename_blob(src, arrow - src,
+						   dst, line_end - dst);
+			continue;
+		}
+
 		renames +=3D manual_rename(src, arrow - src,
 					 dst, line_end - dst);
 	}
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 21d9378..4d5c667 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -189,6 +189,31 @@ test_expect_success 'manual rename correction' '
 	)
 '
=20
+test_expect_success 'manual rename correction with blobs' '
+	(
+		cd correct-rename &&
+		git diff -M --summary HEAD^ | grep rename >actual &&
+		cat >expected <<-\EOF &&
+		 rename old-one =3D> new-one (100%)
+		 rename old-two =3D> new-two (100%)
+		EOF
+		test_cmp expected actual &&
+
+		ONE=3D`echo one | git hash-object --stdin` &&
+		TWO=3D`echo two | git hash-object --stdin` &&
+		cat >correction <<-EOF &&
+		blob $ONE =3D> $TWO
+		blob $TWO =3D> $ONE
+		EOF
+		git diff -M --rename-file=3Dcorrection --summary HEAD^ | grep rename=
 >actual &&
+		cat >expected <<-\EOF &&
+		 rename old-two =3D> new-one (100%)
+		 rename old-one =3D> new-two (100%)
+		EOF
+		test_cmp expected actual
+	)
+'
+
 test_expect_success 'rename correction from notes' '
 	(
 		cd correct-rename &&
--=20
2.7.0.125.g9eec362
