Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F96C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbiEIR7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiEIR7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:59:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D62D7EFA
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j6so28290558ejc.13
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwjxKAKdPbouom9Cr304/LSN8cavkfWeLbLstB0JAYg=;
        b=ipNmewb82r3tB+8kdIPVwzbHYF4gawnAbhBmPbhbMF07IGMCcm253SK29OfUeqOggj
         J1n/qB6JvMibDzhDDljPmhWPIux4EebkwuZS7gLjJrycqVl1BHNDQLrwgtQt4ic9P+Tp
         JovNj9WArF/8myZ8JjMakUSJy0Fhw4nwCGjkcW779slFFKmwjlSp0ZZAnF7PnRQQYIpf
         qywyqcwmnDRjQrhwGYs1nWGSZa79GhP48osoHFj4334in8UVM0g6cEUi/jubj0jZAM+J
         k/3OapjHcx2td34EA0PHUOZiKDFiIFLB5dS2jwwqZ+BEUPU3yNg+TgbB24AIwic+UYV+
         b68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwjxKAKdPbouom9Cr304/LSN8cavkfWeLbLstB0JAYg=;
        b=xp3+gS5I0pAq6eEcgpZpFYbRVrIgX9KxBy4Ic/Af9We4fEv1ApBvgRz6+m9WE9i/vL
         dZ96syG8qr/hd/tWNXjY0gpGJ71hUmMa+YvbzarxOkkck7H7V8StBfIz6aIAZbhyuYyP
         5FXOgH5ajfKg8ODxpgn6CSthtpymcj+7fTTzH6TSsWdCcqNYnGD1HMv0kHZJbyg+Qyb2
         GfPyhGHpadtc8Hfr36+rkOy9CX6Ljp3kexudZyo5VSOMzQ2mbCSLSRDOkgb+2GW5Pqut
         LiCCRK8glQVRfwLJTHr68fNhbpST4QJ/F+O4BoqbJApZRBk1yqh4RIRFNBA3YzmvDgyx
         nWsg==
X-Gm-Message-State: AOAM531Zkl56+9OVn5SfTwFLLTPHUr99Byu3WpI9X2VtDjPReQ8vA5y1
        m6vZN/YOsSLW5EaVTd8IVTC3GE1YL24=
X-Google-Smtp-Source: ABdhPJwOHx+n3iMsolSoDEvhbViUnsU7VGdV7A0QEANk1fn3Z32dWDmCQC2C7o51bp4bUoyDHDrtbw==
X-Received: by 2002:a17:907:70c4:b0:6f3:d23f:d711 with SMTP id yk4-20020a17090770c400b006f3d23fd711mr15165149ejb.205.1652118915358;
        Mon, 09 May 2022 10:55:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:55:15 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 14/15] dir-iterator: option to iterate dirs in post-order
Date:   Mon,  9 May 2022 20:51:58 +0300
Message-Id: <20220509175159.2948802-15-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new option to dir-iterator, using dir_iterator_begin()
flags parameter, allowing to control whether or not directories will
be exposed after their contents. In essence, post-order traversal over
file system entries that are directories.

This new iteration scheme can be enabled with DIR_ITERATOR_DIRS_AFTER
flag which iterates over a directory after doing so over its contents.
The existing flag DIR_ITERATOR_DIRS_BEFORE can be combined with the new
flag DIR_ITERATOR_DIRS_AFTER in any way. These flags do not conflict
with each other and can be combined to:
  * ignore directories by not setting either of them
  * iterate directories pre-order and post-order by enabling both
  * iterate directories pre-order by enabling DIR_ITERATOR_DIRS_BEFORE
  * iterate directories post-order by enabling DIR_ITERATOR_DIRS_AFTER

