Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E3AC433E0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A1364EC0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 17:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBTRIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 12:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhBTRIa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 12:08:30 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D792FC061786
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 09:07:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h98so9466198wrh.11
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 09:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v6XLlmu4CUHfIxTMjNzWCLBgFFcEO0MlUmEL3HXHHY0=;
        b=Tm+WwOZszDFcy73JoO+/p78WdPZ+1Jln8AAtgYTKeyphae1JTQ11Ii6VHKMYyUKZLB
         UTeGv8Iw92amf5Wp/dcgpiO2cy9iYuFNAoMAQB0iUWGthT7aqhgWnkgKFaIwJqrFzVEO
         rM0ypXKAAtcqjAvKACC+l+a3kp99KMObRjicKVnw9akK8iSFsuKv/e+XMisvjqcqZvb0
         ynV2+KHhg8RKmw/c5qWFY2Lfe3aO+JFqKD4CHUiWBh0fqSkEdiU0hdD3WTDAXMDlPsaD
         RaJCdnbPpa3WhZFUXW6OUfSk9tzQu6t1iRQB8kR+3f9ai7YLPky8LKWd+/sfXOX82Gx/
         qJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v6XLlmu4CUHfIxTMjNzWCLBgFFcEO0MlUmEL3HXHHY0=;
        b=fvwVnUS9C4Nbxidfm3HTqidYrAJkKdWuNOaF2Oxo4m6mBNzD5nskAEuBs9mSgfK7uG
         6w2TBTw6t6CX08vPYQ9tXHMW/1Y4AUbLoVpZffVWYA3Ti8gro3u9AftR6J4DgFLDndOk
         Mbn58KBpOpSbfzOpnuup+XWiJHC2f9CGLQxyoUewwnbyvtLL/qXwcDmWhZKbzz0IWb+I
         TjHzSyE06AoARf5B5vvyYj6RzcW0xuZgh7BSkiZcF6miLEd9WubVpLlWNAZcaTiWL6oQ
         eoET+qX3Lk+P9WG7U6s4Tv2gukk5KEYz2P6TUFIv+c6pqLt5IJO/q0atdpELYHCFDeF2
         SyRg==
X-Gm-Message-State: AOAM5334sJOUJLNH/piCvtQT85J8fYG7L/gqXs131Ge+V8g5zxSkDBCc
        +JcKw9qc9gfF2F6+OhD8GHsfuw5LrgA=
X-Google-Smtp-Source: ABdhPJzQvIuYVPOS/zDXD25bW9W254O/5cPDBQlhZ6I/Hxr1gtmS5N8asrr5qP94YQCEk5UsCtUhyw==
X-Received: by 2002:adf:9f54:: with SMTP id f20mr14223662wrg.362.1613840867255;
        Sat, 20 Feb 2021 09:07:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm20020633wrr.41.2021.02.20.09.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 09:07:46 -0800 (PST)
Message-Id: <1d84503fff481910a4ae6eb86fa6f77afc2b3d95.1613840865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.880.v2.git.1613840865.gitgitgadget@gmail.com>
References: <pull.880.git.1613758333.gitgitgadget@gmail.com>
        <pull.880.v2.git.1613840865.gitgitgadget@gmail.com>
From:   "Andrej Shadura via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Feb 2021 17:07:44 +0000
Subject: [PATCH v2 1/2] add: add option --no-filters to disable
 attribute-based filtering
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrej Shadura <andrew.shadura@collabora.co.uk>

It is possible for a user to disable attribute-based filtering when
committing by doing one of the following:

* Create .git/info/attributes unapplying all possible transforming
  attributes.
* Use git hash-object and git update-index to stage files manually.

Doing the former requires keeping an up-to-date list of all attributes
which can transform files when committing or checking out.
Doing the latter is difficult, error-prone and slow when done from
scripts.

Instead, similarly to git hash-object, --no-filter can be added to
git add to enable temporarily disabling filtering in an easy to use
way:

