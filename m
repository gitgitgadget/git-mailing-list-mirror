From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/19] t7063: tests for untracked cache
Date: Mon, 27 Oct 2014 19:10:46 +0700
Message-ID: <1414411846-4450-20-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:12:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XijAG-0003ea-4Z
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbaJ0MMi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:12:38 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:53444 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbaJ0MMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:12:25 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so5557152pde.32
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gA2P3p8j15S9ijBLCOiOnnH4M6i+/xuAut96h8Glw6Q=;
        b=Nj2r3T4mS1Wrh9uNYJT7AGvF+U1YkNlw6beOpk5p2+t/MWX8/gCFvFl2sR/CFcLF3D
         FT1G1pKupxCjdwUz9N2D/v3TKUx9oNCKOjOycBeeImv5D+QVwJ8Es8rPChwq9Z//05/Z
         ayfDtdcb6JtewBW3G7a6YUA+fYdZnJfFl0iey0o70A96Z1CDksvo/Z0iV1k6niywrdPx
         QkBZVbX3ivKExiturcor00Vb8+wlELZJEgYDT1ivN2+VnZ8mG78NFjpL31MtTXwbTe/I
         XE/iz0gGzZDO4xKjYzm3cdSjn1jfz2NAjQun2MllPHKkjcxTQX1kneEHEAGTj2q7BEaS
         JThg==
X-Received: by 10.67.14.129 with SMTP id fg1mr9620192pad.114.1414411944951;
        Mon, 27 Oct 2014 05:12:24 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id vt1sm10856638pab.17.2014.10.27.05.12.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:12:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:12:27 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                                 |   1 +
 Makefile                                   |   1 +
 t/t7063-status-untracked-cache.sh (new +x) | 353 +++++++++++++++++++++=
++++++++
 test-dump-untracked-cache.c (new)          |  61 +++++
 4 files changed, 416 insertions(+)
 create mode 100755 t/t7063-status-untracked-cache.sh
 create mode 100644 test-dump-untracked-cache.c

diff --git a/.gitignore b/.gitignore
index 9ec40fa..fde1143 100644
--- a/.gitignore
+++ b/.gitignore
@@ -183,6 +183,7 @@
 /test-delta
 /test-dump-cache-tree
 /test-dump-split-index
+/test-dump-untracked-cache
 /test-scrap-cache-tree
 /test-genrandom
 /test-hashmap
diff --git a/Makefile b/Makefile
index 356feb5..8070e56 100644
--- a/Makefile
+++ b/Makefile
@@ -552,6 +552,7 @@ TEST_PROGRAMS_NEED_X +=3D test-date
 TEST_PROGRAMS_NEED_X +=3D test-delta
 TEST_PROGRAMS_NEED_X +=3D test-dump-cache-tree
 TEST_PROGRAMS_NEED_X +=3D test-dump-split-index