Update t/t0066-dir-iterator.sh and t/helper/test-dir-iterator.c to test
the new iteration scheme the new flag DIR_ITERATOR_DIRS_AFTER enables.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 dir-iterator.c               |  95 ++++-
 dir-iterator.h               |  17 +-
 t/helper/test-dir-iterator.c |   6 +-
 t/t0066-dir-iterator.sh      | 744 +++++++++++++++++++++++++++++++++--
 4 files changed, 828 insertions(+), 34 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index c1475add27..dec15317f0 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -133,10 +133,17 @@ static int expose_entry(struct dir_iterator_int *iter, char *d_name, char *dir_s
 {
 	int stat_err;
 	unsigned int DIRS_BEFORE = iter->flags & DIR_ITERATOR_DIRS_BEFORE;
+	unsigned int DIRS_AFTER = iter->flags & DIR_ITERATOR_DIRS_AFTER;
 
 	strbuf_addch(&iter->base.path, '/');
 	strbuf_addstr(&iter->base.path, d_name);
 
+	/*
+	 * We've got to check whether or not this is a directory.
+	 * We need to perform this check since the user could've requested
+	 * to ignore directory entries.
+	 */
+
 	if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
 		stat_err = stat(iter->base.path.buf, &iter->base.st);
 	else
@@ -158,6 +165,9 @@ static int expose_entry(struct dir_iterator_int *iter, char *d_name, char *dir_s
 	if (S_ISDIR(iter->base.st.st_mode)) {
 		if (!DIRS_BEFORE && !strcmp(dir_state, "before"))
 			return FAIL_IGN_DIRS;
+
+		if (!DIRS_AFTER && !strcmp(dir_state, "after"))
+			return FAIL_IGN_DIRS;
 	}
 
 	/*
@@ -173,6 +183,36 @@ static int expose_entry(struct dir_iterator_int *iter, char *d_name, char *dir_s
 	return OK;
 }
 
+/*
+ * Get the basename of the current directory.
+ *
+ * Using iter->base.path.buf, find the current dir basename.
+ */
+static char *current_dir_basename(struct dir_iterator_int *iter)
+{
+	char *start = strrchr(iter->base.path.buf, '/');
+	char *basename = NULL;
+
+	if (!start) {
+		/*
+		 * dir-iterator's implementation searches for '/' characters to
+		 * figure out the "active" directory part. Therefore, in this
+		 * case, the current path is the current directory part.
+		 */
+
+		start = iter->base.path.buf;
+	} else {
+		start += 1;  /* Skip '/' character */
+	}
+
+	if (!(basename = calloc(1, strlen(start) + 1)))
+		die_errno("calloc");
+
+	memcpy(basename, start, strlen(start));
+
+	return basename;
+}
+
 int dir_iterator_advance(struct dir_iterator *dir_iterator)
 {
 	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
@@ -200,9 +240,28 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 		 * Therefore, there isn't any case to run out of levels.
 		 */
 
+		/*
+		 * We need to make sure, in case DIRS_AFTER is enabled, to
+		 * expose the entry in order to be consistent with what
+		 * DIRS_BEFORE exposes in case of failed `opendir()` call.
+		 */
+
+		char *d_name = current_dir_basename(iter);
+
 		--iter->levels_nr;
 
-		return dir_iterator_advance(dir_iterator);
+		level = &iter->levels[iter->levels_nr - 1];
+		strbuf_setlen(&iter->base.path, level->prefix_len);
+
+		expose_err = expose_entry(iter, d_name, "after");
+		free(d_name);
+
+		if (expose_err == FAIL_NOT_ENOENT && PEDANTIC)
+			goto error_out;
+		else if (expose_err != OK)
+			return dir_iterator_advance(dir_iterator);
+		else
+			return ITER_OK;
 	}
 
 	strbuf_setlen(&iter->base.path, level->prefix_len);
@@ -220,12 +279,42 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 		} else {
 			/*
 			 * Current directory has been iterated through.
+			 * We need to check if we need to expose current dir
+			 * because of DIRS_AFTER flag.
 			 */
 
-			if (pop_level(iter) == 0)
+			char* d_name = current_dir_basename(iter);
+
+			/*
+			 * We don't care to expose the root directory.
+			 * Users of this API know when iteration starts on root
+			 * directory - they call `dir_iterator_begin()` - and
+			 * when ITER_DONE is returned they know when it's over.
+			 */
+
+			/*
+			 * Call to `pop_level()` needs to preceed call to
+			 * `expose_entry()` because `expose_entry()` appends to
+			 * current `iter->base` and we need to set it up.
+			 */
+
+			if (pop_level(iter) == 0) {
+				free(d_name);
 				return dir_iterator_abort(dir_iterator);
+			}
 
-			return dir_iterator_advance(dir_iterator);
+			level = &iter->levels[iter->levels_nr - 1];
+			strbuf_setlen(&iter->base.path, level->prefix_len);
+
+			expose_err = expose_entry(iter, d_name, "after");
+			free(d_name);
+
+			if (expose_err == FAIL_NOT_ENOENT && PEDANTIC)
+				goto error_out;
+			else if (expose_err != OK)
+				return dir_iterator_advance(dir_iterator);
+			else
+				return ITER_OK;
 		}
 	}
 
diff --git a/dir-iterator.h b/dir-iterator.h
index c1d16a8c6d..825db6b9b8 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -16,9 +16,10 @@
  * the dir_iterator structure to reflect the next path in the
  * iteration. The order that paths are iterated over within a
  * directory is undefined. Directory paths are given before their
- * contents when DIR_ITERATOR_DIRS_BEFORE is set. Failure to set this
- * flag results in directory paths not being exposed. Instead, iteration
- * will happen within directories. Their contents will be exposed.
+ * contents when DIR_ITERATOR_DIRS_BEFORE is set and after when
+ * DIR_ITERATOR_DIRS_AFTER is set. Failure to set any of them results
+ * in directory paths not being exposed. Instead, iteration will happen
+ * within directories. Their contents will be exposed.
  *
  * A typical iteration looks like this:
  *
@@ -67,8 +68,13 @@
  * - DIR_ITERATOR_DIRS_BEFORE: make dir-iterator expose a directory path
  *   before iterating through that directory's contents.
  *
- * Note: Activating none of the flags will iterate through directories'
- * contents but won't expose the directory paths.
+ * - DIR_ITERATOR_DIRS_AFTER: make dir-iterator expose a directory path after
+ *   iterating through that directory's contents.
+ *
+ * Note: any combination of DIR_ITERATOR_BEFORE and DIR_ITERATOR_AFTER works.
+ * Activating both of them will expose directories when descending into one and
+ * when it's been exhausted. Activating none will iterate through directories'
+ * contents but won't expose the directories themselves.
  *
  * Warning: circular symlinks are also followed when
  * DIR_ITERATOR_FOLLOW_SYMLINKS is set. The iteration may end up with
@@ -77,6 +83,7 @@
 #define DIR_ITERATOR_PEDANTIC (1 << 0)
 #define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
 #define DIR_ITERATOR_DIRS_BEFORE (1 << 2)
+#define DIR_ITERATOR_DIRS_AFTER (1 << 3)
 
 struct dir_iterator {
 	/* The current path: */
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index f05d5fde9d..ac5f368335 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -23,9 +23,9 @@ static const char *error_name(int error_number)
  *	--follow-symlinks
  *	--pedantic
  *	--dirs-before
+ *	--dirs-after
  *
- * example:
- * test-tool dir-iterator --pedantic --dirs-before ./somedir
+ * test-tool dir-iterator --pedantic --dirs-before --dirs-after ./somedir
  */
 int cmd__dir_iterator(int argc, const char **argv)
 {
@@ -40,6 +40,8 @@ int cmd__dir_iterator(int argc, const char **argv)
 			flags |= DIR_ITERATOR_PEDANTIC;
 		else if (strcmp(*argv, "--dirs-before") == 0)
 			flags |= DIR_ITERATOR_DIRS_BEFORE;
+		else if (strcmp(*argv, "--dirs-after") == 0)
+			flags |= DIR_ITERATOR_DIRS_AFTER;
 		else
 			die("invalid option '%s'", *argv);
 	}
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index badd82d8a4..63d31b8f7d 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -25,6 +25,22 @@ test_expect_success 'dirs-before of dir with a file' '
 	test-tool dir-iterator --dirs-before ./dir1 >actual-out &&
 	test_cmp expected-out actual-out
 '
+test_expect_success 'dirs-after of dir with a file' '
+	cat >expected-out <<-EOF &&
+	[f] (a) [a] ./dir1/a
+	EOF
+
+	test-tool dir-iterator --dirs-after ./dir1 >actual-out &&
+	test_cmp expected-out actual-out
+'
+test_expect_success 'dirs-before/dirs-after of dir with a file' '
+	cat >expected-out <<-EOF &&
+	[f] (a) [a] ./dir1/a
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir1 >actual-out &&
+	test_cmp expected-out actual-out
+'
 
 test_expect_success 'setup -- dir with a single dir' '
 	mkdir -p dir2/a
@@ -44,6 +60,23 @@ test_expect_success 'dirs-before of dir with a single dir' '
 	test-tool dir-iterator --dirs-before ./dir2 >actual-out &&
 	test_cmp expected-out actual-out
 '
+test_expect_success 'dirs-after of dir with a single dir' '
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir2/a
+	EOF
+
+	test-tool dir-iterator --dirs-after ./dir2 >actual-out &&
+	test_cmp expected-out actual-out
+'
+test_expect_success 'dirs-before/dirs-after of dir with a single dir' '
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir2/a
+	[d] (a) [a] ./dir2/a
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir2 >actual-out &&
+	test_cmp expected-out actual-out
+'
 
 test_expect_success POSIXPERM,SANITY 'setup -- dir w/ single dir w/o perms' '
 	mkdir -p dir3/a
@@ -97,6 +130,62 @@ test_expect_success POSIXPERM,SANITY 'pedantic dirs-before of dir w/ dir w/o per
 
 	chmod 755 dir3/a
 '
+test_expect_success POSIXPERM,SANITY 'dirs-after of dir w/ dir w/o perms' '
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir3/a
+	EOF
+
+	chmod 0 dir3/a &&
+
+	test-tool dir-iterator --dirs-after ./dir3/ >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir3/a
+'
+test_expect_success POSIXPERM,SANITY 'pedantic dirs-after of dir w/ dir w/o perms' '
+	cat >expected-out <<-EOF &&
+	dir_iterator_advance failure: EACCES
+	EOF
+
+	chmod 0 dir3/a &&
+
+	test_must_fail test-tool dir-iterator --dirs-after \
+		--pedantic ./dir3/ >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir3/a
+'
+test_expect_success POSIXPERM,SANITY \
+'dirs-before/dirs-after of dir w/ dir w/o perms' '
+
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir3/a
+	[d] (a) [a] ./dir3/a
+	EOF
+
+	chmod 0 dir3/a &&
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir3/ >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir3/a
+'
+test_expect_success POSIXPERM,SANITY \
+'pedantic dirs-before/dirs-after of dir w/ dir w/o perms' '
+
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir3/a
+	dir_iterator_advance failure: EACCES
+	EOF
+
+	chmod 0 dir3/a &&
+
+	test_must_fail test-tool dir-iterator --dirs-before --dirs-after \
+		--pedantic ./dir3/ >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir3/a
+'
 
 test_expect_success 'setup -- dir w/ five files' '
 	mkdir dir4 &&
@@ -134,6 +223,34 @@ test_expect_success 'dirs-before of dir w/ five files' '
 
 	test_cmp expected-sorted-out actual-sorted-out
 '
+test_expect_success 'dirs-after of dir w/ five files' '
+	cat >expected-sorted-out <<-EOF &&
+	[f] (a) [a] ./dir4/a
+	[f] (b) [b] ./dir4/b
+	[f] (c) [c] ./dir4/c
+	[f] (d) [d] ./dir4/d
+	[f] (e) [e] ./dir4/e
+	EOF
+
+	test-tool dir-iterator --dirs-after ./dir4 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
+test_expect_success 'dirs-before/dirs-after of dir w/ five files' '
+	cat >expected-sorted-out <<-EOF &&
+	[f] (a) [a] ./dir4/a
+	[f] (b) [b] ./dir4/b
+	[f] (c) [c] ./dir4/c
+	[f] (d) [d] ./dir4/d
+	[f] (e) [e] ./dir4/e
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir4 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
 
 test_expect_success 'setup -- dir w/ dir w/ a file' '
 	mkdir -p dir5/a &&
@@ -156,6 +273,25 @@ test_expect_success 'dirs-before of dir w/ dir w/ a file' '
 	test-tool dir-iterator --dirs-before ./dir5 >actual-out &&
 	test_cmp expected-out actual-out
 '
+test_expect_success 'dirs-after of dir w/ dir w/ a file' '
+	cat >expected-after-out <<-EOF &&
+	[f] (a/b) [b] ./dir5/a/b
+	[d] (a) [a] ./dir5/a
+	EOF
+
+	test-tool dir-iterator --dirs-after ./dir5 >actual-out &&
+	test_cmp expected-after-out actual-out
+'
+test_expect_success 'dirs-before/dirs-after of dir w/ dir w/ a file' '
+	cat >expected-before-after-out <<-EOF &&
+	[d] (a) [a] ./dir5/a
+	[f] (a/b) [b] ./dir5/a/b
+	[d] (a) [a] ./dir5/a
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir5 >actual-out &&
+	test_cmp expected-before-after-out actual-out
+'
 
 test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
 	mkdir -p dir6/a/b/c &&
@@ -180,6 +316,31 @@ test_expect_success 'dirs-before of dir w/ three nested dirs w/ file' '
 	test-tool dir-iterator --dirs-before ./dir6 >actual-out &&
 	test_cmp expected-out actual-out
 '
+test_expect_success 'dirs-after of dir w/ three nested dirs w/ file' '
+	cat >expected-after-out <<-EOF &&
+	[f] (a/b/c/d) [d] ./dir6/a/b/c/d
+	[d] (a/b/c) [c] ./dir6/a/b/c
+	[d] (a/b) [b] ./dir6/a/b
+	[d] (a) [a] ./dir6/a
+	EOF
+
+	test-tool dir-iterator --dirs-after ./dir6 >actual-out &&
+	test_cmp expected-after-out actual-out
+'
+test_expect_success 'dirs-before/dirs-after of dir w/ three nested dirs w/ file' '
+	cat >expected-before-after-out <<-EOF &&
+	[d] (a) [a] ./dir6/a
+	[d] (a/b) [b] ./dir6/a/b
+	[d] (a/b/c) [c] ./dir6/a/b/c
+	[f] (a/b/c/d) [d] ./dir6/a/b/c/d
+	[d] (a/b/c) [c] ./dir6/a/b/c
+	[d] (a/b) [b] ./dir6/a/b
+	[d] (a) [a] ./dir6/a
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir6 >actual-out &&
+	test_cmp expected-before-after-out actual-out
+'
 
 test_expect_success POSIXPERM,SANITY \
 'setup -- dir w/ three nested dirs w/ file, second nested dir w/o perms' '
@@ -246,6 +407,70 @@ test_expect_success POSIXPERM,SANITY \
 
 	chmod 755 dir7/a/b
 '
+test_expect_success POSIXPERM,SANITY \
+'dirs-after of dir w/ three nested dirs w/ file, second w/o perms' '
+
+	cat >expected-out <<-EOF &&
+	[d] (a/b) [b] ./dir7/a/b
+	[d] (a) [a] ./dir7/a
+	EOF
+
+	chmod 0 dir7/a/b &&
+
+	test-tool dir-iterator --dirs-after ./dir7 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir7/a/b
+'
+test_expect_success POSIXPERM,SANITY \
+'pedantic dirs-after of dir w/ three nested dirs w/ file, second w/o perms' '
+
+	cat >expected-out <<-EOF &&
+	dir_iterator_advance failure: EACCES
+	EOF
+
+	chmod 0 dir7/a/b &&
+
+	test_must_fail test-tool dir-iterator --dirs-after \
+		--pedantic ./dir7 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir7/a/b
+'
+test_expect_success POSIXPERM,SANITY \
+'dirs-before/dirs-after of dir w/ three nested dirs w/ file, second w/o perms' '
+
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir7/a
+	[d] (a/b) [b] ./dir7/a/b
+	[d] (a/b) [b] ./dir7/a/b
+	[d] (a) [a] ./dir7/a
+	EOF
+
+	chmod 0 dir7/a/b &&
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir7 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir7/a/b
+'
+test_expect_success POSIXPERM,SANITY \
+'pedantic dirs-before/dirs-after of dir w/ three nested dirs w/ file, second w/o perms' '
+
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir7/a
+	[d] (a/b) [b] ./dir7/a/b
+	dir_iterator_advance failure: EACCES
+	EOF
+
+	chmod 0 dir7/a/b &&
+
+	test_must_fail test-tool dir-iterator --dirs-before --dirs-after \
+		--pedantic ./dir7 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir7/a/b
+'
 
 test_expect_success 'setup -- dir w/ two dirs each w/ file' '
 	mkdir -p dir8/a &&
@@ -289,6 +514,50 @@ test_expect_success 'dirs-before of dir w/ two dirs each w/ file' '
 		test_cmp expected-out2 actual-out
 	)
 '
+test_expect_success 'dirs-after of dir w/ two dirs each w/ file' '
+	cat >expected-out1 <<-EOF &&
+	[f] (a/b) [b] ./dir8/a/b
+	[d] (a) [a] ./dir8/a
+	[f] (c/d) [d] ./dir8/c/d
+	[d] (c) [c] ./dir8/c
+	EOF
+	cat >expected-out2 <<-EOF &&
+	[f] (c/d) [d] ./dir8/c/d
+	[d] (c) [c] ./dir8/c
+	[f] (a/b) [b] ./dir8/a/b
+	[d] (a) [a] ./dir8/a
+	EOF
+
+	test-tool dir-iterator --dirs-after ./dir8 >actual-out &&
+	(
+		test_cmp expected-out1 actual-out ||
+		test_cmp expected-out2 actual-out
+	)
+'
+test_expect_success 'dirs-before/dirs-after of dir w/ two dirs each w/ file' '
+	cat >expected-out1 <<-EOF &&
+	[d] (a) [a] ./dir8/a
+	[f] (a/b) [b] ./dir8/a/b
+	[d] (a) [a] ./dir8/a
+	[d] (c) [c] ./dir8/c
+	[f] (c/d) [d] ./dir8/c/d
+	[d] (c) [c] ./dir8/c
+	EOF
+	cat >expected-out2 <<-EOF &&
+	[d] (c) [c] ./dir8/c
+	[f] (c/d) [d] ./dir8/c/d
+	[d] (c) [c] ./dir8/c
+	[d] (a) [a] ./dir8/a
+	[f] (a/b) [b] ./dir8/a/b
+	[d] (a) [a] ./dir8/a
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir8 >actual-out &&
+	(
+		test_cmp expected-out1 actual-out ||
+		test_cmp expected-out2 actual-out
+	)
+'
 
 test_expect_success 'setup -- dir w/ two dirs, one w/ two and one w/ one files' '
 	mkdir -p dir9/a &&
@@ -369,35 +638,123 @@ test_expect_success \
 		test_cmp expected-out4 actual-out
 	)
 '
