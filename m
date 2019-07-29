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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8CB1F97E
	for <e@80x24.org>; Mon, 29 Jul 2019 22:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfG2WU6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 18:20:58 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:49340 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfG2WU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 18:20:57 -0400
Received: by mail-qk1-f201.google.com with SMTP id l14so53107306qke.16
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=NYAUZdTyKy/QotdR40vLbL2Nfr93N1Bt1/g6frVAwKc=;
        b=jsV0NAkCW1/hbZXOFXMiZEKcrZoqX7xA0TF0f4dzX9R9NhD6LuZQzjX9qrap/Paz0O
         WlvzeEBUTKIwEdnzARuM586efE9XLDuGl1+wf1LvSVqasCq6VhlSi2t4UppkTY2eQbKx
         u4V2Nkr0tEytqluA9jdF0C021PwEbBKf2QEUnPpfnxA6H71coYwXV+gNKHTRqnzmERRe
         Tl9CVakEgMOOrOQCQYDqzNGgM6fN0JcuCpfFpmDGOPdUy+iIxNeIx7DATe/tmk7bCuxi
         D7mj7JYJmJyBEFbsJmtSLxnkro2eTw0wMn8Cy09/rgtLJzbbMX2073CvWjOC4Qs+gorV
         2wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=NYAUZdTyKy/QotdR40vLbL2Nfr93N1Bt1/g6frVAwKc=;
        b=fUK3b9sEVJXCfKW+MqhUFaIub9SXvTnq/X0lqi4XWu/tePlRnKONCeyrxGpfNEHkcI
         NdrdKf8pgfgoxBRXQy1SnrTGhjveRz0BPekh7yHowBamATe1PbFSqesIfNVRKnkicinn
         MJmiAgSU5bbyHIeQrD6xqr8iaHD7HAUrk510/phML2IYVtiUIA3wW5479P1cODAQnE25
         uy1cuMz7yq/C1gQaRPLpVlXruGuwBXp/M9gKaw+vwoR9WwMujuzdgmSrPVOCu9DaQ8OT
         wt4pDyKWQY+auFcutkjMoocmPU78fYhYy6/atsqypK2ZnHMDpLABKtIVu42Hp9RgjGia
         z/0A==
X-Gm-Message-State: APjAAAU0nMd14D9cJWdhQAu5qr7RNuocdX7kbmpHRrj9T4yt1SS5QI+0
        vbYqEoT6hoAl3OrINIaLGuPLUF7CVU+3wcanGLPNe1BLrIm+Gdo6JnMgebZ01iSrnGrCMVHhIRM
        oDUzlyQDW6uPGea2zoLBB5+5H8zsBGYjxLWW/KdFHJik20JFxRZWc0pcEiLIfGlM=
X-Google-Smtp-Source: APXvYqwpGOu047yIWLUK/CVhNxCugnrBBCILhTWOGhZ4h9DGMHqo+PorNnvbWFJEH5LXdCyW6nNFfHSjhzhf4A==
X-Received: by 2002:a37:9dc8:: with SMTP id g191mr74931338qke.431.1564438856125;
 Mon, 29 Jul 2019 15:20:56 -0700 (PDT)
Date:   Mon, 29 Jul 2019 15:20:52 -0700
Message-Id: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [RFC PATCH] trace2: don't overload target directories
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

trace2 can write files into a target directory. With heavy usage, this
directory can fill up with files, causing difficulty for
trace-processing systems.

When trace2 would write a file to a target directory, first check
whether or not the directory is overloaded. A directory is overloaded if
there is a sentinel file declaring an overload, or if the number of
files exceeds a threshold. If the latter, create a sentinel file to
speed up later overload checks.

The file count threshold is currently set to 1M files, but this can be
overridden for testing with GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT.

The assumption is that a separate trace-processing system is dealing
with the generated traces; once it processes and removes the sentinel
file, it should be safe to generate new trace files again.

Potential future work:
* Write a message into the sentinel file (should match the requested
  trace2 output format).