* Add new flag ADD_CACHE_RAW to add_to_index()
* Add new flag HASH_RAW to index_fd()

Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
---
 Documentation/git-add.txt | 10 ++++++++-
 Documentation/gitfaq.txt  |  7 ++++++
 builtin/add.c             |  3 +++
 cache.h                   |  2 ++
 object-file.c             |  2 +-
 read-cache.c              |  3 +++
 t/t2205-add-no-filters.sh | 46 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100755 t/t2205-add-no-filters.sh

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index be5e3ac54b85..75b474a88fca 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
+	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]] [--no-filters]
 	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
 	  [--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	  [--] [<pathspec>...]
@@ -183,6 +183,14 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	in order to correct files added with wrong CRLF/LF line endings.
 	This option implies `-u`.
 
+--no-filters::
+	Add the contents as is, ignoring any input filter that would
+	have been chosen by the attributes mechanism, including the end-of-line
+	conversion. Note that this option is not intended for interactive use,
+	since files added this way will always show up as modified if Git were
+	to apply transformations to them, making the situation potentially
+	very confusing.
+
 --chmod=(+|-)x::
 	Override the executable bit of the added files.  The executable
 	bit is only changed in the index, the files on disk are left
diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index afdaeab8503c..6011abca0bea 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -395,6 +395,13 @@ following on an otherwise clean working tree:
 ----
 $ git add --renormalize .
 ----
++
+Another situation where perpetually modified may appear on any platform is when
+a file has been committed without running any filters (including the end-of-line
+conversion), but the `.gitattributes` file states that this file requires a
+conversion.  In this case, you can either renormalize the files if this happened
+by mistake, or modify `.gitattributes` or `$GIT_DIR/info/attributes` as described
+above to exempt the file from the conversion if this was intentional.
 
 [[recommended-storage-settings]]
 What's the recommended way to store files in Git?::
diff --git a/builtin/add.c b/builtin/add.c
index a825887c503d..609a0e6c0157 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -29,6 +29,7 @@ static const char * const builtin_add_usage[] = {
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
 static int add_renormalize;
+static int no_filters;
 static int pathspec_file_nul;
 static const char *pathspec_from_file;
 static int legacy_stash_p; /* support for the scripted `git stash` */
@@ -334,6 +335,7 @@ static struct option builtin_add_options[] = {
 	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files"), 0),
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
 	OPT_BOOL(0, "renormalize", &add_renormalize, N_("renormalize EOL of tracked files (implies -u)")),
+	OPT_BOOL(0 , "no-filters", &no_filters, N_("store file as is without filters")),
 	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
 	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
 	OPT_CALLBACK_F(0, "ignore-removal", &addremove_explicit,
@@ -531,6 +533,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (show_only ? ADD_CACHE_PRETEND : 0) |
 		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
+		 (no_filters ? ADD_CACHE_RAW : 0) |
 		 (!(addremove || take_worktree_changes)
 		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
diff --git a/cache.h b/cache.h
index d92814961405..df83b5709c32 100644
--- a/cache.h
+++ b/cache.h
@@ -820,6 +820,7 @@ int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
+#define ADD_CACHE_RAW 32
 /*
  * These two are used to add the contents of the file at path
  * to the index, marking the working tree up-to-date by storing
@@ -858,6 +859,7 @@ int ie_modified(struct index_state *, const struct cache_entry *, struct stat *,
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
 #define HASH_RENORMALIZE  4
+#define HASH_RAW          8
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
diff --git a/object-file.c b/object-file.c
index 5bcfde847188..74487c22e586 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2067,7 +2067,7 @@ static int index_mem(struct index_state *istate,
 	/*
 	 * Convert blobs to git internal format
 	 */
-	if ((type == OBJ_BLOB) && path) {
+	if ((type == OBJ_BLOB) && path && !(flags & HASH_RAW)) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(istate, path, buf, size, &nbuf,
 				   get_conv_flags(flags))) {
diff --git a/read-cache.c b/read-cache.c
index 29144cf879e7..0fb31201c705 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -716,6 +716,9 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	if (flags & ADD_CACHE_RENORMALIZE)
 		hash_flags |= HASH_RENORMALIZE;
 
+	if (flags & ADD_CACHE_RAW)
+		hash_flags |= HASH_RAW;
+
 	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
 		return error(_("%s: can only add regular files, symbolic links or git-directories"), path);
 
diff --git a/t/t2205-add-no-filters.sh b/t/t2205-add-no-filters.sh
new file mode 100755
index 000000000000..a897ed810827
--- /dev/null
+++ b/t/t2205-add-no-filters.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='git add --no-filters
+
+This test creates a file and a corresponding .gitattributes setup
+to ensure the file undergoes a conversion when committed or checked
+out.
+
+It then verifies that the conversion happens by default, but does not
+when --no-filters is used.'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo "* eol=crlf" > .gitattributes &&
+	git add .gitattributes &&
+	git commit -m initial &&
+	printf "test\r\ntest\r\n" > test
+'
+
+test_expect_success 'add without --no-filters' '
+	original="$(git hash-object --stdin < test)" &&
+	converted="$(git hash-object test)" &&
+	git add test &&
+	git ls-files -s > actual &&
+	cat > expected <<-EOF &&
+	100644 $(git hash-object .gitattributes) 0	.gitattributes
+	100644 $converted 0	test
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'add with --no-filters' '
+	git rm -f --cached test &&
+	original="$(git hash-object --stdin < test)" &&
+	converted="$(git hash-object test)" &&
+	git add --no-filters test &&
+	git ls-files -s > actual &&
+	cat > expected <<-EOF &&
+	100644 $(git hash-object .gitattributes) 0	.gitattributes
+	100644 $original 0	test
+	EOF
+	test_cmp expected actual
+'
+
+test_done
-- 
gitgitgadget