+test_expect_success \
+'dirs-after of dir w/ two dirs, one w/ two and one w/ one files' '
 
-test_expect_success 'setup -- dir w/ two nested dirs, each w/ file' '
-	mkdir -p dir10/a &&
-	>dir10/a/b &&
-	mkdir dir10/a/c &&
-	>dir10/a/c/d
-'
-test_expect_success 'dirs-ignore of dir w/ two nested dirs, each w/ file' '
 	cat >expected-out1 <<-EOF &&
-	[f] (a/b) [b] ./dir10/a/b
-	[f] (a/c/d) [d] ./dir10/a/c/d
+	[f] (a/b) [b] ./dir9/a/b
+	[f] (a/c) [c] ./dir9/a/c
+	[d] (a) [a] ./dir9/a
+	[f] (d/e) [e] ./dir9/d/e
+	[d] (d) [d] ./dir9/d
 	EOF
 	cat >expected-out2 <<-EOF &&
-	[f] (a/c/d) [d] ./dir10/a/c/d
-	[f] (a/b) [b] ./dir10/a/b
+	[f] (a/c) [c] ./dir9/a/c
+	[f] (a/b) [b] ./dir9/a/b
+	[d] (a) [a] ./dir9/a
+	[f] (d/e) [e] ./dir9/d/e
+	[d] (d) [d] ./dir9/d
 	EOF
