From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/32] t1700: new tests for split-index mode
Date: Fri, 13 Jun 2014 19:19:51 +0700
Message-ID: <1402661991-14977-33-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:23:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQVk-0005An-Ve
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbaFMMXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:23:08 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58532 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbaFMMXG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:23:06 -0400
Received: by mail-pa0-f54.google.com with SMTP id et14so2095324pad.13
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TfVKDZtqS6a0hieX9VpXLzdyO1RqNf5a9cOPVcR2Yp8=;
        b=ON3GdBKIDA80ckjarbNjoFYzuVoj0Nd5A1rirK+F7kBFhNU0ueQfAqu32arHlbFTHc
         jKp6yjZVOmmcRz7EZeC2C3e0JO1+RG+bAeK1+xMz1g4dWyS5IQ9C2qBm4Q3IAaKNrDWs
         xtY2QvK1pp1RiyoHubNmFy1GI0rXr5Z7wN/mwOaJkCJ59SHntCvJ9QprWRaF2v4ZdNDy
         y0slrUqnRt4TT9NpDJ3WH3OK+3aym7LyApC/fejX9qthhCTVTNhMkN96VojEwooOrJ+j
         48p7tmohj/jpbGpkTEW6xOc79OP/4mZuZ++uYUxFkMTfe3GoSvOMzwtN/skP0ZSNYPUV
         8nzw==
X-Received: by 10.69.20.74 with SMTP id ha10mr2787345pbd.127.1402662186483;
        Fri, 13 Jun 2014 05:23:06 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id ty3sm20775032pab.20.2014.06.13.05.23.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:23:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:23:06 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251589>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                      |   1 +
 Makefile                        |   1 +
 cache.h                         |   2 +
 read-cache.c                    |   3 +-
 t/t1700-split-index.sh (new +x) | 194 ++++++++++++++++++++++++++++++++=
++++++++
 test-dump-split-index.c (new)   |  34 +++++++
 6 files changed, 233 insertions(+), 2 deletions(-)
 create mode 100755 t/t1700-split-index.sh
 create mode 100644 test-dump-split-index.c

diff --git a/.gitignore b/.gitignore
index dc600f9..70992a4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -180,6 +180,7 @@
 /test-date
 /test-delta
 /test-dump-cache-tree
+/test-dump-split-index
 /test-scrap-cache-tree
 /test-genrandom
 /test-hashmap
diff --git a/Makefile b/Makefile
index 94ad3ce..028749b 100644
--- a/Makefile
+++ b/Makefile
@@ -565,6 +565,7 @@ TEST_PROGRAMS_NEED_X +=3D test-ctype
 TEST_PROGRAMS_NEED_X +=3D test-date
 TEST_PROGRAMS_NEED_X +=3D test-delta
 TEST_PROGRAMS_NEED_X +=3D test-dump-cache-tree
+TEST_PROGRAMS_NEED_X +=3D test-dump-split-index
 TEST_PROGRAMS_NEED_X +=3D test-genrandom
 TEST_PROGRAMS_NEED_X +=3D test-hashmap
 TEST_PROGRAMS_NEED_X +=3D test-index-version
diff --git a/cache.h b/cache.h
index 7523c28..c6b7770 100644
--- a/cache.h
+++ b/cache.h
@@ -473,6 +473,8 @@ extern int daemonize(void);
 struct lock_file;
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const struct paths=
pec *pathspec);
+extern int do_read_index(struct index_state *istate, const char *path,
+			 int must_exist); /* for testting only! */
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
diff --git a/read-cache.c b/read-cache.c
index 12335a3..342fe52 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1463,8 +1463,7 @@ static struct cache_entry *create_from_disk(struc=
t ondisk_cache_entry *ondisk,
 }
=20
 /* remember to discard_cache() before reading a different cache! */
-static int do_read_index(struct index_state *istate, const char *path,
-			 int must_exist)
+int do_read_index(struct index_state *istate, const char *path, int mu=
st_exist)
 {
 	int fd, i;
 	struct stat st;
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
new file mode 100755
index 0000000..94fb473
--- /dev/null
+++ b/t/t1700-split-index.sh
@@ -0,0 +1,194 @@
+#!/bin/sh
+
+test_description=3D'split index mode tests'
+
+. ./test-lib.sh
+
+# We need total control of index splitting here
+sane_unset GIT_TEST_SPLIT_INDEX
+
+test_expect_success 'enable split index' '
+	git update-index --split-index &&
+	test-dump-split-index .git/index >actual &&
+	cat >expect <<EOF &&
+own 8299b0bcd1ac364e5f1d7768efb62fa2da79a339
+base 39d890139ee5356c7ef572216cebcd27aa41f9df
+replacements:
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add one file' '
+	: >one &&
+	git update-index --add one &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+base 39d890139ee5356c7ef572216cebcd27aa41f9df
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+replacements:
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'disable split index' '
+	git update-index --no-split-index &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	BASE=3D`test-dump-split-index .git/index | grep "^own" | sed "s/own/b=
ase/"` &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+not a split index
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'enable split index again, "one" now belongs to ba=
se index"' '
+	git update-index --split-index &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'modify original file, base index untouched' '
+	echo modified >one &&
+	git update-index one &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	q_to_tab >expect <<EOF &&
+$BASE
+100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
+replacements: 0
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add another file, which stays index' '
+	: >two &&
+	git update-index --add two &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	q_to_tab >expect <<EOF &&
+$BASE
+100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+replacements: 0
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'remove file not in base index' '
+	git update-index --force-remove two &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	q_to_tab >expect <<EOF &&
+$BASE
+100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
+replacements: 0
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'remove file in base index' '
+	git update-index --force-remove one &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions: 0
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add original file back' '
+	: >one &&
+	git update-index --add one &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+replacements:
+deletions: 0
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add new file' '
+	: >two &&
+	git update-index --add two &&
+	git ls-files --stage >actual &&
+	cat >expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'unify index, two files remain' '
+	git update-index --no-split-index &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+EOF
+	test_cmp ls-files.expect ls-files.actual
+
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+not a split index
+EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/test-dump-split-index.c b/test-dump-split-index.c
new file mode 100644
index 0000000..9cf3112
--- /dev/null
+++ b/test-dump-split-index.c
@@ -0,0 +1,34 @@
+#include "cache.h"
+#include "split-index.h"
+#include "ewah/ewok.h"
+
+static void show_bit(size_t pos, void *data)
+{
+	printf(" %d", (int)pos);
+}
+
+int main(int ac, char **av)
+{
+	struct split_index *si;
+	int i;
+
+	do_read_index(&the_index, av[1], 1);
+	printf("own %s\n", sha1_to_hex(the_index.sha1));
+	si =3D the_index.split_index;
+	if (!si) {
+		printf("not a split index\n");
+		return 0;
+	}
+	printf("base %s\n", sha1_to_hex(si->base_sha1));
+	for (i =3D 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce =3D the_index.cache[i];
+		printf("%06o %s %d\t%s\n", ce->ce_mode,
+		       sha1_to_hex(ce->sha1), ce_stage(ce), ce->name);
+	}
+	printf("replacements:");
+	ewah_each_bit(si->replace_bitmap, show_bit, NULL);
+	printf("\ndeletions:");
+	ewah_each_bit(si->delete_bitmap, show_bit, NULL);
+	printf("\n");
+	return 0;
+}
--=20
1.9.1.346.ga2b5940
