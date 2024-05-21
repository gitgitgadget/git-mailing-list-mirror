Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2F149C54
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321454; cv=none; b=jCOr/mcDdNm+JjTuMUjdRyz+/QaB9au42yzbvCLtmLbVS+Tlybq+70J/MouFh42qw7j0LADLoMkent+C3oCGlQtWOYeQGtS3qxh479wofK5Hjh1H/eyaNNDCmLGces9rDAYkUZz2/5TmKvVZR4PsAi3U8LQvom+KFtzNonWoOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321454; c=relaxed/simple;
	bh=bT9U6JZaSx5HPrksYCIgmRPWw2qdVvhiv+QJenj9zjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXGcm/wfpQYDzXgBWr5t0ifqpfyKHBmesuOag+vphIkpkDG7h1r0nPkGYtPf+wGSR89gQSlZrSxj1KGsqbdSm8AD+nVTDX8udVzxtTjm/729zpR76rL46aWNpMDHn6hM0qspUOMd3Mxs+bArOet6xDSKdnwtgPAiPuzSUC5qmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NIZHdT7V; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NIZHdT7V"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AA8522290;
	Tue, 21 May 2024 15:57:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=bT9U6JZaSx5HPrksYCIgmRPWw
	2qdVvhiv+QJenj9zjQ=; b=NIZHdT7V9YSXnu1U9rafT/R39dpnk1MvX1hybLHGt
	W85gYpUe6rhfjnrsej/25WjkeJy0aA9XAbuMMyWxchjlikGh/Gr3CM2qIOeU0E0s
	9i+uhGB43/fanoEyntXrlz/jKnrWjbOMGdMezkSmMYGqSw4tvhBTYbWTYuRgGsGo
	8k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 023C22228F;
	Tue, 21 May 2024 15:57:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D9F72228E;
	Tue, 21 May 2024 15:57:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 11/12] Revert "Add a helper function to compare file contents"
Date: Tue, 21 May 2024 12:56:57 -0700
Message-ID: <20240521195659.870714-12-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <20240521195659.870714-1-gitster@pobox.com>
References: <20240521195659.870714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 5BD0C3D8-17AC-11EF-832F-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that during a `git clone`, the hooks' contents are no longer
compared to the templates' files', the caller for which the
`do_files_match()` function was introduced is gone, and therefore this
function can be retired, too.

This reverts commit 584de0b4c23 (Add a helper function to compare file
contents, 2024-03-30).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                    | 14 ---------
 copy.c                     | 58 --------------------------------------
 t/helper/test-path-utils.c | 10 -------
 t/t0060-path-utils.sh      | 41 ---------------------------
 4 files changed, 123 deletions(-)

diff --git a/cache.h b/cache.h
index 16b34799bf..8c5fb1e1ba 100644
--- a/cache.h
+++ b/cache.h
@@ -1785,20 +1785,6 @@ int copy_fd(int ifd, int ofd);
 int copy_file(const char *dst, const char *src, int mode);
 int copy_file_with_time(const char *dst, const char *src, int mode);
=20
-/*
- * Compare the file mode and contents of two given files.
- *
- * If both files are actually symbolic links, the function returns 1 if =
the link
- * targets are identical or 0 if they are not.
- *
- * If any of the two files cannot be accessed or in case of read failure=
s, this
- * function returns 0.
- *
- * If the file modes and contents are identical, the function returns 1,
- * otherwise it returns 0.
- */
-int do_files_match(const char *path1, const char *path2);
-
 void write_or_die(int fd, const void *buf, size_t count);
 void fsync_or_die(int fd, const char *);
 int fsync_component(enum fsync_component component, int fd);
diff --git a/copy.c b/copy.c
index 8492f6fc83..4de6a110f0 100644
--- a/copy.c
+++ b/copy.c
@@ -65,61 +65,3 @@ int copy_file_with_time(const char *dst, const char *s=
rc, int mode)
 		return copy_times(dst, src);
 	return status;
 }