-
-	test-tool dir-iterator ./dir10/ >actual-out &&
-	(
-		test_cmp expected-out1 actual-out ||
-		test_cmp expected-out2 actual-out
-	)
-'
-test_expect_success 'dirs-before of dir w/ two nested dirs, each w/ file' '
-	cat >expected-out1 <<-EOF &&
-	[d] (a) [a] ./dir10/a
-	[f] (a/b) [b] ./dir10/a/b
-	[d] (a/c) [c] ./dir10/a/c
-	[f] (a/c/d) [d] ./dir10/a/c/d
+	cat >expected-out3 <<-EOF &&
+	[f] (d/e) [e] ./dir9/d/e
+	[d] (d) [d] ./dir9/d
+	[f] (a/b) [b] ./dir9/a/b
+	[f] (a/c) [c] ./dir9/a/c
+	[d] (a) [a] ./dir9/a
+	EOF
+	cat >expected-out4 <<-EOF &&
+	[f] (d/e) [e] ./dir9/d/e
+	[d] (d) [d] ./dir9/d
+	[f] (a/c) [c] ./dir9/a/c
+	[f] (a/b) [b] ./dir9/a/b
+	[d] (a) [a] ./dir9/a
+	EOF
+
+	test-tool dir-iterator --dirs-after ./dir9 >actual-out &&
+	(
+		test_cmp expected-out1 actual-out ||
+		test_cmp expected-out2 actual-out ||
+		test_cmp expected-out3 actual-out ||
+		test_cmp expected-out4 actual-out
+	)
+'
+test_expect_success \
+'dirs-before/dirs-after of dir w/ two dirs, one w/ two and one w/ one files' '
+
+	cat >expected-out1 <<-EOF &&
+	[d] (a) [a] ./dir9/a
+	[f] (a/b) [b] ./dir9/a/b
+	[f] (a/c) [c] ./dir9/a/c
+	[d] (a) [a] ./dir9/a
+	[d] (d) [d] ./dir9/d
+	[f] (d/e) [e] ./dir9/d/e
+	[d] (d) [d] ./dir9/d
+	EOF
+	cat >expected-out2 <<-EOF &&
+	[d] (a) [a] ./dir9/a
+	[f] (a/c) [c] ./dir9/a/c
+	[f] (a/b) [b] ./dir9/a/b
+	[d] (a) [a] ./dir9/a
+	[d] (d) [d] ./dir9/d
+	[f] (d/e) [e] ./dir9/d/e
+	[d] (d) [d] ./dir9/d
+	EOF
+	cat >expected-out3 <<-EOF &&
+	[d] (d) [d] ./dir9/d
+	[f] (d/e) [e] ./dir9/d/e
+	[d] (d) [d] ./dir9/d
+	[d] (a) [a] ./dir9/a
+	[f] (a/b) [b] ./dir9/a/b
+	[f] (a/c) [c] ./dir9/a/c
+	[d] (a) [a] ./dir9/a
+	EOF
+	cat >expected-out4 <<-EOF &&
+	[d] (d) [d] ./dir9/d
+	[f] (d/e) [e] ./dir9/d/e
+	[d] (d) [d] ./dir9/d
+	[d] (a) [a] ./dir9/a
+	[f] (a/c) [c] ./dir9/a/c
+	[f] (a/b) [b] ./dir9/a/b
+	[d] (a) [a] ./dir9/a
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir9 >actual-out &&
+	(
+		test_cmp expected-out1 actual-out ||
+		test_cmp expected-out2 actual-out ||
+		test_cmp expected-out3 actual-out ||
+		test_cmp expected-out4 actual-out
+	)
+'
+
+test_expect_success 'setup -- dir w/ two nested dirs, each w/ file' '
+	mkdir -p dir10/a &&
+	>dir10/a/b &&
+	mkdir dir10/a/c &&
+	>dir10/a/c/d
+'
+test_expect_success 'dirs-ignore of dir w/ two nested dirs, each w/ file' '
+	cat >expected-out1 <<-EOF &&
+	[f] (a/b) [b] ./dir10/a/b
+	[f] (a/c/d) [d] ./dir10/a/c/d
+	EOF
+	cat >expected-out2 <<-EOF &&
+	[f] (a/c/d) [d] ./dir10/a/c/d
+	[f] (a/b) [b] ./dir10/a/b
+	EOF
+
+	test-tool dir-iterator ./dir10/ >actual-out &&
+	(
+		test_cmp expected-out1 actual-out ||
+		test_cmp expected-out2 actual-out
+	)
+'
+test_expect_success 'dirs-before of dir w/ two nested dirs, each w/ file' '
+	cat >expected-out1 <<-EOF &&
+	[d] (a) [a] ./dir10/a
+	[f] (a/b) [b] ./dir10/a/b
+	[d] (a/c) [c] ./dir10/a/c
+	[f] (a/c/d) [d] ./dir10/a/c/d
 	EOF
 	cat >expected-out2 <<-EOF &&
 	[d] (a) [a] ./dir10/a