* Make the overload threshold (and the whole overload feature)
  configurable.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/t0210-trace2-normal.sh | 15 ++++++++
 trace2/tr2_dst.c         | 81 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index ce7574edb1..e8a03e9212 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -186,4 +186,19 @@ test_expect_success 'using global config with include' '
 	test_cmp expect actual
 '
 
+test_expect_success "don't overload target directory" '
+	GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT=100 &&
+	export GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT &&
+	test_when_finished "rm -r trace_target_dir" &&
+	mkdir trace_target_dir &&
+	test_seq $GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT | sed "s#^#trace_target_dir/#" | sort > expected_filenames.txt &&
+	xargs touch < expected_filenames.txt &&
+	ls trace_target_dir | sed "s#^#trace_target_dir/#" > first_ls_output.txt &&
+	test_cmp expected_filenames.txt first_ls_output.txt &&
+	GIT_TRACE2="$(pwd)/trace_target_dir" test-tool trace2 001return 0 &&
+	echo "trace_target_dir/git-trace2-overload" >> expected_filenames.txt &&
+	ls trace_target_dir | sed "s#^#trace_target_dir/#" > second_ls_output.txt &&
+	test_cmp expected_filenames.txt second_ls_output.txt
+'
+
 test_done
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index 5dda0ca1cd..3286297918 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -1,3 +1,5 @@
+#include <dirent.h>
+
 #include "cache.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
@@ -8,6 +10,18 @@
  */
 #define MAX_AUTO_ATTEMPTS 10
 
+/*
+ * Sentinel file used to detect when we're overloading a directory with too many
+ * trace files.
+ */
+#define OVERLOAD_SENTINEL_NAME "git-trace2-overload"
+
+/*
+ * How many files we can write to a directory before entering overload mode.
+ * This can be overridden with the envvar GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT
+ */
+#define OVERLOAD_FILE_COUNT 1000000
+
 static int tr2_dst_want_warning(void)
 {
 	static int tr2env_dst_debug = -1;
@@ -32,6 +46,63 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
 	dst->need_close = 0;
 }
 
+/*
+ * Check to make sure we're not overloading the target directory with too many
+ * files. First check for the presence of a sentinel file, then check file
+ * count. If we are overloaded, create the sentinel file if it doesn't already
+ * exist.
+ *
+ * We expect that some trace processing system is gradually collecting files
+ * from the target directory; after it removes the sentinel file we'll start
+ * writing traces again.
+ */
+static int tr2_dst_overloaded(const char *tgt_prefix)
+{
+	int file_count = 0, overload_file_count = 0;
+	char *test_threshold_val;
+	DIR *dirp;
+	struct strbuf path = STRBUF_INIT, sentinel_path = STRBUF_INIT;
+	struct stat statbuf;
+
+	strbuf_addstr(&path, tgt_prefix);
+	if (!is_dir_sep(path.buf[path.len - 1])) {
+		strbuf_addch(&path, '/');
+	}
+
+	/* check sentinel */
+	strbuf_addstr(&sentinel_path, path.buf);
+	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
+	if (!stat(sentinel_path.buf, &statbuf)) {
+		strbuf_release(&path);
+		return 1;
+	}
+
+	/* check if we're overriding the threshold (e.g., for testing) */
+	test_threshold_val = getenv("GIT_TRACE2_TEST_OVERLOAD_FILE_COUNT");
+	if (test_threshold_val)
+		overload_file_count = atoi(test_threshold_val);
+	if (overload_file_count <= 0)
+		overload_file_count = OVERLOAD_FILE_COUNT;
+
+
+	/* check file count */
+	dirp = opendir(path.buf);
+	while (file_count < overload_file_count && dirp && readdir(dirp))
+		file_count++;
+	if (dirp)
+		closedir(dirp);
+
+	if (file_count >= overload_file_count) {
+		creat(sentinel_path.buf, S_IRUSR | S_IWUSR);
+		/* TODO: Write a target-specific message? */
+		strbuf_release(&path);
+		return 1;
+	}
+
+	strbuf_release(&path);
+	return 0;
+}
+
 static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
 {
 	int fd;
@@ -50,6 +121,16 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
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
-- 
2.22.0.709.g102302147b-goog

