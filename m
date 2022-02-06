Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADF7C433FE
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 22:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbiBFWjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbiBFWjM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 17:39:12 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066E7C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 14:39:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r131so3091967wma.1
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 14:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/YgE6HcYr0iVZEJQDjVJNqnE1YmNInJV+ZhLiq4Buw4=;
        b=N+FqXMBPtHvws6mOdCjmrvhJYoKUi7AvHXDiErEExysJee/uphOPthtjujDhCEUzOv
         Ck9uwJRkE7hM9BzIvnvzE1vnuh6Y5d1lJymlRsDbUcTDzJIamcW3QxbXnhkcW+5ULbWM
         x3hxA367NuztEWTzaGo3Cg9hpCbWeMOcvb2ieo8O8XsM7mpf6P1s/rJdBU6+Cp2gZN6X
         /ukN4tS/klQk8/GG/E5zSIir28eVnMxLcaF90AbXVwbpH6qCa8KkK/bZFVlRN99Q7p5x
         Yay29oVbiYFvPmo1FSkemACak33czGs3up+nF/DuQq6K56alntttBz9Jskx3aQNpQbR0
         7n0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/YgE6HcYr0iVZEJQDjVJNqnE1YmNInJV+ZhLiq4Buw4=;
        b=1uKl7Z64T7A9mkMflEaRGJGoQSkYbH5yMdEuUCbkftIAxuovLv9zXI8IH+t5LOMpej
         gjUeeVHWIZitQFohbCQupVqH8/83NG+5lUG8h2GAtaR+0tvB8sq3jaJic5ltbb58rdkp
         LAyLIJb2F8cWEM9SS66LLlrv4oTB8F7IVbE7wZGK6pqW9MxhgPAkjb1qyzwU+DVQcGeE
         b+RTYSxRs8zEZU7D28lZdq5cq6iyvJmuWN4y2pjD5i0kGYNk6KJt61miLy+GtW2/BMet
         kl4Nlnct+2e8i/YiYbZE3cOiHnm5jsNMwSCiZe956o05L5kcwoj/rB3Wncu1zJWhzHfU
         ODkw==
X-Gm-Message-State: AOAM532dY12d2rJSY1qYkwcmDtTxyblmy/AgjrBctqaIwO62dPZPFPnr
        nGC/RcOXq2/ipcK3Lq5AOWI1WGSn430=
X-Google-Smtp-Source: ABdhPJw+nyP/wyeRqjWOp9mLgb/qk/dXmmhqwxj6AHOuNn+vTyAEK/XK9M8cKUlftkIt6IG2NBnHBQ==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr8326798wmc.112.1644187147623;
        Sun, 06 Feb 2022 14:39:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2sm8036094wrw.14.2022.02.06.14.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:39:07 -0800 (PST)
Message-Id: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Feb 2022 22:39:00 +0000
Subject: [PATCH v2 0/6] scalar: implement the subcommand "diagnose"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over the course of the years, we developed a sub-command that gathers
diagnostic data into a .zip file that can then be attached to bug reports.
This sub-command turned out to be very useful in helping Scalar developers
identify and fix issues.

Changes since v1:

 * Instead of creating a throw-away repository, staging the contents of the
   .zip file and then using git write-tree and git archive to write the .zip
   file, the patch series now introduces a new option to git archive and
   uses write_archive() directly (avoiding any separate process).
 * Since the command avoids separate processes, it is now blazing fast on
   Windows, and I dropped the spinner() function because it's no longer
   needed.
 * While reworking the test case, I noticed that scalar [...] <enlistment>
   failed to verify that the specified directory exists, and would happily
   "traverse to its parent directory" on its quest to find a Scalar
   enlistment. That is of course incorrect, and has been fixed as a "while
   at it" sort of preparatory commit.
 * I had forgotten to sign off on all the commits, which has been fixed.
 * Instead of some "home-grown" readdir()-based function, the code now uses
   for_each_file_in_pack_dir() to look through the pack directories.
 * If any alternates are configured, their pack directories are now included
   in the output.
 * The commit message that might be interpreted to promise information about
   large loose files has been corrected to no longer promise that.
 * The test cases have been adjusted to test a little bit more (e.g.
   verifying that specific paths are mentioned in the output, instead of
   merely verifying that the output is non-empty).

Johannes Schindelin (4):
  archive: optionally add "virtual" files
  scalar: validate the optional enlistment argument
  Implement `scalar diagnose`
  scalar diagnose: include disk space information