@@ -412,6 +769,50 @@ test_expect_success 'dirs-before of dir w/ two nested dirs, each w/ file' '
 		test_cmp expected-out2 actual-out
 	)
 '
+test_expect_success 'dirs-after of dir w/ two nested dirs, each w/ file' '
+	cat >expected-out1 <<-EOF &&
+	[f] (a/b) [b] ./dir10/a/b
+	[f] (a/c/d) [d] ./dir10/a/c/d
+	[d] (a/c) [c] ./dir10/a/c
+	[d] (a) [a] ./dir10/a
+	EOF
+	cat >expected-out2 <<-EOF &&
+	[f] (a/c/d) [d] ./dir10/a/c/d
+	[d] (a/c) [c] ./dir10/a/c
+	[f] (a/b) [b] ./dir10/a/b
+	[d] (a) [a] ./dir10/a
+	EOF
+
+	test-tool dir-iterator --dirs-after ./dir10/ >actual-out &&
+	(
+		test_cmp expected-out1 actual-out ||
+		test_cmp expected-out2 actual-out
+	)
+'
+test_expect_success 'dirs-before/dirs-after of dir w/ two nested dirs, each w/ file' '
+	cat >expected-out1 <<-EOF &&
+	[d] (a) [a] ./dir10/a
+	[f] (a/b) [b] ./dir10/a/b
+	[d] (a/c) [c] ./dir10/a/c
+	[f] (a/c/d) [d] ./dir10/a/c/d
+	[d] (a/c) [c] ./dir10/a/c
+	[d] (a) [a] ./dir10/a
+	EOF
+	cat >expected-out2 <<-EOF &&
+	[d] (a) [a] ./dir10/a
+	[d] (a/c) [c] ./dir10/a/c
+	[f] (a/c/d) [d] ./dir10/a/c/d
+	[d] (a/c) [c] ./dir10/a/c
+	[f] (a/b) [b] ./dir10/a/b
+	[d] (a) [a] ./dir10/a
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir10 >actual-out &&
+	(
+		test_cmp expected-out1 actual-out ||
+		test_cmp expected-out2 actual-out
+	)
+'
 
 test_expect_success 'setup -- dir w/ complex structure' '
 	mkdir -p dir11 &&