-
-static int do_symlinks_match(const char *path1, const char *path2)
-{
-	struct strbuf buf1 =3D STRBUF_INIT, buf2 =3D STRBUF_INIT;
-	int ret =3D 0;
-
-	if (!strbuf_readlink(&buf1, path1, 0) &&
-	    !strbuf_readlink(&buf2, path2, 0))
-		ret =3D !strcmp(buf1.buf, buf2.buf);
-
-	strbuf_release(&buf1);
-	strbuf_release(&buf2);
-	return ret;
-}
-
-int do_files_match(const char *path1, const char *path2)
-{
-	struct stat st1, st2;
-	int fd1 =3D -1, fd2 =3D -1, ret =3D 1;
-	char buf1[8192], buf2[8192];
-
-	if ((fd1 =3D open_nofollow(path1, O_RDONLY)) < 0 ||
-	    fstat(fd1, &st1) || !S_ISREG(st1.st_mode)) {
-		if (fd1 < 0 && errno =3D=3D ELOOP)
-			/* maybe this is a symbolic link? */
-			return do_symlinks_match(path1, path2);
-		ret =3D 0;
-	} else if ((fd2 =3D open_nofollow(path2, O_RDONLY)) < 0 ||
-		   fstat(fd2, &st2) || !S_ISREG(st2.st_mode)) {
-		ret =3D 0;
-	}
-
-	if (ret)
-		/* to match, neither must be executable, or both */
-		ret =3D !(st1.st_mode & 0111) =3D=3D !(st2.st_mode & 0111);
-
-	if (ret)
-		ret =3D st1.st_size =3D=3D st2.st_size;
-
-	while (ret) {
-		ssize_t len1 =3D read_in_full(fd1, buf1, sizeof(buf1));
-		ssize_t len2 =3D read_in_full(fd2, buf2, sizeof(buf2));
-
-		if (len1 < 0 || len2 < 0 || len1 !=3D len2)
-			ret =3D 0; /* read error or different file size */
-		else if (!len1) /* len2 is also 0; hit EOF on both */
-			break; /* ret is still true */
-		else
-			ret =3D !memcmp(buf1, buf2, len1);
-	}
-
-	if (fd1 >=3D 0)
-		close(fd1);
-	if (fd2 >=3D 0)
-		close(fd2);
-
-	return ret;
-}
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 0e0de21807..f69709d674 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -495,16 +495,6 @@ int cmd__path_utils(int argc, const char **argv)
 		return !!res;
 	}
=20
-	if (argc =3D=3D 4 && !strcmp(argv[1], "do_files_match")) {
-		int ret =3D do_files_match(argv[2], argv[3]);
-
-		if (ret)
-			printf("equal\n");
-		else
-			printf("different\n");
-		return !ret;
-	}
-
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 73d0e1a7f1..68e29c904a 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -560,45 +560,4 @@ test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXE=
C_IN_PWD '%(prefix)/ works'
 	test_cmp expect actual
 '
=20
-test_expect_success 'do_files_match()' '
-	test_seq 0 10 >0-10.txt &&
-	test_seq -1 10 >-1-10.txt &&
-	test_seq 1 10 >1-10.txt &&
-	test_seq 1 9 >1-9.txt &&
-	test_seq 0 8 >0-8.txt &&
-
-	test-tool path-utils do_files_match 0-10.txt 0-10.txt >out &&
-
-	assert_fails() {
-		test_must_fail \
-		test-tool path-utils do_files_match "$1" "$2" >out &&
-		grep different out
-	} &&
-
-	assert_fails 0-8.txt 1-9.txt &&
-	assert_fails -1-10.txt 0-10.txt &&
-	assert_fails 1-10.txt 1-9.txt &&
-	assert_fails 1-10.txt .git &&
-	assert_fails does-not-exist 1-10.txt &&
-
-	if test_have_prereq FILEMODE
-	then
-		cp 0-10.txt 0-10.x &&
-		chmod a+x 0-10.x &&
-		assert_fails 0-10.txt 0-10.x
-	fi &&
-
-	if test_have_prereq SYMLINKS
-	then
-		ln -sf 0-10.txt symlink &&
-		ln -s 0-10.txt another-symlink &&
-		ln -s over-the-ocean yet-another-symlink &&
-		ln -s "$PWD/0-10.txt" absolute-symlink &&
-		assert_fails 0-10.txt symlink &&
-		test-tool path-utils do_files_match symlink another-symlink &&
-		assert_fails symlink yet-another-symlink &&
-		assert_fails symlink absolute-symlink
-	fi
-'
-
 test_done
--=20
2.45.1-216-g4365c6fcf9

