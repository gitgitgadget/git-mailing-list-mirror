Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 872881F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 23:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfJCXdL (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 19:33:11 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:37042 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731688AbfJCXdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 19:33:11 -0400
Received: by mail-qk1-f201.google.com with SMTP id o133so4500834qke.4
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 16:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9E9hOYsrs89GMjPlB3G+AxpcVxldK5ktvSdyV9kFHvc=;
        b=oqcIKVcIjbFe8M4Og9t9kGrd+fuTysvBQzbcfzx1d7aB0Hr8iRFN1VZdBSdLXog7+i
         g3swJp9RfmlUXtKjYy+Pcjx2v4h7+htGopk4n3gK3a4aerbeEotE2Ikdt+U0t9EJMgRC
         PNECaO3ilLl3y2+KNA/0VGyIHG35cGy+nWeP7eqI7t8KB8vjrTHffNhiefF8zDCtzaxs
         jQmLjCKIxm3ijjMk4J1NeCFAYLqn2ki9zSVr88qe3DxVuyiYtR45X/5vyge/PGlyUu+d
         u59Ra0qSBni+n1rBtT9HNew1GWdQEeRq3T84c9Qz2xI/C/+cx+RxKoulWllpAtXCvgpk
         b4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9E9hOYsrs89GMjPlB3G+AxpcVxldK5ktvSdyV9kFHvc=;
        b=LmMR32KAi13BBou7WjFjBRgOatLmaXbUpNchr46l+yb0Z0dg4QVhqN5/nZEMe9QA5x
         R8s+bGmzAhaweutUYSiHivMMgxb8mkbHx+Zt5tC97eyH+NZpchh6P5myKc2WJYdQpaH7
         Wzl54HvKRjEbR29nWd8/ISD36g9gC0IlxtATCDORp6DrNkYKAzc/+k1GqOzeBqC/GFPE
         qHPHD1AOAG8GogiQjJLy0/xyZ1lOTg/Nt/HWWrXbo9nmrOO6+gfKKSeBVMCRqvgh9BcY
         +lcg/CIntqMtDKuzltn182GzSXszceQLMScU5s3QkUvBb3dwfrd++JWg5gZ7JDs/il73
         fchQ==
X-Gm-Message-State: APjAAAWCmPINFbs3waNQrva8De0Mxd8mcgRXLzZtKKkYpivVpODphg6j
        IbK87zPBj1vyZsi/XUC9wmrH6iPy4dE483jdnMEKguXP1gWxrZHDxWCDwLt6oRg5FC1ugh+WAWH
        crD+PEGKjX3gRowXRatBV9jAiyITuwLj0p69YoITS7AFDFhsqpPA0qX+ZFbXjCW4=
X-Google-Smtp-Source: APXvYqwV6o061XjNaGVWMmwNI6y0rD9rs6pQ19b5XaA7DnTHel+0bi4lVgDW368PfSVWY8bBZ9lKGbPjEXuajA==
X-Received: by 2002:ac8:33c3:: with SMTP id d3mr12919484qtb.41.1570145589825;
 Thu, 03 Oct 2019 16:33:09 -0700 (PDT)
Date:   Thu,  3 Oct 2019 16:32:58 -0700
In-Reply-To: <cover.1570144820.git.steadmon@google.com>
Message-Id: <98a8440d3f0ef3cd3cdd0291051d976d4a659cc4.1570144820.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1570144820.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v4 3/4] trace2: don't overload target directories
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

trace2 can write files into a target directory. With heavy usage, this
directory can fill up with files, causing difficulty for
trace-processing systems.

This patch adds a config option (trace2.maxFiles) to set a maximum
number of files that trace2 will write to a target directory. The
following behavior is enabled when the maxFiles is set to a positive
integer:
  When trace2 would write a file to a target directory, first check
  whether or not the directory is overloaded. A directory is overloaded
  if there is a sentinel file declaring an overload, or if the number of
  files exceeds trace2.maxFiles. If the latter, create a sentinel file
  to speed up later overload checks.

The assumption is that a separate trace-processing system is dealing
with the generated traces; once it processes and removes the sentinel
file, it should be safe to generate new trace files again.

The default value for trace2.maxFiles is zero, which disables the
overload check.

The config can also be overridden with a new environment variable:
GIT_TRACE2_MAX_FILES.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/config/trace2.txt |  6 +++
 t/t0212-trace2-event.sh         | 17 +++++++
 trace2/tr2_dst.c                | 86 +++++++++++++++++++++++++++++++++
 trace2/tr2_sysenv.c             |  3 ++
 trace2/tr2_sysenv.h             |  2 +
 5 files changed, 114 insertions(+)

diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.txt
index 2edbfb02fe..4ce0b9a6d1 100644
--- a/Documentation/config/trace2.txt
+++ b/Documentation/config/trace2.txt
@@ -54,3 +54,9 @@ trace2.destinationDebug::
 	By default, these errors are suppressed and tracing is
 	silently disabled.  May be overridden by the
 	`GIT_TRACE2_DST_DEBUG` environment variable.
+
+trace2.maxFiles::
+	Integer.  When writing trace files to a target directory, do not
+	write additional traces if we would exceed this many files. Instead,
+	write a sentinel file that will block further tracing to this
+	directory. Defaults to 0, which disables this check.
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index ff5b9cc729..2ff97e72da 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -265,4 +265,21 @@ test_expect_success JSON_PP 'using global config, event stream, error event' '
 	test_cmp expect actual
 '
 