@@ -457,6 +858,52 @@ test_expect_success 'dirs-before of dir w/ complex structure' '
 
 	test_cmp expected-sorted-out actual-sorted-out
 '
+test_expect_success 'dirs-after of dir w/ complex structure' '
+	cat >expected-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir11/a
+	[d] (a/b) [b] ./dir11/a/b
+	[d] (a/b/c) [c] ./dir11/a/b/c
+	[d] (d) [d] ./dir11/d
+	[d] (d/e) [e] ./dir11/d/e
+	[d] (d/e/d) [d] ./dir11/d/e/d
+	[f] (a/b/c/d) [d] ./dir11/a/b/c/d
+	[f] (a/e) [e] ./dir11/a/e
+	[f] (b) [b] ./dir11/b
+	[f] (c) [c] ./dir11/c
+	[f] (d/e/d/a) [a] ./dir11/d/e/d/a
+	EOF
+
+	test-tool dir-iterator --dirs-after ./dir11 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
+test_expect_success 'dirs-before/dirs-after of dir w/ complex structure' '
+	cat >expected-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir11/a
+	[d] (a) [a] ./dir11/a
+	[d] (a/b) [b] ./dir11/a/b
+	[d] (a/b) [b] ./dir11/a/b
+	[d] (a/b/c) [c] ./dir11/a/b/c
+	[d] (a/b/c) [c] ./dir11/a/b/c
+	[d] (d) [d] ./dir11/d
+	[d] (d) [d] ./dir11/d
+	[d] (d/e) [e] ./dir11/d/e
+	[d] (d/e) [e] ./dir11/d/e
+	[d] (d/e/d) [d] ./dir11/d/e/d
+	[d] (d/e/d) [d] ./dir11/d/e/d
+	[f] (a/b/c/d) [d] ./dir11/a/b/c/d
+	[f] (a/e) [e] ./dir11/a/e
+	[f] (b) [b] ./dir11/b
+	[f] (c) [c] ./dir11/c
+	[f] (d/e/d/a) [a] ./dir11/d/e/d/a
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir11 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
 
 test_expect_success POSIXPERM,SANITY 'setup -- dir w/o perms' '
 	mkdir -p dir12/a &&