Matthew John Cheetham (2):
  scalar: teach `diagnose` to gather packfile info
  scalar: teach `diagnose` to gather loose objects information

 Documentation/git-archive.txt    |  11 ++
 archive.c                        |  51 +++++-
 contrib/scalar/scalar.c          | 291 ++++++++++++++++++++++++++++++-
 contrib/scalar/scalar.txt        |  12 ++
 contrib/scalar/t/t9099-scalar.sh |  27 +++
 t/t5003-archive-zip.sh           |  12 ++
 6 files changed, 394 insertions(+), 10 deletions(-)


base-commit: ddc35d833dd6f9e8946b09cecd3311b8aa18d295
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1128%2Fdscho%2Fscalar-diagnose-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1128/dscho/scalar-diagnose-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1128

Range-diff vs v1:

 -:  ----------- > 1:  49ff3c1f2b3 archive: optionally add "virtual" files
 -:  ----------- > 2:  600da8d465e scalar: validate the optional enlistment argument
 1:  ce85506e7a4 ! 3:  0d570137bb6 Implement `scalar diagnose`
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## contrib/scalar/scalar.c ##
     +@@
     + #include "dir.h"
     + #include "packfile.h"
     + #include "help.h"
     ++#include "archive.h"
     + 
     + /*
     +  * Remove the deepest subdirectory in the provided path string. Path must not
      @@ contrib/scalar/scalar.c: static int unregister_dir(void)
       	return res;
       }
       
     -+static int stage(const char *git_dir, struct strbuf *buf, const char *path)
     -+{
     -+	struct strbuf cacheinfo = STRBUF_INIT;
     -+	struct child_process cp = CHILD_PROCESS_INIT;
     -+	int res;
     -+
     -+	strbuf_addstr(&cacheinfo, "100644,");
     -+
     -+	cp.git_cmd = 1;
     -+	strvec_pushl(&cp.args, "--git-dir", git_dir,
     -+		     "hash-object", "-w", "--stdin", NULL);
     -+	res = pipe_command(&cp, buf->buf, buf->len, &cacheinfo, 256, NULL, 0);
     -+	if (!res) {
     -+		strbuf_rtrim(&cacheinfo);
     -+		strbuf_addch(&cacheinfo, ',');
     -+		/* We cannot stage `.git`, use `_git` instead. */
     -+		if (starts_with(path, ".git/"))
     -+			strbuf_addf(&cacheinfo, "_%s", path + 1);
     -+		else
     -+			strbuf_addstr(&cacheinfo, path);
     -+
     -+		child_process_init(&cp);
     -+		cp.git_cmd = 1;
     -+		strvec_pushl(&cp.args, "--git-dir", git_dir,
     -+			     "update-index", "--add", "--cacheinfo",
     -+			     cacheinfo.buf, NULL);
     -+		res = run_command(&cp);
     -+	}
     -+
     -+	strbuf_release(&cacheinfo);
     -+	return res;
     -+}
     -+
     -+static int stage_file(const char *git_dir, const char *path)
     -+{
     -+	struct strbuf buf = STRBUF_INIT;
     -+	int res;
     -+
     -+	if (strbuf_read_file(&buf, path, 0) < 0)
     -+		return error(_("could not read '%s'"), path);
     -+
     -+	res = stage(git_dir, &buf, path);
     -+
     -+	strbuf_release(&buf);
     -+	return res;
     -+}
     -+
     -+static int stage_directory(const char *git_dir, const char *path, int recurse)
     ++static int add_directory_to_archiver(struct strvec *archiver_args,
     ++					  const char *path, int recurse)
      +{
      +	int at_root = !*path;
      +	DIR *dir = opendir(at_root ? "." : path);
     @@ contrib/scalar/scalar.c: static int unregister_dir(void)
      +	if (!at_root)
      +		strbuf_addf(&buf, "%s/", path);
      +	len = buf.len;
     ++	strvec_pushf(archiver_args, "--prefix=%s", buf.buf);
      +
      +	while (!res && (e = readdir(dir))) {
      +		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
     @@ contrib/scalar/scalar.c: static int unregister_dir(void)
      +		strbuf_setlen(&buf, len);
      +		strbuf_addstr(&buf, e->d_name);
      +
     -+		if ((e->d_type == DT_REG && stage_file(git_dir, buf.buf)) ||
     -+		    (e->d_type == DT_DIR && recurse &&
     -+		     stage_directory(git_dir, buf.buf, recurse)))
     ++		if (e->d_type == DT_REG)
     ++			strvec_pushf(archiver_args, "--add-file=%s", buf.buf);
     ++		else if (e->d_type != DT_DIR)
      +			res = -1;
     ++		else if (recurse)
     ++		     add_directory_to_archiver(archiver_args, buf.buf, recurse);
      +	}
      +
      +	closedir(dir);
      +	strbuf_release(&buf);
      +	return res;
      +}
     -+
     -+static int index_to_zip(const char *git_dir)
     -+{
     -+	struct child_process cp = CHILD_PROCESS_INIT;
     -+	struct strbuf oid = STRBUF_INIT;
     -+
     -+	cp.git_cmd = 1;
     -+	strvec_pushl(&cp.args, "--git-dir", git_dir, "write-tree", NULL);
     -+	if (pipe_command(&cp, NULL, 0, &oid, the_hash_algo->hexsz + 1,
     -+			 NULL, 0))
     -+		return error(_("could not write temporary tree object"));
     -+
     -+	strbuf_rtrim(&oid);
     -+	child_process_init(&cp);
     -+	cp.git_cmd = 1;
     -+	strvec_pushl(&cp.args, "--git-dir", git_dir, "archive", "-o", NULL);
     -+	strvec_pushf(&cp.args, "%s.zip", git_dir);
     -+	strvec_pushl(&cp.args, oid.buf, "--", NULL);
     -+	strbuf_release(&oid);
     -+	return run_command(&cp);
     -+}
      +
       /* printf-style interface, expects `<key>=<value>` argument */
       static int set_config(const char *fmt, ...)
     @@ contrib/scalar/scalar.c: cleanup:
      +		N_("scalar diagnose [<enlistment>]"),
      +		NULL
      +	};
     -+	struct strbuf tmp_dir = STRBUF_INIT;
     ++	struct strbuf zip_path = STRBUF_INIT;
     ++	struct strvec archiver_args = STRVEC_INIT;
     ++	char **argv_copy = NULL;
     ++	int stdout_fd = -1, archiver_fd = -1;
      +	time_t now = time(NULL);
      +	struct tm tm;
      +	struct strbuf path = STRBUF_INIT, buf = STRBUF_INIT;
     ++	size_t off;
      +	int res = 0;
      +
      +	argc = parse_options(argc, argv, NULL, options,
      +			     usage, 0);
      +
     -+	setup_enlistment_directory(argc, argv, usage, options, &buf);
     ++	setup_enlistment_directory(argc, argv, usage, options, &zip_path);
     ++
     ++	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
     ++	strbuf_addftime(&zip_path,
     ++			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
     ++	strbuf_addstr(&zip_path, ".zip");
     ++	switch (safe_create_leading_directories(zip_path.buf)) {
     ++	case SCLD_EXISTS:
     ++	case SCLD_OK:
     ++		break;
     ++	default:
     ++		error_errno(_("could not create directory for '%s'"),
     ++			    zip_path.buf);
     ++		goto diagnose_cleanup;
     ++	}
     ++	stdout_fd = dup(1);
     ++	if (stdout_fd < 0) {
     ++		res = error_errno(_("could not duplicate stdout"));
     ++		goto diagnose_cleanup;
     ++	}
      +
     -+	strbuf_addstr(&buf, "/.scalarDiagnostics/scalar_");
     -+	strbuf_addftime(&buf, "%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
     -+	if (run_git("init", "-q", "-b", "dummy", "--bare", buf.buf, NULL)) {
     -+		res = error(_("could not initialize temporary repository: %s"),
     -+			    buf.buf);
     ++	archiver_fd = xopen(zip_path.buf, O_CREAT | O_WRONLY | O_TRUNC, 0666);
     ++	if (archiver_fd < 0 || dup2(archiver_fd, 1) < 0) {
     ++		res = error_errno(_("could not redirect output"));
      +		goto diagnose_cleanup;
      +	}
     -+	strbuf_realpath(&tmp_dir, buf.buf, 1);
      +
     -+	strbuf_reset(&buf);
     -+	strbuf_addf(&buf, "Collecting diagnostic info into temp folder %s\n\n",
     -+		    tmp_dir.buf);
     ++	init_zip_archiver();
     ++	strvec_pushl(&archiver_args, "scalar-diagnose", "--format=zip", NULL);
      +
     ++	strbuf_reset(&buf);
     ++	strbuf_addstr(&buf,
     ++		      "--add-file-with-content=diagnostics.log:"
     ++		      "Collecting diagnostic info\n\n");
      +	get_version_info(&buf, 1);
      +
      +	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
     -+	fwrite(buf.buf, buf.len, 1, stdout);
     -+
     -+	if ((res = stage(tmp_dir.buf, &buf, "diagnostics.log")))
     -+		goto diagnose_cleanup;
     -+
     -+	if ((res = stage_directory(tmp_dir.buf, ".git", 0)) ||
     -+	    (res = stage_directory(tmp_dir.buf, ".git/hooks", 0)) ||
     -+	    (res = stage_directory(tmp_dir.buf, ".git/info", 0)) ||
     -+	    (res = stage_directory(tmp_dir.buf, ".git/logs", 1)) ||
     -+	    (res = stage_directory(tmp_dir.buf, ".git/objects/info", 0)))
     ++	off = strchr(buf.buf, ':') + 1 - buf.buf;
     ++	write_or_die(stdout_fd, buf.buf + off, buf.len - off);
     ++	strvec_push(&archiver_args, buf.buf);
     ++
     ++	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
     ++	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
     ++	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
     ++	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
     ++	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
      +		goto diagnose_cleanup;
      +
     -+	res = index_to_zip(tmp_dir.buf);
     ++	strvec_pushl(&archiver_args, "--prefix=",
     ++		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
      +
     -+	if (!res)
     -+		res = remove_dir_recursively(&tmp_dir, 0);
     ++	/* `write_archive()` modifies the `argv` passed to it. Let it. */
     ++	argv_copy = xmemdupz(archiver_args.v,
     ++			     sizeof(char *) * archiver_args.nr);
     ++	res = write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
     ++			    the_repository, NULL, 0);
     ++	if (res) {
     ++		error(_("failed to write archive"));
     ++		goto diagnose_cleanup;
     ++	}
      +
      +	if (!res)
      +		printf("\n"
      +		       "Diagnostics complete.\n"
     -+		       "All of the gathered info is captured in '%s.zip'\n",
     -+		       tmp_dir.buf);
     ++		       "All of the gathered info is captured in '%s'\n",
     ++		       zip_path.buf);
      +
      +diagnose_cleanup:
     -+	strbuf_release(&tmp_dir);
     ++	if (archiver_fd >= 0) {
     ++		close(1);
     ++		dup2(stdout_fd, 1);
     ++	}
     ++	free(argv_copy);
     ++	strvec_clear(&archiver_args);
     ++	strbuf_release(&zip_path);
      +	strbuf_release(&path);
      +	strbuf_release(&buf);
      +
     @@ contrib/scalar/scalar.txt: reconfigure the enlistment.
       
      
       ## contrib/scalar/t/t9099-scalar.sh ##
     -@@ contrib/scalar/t/t9099-scalar.sh: test_expect_success 'scalar clone' '
     - 	)
     +@@ contrib/scalar/t/t9099-scalar.sh: test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
     + 	grep "cloned. does not exist" err
       '
       
      +SQ="'"
      +test_expect_success UNZIP 'scalar diagnose' '
     ++	scalar clone "file://$(pwd)" cloned --single-branch &&
      +	scalar diagnose cloned >out &&
      +	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
      +	zip_path=$(cat zip_path) &&
     @@ contrib/scalar/t/t9099-scalar.sh: test_expect_success 'scalar clone' '
      +	test_file_not_empty out
      +'
      +
     - test_expect_success 'scalar reconfigure' '
     - 	git init one/src &&
     - 	scalar register one &&
     + test_done
 2:  f8885b27502 ! 4:  938e38b5a09 scalar diagnose: include disk space information
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## contrib/scalar/scalar.c ##
     -@@ contrib/scalar/scalar.c: static int index_to_zip(const char *git_dir)
     - 	return run_command(&cp);
     +@@ contrib/scalar/scalar.c: static int add_directory_to_archiver(struct strvec *archiver_args,
     + 	return res;
       }
       
      +#ifndef WIN32
     @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
       
       	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
      +	get_disk_info(&buf);
     - 	fwrite(buf.buf, buf.len, 1, stdout);
     - 
     - 	if ((res = stage(tmp_dir.buf, &buf, "diagnostics.log")))
     + 	off = strchr(buf.buf, ':') + 1 - buf.buf;
     + 	write_or_die(stdout_fd, buf.buf + off, buf.len - off);
     + 	strvec_push(&archiver_args, buf.buf);
     +
     + ## contrib/scalar/t/t9099-scalar.sh ##
     +@@ contrib/scalar/t/t9099-scalar.sh: SQ="'"
     + test_expect_success UNZIP 'scalar diagnose' '
     + 	scalar clone "file://$(pwd)" cloned --single-branch &&
     + 	scalar diagnose cloned >out &&
     ++	grep "Available space" out &&
     + 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
     + 	zip_path=$(cat zip_path) &&
     + 	test -n "$zip_path" &&
 3:  330b36de799 ! 5:  bd9428919fa scalar: teach `diagnose` to gather packfile info
     @@ Metadata
       ## Commit message ##
          scalar: teach `diagnose` to gather packfile info
      
     -    Teach the `scalar diagnose` command to gather file size information
     -    about pack files.
     +    It's helpful to see if there are other crud files in the pack
     +    directory. Let's teach the `scalar diagnose` command to gather
     +    file size information about pack files.
     +
     +    While at it, also enumerate the pack files in the alternate
     +    object directories, if any are registered.
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## contrib/scalar/scalar.c ##
     +@@
     + #include "packfile.h"
     + #include "help.h"
     + #include "archive.h"
     ++#include "object-store.h"
     + 
     + /*
     +  * Remove the deepest subdirectory in the provided path string. Path must not
      @@ contrib/scalar/scalar.c: cleanup:
       	return res;
       }
       
     -+static void dir_file_stats(struct strbuf *buf, const char *path)
     ++static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
     ++				   const char *file_name, void *data)
      +{
     -+	DIR *dir = opendir(path);
     -+	struct dirent *e;
     -+	struct stat e_stat;
     -+	struct strbuf file_path = STRBUF_INIT;
     -+	size_t base_path_len;
     ++	struct strbuf *buf = data;
     ++	struct stat st;
      +
     -+	if (!dir)
     -+		return;
     ++	if (!stat(full_path, &st))
     ++		strbuf_addf(buf, "%-70s %16" PRIuMAX "\n", file_name,
     ++			    (uintmax_t)st.st_size);
     ++}
      +
     -+	strbuf_addstr(buf, "Contents of ");
     -+	strbuf_add_absolute_path(buf, path);
     -+	strbuf_addstr(buf, ":\n");
     ++static int dir_file_stats(struct object_directory *object_dir, void *data)
     ++{
     ++	struct strbuf *buf = data;
      +
     -+	strbuf_add_absolute_path(&file_path, path);
     -+	strbuf_addch(&file_path, '/');
     -+	base_path_len = file_path.len;
     ++	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
      +
     -+	while ((e = readdir(dir)) != NULL)
     -+		if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG) {
     -+			strbuf_setlen(&file_path, base_path_len);
     -+			strbuf_addstr(&file_path, e->d_name);
     -+			if (!stat(file_path.buf, &e_stat))
     -+				strbuf_addf(buf, "%-70s %16"PRIuMAX"\n",
     -+					    e->d_name,
     -+					    (uintmax_t)e_stat.st_size);
     -+		}
     ++	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
     ++				  data);
      +
     -+	strbuf_release(&file_path);
     -+	closedir(dir);
     ++	return 0;
      +}
      +
       static int cmd_diagnose(int argc, const char **argv)
       {
       	struct option options[] = {
      @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
     - 	if ((res = stage(tmp_dir.buf, &buf, "diagnostics.log")))
     - 		goto diagnose_cleanup;
     + 	write_or_die(stdout_fd, buf.buf + off, buf.len - off);
     + 	strvec_push(&archiver_args, buf.buf);
       
      +	strbuf_reset(&buf);
     -+	dir_file_stats(&buf, ".git/objects/pack");
     -+
     -+	if ((res = stage(tmp_dir.buf, &buf, "packs-local.txt")))
     -+		goto diagnose_cleanup;
     ++	strbuf_addstr(&buf, "--add-file-with-content=packs-local.txt:");
     ++	dir_file_stats(the_repository->objects->odb, &buf);
     ++	foreach_alt_odb(dir_file_stats, &buf);
     ++	strvec_push(&archiver_args, buf.buf);
      +
     - 	if ((res = stage_directory(tmp_dir.buf, ".git", 0)) ||
     - 	    (res = stage_directory(tmp_dir.buf, ".git/hooks", 0)) ||
     - 	    (res = stage_directory(tmp_dir.buf, ".git/info", 0)) ||
     + 	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
     + 	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
     + 	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
      
       ## contrib/scalar/t/t9099-scalar.sh ##
     +@@ contrib/scalar/t/t9099-scalar.sh: test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
     + SQ="'"
     + test_expect_success UNZIP 'scalar diagnose' '
     + 	scalar clone "file://$(pwd)" cloned --single-branch &&
     ++	git repack &&
     ++	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
     + 	scalar diagnose cloned >out &&
     + 	grep "Available space" out &&
     + 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
      @@ contrib/scalar/t/t9099-scalar.sh: test_expect_success UNZIP 'scalar diagnose' '
       	folder=${zip_path%.zip} &&
       	test_path_is_missing "$folder" &&
       	unzip -p "$zip_path" diagnostics.log >out &&
     +-	test_file_not_empty out
      +	test_file_not_empty out &&
      +	unzip -p "$zip_path" packs-local.txt >out &&
     - 	test_file_not_empty out
     ++	grep "$(pwd)/.git/objects" out
       '
       
     + test_done
 4:  213f2c94b73 ! 6:  7a8875be425 scalar: teach `diagnose` to gather loose objects information
     @@ Commit message
      
          When operating at the scale that Scalar wants to support, certain data
          shapes are more likely to cause undesirable performance issues, such as
     -    large numbers or large sizes of loose objects.
     +    large numbers of loose objects.
      
          By including statistics about this, `scalar diagnose` now makes it
          easier to identify such scenarios.
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## contrib/scalar/scalar.c ##
     -@@ contrib/scalar/scalar.c: static void dir_file_stats(struct strbuf *buf, const char *path)
     - 	closedir(dir);
     +@@ contrib/scalar/scalar.c: static int dir_file_stats(struct object_directory *object_dir, void *data)
     + 	return 0;
       }
       
      +static int count_files(char *path)
     @@ contrib/scalar/scalar.c: static void dir_file_stats(struct strbuf *buf, const ch
       {
       	struct option options[] = {
      @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
     - 	if ((res = stage(tmp_dir.buf, &buf, "packs-local.txt")))
     - 		goto diagnose_cleanup;
     + 	foreach_alt_odb(dir_file_stats, &buf);
     + 	strvec_push(&archiver_args, buf.buf);
       
      +	strbuf_reset(&buf);
     ++	strbuf_addstr(&buf, "--add-file-with-content=objects-local.txt:");
      +	loose_objs_stats(&buf, ".git/objects");
     ++	strvec_push(&archiver_args, buf.buf);
      +
     -+	if ((res = stage(tmp_dir.buf, &buf, "objects-local.txt")))
     -+		goto diagnose_cleanup;
     -+
     - 	if ((res = stage_directory(tmp_dir.buf, ".git", 0)) ||
     - 	    (res = stage_directory(tmp_dir.buf, ".git/hooks", 0)) ||
     - 	    (res = stage_directory(tmp_dir.buf, ".git/info", 0)) ||
     + 	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
     + 	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
     + 	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
      
       ## contrib/scalar/t/t9099-scalar.sh ##
     +@@ contrib/scalar/t/t9099-scalar.sh: test_expect_success UNZIP 'scalar diagnose' '
     + 	scalar clone "file://$(pwd)" cloned --single-branch &&
     + 	git repack &&
     + 	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
     ++	test_commit -C cloned/src loose &&
     + 	scalar diagnose cloned >out &&
     + 	grep "Available space" out &&
     + 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
      @@ contrib/scalar/t/t9099-scalar.sh: test_expect_success UNZIP 'scalar diagnose' '
       	unzip -p "$zip_path" diagnostics.log >out &&
       	test_file_not_empty out &&
       	unzip -p "$zip_path" packs-local.txt >out &&
     -+	test_file_not_empty out &&
     +-	grep "$(pwd)/.git/objects" out
     ++	grep "$(pwd)/.git/objects" out &&
      +	unzip -p "$zip_path" objects-local.txt >out &&
     - 	test_file_not_empty out
     ++	grep "^Total: [1-9]" out
       '
       
     + test_done
 5:  3a2cdce554a < -:  ----------- scalar diagnose: show a spinner while staging content

-- 
gitgitgadget