+test_expect_success "don't overload target directory" '
+	mkdir trace_target_dir &&
+	test_when_finished "rm -r trace_target_dir" &&
+	(
+		GIT_TRACE2_MAX_FILES=5 &&
+		export GIT_TRACE2_MAX_FILES &&
+		cd trace_target_dir &&
+		test_seq $GIT_TRACE2_MAX_FILES >../expected_filenames.txt &&
+		xargs touch <../expected_filenames.txt &&
+		cd .. &&
+		GIT_TRACE2_EVENT="$(pwd)/trace_target_dir" test-tool trace2 001return 0
+	) &&
+	echo git-trace2-overload >>expected_filenames.txt &&
+	ls trace_target_dir >ls_output.txt &&
+	test_cmp expected_filenames.txt ls_output.txt
+'
+
 test_done
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index 5dda0ca1cd..af3405f179 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -1,3 +1,5 @@
+#include <dirent.h>
+
 #include "cache.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
@@ -8,6 +10,19 @@
  */
 #define MAX_AUTO_ATTEMPTS 10
 
+/*
+ * Sentinel file used to detect when we're overloading a directory with too many
+ * trace files.
+ */
+#define OVERLOAD_SENTINEL_NAME "git-trace2-overload"
+
+/*
+ * When set to zero, disables directory overload checking. Otherwise, controls
+ * how many files we can write to a directory before entering overload mode.
+ * This can be overridden via the TR2_SYSENV_MAX_FILES setting.
+ */
+static int tr2env_max_files = 0;
+
 static int tr2_dst_want_warning(void)
 {
 	static int tr2env_dst_debug = -1;
@@ -32,6 +47,67 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
 	dst->need_close = 0;
 }
 
+/*
+ * Check to make sure we're not overloading the target directory with too many
+ * files. First get the threshold (if present) from the config or envvar. If
+ * it's zero or unset, disable this check.  Next check for the presence of a
+ * sentinel file, then check file count. If we are overloaded, create the
+ * sentinel file if it doesn't already exist.
+ *
+ * We expect that some trace processing system is gradually collecting files
+ * from the target directory; after it removes the sentinel file we'll start
+ * writing traces again.
+ */
+static int tr2_dst_overloaded(const char *tgt_prefix)
+{
+	int file_count = 0, max_files = 0, ret = 0;
+	const char *max_files_var;
+	DIR *dirp;
+	struct strbuf path = STRBUF_INIT, sentinel_path = STRBUF_INIT;
+	struct stat statbuf;
+
+	/* Get the config or envvar and decide if we should continue this check */
+	max_files_var = tr2_sysenv_get(TR2_SYSENV_MAX_FILES);
+	if (max_files_var && *max_files_var && ((max_files = atoi(max_files_var)) >= 0))
+		tr2env_max_files = max_files;
+
+	if (!tr2env_max_files) {
+		ret = 0;
+		goto cleanup;
+	}
+
+	strbuf_addstr(&path, tgt_prefix);
+	if (!is_dir_sep(path.buf[path.len - 1])) {
+		strbuf_addch(&path, '/');
+	}
+
+	/* check sentinel */
+	strbuf_addbuf(&sentinel_path, &path);
+	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
+	if (!stat(sentinel_path.buf, &statbuf)) {
+		ret = 1;
+		goto cleanup;
+	}
+
+	/* check file count */
+	dirp = opendir(path.buf);
+	while (file_count < tr2env_max_files && dirp && readdir(dirp))
+		file_count++;
+	if (dirp)
+		closedir(dirp);
+
+	if (file_count >= tr2env_max_files) {
+		creat(sentinel_path.buf, 0666);
+		ret = 1;
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&path);
+	strbuf_release(&sentinel_path);
+	return ret;
+}
+
 static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
 {
 	int fd;
@@ -50,6 +126,16 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
 	strbuf_addstr(&path, sid);
 	base_path_len = path.len;
 
+	if (tr2_dst_overloaded(tgt_prefix)) {
+		strbuf_release(&path);
+		if (tr2_dst_want_warning())
+			warning("trace2: not opening %s trace file due to too "
+				"many files in target directory %s",
+				tr2_sysenv_display_name(dst->sysenv_var),
+				tgt_prefix);
+		return 0;
+	}
+
 	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
 		if (attempt_count > 0) {
 			strbuf_setlen(&path, base_path_len);
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 5958cfc424..3c3792eca2 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -49,6 +49,9 @@ static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
 				       "trace2.perftarget" },
 	[TR2_SYSENV_PERF_BRIEF]    = { "GIT_TRACE2_PERF_BRIEF",
 				       "trace2.perfbrief" },
+
+	[TR2_SYSENV_MAX_FILES]     = { "GIT_TRACE2_MAX_FILES",
+				       "trace2.maxfiles" },
 };
 /* clang-format on */
 
diff --git a/trace2/tr2_sysenv.h b/trace2/tr2_sysenv.h
index 8dd82a7a56..d4364a7b85 100644
--- a/trace2/tr2_sysenv.h
+++ b/trace2/tr2_sysenv.h
@@ -24,6 +24,8 @@ enum tr2_sysenv_variable {
 	TR2_SYSENV_PERF,
 	TR2_SYSENV_PERF_BRIEF,
 
+	TR2_SYSENV_MAX_FILES,
+
 	TR2_SYSENV_MUST_BE_LAST
 };
 
-- 
2.23.0.581.g78d2f28ef7-goog

