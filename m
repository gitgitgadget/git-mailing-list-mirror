Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A868C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiHAVPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiHAVPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:15:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B4517E09
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:15:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p10so11398953wru.8
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ZxH1M4hxoHyOY1tbJ6GxwsP9UZIUbS7BDtmvR1S2mV8=;
        b=fEgivA7naW3IoyE40NZ0HMy7FayqAHuE4hAoyLutmUe+nzd9rUD+QfUu8Pt7tEZV5k
         Zd5PeVtFslprH4pb78nHVqUB+wcMBXoVJnDWw1Be5q9aJGyegiZZAVVskwj1lK669Cnl
         JdCgoI5W7f5Er9uuwddd9wHfjG59Rnjm5yUs/Ngnf57iGaen3CANGDCa3ffFlWkpfs29
         BGGrJw3zoNCRokjhkWhz311F2eJvFl9fZdprZ+2ntMr7my8PRAp4YqzXfRfb6kWyXAtL
         iUYUwDBAcw6wG4R3uzJg+MzMSthjCvzSGJCJBhVwTu90cZzx1QucpHtbrjyAgcOy8J7B
         iv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ZxH1M4hxoHyOY1tbJ6GxwsP9UZIUbS7BDtmvR1S2mV8=;
        b=qqVqT04y5Etq3MXR0+erqyasBiYI1WX44kSJbq9AcK4V6ZqiYOO6nnt+QjXu2C0cf/
         s17mOdilHbZgFZRJqvSHyYNih/pCp1X1KXix6UZTyMtaHArftu1wUi8cEfS3zjTuBgDm
         nlS/q/lDjnVm9UXYt7ht5bpxYCX6YEy4lg3ErI/F4loqg+m0QI/0OadtmxLX+3T7C9DB
         BPe0DVHGRoJdvzenaXy0V2cJOcbRM90XAwVwQva+oD40sBICsOar3Omv3s9Fr5ZJL7I1
         roclFcoG3JMhfnNx/MdrIv/L2ne/Kh2MpLgDylvWbtjrtdJV3Co0+rAdX4fhDUfJp6BF
         GSTQ==
X-Gm-Message-State: ACgBeo2EuI1PEyaZWXJsPJT2ZExHL8sNSFGRS+9ycBIHB9k43vwKkCTN
        CAoF1UDXgYdY0drZ3mpzcn/pa9CH41M=
X-Google-Smtp-Source: AA6agR6LhByqXScdDyApqbuFN6e2CQx902JkbQ7TLwt/f1yKp1lAW+BBJbV8Iwyr2idCiabTRlxzmA==
X-Received: by 2002:a5d:48d2:0:b0:21e:8f48:e362 with SMTP id p18-20020a5d48d2000000b0021e8f48e362mr12171575wrs.356.1659388501960;
        Mon, 01 Aug 2022 14:15:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1-20020a7bcb01000000b003a3253b705dsm16231343wmj.35.2022.08.01.14.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:15:01 -0700 (PDT)
Message-Id: <932dc8cddacf1841996cd3e0d512b95828213015.1659388498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 21:14:53 +0000
Subject: [PATCH 2/7] builtin/bugreport.c: create '--diagnose' option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Create a '--diagnose' option for 'git bugreport' to collect additional
information about the repository and write it to a zipped archive.

The "diagnose" functionality was originally implemented for Scalar in
aa5c79a331 (scalar: implement `scalar diagnose`, 2022-05-28). However, the
diagnostics gathered are not specific to Scalar-cloned repositories and
could be useful when diagnosing issues in any Git repository.

Note that, while this patch appears large, it is mostly copied directly out
of 'scalar.c'. Specifically, the functions

- dir_file_stats_objects()
- dir_file_stats()
- count_files()
- loose_objs_stats()
- add_directory_to_archiver()
- get_disk_info()

are all copied verbatim from 'scalar.c'. The 'create_diagnostics_archive()'
function is a mostly unmodified copy of 'cmd_diagnose()', with the primary
changes being that 'zip_path' is an input and "Enlistment root" is corrected
to "Repository root" in the logs.