@@ -511,6 +958,61 @@ test_expect_success POSIXPERM,SANITY 'pedantic dirs-before of root dir w/o perms
 
 	chmod 755 dir12
 '
+test_expect_success POSIXPERM,SANITY 'dirs-after of root dir w/o perms' '
+	cat >expected-out <<-EOF &&
+	dir_iterator_begin failure: EACCES
+	EOF
+
+	chmod 0 dir12 &&
+
+	test_must_fail test-tool dir-iterator --dirs-after ./dir12 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir12
+'
+test_expect_success POSIXPERM,SANITY 'pedantic dirs-after of root dir w/o perms' '
+	cat >expected-out <<-EOF &&
+	dir_iterator_begin failure: EACCES
+	EOF
+
+	chmod 0 dir12 &&
+
+	test_must_fail test-tool dir-iterator --dirs-after \
+		--pedantic ./dir12 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir12
+'
+test_expect_success POSIXPERM,SANITY \
+'dirs-before/dirs-after of root dir w/o perms' '
+
+	cat >expected-out <<-EOF &&
+	dir_iterator_begin failure: EACCES
+	EOF
+
+	chmod 0 dir12 &&
+
+	test_must_fail test-tool dir-iterator --dirs-before --dirs-after \
+		./dir12 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir12
+'
+test_expect_success POSIXPERM,SANITY \
+'pedantic dirs-before/dirs-after of root dir w/o perms' '
+
+	cat >expected-out <<-EOF &&
+	dir_iterator_begin failure: EACCES
+	EOF
+
+	chmod 0 dir12 &&
+
+	test_must_fail test-tool dir-iterator --dirs-before --dirs-after \
+		--pedantic ./dir12 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir12
+'
 
 test_expect_success 'begin should fail upon inexistent paths' '
 	echo "dir_iterator_begin failure: ENOENT" >expected-out &&
@@ -591,6 +1093,66 @@ test_expect_success POSIXPERM,SANITY \
 
 	chmod 755 dir13/a
 '
+test_expect_success POSIXPERM,SANITY \
+'dirs-after of dir w/ dir w/o perms w/ file' '
+
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir13/a
+	EOF
+
+	chmod 0 dir13/a &&
+
+	test-tool dir-iterator --dirs-after ./dir13 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir13/a
+'
+test_expect_success POSIXPERM,SANITY \
+'pedantic dirs-after of dir w/ dir w/o perms w/ file' '
+
+	cat >expected-out <<-EOF &&
+	dir_iterator_advance failure: EACCES
+	EOF
+
+	chmod 0 dir13/a &&
+
+	test_must_fail test-tool dir-iterator --dirs-after \
+		--pedantic ./dir13 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir13/a
+'
+test_expect_success POSIXPERM,SANITY \
+'dirs-before/dirs-after of dir w/ dir w/o perms w/ file' '
+
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir13/a
+	[d] (a) [a] ./dir13/a
+	EOF
+
+	chmod 0 dir13/a &&
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir13 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir13/a
+'
+test_expect_success POSIXPERM,SANITY \
+'pedantic dirs-before/dirs-after of dir w/ dir w/o perms w/ file' '
+
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir13/a
+	dir_iterator_advance failure: EACCES
+	EOF
+
+	chmod 0 dir13/a &&
+
+	test_must_fail test-tool dir-iterator --dirs-before --dirs-after \
+		--pedantic ./dir13 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir13/a
+'
 
 test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
 	mkdir -p dir14/a &&
