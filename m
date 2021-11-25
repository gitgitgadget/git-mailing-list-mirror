Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA36C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 08:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353574AbhKYIoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353355AbhKYImb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 03:42:31 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0DCC061759
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o13so9849647wrs.12
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hfm1gxJwty2gwi03Zgp9fZTvaUvyXAQrfW4xHgltKWM=;
        b=hckCYaah4YPmuXI0yHvgc8J4Pc1QRp742wUHUFCsCntm+rjqKXM30yPXZctRGWhjTw
         puRkbMpXG0cp4keaeq/mO/A2YiRVndA0yiCdSS3w6w7DV4aZxpKwJx6PMbLOvPtQPoIu
         ZBxKuSEsQJvy2LTDQEEkFC/pCuquM+uDXaIQ+QPQQKJgQUvyMIlK2Wu0VZ3Zwoasd6WR
         ZrDjMlXpDjrFmFsZPCSUKSLKCET250Y1w+8ybijSlJogZ4PlhUL/jC9kgs4YumhZYPHE
         CQhCIXtlvK87RiuyPPT3Bm6UkiVUd6B+PEJNq3cGtpV9qYkfsTuJXDnP82kpUt+3dDEC
         p48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hfm1gxJwty2gwi03Zgp9fZTvaUvyXAQrfW4xHgltKWM=;
        b=7VpwOG6Sls6W49pNYJILDSwO+LhLUcy0nrP92SW4MsibZPKlB+8ojsXn+hFiD2o8jU
         EmfdYh5QXqaoBVyLN2hLc5paiO6o7pXZam3GF8Q3TaeUuvwf4BJKL08U5VrJOUbjKKJL
         im/WzXqwwN0nRFe4uHM6Hl1d08PORXAmunY5ITPoPgCYQDp9532U91jXLD9IM7wL8UjD
         yoZEMz7w2F6fs7AddoapZt2sRWdwbZkHYWsnOACQK8Jd3OlkvaGIsDO9JFJmQTZu842O
         Xkq5C1LMI1kQ2n4mpd1ZViSwetp36aOFT58qgi9kuUXWzMbJ2E5JfaVYG+1RueB5fN2r
         vE8Q==
X-Gm-Message-State: AOAM532Du0c8AvSxhRgxtohHaHm/+hYwE+emWZ0fuUYnZqJ/0PelYTeA
        ciWJG88q4ACMbNND3a3QfuiNID7VS54=
X-Google-Smtp-Source: ABdhPJx4thbPeODTGv0MXdpmjpEw2SFC31IhJwE+Hkx97OxMZXu7bwe5b3wHV0YuVP12L2hqaxfyEg==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr4587344wrq.94.1637829557927;
        Thu, 25 Nov 2021 00:39:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm2057721wrt.64.2021.11.25.00.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:39:17 -0800 (PST)