The remainder of the patch is made up of adding the '--diagnose' option to
'cmd_bugreport()' (including generation of the archive's 'zip_path'),
updating documentation, and adding a test. Note that the test is
'test_expect_failure' due to bugs in the original 'scalar diagnose'. These
will be fixed in subsequent patches.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-bugreport.txt |  11 +-
 builtin/bugreport.c             | 282 +++++++++++++++++++++++++++++++-
 t/t0091-bugreport.sh            |  20 +++
 3 files changed, 309 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index d8817bf3cec..b55658bc287 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -8,7 +8,7 @@ git-bugreport - Collect information for user to file a bug report
 SYNOPSIS
 --------
 [verse]
-'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+'git bugreport' [<options>]
 
 DESCRIPTION
 -----------
@@ -31,6 +31,9 @@ The following information is captured automatically:
  - A list of enabled hooks
  - $SHELL
 
+Additional information may be gathered into a separate zip archive using the
+`--diagnose` option.
+
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
 is unreadable. In this kind of scenario, it may be helpful to manually gather
@@ -49,6 +52,12 @@ OPTIONS
 	named 'git-bugreport-<formatted suffix>'. This should take the form of a
 	strftime(3) format string; the current local time will be used.
 
+--diagnose::
+	Create a zip archive of information about the repository including logs
+	and certain statistics describing the data shape of the repository. The
+	archive is written to the same output directory as the bug report and is
+	named 'git-diagnostics-<formatted suffix>'.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 9de32bc96e7..35b1fc48bf1 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -5,6 +5,10 @@
 #include "compat/compiler.h"
 #include "hook.h"
 #include "hook-list.h"
+#include "dir.h"
+#include "object-store.h"
+#include "packfile.h"
+#include "archive.h"
 
 
 static void get_system_info(struct strbuf *sys_info)
@@ -59,7 +63,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
+	N_("git bugreport [<options>]"),
 	NULL
 };
 
@@ -91,6 +95,259 @@ static void get_header(struct strbuf *buf, const char *title)
 	strbuf_addf(buf, "\n\n[%s]\n", title);
 }
 