@@ -657,6 +1219,81 @@ test_expect_success SYMLINKS \
 
 	test_cmp expected-sorted-out actual-sorted-out
 '
+test_expect_success SYMLINKS 'dirs-after of dir w/ symlinks w/o cycle' '
+	cat >expected-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir14/a
+	[d] (b) [b] ./dir14/b
+	[d] (b/c) [c] ./dir14/b/c
+	[f] (a/d) [d] ./dir14/a/d
+	[s] (a/e) [e] ./dir14/a/e
+	[s] (a/f) [f] ./dir14/a/f
+	EOF
+
+	test-tool dir-iterator --dirs-after ./dir14 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
+test_expect_success SYMLINKS \
+'follow-symlinks dirs-after of dir w/ symlinks w/o cycle' '
+
+	cat >expected-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir14/a
+	[d] (a/f) [f] ./dir14/a/f
+	[d] (a/f/c) [c] ./dir14/a/f/c
+	[d] (b) [b] ./dir14/b
+	[d] (b/c) [c] ./dir14/b/c
+	[f] (a/d) [d] ./dir14/a/d
+	[f] (a/e) [e] ./dir14/a/e
+	EOF
+
+	test-tool dir-iterator --dirs-after --follow-symlinks ./dir14 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
+test_expect_success SYMLINKS 'dirs-before/dirs-after of dir w/ symlinks w/o cycle' '
+	cat >expected-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir14/a
+	[d] (a) [a] ./dir14/a
+	[d] (b) [b] ./dir14/b
+	[d] (b) [b] ./dir14/b
+	[d] (b/c) [c] ./dir14/b/c
+	[d] (b/c) [c] ./dir14/b/c
+	[f] (a/d) [d] ./dir14/a/d
+	[s] (a/e) [e] ./dir14/a/e
+	[s] (a/f) [f] ./dir14/a/f
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir14 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
+test_expect_success SYMLINKS \
+'follow-symlinks dirs-before/dirs-after of dir w/ symlinks w/o cycle' '
+
+	cat >expected-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir14/a
+	[d] (a) [a] ./dir14/a
+	[d] (a/f) [f] ./dir14/a/f
+	[d] (a/f) [f] ./dir14/a/f
+	[d] (a/f/c) [c] ./dir14/a/f/c
+	[d] (a/f/c) [c] ./dir14/a/f/c
+	[d] (b) [b] ./dir14/b
+	[d] (b) [b] ./dir14/b
+	[d] (b/c) [c] ./dir14/b/c
+	[d] (b/c) [c] ./dir14/b/c
+	[f] (a/d) [d] ./dir14/a/d
+	[f] (a/e) [e] ./dir14/a/e
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after \
+		--follow-symlinks ./dir14 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
 
 test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/ cycle' '
 	mkdir -p dir15/a/b &&
@@ -719,5 +1356,64 @@ test_expect_success SYMLINKS \
 
 	test_cmp expected-tailed-out actual-tailed-out
 '
+test_expect_success SYMLINKS 'dirs-after of dir w/ symlinks w/ cycle' '
+	cat >expected-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir15/a
+	[d] (a/b) [b] ./dir15/a/b
+	[d] (a/c) [c] ./dir15/a/c
+	[s] (a/b/d) [d] ./dir15/a/b/d
+	[s] (a/b/e) [e] ./dir15/a/b/e
+	[s] (a/b/f) [f] ./dir15/a/b/f
+	EOF
+
+	test-tool dir-iterator --dirs-after ./dir15 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
+test_expect_success SYMLINKS \
+'pedantic follow-symlinks dirs-after of dir w/ symlinks w/ cycle' '
+
+	cat >expected-tailed-out <<-EOF &&
+	dir_iterator_advance failure: ELOOP
+	EOF
+
+	test_must_fail test-tool dir-iterator --dirs-after \
+		--pedantic --follow-symlinks ./dir15 >actual-out &&
+	tail -n 1 actual-out >actual-tailed-out &&
+
+	test_cmp expected-tailed-out actual-tailed-out
+'
+test_expect_success SYMLINKS 'dirs-before/dirs-after of dir w/ symlinks w/ cycle' '
+	cat >expected-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir15/a
+	[d] (a) [a] ./dir15/a
+	[d] (a/b) [b] ./dir15/a/b
+	[d] (a/b) [b] ./dir15/a/b
+	[d] (a/c) [c] ./dir15/a/c
+	[d] (a/c) [c] ./dir15/a/c
+	[s] (a/b/d) [d] ./dir15/a/b/d
+	[s] (a/b/e) [e] ./dir15/a/b/e
+	[s] (a/b/f) [f] ./dir15/a/b/f
+	EOF
+
+	test-tool dir-iterator --dirs-before --dirs-after ./dir15 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
+test_expect_success SYMLINKS \
+'pedantic follow-symlinks dirs-before/dirs-after of dir w/ symlinks w/ cycle' '
+
+	cat >expected-tailed-out <<-EOF &&
+	dir_iterator_advance failure: ELOOP
+	EOF
+
+	test_must_fail test-tool dir-iterator --dirs-before --dirs-after \
+		--pedantic --follow-symlinks ./dir15 >actual-out &&
+	tail -n 1 actual-out >actual-tailed-out &&
+
+	test_cmp expected-tailed-out actual-tailed-out
+'
 
 test_done
-- 
2.36.1

