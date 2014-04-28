From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/32] t1700: new tests for split-index mode
Date: Mon, 28 Apr 2014 17:55:53 +0700
Message-ID: <1398682553-11634-33-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:57:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejFh-0004Ju-Nt
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbaD1K53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:57:29 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:55923 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbaD1K5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:57:24 -0400
Received: by mail-pd0-f174.google.com with SMTP id z10so4823888pdj.33
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=p4YWi+LNGOIPeRt/ULjTVJYnhLiT4kLYPC4Vn6AnXik=;
        b=eKyrb9c/2n0TZ7SOuwOrUyOVt8nVt39A0Cgh87Ujl5b6stx7tk7l7gIkfrTzCLmWwB
         KH0Ub2GBUe69NdxrnHaYw0RXAaDozCFB8vl8RwI9tP/OX/kICjft3rqFVzF0phW6rY9w
         w+tCNMLkQ8wNlvE4gI1P9mVnkZEn9x/oIY0TWoESu7zAo4chDaYMuKXu6dyLom3xGXtn
         VuWP/tCgEv2prUUgjhwEVAoOd/vOoeGmxyjPwOYgFdLniaQ7jcX/nRGHRM495HSM9PwO
         m01l62DQQ6IeZCH6wN80q+Z6ZCbX6t/iZALSjHOhAX9YARK7nIHOYvqQVaIf8OgcRjo/
         7aRA==
X-Received: by 10.66.155.7 with SMTP id vs7mr24586169pab.42.1398682643609;
        Mon, 28 Apr 2014 03:57:23 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id bc4sm34259495pbb.2.2014.04.28.03.57.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:57:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:58:51 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247295>

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
index c3957bb..e39a4f5 100644
--- a/Makefile
+++ b/Makefile
@@ -562,6 +562,7 @@ TEST_PROGRAMS_NEED_X +=3D test-ctype
 TEST_PROGRAMS_NEED_X +=3D test-date
 TEST_PROGRAMS_NEED_X +=3D test-delta
 TEST_PROGRAMS_NEED_X +=3D test-dump-cache-tree
+TEST_PROGRAMS_NEED_X +=3D test-dump-split-index
 TEST_PROGRAMS_NEED_X +=3D test-genrandom
 TEST_PROGRAMS_NEED_X +=3D test-hashmap
 TEST_PROGRAMS_NEED_X +=3D test-index-version
diff --git a/cache.h b/cache.h
index 42cdfe6..6ad2595 100644
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
index 831b67e..159c3e8 100644
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
index 0000000..42fb4f4
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
+	for (i =3D 0; i< the_index.cache_nr; i++) {
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