+static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
+				   const char *file_name, void *data)
+{
+	struct strbuf *buf = data;
+	struct stat st;
+
+	if (!stat(full_path, &st))
+		strbuf_addf(buf, "%-70s %16" PRIuMAX "\n", file_name,
+			    (uintmax_t)st.st_size);
+}
+
+static int dir_file_stats(struct object_directory *object_dir, void *data)
+{
+	struct strbuf *buf = data;
+
+	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
+
+	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
+				  data);
+
+	return 0;
+}
+
+static int count_files(char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int count = 0;
+
+	if (!dir)
+		return 0;
+
+	while ((e = readdir(dir)) != NULL)
+		if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG)
+			count++;
+
+	closedir(dir);
+	return count;
+}
+
+static void loose_objs_stats(struct strbuf *buf, const char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int count;
+	int total = 0;
+	unsigned char c;
+	struct strbuf count_path = STRBUF_INIT;
+	size_t base_path_len;
+
+	if (!dir)
+		return;
+
+	strbuf_addstr(buf, "Object directory stats for ");
+	strbuf_add_absolute_path(buf, path);
+	strbuf_addstr(buf, ":\n");
+
+	strbuf_add_absolute_path(&count_path, path);
+	strbuf_addch(&count_path, '/');
+	base_path_len = count_path.len;
+
+	while ((e = readdir(dir)) != NULL)
+		if (!is_dot_or_dotdot(e->d_name) &&
+		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
+		    !hex_to_bytes(&c, e->d_name, 1)) {
+			strbuf_setlen(&count_path, base_path_len);
+			strbuf_addstr(&count_path, e->d_name);
+			total += (count = count_files(count_path.buf));
+			strbuf_addf(buf, "%s : %7d files\n", e->d_name, count);
+		}
+
+	strbuf_addf(buf, "Total: %d loose objects", total);
+
+	strbuf_release(&count_path);
+	closedir(dir);
+}
+
+static int add_directory_to_archiver(struct strvec *archiver_args,
+				     const char *path, int recurse)
+{
+	int at_root = !*path;
+	DIR *dir = opendir(at_root ? "." : path);
+	struct dirent *e;
+	struct strbuf buf = STRBUF_INIT;
+	size_t len;
+	int res = 0;
+
+	if (!dir)
+		return error_errno(_("could not open directory '%s'"), path);
+
+	if (!at_root)
+		strbuf_addf(&buf, "%s/", path);
+	len = buf.len;
+	strvec_pushf(archiver_args, "--prefix=%s", buf.buf);
+
+	while (!res && (e = readdir(dir))) {
+		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
+			continue;
+
+		strbuf_setlen(&buf, len);
+		strbuf_addstr(&buf, e->d_name);
+
+		if (e->d_type == DT_REG)
+			strvec_pushf(archiver_args, "--add-file=%s", buf.buf);
+		else if (e->d_type != DT_DIR)
+			warning(_("skipping '%s', which is neither file nor "
+				  "directory"), buf.buf);
+		else if (recurse &&
+			 add_directory_to_archiver(archiver_args,
+						   buf.buf, recurse) < 0)
+			res = -1;
+	}
+
+	closedir(dir);
+	strbuf_release(&buf);
+	return res;
+}
+
+#ifndef WIN32
+#include <sys/statvfs.h>
+#endif
+
+static int get_disk_info(struct strbuf *out)
+{
+#ifdef WIN32
+	struct strbuf buf = STRBUF_INIT;
+	char volume_name[MAX_PATH], fs_name[MAX_PATH];
+	DWORD serial_number, component_length, flags;
+	ULARGE_INTEGER avail2caller, total, avail;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (!GetDiskFreeSpaceExA(buf.buf, &avail2caller, &total, &avail)) {
+		error(_("could not determine free disk size for '%s'"),
+		      buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_setlen(&buf, offset_1st_component(buf.buf));
+	if (!GetVolumeInformationA(buf.buf, volume_name, sizeof(volume_name),
+				   &serial_number, &component_length, &flags,
+				   fs_name, sizeof(fs_name))) {
+		error(_("could not get info for '%s'"), buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, avail2caller.QuadPart);
+	strbuf_addch(out, '\n');
+	strbuf_release(&buf);
+#else
+	struct strbuf buf = STRBUF_INIT;
+	struct statvfs stat;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (statvfs(buf.buf, &stat) < 0) {
+		error_errno(_("could not determine free disk size for '%s'"),
+			    buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
+	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
+	strbuf_release(&buf);
+#endif
+	return 0;
+}
+
+static int create_diagnostics_archive(struct strbuf *zip_path)
+{
+	struct strvec archiver_args = STRVEC_INIT;
+	char **argv_copy = NULL;
+	int stdout_fd = -1, archiver_fd = -1;
+	struct strbuf buf = STRBUF_INIT;
+	int res = 0;
+
+	stdout_fd = dup(1);
+	if (stdout_fd < 0) {
+		res = error_errno(_("could not duplicate stdout"));
+		goto diagnose_cleanup;
+	}
+
+	archiver_fd = xopen(zip_path->buf, O_CREAT | O_WRONLY | O_TRUNC, 0666);
+	if (archiver_fd < 0 || dup2(archiver_fd, 1) < 0) {
+		res = error_errno(_("could not redirect output"));
+		goto diagnose_cleanup;
+	}
+
+	init_zip_archiver();
+	strvec_pushl(&archiver_args, "scalar-diagnose", "--format=zip", NULL);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "Collecting diagnostic info\n\n");
+	get_version_info(&buf, 1);
+
+	strbuf_addf(&buf, "Repository root: %s\n", the_repository->worktree);
+	get_disk_info(&buf);
+	write_or_die(stdout_fd, buf.buf, buf.len);
+	strvec_pushf(&archiver_args,
+		     "--add-virtual-file=diagnostics.log:%.*s",
+		     (int)buf.len, buf.buf);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
+	dir_file_stats(the_repository->objects->odb, &buf);
+	foreach_alt_odb(dir_file_stats, &buf);
+	strvec_push(&archiver_args, buf.buf);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-virtual-file=objects-local.txt:");
+	loose_objs_stats(&buf, ".git/objects");
+	strvec_push(&archiver_args, buf.buf);
+
+	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
+		goto diagnose_cleanup;
+
+	strvec_pushl(&archiver_args, "--prefix=",
+		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
+
+	/* `write_archive()` modifies the `argv` passed to it. Let it. */
+	argv_copy = xmemdupz(archiver_args.v,
+			     sizeof(char *) * archiver_args.nr);
+	res = write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
+			    the_repository, NULL, 0);
+	if (res) {
+		error(_("failed to write archive"));
+		goto diagnose_cleanup;
+	}
+
+	if (!res)
+		fprintf(stderr, "\n"
+			"Diagnostics complete.\n"
+			"All of the gathered info is captured in '%s'\n",
+			zip_path->buf);
+
+diagnose_cleanup:
+	if (archiver_fd >= 0) {
+		close(1);
+		dup2(stdout_fd, 1);
+	}
+	free(argv_copy);
+	strvec_clear(&archiver_args);
+	strbuf_release(&buf);
+
+	return res;
+}
+
 int cmd_bugreport(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buffer = STRBUF_INIT;
@@ -98,16 +355,20 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	int report = -1;
 	time_t now = time(NULL);
 	struct tm tm;
+	int diagnose = 0;
 	char *option_output = NULL;
 	char *option_suffix = "%Y-%m-%d-%H%M";
 	const char *user_relative_path = NULL;
 	char *prefixed_filename;
+	size_t output_path_len;
 
 	const struct option bugreport_options[] = {
+		OPT_BOOL(0, "diagnose", &diagnose,
+			 N_("generate a diagnostics zip archive")),
 		OPT_STRING('o', "output-directory", &option_output, N_("path"),
-			   N_("specify a destination for the bugreport file")),
+			   N_("specify a destination for the bugreport file(s)")),
 		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
-			   N_("specify a strftime format suffix for the filename")),
+			   N_("specify a strftime format suffix for the filename(s)")),
 		OPT_END()
 	};
 
@@ -119,6 +380,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 					    option_output ? option_output : "");
 	strbuf_addstr(&report_path, prefixed_filename);
 	strbuf_complete(&report_path, '/');
+	output_path_len = report_path.len;
 
 	strbuf_addstr(&report_path, "git-bugreport-");
 	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
@@ -133,6 +395,20 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 		    report_path.buf);
 	}
 