+TEST_PROGRAMS_NEED_X +=3D test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X +=3D test-genrandom
 TEST_PROGRAMS_NEED_X +=3D test-hashmap
 TEST_PROGRAMS_NEED_X +=3D test-index-version
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untrack=
ed-cache.sh
new file mode 100755
index 0000000..2b2ffd7
--- /dev/null
+++ b/t/t7063-status-untracked-cache.sh
@@ -0,0 +1,353 @@
+#!/bin/sh
+
+test_description=3D'test untracked cache'
+
+. ./test-lib.sh
+
+avoid_racy() {
+	sleep 1
+}
+
+git update-index --untracked-cache
+# It's fine if git update-index returns an error code other than one,
+# it'll be caught in the first test.
+if test $? -eq 1; then
+	skip_all=3D'This system does not support untracked cache'
+	test_done
+fi
+
+test_expect_success 'setup' '
+	git init worktree &&
+	cd worktree &&
+	mkdir done dtwo dthree &&
+	touch one two three done/one dtwo/two dthree/three &&
+	git add one two done/one &&
+	: >.git/info/exclude &&
+	git update-index --untracked-cache
+'
+
+test_expect_success 'untracked cache is empty' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 0000000000000000000000000000000000000000
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+EOF
+	test_cmp ../expect ../actual
+'
+
+cat >../status.expect <<EOF &&
+A  done/one
+A  one
+A  two
+?? dthree/
+?? dtwo/
+?? three
+EOF
+
+cat >../dump.expect <<EOF &&
+info/exclude e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ 0000000000000000000000000000000000000000 recurse valid
+dthree/
+dtwo/
+three
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only v=
alid
+three
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only val=
id
+two
+EOF
+
+test_expect_success 'status first time (empty cache)' '
+	avoid_racy &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 3
+gitignore invalidation: 1
+directory invalidation: 0
+opendir: 4
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'untracked cache after first status' '
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../dump.expect ../actual
+'
+
+test_expect_success 'status second time (fully populated cache)' '
+	avoid_racy &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 0
+opendir: 0
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'untracked cache after second status' '
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../dump.expect ../actual
+'
+
+test_expect_success 'modify in root directory, one dir invalidation' '
+	avoid_racy &&
+	: >four &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	cat >../status.expect <<EOF &&
+A  done/one
+A  one
+A  two
+?? dthree/
+?? dtwo/
+?? four
+?? three
+EOF
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 1
+opendir: 1
+EOF
+	test_cmp ../trace.expect ../trace
+
+'
+
+test_expect_success 'verify untracked cache dump' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ 0000000000000000000000000000000000000000 recurse valid
+dthree/
+dtwo/
+four
+three
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only v=
alid
+three
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only val=
id
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'new .gitignore invalidates recursively' '
+	avoid_racy &&
+	echo four >.gitignore &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	cat >../status.expect <<EOF &&
+A  done/one
+A  one
+A  two
+?? .gitignore
+?? dthree/
+?? dtwo/
+?? three
+EOF
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 1
+directory invalidation: 1
+opendir: 4
+EOF
+	test_cmp ../trace.expect ../trace
+
+'
+
+test_expect_success 'verify untracked cache dump' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dthree/
+dtwo/
+three
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only v=
alid
+three
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only val=
id
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'new info/exclude invalidates everything' '
+	avoid_racy &&
+	echo three >>.git/info/exclude &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	cat >../status.expect <<EOF &&
+A  done/one
+A  one
+A  two
+?? .gitignore
+?? dtwo/
+EOF
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 1
+directory invalidation: 0
+opendir: 4
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'verify untracked cache dump' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dtwo/
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only v=
alid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only val=
id
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'move two from tracked to untracked' '
+	git rm --cached two &&
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only v=
alid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only val=
id
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'status after the move' '
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	cat >../status.expect <<EOF &&
+A  done/one
+A  one
+?? .gitignore
+?? dtwo/
+?? two
+EOF
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 0
+opendir: 1
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'verify untracked cache dump' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dtwo/
+two
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only v=
alid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only val=
id
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'move two from untracked to tracked' '
+	git add two &&
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only v=
alid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only val=
id
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'status after the move' '
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	cat >../status.expect <<EOF &&
+A  done/one
+A  one
+A  two
+?? .gitignore
+?? dtwo/
+EOF
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 0
+opendir: 1
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'verify untracked cache dump' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dtwo/
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only v=
alid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only val=
id
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_done
diff --git a/test-dump-untracked-cache.c b/test-dump-untracked-cache.c
new file mode 100644
index 0000000..710441e
--- /dev/null
+++ b/test-dump-untracked-cache.c
@@ -0,0 +1,61 @@
+#include "cache.h"
+#include "dir.h"
+
+static int compare_untracked(const void *a_, const void *b_)
+{
+	const char *const *a =3D a_;
+	const char *const *b =3D b_;
+	return strcmp(*a, *b);
+}
+
+static int compare_dir(const void *a_, const void *b_)
+{
+	const struct untracked_cache_dir *const *a =3D a_;
+	const struct untracked_cache_dir *const *b =3D b_;
+	return strcmp((*a)->name, (*b)->name);
+}
+
+static void dump(struct untracked_cache_dir *ucd, struct strbuf *base)
+{
+	int i, len;
+	qsort(ucd->untracked, ucd->untracked_nr, sizeof(*ucd->untracked),
+	      compare_untracked);
+	qsort(ucd->dirs, ucd->dirs_nr, sizeof(*ucd->dirs),
+	      compare_dir);
+	len =3D base->len;
+	strbuf_addf(base, "%s/", ucd->name);
+	printf("%s %s", base->buf,
+	       sha1_to_hex(ucd->exclude_sha1));
+	if (ucd->recurse)
+		fputs(" recurse", stdout);
+	if (ucd->check_only)
+		fputs(" check_only", stdout);
+	if (ucd->valid)
+		fputs(" valid", stdout);
+	printf("\n");
+	for (i =3D 0; i < ucd->untracked_nr; i++)
+		printf("%s\n", ucd->untracked[i]);
+	for (i =3D 0; i < ucd->dirs_nr; i++)
+		dump(ucd->dirs[i], base);
+	strbuf_setlen(base, len);
+}
+
+int main(int ac, char **av)
+{
+	struct untracked_cache *uc;
+	struct strbuf base =3D STRBUF_INIT;
+	if (read_cache() < 0)
+		die("unable to read index file");
+	uc =3D the_index.untracked;
+	if (!uc) {
+		printf("no untracked cache\n");
+		return 0;
+	}
+	printf("info/exclude %s\n", sha1_to_hex(uc->ss_info_exclude.sha1));
+	printf("core.excludesfile %s\n", sha1_to_hex(uc->ss_excludes_file.sha=
1));
+	printf("exclude_per_dir %s\n", uc->exclude_per_dir);
+	printf("flags %08x\n", uc->dir_flags);
+	if (uc->root)
+		dump(uc->root, &base);
+	return 0;
+}
--=20
2.1.0.rc0.78.gc0d8480
