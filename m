From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/8] archive: add tests for directory selection
Date: Wed,  8 Apr 2009 20:05:29 +1000
Message-ID: <1239185133-4181-5-git-send-email-pclouds@gmail.com>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
 <1239185133-4181-2-git-send-email-pclouds@gmail.com>
 <1239185133-4181-3-git-send-email-pclouds@gmail.com>
 <1239185133-4181-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 12:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUi1-0005bq-7u
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756282AbZDHKHB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 06:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763220AbZDHKHA
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:07:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:44704 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763153AbZDHKG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:06:59 -0400
Received: by rv-out-0506.google.com with SMTP id f9so37692rvb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JlMf3Zwz1jbSrE/IIs4Rfx7mmMV8qpZVAFFx9vIam48=;
        b=XTluPfKhjAQGTlTnk/rf20R741Tl7UprbaTW5+eOHIpQ0jRYxq5bUoxL9QkcVcv7t0
         0S8AIhf5GkCrYL9bfKCkezK5ECdo3z6d//3F4/Ygx7RR5DYC7+i7CTR9r81D7avqLdEK
         xG1L4TaVVqX36bOSkvAO5rh9iAXVhVrwzvwI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=L0kty5xedT+5tCGv8X5NP+kp5oHQqrIxJpHVPrhedK6L+SnJsM46lv3izB6ItFWFyw
         uNqW+AMm+qlRqmE7cDhdm82nGPP3ZjI2uvba28tH5nU6AFkVu2jvA2/5JyZJlAHPg8Bv
         MQREPk1aYCGT4xskqqHKl9Fa7I1oQXC9RQ9CY=
Received: by 10.141.137.16 with SMTP id p16mr462961rvn.200.1239185218889;
        Wed, 08 Apr 2009 03:06:58 -0700 (PDT)
Received: from dektop ([121.91.216.142])
        by mx.google.com with ESMTPS id c20sm24855880rvf.20.2009.04.08.03.06.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 03:06:58 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Apr 2009 20:06:51 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
In-Reply-To: <1239185133-4181-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116066>

While in archive.c, it says "pathspec". It's not really pathspec.
Make a few tests to catch this point.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c               |   17 +++++++++++++++++
 t/t0024-crlf-archive.sh |   30 +++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/archive.c b/archive.c
index e87fed7..5b54d95 100644
--- a/archive.c
+++ b/archive.c
@@ -15,6 +15,8 @@ static char const * const archive_usage[] =3D {
=20
 #define USES_ZLIB_COMPRESSION 1
=20
+static int list_archive(struct archiver_args *args);
+
 static const struct archiver {
 	const char *name;
 	write_archive_fn_t write_archive;
@@ -22,8 +24,23 @@ static const struct archiver {
 } archivers[] =3D {
 	{ "tar", write_tar_archive },
 	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
+	{ "dump-file-list", list_archive },
 };
=20
+static int list_archive_entry(struct archiver_args *args,
+		const unsigned char *sha1, const char *path, size_t pathlen,
+		unsigned int mode, void *buffer, unsigned long size)
+{
+	printf("%s\n", path);
+	return 0;
+}
+
+static int list_archive(struct archiver_args *args)
+{
+	write_archive_entries(args, list_archive_entry);
+	return 0;
+}
+
 static void format_subst(const struct commit *commit,
                          const char *src, size_t len,
                          struct strbuf *buf)
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index 9c56e0e..695ad5a 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -9,14 +9,42 @@ test_expect_success setup '
=20
 	git config core.autocrlf true
=20
+	mkdir sub &&
 	printf "CRLF line ending\r\nAnd another\r\n" > sample &&
-	git add sample &&
+	cp sample sub/sample &&
+	git add sample sub/sample &&
=20
 	test_tick &&
 	git commit -m Initial
=20
 '
=20
+cat <<\EOF > expected
+sample
+sub/
+sub/sample
+EOF
+
+test_expect_success 'archive without subdir' '
+	git archive --format=3Ddump-file-list HEAD > output &&
+	test_cmp output expected
+'
+
+cat <<\EOF > expected
+sub/
+sub/sample
+EOF
+
+test_expect_success 'archive with subdir' '
+	git archive --format=3Ddump-file-list HEAD sub > output &&
+	test_cmp output expected
+'
+
+test_expect_success 'subdir is not pathspec' '
+	test "$(git archive --format=3Ddump-file-list HEAD sub/)" =3D ""
+	test "$(git archive --format=3Ddump-file-list HEAD s\*)" =3D ""
+'
+
 test_expect_success 'tar archive' '
=20
 	git archive --format=3Dtar HEAD |
--=20
1.6.2.2.602.g83ee9f