+	/* Prepare diagnostics, if requested */
+	if (diagnose) {
+		struct strbuf zip_path = STRBUF_INIT;
+		strbuf_add(&zip_path, report_path.buf, output_path_len);
+		strbuf_addstr(&zip_path, "git-diagnostics-");
+		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+		strbuf_addstr(&zip_path, ".zip");
+
+		if (create_diagnostics_archive(&zip_path))
+			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
+
+		strbuf_release(&zip_path);
+	}
+
 	/* Prepare the report contents */
 	get_bug_template(&buffer);
 
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 08f5fe9caef..3cf983aa67f 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -78,4 +78,24 @@ test_expect_success 'indicates populated hooks' '
 	test_cmp expect actual
 '
 
+test_expect_failure UNZIP '--diagnose creates diagnostics zip archive' '
+	test_when_finished rm -rf report &&
+
+	git bugreport --diagnose -o report -s test >out &&
+
+	zip_path=report/git-diagnostics-test.zip &&
+	grep "Available space" out &&
+	test_path_is_file "$zip_path" &&
+
+	# Check zipped archive content
+	"$GIT_UNZIP" -p "$zip_path" diagnostics.log >out &&
+	test_file_not_empty out &&
+
+	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
+	grep ".git/objects" out &&
+
+	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
+	grep "^Total: [0-9][0-9]*" out
+'
+
 test_done
-- 
gitgitgadget

