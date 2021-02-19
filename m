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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564ECC433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 18:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A82564E86
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 18:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBSSM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhBSSM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 13:12:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC4C061756
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 10:12:16 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l17so7817258wmq.2
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 10:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bxU8TPY7mAsO7DUTQtbIMp7AYAqUPk5PUlCx0xT5nY0=;
        b=MLIg3vpRHUHHWnvmV2XWlYtAxX8leTo3EyFTocK5/T52ZgpOUOSzmieqFRY9mKf3th
         6Q3rfTstUedXL0/M4cvpNSV+0lxYHEdzQy4pOOWL30l/9QhnQdvs+AB6yK22apd/329n
         t5gx0czPX0nX1CmJ3sy+RnPf372W1Zq8qIiD+kT1pzwXl2wGJzGtFXZkSYjF4pjOnkvK
         Lq4k/sUPISzrI23Gb5NXhifuLgvohcSSH0s7nH+e2wFYyVtcf6LySXX4CF7wEi7GWAVS
         gXQ5q1QAY6PrgGCJpzvQjeteQXEOUtdeCMvndkcyVmm8WqgVDmlyh9jVHgIsKx/cL667
         bvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bxU8TPY7mAsO7DUTQtbIMp7AYAqUPk5PUlCx0xT5nY0=;
        b=OHLJPHHlaPnCDpvytjD0i0uoEACLWA/XxXpj00Vogmfu/jPrijRtLxhT48waL+N7Qt
         DDf6P/Y80b4xkSDj9kqeZSRxNM9vcNiWw6nVApu32zOxSqa+abwUkYcKktMHM/ojLh2U
         GQCIfMXnafI8Vbnkt1OpZYzVkI+jZaKCqkiEEJTdbfP5jkvMFgdsp9Y2+ERAjUMugMiP
         kiNx8N1vgva7s+aDMOMGDj8ZR35JANOuyIdCD45iS7a5X4EgUewgEZ2oWzBWoyBhpkdC
         FOOnl0CNPmQ3IubYtLapNCxBr5edGMc76YpPoODUOLTrm9QwDV69Mc9EWFKAjMan4LeR
         OdgA==
X-Gm-Message-State: AOAM533ltolADHTgIqh5CrpVkgbyiA9FtuU9+9KETrTMHcRRUsm9BiYO
        2E2I8wGnaL/KArOdoFIGs2aw/IETfuY=
X-Google-Smtp-Source: ABdhPJxzbogvtFpx4Tvy+VfiC/sSi6pWGQgo5sNwVgtSWqq6JGXRv34Xbih33WaLDzvfdWhjQppeJw==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr9330920wml.100.1613758335517;
        Fri, 19 Feb 2021 10:12:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q140sm16062186wme.0.2021.02.19.10.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:12:15 -0800 (PST)
Message-Id: <cf8eb886a1e29c94ee5ec070fb380d6bc36f40db.1613758333.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.880.git.1613758333.gitgitgadget@gmail.com>
References: <pull.880.git.1613758333.gitgitgadget@gmail.com>
From:   "Andrej Shadura via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Feb 2021 18:12:12 +0000
Subject: [PATCH 1/2] add: add option --no-filters to disable attribute-based
 filtering
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
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
 Documentation/git-add.txt |  7 +++++-
 builtin/add.c             |  3 +++
 cache.h                   |  2 ++
 object-file.c             |  2 +-
 read-cache.c              |  3 +++
 t/t2205-add-no-filters.sh | 46 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100755 t/t2205-add-no-filters.sh

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index be5e3ac54b85..b3d7b13e83f4 100644
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
@@ -183,6 +183,11 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	in order to correct files added with wrong CRLF/LF line endings.
 	This option implies `-u`.
 
+--no-filters::
+	Add the contents as is, ignoring any input filter that would
+	have been chosen by the attributes mechanism, including the end-of-line
+	conversion.
+
 --chmod=(+|-)x::
 	Override the executable bit of the added files.  The executable
 	bit is only changed in the index, the files on disk are left
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