Message-Id: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 08:39:07 +0000
Subject: [PATCH v2 0/9] Avoid removing the current working directory, even if it becomes empty
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Traditionally, if folks run git commands such as checkout or rebase from a
subdirectory, that git command could remove their current working directory
and result in subsequent git and non-git commands either getting confused or
printing messages that confuse the user (e.g. "fatal: Unable to read current
working directory: No such file or directory"). Many commands either
silently avoid removing directories that are not empty (i.e. those that have
untracked or modified files in them)[1], or show an error and abort,
depending on which is more appropriate for the command in question. With
this series, we augment the reasons to avoid removing directories to include
not just has-untracked-or-modified-files, but also to avoid removing the
original_cwd as well.

Peff and Junio provided some good pros/cons, if it helps:

 * Pros: Peff (original suggester of the idea)[2], and Junio[3]
 * Cons: Peff [2, again -- see the "P.S."], and Junio[4]

[1] well, with a few exceptions; see
https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/YS8eEtwQvF7TaLCb@coredump.intra.peff.net/
[3] https://lore.kernel.org/git/xmqqo86elyht.fsf@gitster.g/ [4]
https://lore.kernel.org/git/xmqqo8691gr8.fsf@gitster.g/

Changes since v1:

 * clarified multiple commit messages
 * renamed the_cwd to startup_info->original_cwd to make it clearer that
   it's our parent process'es cwd that really matters, which we inherited at
   program startup. Also pulls it out of the global namespace.
 * Normalize the path for startup_info->original_cwd, and ensure that it's
   actually the original cwd even if -C is passed to git.
 * small code cleanups suggested by René and Ævar
 * split the final patch, which got the most comments into two, one for each
   function being modified; significantly extending the first of the two
   commit messages with a lot of history
 * no longer has a content conflict with so/stash-staged
 * add another value for the flags parameter that remove_dir_recursively()
   takes so that it can opt into either the old or the new behavior. Use
   that for the one special corner case I could find where it matters, and
   add a few tests around it to highlight the utility of the flag.

Elijah Newren (9):
  t2501: add various tests for removing the current working directory
  setup: introduce startup_info->original_cwd
  unpack-trees: refuse to remove startup_info->original_cwd
  unpack-trees: add special cwd handling
  symlinks: do not include startup_info->original_cwd in dir removal
  clean: do not attempt to remove startup_info->original_cwd
  stash: do not attempt to remove startup_info->original_cwd
  dir: avoid incidentally removing the original_cwd in remove_path()
  dir: new flag to remove_dir_recurse() to spare the original_cwd

 builtin/clean.c      |  47 +++++--
 builtin/rm.c         |   3 +-
 builtin/stash.c      |   6 +-
 cache.h              |   1 +
 dir.c                |  15 ++-
 dir.h                |   9 +-
 git.c                |   2 +
 setup.c              |  49 +++++++
 symlinks.c           |   8 +-
 t/t2501-cwd-empty.sh | 297 +++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c       |  30 ++++-
 unpack-trees.h       |   1 +
 12 files changed, 446 insertions(+), 22 deletions(-)
 create mode 100755 t/t2501-cwd-empty.sh


base-commit: 88d915a634b449147855041d44875322de2b286d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1140%2Fnewren%2Fcwd_removal-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1140/newren/cwd_removal-v2
Pull-Request: https://github.com/git/git/pull/1140

Range-diff vs v1:

  1:  0b71996a3b4 !  1:  38a120f5c03 t2501: add various tests for removing the current working directory
     @@ Commit message
          Numerous commands will remove empty working directories, especially if
          they are in the way of placing needed files.  That is normally fine, but
          removing the current working directory can cause confusion for the user
     -    when they run subsequent commands.  Add some tests checking for such
     -    problems.
     +    when they run subsequent commands.  For example, after one git process
     +    has removed the current working directory, git status/log/diff will all
     +    abort with the message:
     +
     +        fatal: Unable to read current working directory: No such file or directory
     +
     +    Since there are several code paths that can result in the current
     +    working directory being removed, add several tests of various different
     +    codepaths that check for the behavior we would instead like to see.
     +    This include a number of new error messages that we will be adding in
     +    subsequent commits as we implement the desired checks.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
  2:  7b0c665fb75 <  -:  ----------- repository, setup: introduce the_cwd
  -:  ----------- >  2:  f6129a8ac9c setup: introduce startup_info->original_cwd
  3:  94bf468be09 !  3:  e74975e83cc unpack-trees: refuse to remove the current working directory
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    unpack-trees: refuse to remove the current working directory
     +    unpack-trees: refuse to remove startup_info->original_cwd
      
          In the past, when a directory needs to be removed to make room for a
          file, we have always errored out when that directory contains any
          untracked (but not ignored) files.  Add an extra condition on that: also
     -    error out if the directory is the current working directory.
     +    error out if the directory is the current working directory we inherited
     +    from our parent process.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ unpack-trees.c: static int verify_clean_subdirectory(const struct cache_entry *c
       	if (i)
       		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
      +
     -+	/* Do not lose the current working directory. */
     -+	if (the_cwd && !strcmp(the_cwd, ce->name))
     ++	/* Do not lose startup_info->original_cwd */
     ++	if (startup_info->original_cwd &&
     ++	    !strcmp(startup_info->original_cwd, ce->name))
      +		return add_rejected_path(o, ERROR_CWD_IN_THE_WAY, ce->name);
      +
       	return cnt;
  4:  39830fffd45 !  4:  e06806e3a32 unpack-trees: add special cwd handling
     @@ Commit message
          code from the previous commit in verify_clean_subdirectory().  However,
          when we are preserving untracked files, we would rather any error
          messages about untracked files being in the way take precedence over
     -    error messages about a subdirectory that happens to be the current
     -    working directory being in the way.  But in the
     -    UNPACK_RESET_OVERWRITE_UNTRACKED case, there is no untracked checking to
     -    be done, so we simply add a special case near the top of
     -    verify_absent_1.
     +    error messages about a subdirectory that happens to be the_original_cwd
     +    being in the way.  But in the UNPACK_RESET_OVERWRITE_UNTRACKED case,
     +    there is no untracked checking to be done, so we simply add a special
     +    case near the top of verify_absent_1.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ unpack-trees.c: static int verify_absent_1(const struct cache_entry *ce,
       		return 0;
       
      +	if (o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED) {
     -+		/* Avoid nuking cwd... */
     -+		if (the_cwd && !strcmp(the_cwd, ce->name))
     ++		/* Avoid nuking startup_info->original_cwd... */
     ++		if (startup_info->original_cwd &&
     ++		    !strcmp(startup_info->original_cwd, ce->name))
      +			return add_rejected_path(o, ERROR_CWD_IN_THE_WAY,
      +						 ce->name);
      +		/* ...but nuke anything else. */
  5:  8a69d2878c9 !  5:  46728f74ea1 symlinks: do not include current working directory in dir removal
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    symlinks: do not include current working directory in dir removal
     +    symlinks: do not include startup_info->original_cwd in dir removal
      
          symlinks has a pair of schedule_dir_for_removal() and
          remove_scheduled_dirs() functions that ensure that directories made
          empty by removing other files also themselves get removed.  However, we
     -    want to exclude the current working directory and leave it around so
     -    that subsequent git commands (and non-git commands) that the user runs
     -    afterwards don't cause the user to get confused.
     +    want to exclude startup_info->original_cwd and leave it around.  This
     +    avoids the user getting confused by subsequent git commands (and non-git
     +    commands) that would otherwise report confusing messages about being
     +    unable to read the current working directory.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## symlinks.c ##
     -@@ symlinks.c: static int threaded_has_dirs_only_path(struct cache_def *cache, const char *name
     - 
     - static struct strbuf removal = STRBUF_INIT;
     - 
     -+static int cant_remove(char *dirname)
     -+{
     -+	if (the_cwd && !strcmp(dirname, the_cwd))
     -+		return 1;
     -+	return rmdir(dirname);
     -+}
     -+
     - static void do_remove_scheduled_dirs(int new_len)
     +@@ symlinks.c: static void do_remove_scheduled_dirs(int new_len)
       {
       	while (removal.len > new_len) {
       		removal.buf[removal.len] = '\0';
      -		if (rmdir(removal.buf))
     -+		if (cant_remove(removal.buf))
     ++		if ((startup_info->original_cwd &&
     ++		     !strcmp(removal.buf, startup_info->original_cwd)) ||
     ++		    rmdir(removal.buf))
       			break;
       		do {
       			removal.len--;
     @@ symlinks.c: void schedule_dir_for_removal(const char *name, int len)
       {
       	int match_len, last_slash, i, previous_slash;
       
     -+	if (the_cwd && !strcmp(name, the_cwd))
     ++	if (startup_info->original_cwd &&
     ++	    !strcmp(name, startup_info->original_cwd))
      +		return;	/* Do not remove the current working directory */
      +
       	match_len = last_slash = i =
  6:  69bcaf0aab2 !  6:  01ce9444dae clean: do not attempt to remove current working directory
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    clean: do not attempt to remove current working directory
     +    clean: do not attempt to remove startup_info->original_cwd
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/clean.c: static const char *msg_skip_git_dir = N_("Skipping repository %
       
       enum color_clean {
       	CLEAN_COLOR_RESET = 0,
     +@@ builtin/clean.c: static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
     + {
     + 	DIR *dir;
     + 	struct strbuf quoted = STRBUF_INIT;
     ++	struct strbuf realpath = STRBUF_INIT;
     ++	struct strbuf real_ocwd = STRBUF_INIT;
     + 	struct dirent *e;
     + 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
     + 	struct string_list dels = STRING_LIST_INIT_DUP;
      @@ builtin/clean.c: static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
       	strbuf_setlen(path, original_len);
       
     @@ builtin/clean.c: static int remove_dirs(struct strbuf *path, const char *prefix,
      -			quote_path(path->buf, prefix, &quoted, 0);
      -			errno = saved_errno;
      -			warning_errno(_(msg_warn_remove_failed), quoted.buf);
     -+		int prefixlen = prefix ? strlen(prefix) : 0;
     -+		if (prefix &&
     -+		    path->len == prefixlen + 2 &&
     -+		    !strncmp(path->buf, prefix, prefixlen) &&
     -+		    !strcmp(path->buf + prefixlen, "./")) {
     ++		/*
     ++		 * Normalize path components in path->buf, e.g. change '\' to
     ++		 * '/' on Windows.
     ++		 */
     ++		strbuf_realpath(&realpath, path->buf, 1);
     ++
     ++		/*
     ++		 * path and realpath are absolute; for comparison, we want
     ++		 * startup_info->original_cwd to be an absolute path too.  We
     ++		 * can use strbuf_realpath for this.  Also, if original_cwd
     ++		 * started out as the empty string, then it corresponded to
     ++		 * the top of the worktree, which is protected by other means
     ++		 * so we just leave it blank.
     ++		 */
     ++		 if (*startup_info->original_cwd)
     ++			 strbuf_realpath(&real_ocwd,
     ++					 startup_info->original_cwd, 1);
     ++
     ++		if (!strbuf_cmp(&realpath, &real_ocwd)) {
      +			printf("%s", dry_run ? _(msg_would_skip_cwd) : _(msg_skip_cwd));
       			*dir_gone = 0;
      -			ret = 1;
     @@ builtin/clean.c: static int remove_dirs(struct strbuf *path, const char *prefix,
       		}
       	}
       
     +@@ builtin/clean.c: static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
     + 			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
     + 	}
     + out:
     ++	strbuf_release(&realpath);
     ++	strbuf_release(&real_ocwd);
     + 	strbuf_release(&quoted);
     + 	string_list_clear(&dels, 0);
     + 	return ret;
      
       ## t/t2501-cwd-empty.sh ##
      @@ t/t2501-cwd-empty.sh: test_expect_failure 'apply does not remove cwd incidentally' '
  7:  93005b17c28 !  7:  edec0894ca2 stash: do not attempt to remove current working directory
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    stash: do not attempt to remove current working directory
     +    stash: do not attempt to remove startup_info->original_cwd
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/stash.c ##
     -@@ builtin/stash.c: static int create_stash(int argc, const char **argv, const char *prefix)
     - 	return ret;
     - }
     - 
     --static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
     -+static int do_push_stash(const struct pathspec *ps, const char *stash_msg,
     -+			 const char *prefix, int quiet,
     - 			 int keep_index, int patch_mode, int include_untracked)
     - {
     - 	int ret = 0;
      @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
       			struct child_process cp = CHILD_PROCESS_INIT;
       
       			cp.git_cmd = 1;
     -+			if (prefix)
     -+				strvec_pushl(&cp.args, "-C", prefix, NULL);
     ++			if (startup_info->original_cwd &&
     ++			    *startup_info->original_cwd &&
     ++			    !is_absolute_path(startup_info->original_cwd))
     ++				cp.dir = startup_info->original_cwd;
       			strvec_pushl(&cp.args, "clean", "--force",
      -				     "--quiet", "-d", NULL);
      +				     "--quiet", "-d", ":/", NULL);
       			if (include_untracked == INCLUDE_ALL_FILES)
       				strvec_push(&cp.args, "-x");
       			if (run_command(&cp)) {
     -@@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *prefix,
     - 		die(_("--pathspec-file-nul requires --pathspec-from-file"));
     - 	}
     - 
     --	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
     --			     include_untracked);
     -+	return do_push_stash(&ps, stash_msg, prefix, quiet, keep_index,
     -+			     patch_mode, include_untracked);
     - }
     - 
     - static int save_stash(int argc, const char **argv, const char *prefix)
     -@@ builtin/stash.c: static int save_stash(int argc, const char **argv, const char *prefix)
     - 		stash_msg = strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
     - 
     - 	memset(&ps, 0, sizeof(ps));
     --	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
     -+	ret = do_push_stash(&ps, stash_msg, prefix, quiet, keep_index,
     - 			    patch_mode, include_untracked);
     - 
     - 	strbuf_release(&stash_msg_buf);
      
       ## t/t2501-cwd-empty.sh ##
      @@ t/t2501-cwd-empty.sh: test_expect_success 'clean does not remove cwd incidentally' '
  8:  a5528cbb14d !  8:  1815f18592b dir: avoid removing the current working directory
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    dir: avoid removing the current working directory
     +    dir: avoid incidentally removing the original_cwd in remove_path()
      
     -    dir has a convenient remove_path() helper that will both remove a file
     -    in a directory and remove its containing directory if it becomes empty
     -    as a result of the removal, recursing all the way up.  However, we do
     -    not want the current working directory to be removed, even if it becomes
     -    empty.
     +    Modern git often tries to avoid leaving empty directories around when
     +    removing files.  Originally, it did not bother.  This behavior started
     +    with commit 80e21a9ed809 (merge-recursive::removeFile: remove empty
     +    directories, 2005-11-19), stating the reason simply as:
      
     -    dir also has a remove_dir_recursively() function which appears to mostly
     -    be used to remove metadata directories or temporary directories or
     -    submodules or worktrees.  I am not sure if it needs to be protected
     -    against removing the current working directory, but did so for good
     -    measure.
     +        When the last file in a directory is removed as the result of a
     +        merge, try to rmdir the now-empty directory.
     +
     +    This was reimplemented in C and renamed to remove_path() in commit
     +    e1b3a2cad7 ("Build-in merge-recursive", 2008-02-07), but was still
     +    internal to merge-recursive.
     +
     +    This trend towards removing leading empty directories continued with
     +    commit d9b814cc97f1 (Add builtin "git rm" command, 2006-05-19), which
     +    stated the reasoning as:
     +
     +        The other question is what to do with leading directories. The old
     +        "git rm" script didn't do anything, which is somewhat inconsistent.
     +        This one will actually clean up directories that have become empty
     +        as a result of removing the last file, but maybe we want to have a
     +        flag to decide the behaviour?
     +
     +    remove_path() in dir.c was added in 4a92d1bfb784 (Add remove_path: a
     +    function to remove as much as possible of a path, 2008-09-27), because
     +    it was noted that we had two separate implementations of the same idea
     +    AND both were buggy.  It described the purpose of the function as
     +
     +        a function to remove as much as possible of a path
     +
     +    Why remove as much as possible?  Well, at the time we probably would
     +    have said something like:
     +
     +      * removing leading directories makes things feel tidy
     +      * removing leading directories doesn't hurt anything so long as they
     +        had no files in them.
     +
     +    But I don't believe those reasons hold when the empty directory happens
     +    to be the current working directory we inherited from our parent
     +    process.  Leaving the parent process in a deleted directory can cause
     +    user confusion when subsequent processes fail: any git command, for
     +    example, will immediately fail with
     +
     +        fatal: Unable to read current working directory: No such file or directory
     +
     +    Other commands may similarly get confused.  Modify remove_path() so that
     +    the empty leading directories it also deletes does not include the
     +    current working directory we inherited from our parent process.  I have
     +    looked through every caller of remove_path() in the current codebase to
     +    make sure that all should take this change.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## dir.c ##
     -@@ dir.c: static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
     - 	closedir(dir);
     - 
     - 	strbuf_setlen(path, original_len);
     --	if (!ret && !keep_toplevel && !kept_down)
     --		ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
     --	else if (kept_up)
     -+	if (!ret && !keep_toplevel && !kept_down) {
     -+		if (the_cwd && !strcmp(the_cwd, path->buf))
     -+			ret = -1; /* Do not remove current working directory */
     -+		else
     -+			ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
     -+	} else if (kept_up)
     - 		/*
     - 		 * report the uplevel that it is not an error that we
     - 		 * did not rmdir() our directory.
      @@ dir.c: int remove_path(const char *name)
       		slash = dirs + (slash - name);
       		do {
       			*slash = '\0';
     -+			if (the_cwd && !strcmp(the_cwd, dirs))
     ++			if (startup_info->original_cwd &&
     ++			    !strcmp(startup_info->original_cwd, dirs))
      +				break;
       		} while (rmdir(dirs) == 0 && (slash = strrchr(dirs, '/')));
       		free(dirs);
       	}
      
     + ## dir.h ##
     +@@ dir.h: int get_sparse_checkout_patterns(struct pattern_list *pl);
     +  */
     + int remove_dir_recursively(struct strbuf *path, int flag);
     + 
     +-/* tries to remove the path with empty directories along it, ignores ENOENT */
     ++/*
     ++ * Tries to remove the path, along with leading empty directories so long as
     ++ * those empty directories are not startup_info->original_cwd.  Ignores
     ++ * ENOENT.
     ++ */
     + int remove_path(const char *path);
     + 
     + int fspathcmp(const char *a, const char *b);
     +
       ## t/t2501-cwd-empty.sh ##
      @@ t/t2501-cwd-empty.sh: test_expect_success 'revert fails if cwd needs to be removed' '
       	test_path_is_dir dirORfile
  -:  ----------- >  9:  adaad7aeaac dir: new flag to remove_dir_recurse() to spare the original_cwd

-- 
gitgitgadget
