Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC25A1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 22:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfJDWI0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 18:08:26 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:32858 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDWI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 18:08:26 -0400
Received: by mail-pl1-f202.google.com with SMTP id d2so4781140pll.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sOuCrhSsmDq/KD+ATvLopnV46RIR2E6O6AralE9eSt0=;
        b=tTKjKoMuuzIObNqlvqP+kYzHtVeDl5MfPXvjigtk8VRgmPgOh2BOXnYR2JLQf8xyyg
         sHQT8HvPsWxIW8V9TEpiUJPrFDaNX4B/qXzJC5XVla2uamSriB3PYqk8DoxSV13Mu9+1
         0wSXya6UuJouOptmKZqTCX69nip2j0vf9J4DGqtnNMixJKKuNcXbh4SqytmA+l3OJnK8
         ZPvi5ZBlMs8QYFLHkwfO5UaoxsdlGTWxlczkPh/lOdSEj2WMtMn0cXWKuZsg7ot9KX7i
         mNFywnPbUsDbqAhBiaGx00ZgpdFPxrQnKd5Vg/K2yh5hxkH81wXfemR+Ooj/odZXiv/Q
         AHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sOuCrhSsmDq/KD+ATvLopnV46RIR2E6O6AralE9eSt0=;
        b=lk6kxa04QzpVC8bXbYdH5KDv+9wdqOXN56g28O1cQojYqOanx/zCykZM8Ko3iUD4eN
         rUm0rBJW2FQuGXFIvfamEGl7PybwYaTRNWDute0hoXN7BbuPhDUBfKetr9nDlV8/ApNG
         XkhL12Z3l3oSZcA1Ex4AWKDXNG1o/nu+Bs0QkgmP8YNhBX6zFVYuwIi0PSbtgLFxuk+x
         spoK9mJS67vg7WJxxwbdHeQkPsM0p0D3o6gFTg52+9n5RJVprepxjp27PHYPCUsJkOhp
         wYg2pEMGy3Q1GuUIo/O6d/eWS/xb6Ca7GVgnpPMVqLYwiskEqepaBLR/eSMp1vunW+R3
         MQlQ==
X-Gm-Message-State: APjAAAWy2qRZvJOk58pwNTfY4SIhoicgMDrLJhtAhGSxlC6zTaMwxuJ/
        pwl1eRPygOCoZpagJymMU2D2gcH6gVJr2uBO8MyXJcmyAGy59mBl4PCII5Gx3nQCHH5H6CJSIth
        4+k7x7In/dW2FiYh0ptKDeVaQ6MxD6G8XsjN+jFX+CeeBBNzhfZeidHhgod2OZ1Y=
X-Google-Smtp-Source: APXvYqzpwWbnMDLfNfDvyKECC0xHzaKmNiMEkpubBfYq3qk43OJ4s2zUe/e4gwhAMVaCDfm1z3eEJve5ZhNVqQ==
X-Received: by 2002:a63:ce0e:: with SMTP id y14mr17744174pgf.309.1570226904225;
 Fri, 04 Oct 2019 15:08:24 -0700 (PDT)
Date:   Fri,  4 Oct 2019 15:08:17 -0700
In-Reply-To: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
Message-Id: <cover.1570225500.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v5 0/4] trace2: discard new traces if the target directory
 contains too many files
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since V4:
* Avoid the use of the non-specific term "overload" in code, trace
  output, commit messages, and documentation.
* Remove an unnecessary <dirent.h> include that was breaking the Windows
  build.

Josh Steadmon (4):
  docs: mention trace2 target-dir mode in git-config
  docs: clarify trace2 version invariants
  trace2: discard new traces if target directory has too many files
  trace2: write discard message to sentinel files

 Documentation/config/trace2.txt        |   6 ++
 Documentation/technical/api-trace2.txt |  31 +++++--
 Documentation/trace2-target-values.txt |   4 +-
 t/t0212-trace2-event.sh                |  19 +++++
 trace2/tr2_dst.c                       | 111 ++++++++++++++++++++++---
 trace2/tr2_dst.h                       |   1 +
 trace2/tr2_sysenv.c                    |   3 +
 trace2/tr2_sysenv.h                    |   2 +
 trace2/tr2_tgt_event.c                 |  31 +++++--
 trace2/tr2_tgt_normal.c                |   2 +-
 trace2/tr2_tgt_perf.c                  |   2 +-
 11 files changed, 184 insertions(+), 28 deletions(-)

Range-diff against v4:
1:  98a8440d3f ! 1:  391051b308 trace2: don't overload target directories
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    trace2: don't overload target directories
    +    trace2: discard new traces if target directory has too many files
     
         trace2 can write files into a target directory. With heavy usage, this
         directory can fill up with files, causing difficulty for
    @@ Commit message
         following behavior is enabled when the maxFiles is set to a positive
         integer:
           When trace2 would write a file to a target directory, first check
    -      whether or not the directory is overloaded. A directory is overloaded
    -      if there is a sentinel file declaring an overload, or if the number of
    -      files exceeds trace2.maxFiles. If the latter, create a sentinel file
    -      to speed up later overload checks.
    +      whether or not the traces should be discarded. Traces should be
    +      discarded if:
    +        * there is a sentinel file declaring that there are too many files
    +        * OR, the number of files exceeds trace2.maxFiles.
    +      In the latter case, we create a sentinel file named git-trace2-discard
    +      to speed up future checks.
     
         The assumption is that a separate trace-processing system is dealing
         with the generated traces; once it processes and removes the sentinel
         file, it should be safe to generate new trace files again.
     
    -    The default value for trace2.maxFiles is zero, which disables the
    -    overload check.
    +    The default value for trace2.maxFiles is zero, which disables the file
    +    count check.
     
         The config can also be overridden with a new environment variable:
         GIT_TRACE2_MAX_FILES.
    @@ t/t0212-trace2-event.sh: test_expect_success JSON_PP 'using global config, event
      	test_cmp expect actual
      '
      
    -+test_expect_success "don't overload target directory" '
    ++test_expect_success 'discard traces when there are too many files' '
     +	mkdir trace_target_dir &&
     +	test_when_finished "rm -r trace_target_dir" &&
     +	(
    @@ t/t0212-trace2-event.sh: test_expect_success JSON_PP 'using global config, event
     +		cd .. &&
     +		GIT_TRACE2_EVENT="$(pwd)/trace_target_dir" test-tool trace2 001return 0
     +	) &&
    -+	echo git-trace2-overload >>expected_filenames.txt &&
    ++	echo git-trace2-discard >>expected_filenames.txt &&
     +	ls trace_target_dir >ls_output.txt &&
     +	test_cmp expected_filenames.txt ls_output.txt
     +'
    @@ t/t0212-trace2-event.sh: test_expect_success JSON_PP 'using global config, event
      test_done
     
      ## trace2/tr2_dst.c ##
    -@@
    -+#include <dirent.h>
    -+
    - #include "cache.h"
    - #include "trace2/tr2_dst.h"
    - #include "trace2/tr2_sid.h"
     @@
       */
      #define MAX_AUTO_ATTEMPTS 10
      
     +/*
    -+ * Sentinel file used to detect when we're overloading a directory with too many
    -+ * trace files.
    ++ * Sentinel file used to detect when we should discard new traces to avoid
    ++ * writing too many trace files to a directory.
     + */
    -+#define OVERLOAD_SENTINEL_NAME "git-trace2-overload"
    ++#define DISCARD_SENTINEL_NAME "git-trace2-discard"
     +
     +/*
    -+ * When set to zero, disables directory overload checking. Otherwise, controls
    -+ * how many files we can write to a directory before entering overload mode.
    ++ * When set to zero, disables directory file count checks. Otherwise, controls
    ++ * how many files we can write to a directory before entering discard mode.
     + * This can be overridden via the TR2_SYSENV_MAX_FILES setting.
     + */
     +static int tr2env_max_files = 0;
    @@ trace2/tr2_dst.c: void tr2_dst_trace_disable(struct tr2_dst *dst)
     + * from the target directory; after it removes the sentinel file we'll start
     + * writing traces again.
     + */
    -+static int tr2_dst_overloaded(const char *tgt_prefix)
    ++static int tr2_dst_too_many_files(const char *tgt_prefix)
     +{
     +	int file_count = 0, max_files = 0, ret = 0;
     +	const char *max_files_var;
    @@ trace2/tr2_dst.c: void tr2_dst_trace_disable(struct tr2_dst *dst)
     +
     +	/* check sentinel */
     +	strbuf_addbuf(&sentinel_path, &path);
    -+	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
    ++	strbuf_addstr(&sentinel_path, DISCARD_SENTINEL_NAME);
     +	if (!stat(sentinel_path.buf, &statbuf)) {
     +		ret = 1;
     +		goto cleanup;
    @@ trace2/tr2_dst.c: static int tr2_dst_try_auto_path(struct tr2_dst *dst, const ch
      	strbuf_addstr(&path, sid);
      	base_path_len = path.len;
      
    -+	if (tr2_dst_overloaded(tgt_prefix)) {
    ++	if (tr2_dst_too_many_files(tgt_prefix)) {
     +		strbuf_release(&path);
     +		if (tr2_dst_want_warning())
     +			warning("trace2: not opening %s trace file due to too "
2:  790c5ac95a ! 2:  1c3c7f01c6 trace2: write overload message to sentinel files
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    trace2: write overload message to sentinel files
    +    trace2: write discard message to sentinel files
     
    -    Add a new "overload" event type for trace2 event destinations. When the
    -    trace2 overload feature creates a sentinel file, it will include the
    -    normal trace2 output in the sentinel, along with this new overload
    +    Add a new "discard" event type for trace2 event destinations. When the
    +    trace2 file count check creates a sentinel file, it will include the
    +    normal trace2 output in the sentinel, along with this new discard
         event.
     
         Writing this message into the sentinel file is useful for tracking how
    -    often the overload protection feature is triggered in practice.
    +    often the file count check triggers in practice.
     
         Bump up the event format version since we've added a new event type.
     
    @@ Documentation/technical/api-trace2.txt: only present on the "start" and "atexit"
      }
      ------------
      
    -+`"overload"`::
    -+	This event is created in a sentinel file if we are overloading a target
    -+	trace directory (see the trace2.maxFiles config option).
    ++`"discard"`::
    ++	This event is written to the git-trace2-discard sentinel file if there
    ++	are too many files in the target trace directory (see the
    ++	trace2.maxFiles config option).
     ++
     +------------
     +{
    -+	"event":"overload",
    ++	"event":"discard",
     +	...
     +}
     +------------
    @@ Documentation/technical/api-trace2.txt: only present on the "start" and "atexit"
      +
     
      ## t/t0212-trace2-event.sh ##
    -@@ t/t0212-trace2-event.sh: test_expect_success "don't overload target directory" '
    +@@ t/t0212-trace2-event.sh: test_expect_success 'discard traces when there are too many files' '
      	) &&
    - 	echo git-trace2-overload >>expected_filenames.txt &&
    + 	echo git-trace2-discard >>expected_filenames.txt &&
      	ls trace_target_dir >ls_output.txt &&
     -	test_cmp expected_filenames.txt ls_output.txt
     +	test_cmp expected_filenames.txt ls_output.txt &&
    -+	head -n1 trace_target_dir/git-trace2-overload | grep \"event\":\"version\" &&
    -+	head -n2 trace_target_dir/git-trace2-overload | tail -n1 | grep \"event\":\"overload\"
    ++	head -n1 trace_target_dir/git-trace2-discard | grep \"event\":\"version\" &&
    ++	head -n2 trace_target_dir/git-trace2-discard | tail -n1 | grep \"event\":\"too_many_files\"
      '
      
      test_done
    @@ trace2/tr2_dst.c: void tr2_dst_trace_disable(struct tr2_dst *dst)
     + * sentinel file, then check file count.
     + *
     + * Returns 0 if tracing should proceed as normal. Returns 1 if the sentinel file
    -+ * already exists, which means tracing should be disabled. Returns -1 if we are
    -+ * overloaded but there was no sentinel file, which means we have created and
    -+ * should write traces to the sentinel file.
    ++ * already exists, which means tracing should be disabled. Returns -1 if there
    ++ * are too many files but there was no sentinel file, which means we have
    ++ * created and should write traces to the sentinel file.
       *
       * We expect that some trace processing system is gradually collecting files
       * from the target directory; after it removes the sentinel file we'll start
       * writing traces again.
       */
    --static int tr2_dst_overloaded(const char *tgt_prefix)
    -+static int tr2_dst_overloaded(struct tr2_dst *dst, const char *tgt_prefix)
    +-static int tr2_dst_too_many_files(const char *tgt_prefix)
    ++static int tr2_dst_too_many_files(struct tr2_dst *dst, const char *tgt_prefix)
      {
      	int file_count = 0, max_files = 0, ret = 0;
      	const char *max_files_var;
    -@@ trace2/tr2_dst.c: static int tr2_dst_overloaded(const char *tgt_prefix)
    +@@ trace2/tr2_dst.c: static int tr2_dst_too_many_files(const char *tgt_prefix)
      		closedir(dirp);
      
      	if (file_count >= tr2env_max_files) {
     -		creat(sentinel_path.buf, 0666);
     -		ret = 1;
    -+		dst->overloaded = 1;
    ++		dst->too_many_files = 1;
     +		dst->fd = open(sentinel_path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
     +		ret = -1;
      		goto cleanup;
      	}
      
    -@@ trace2/tr2_dst.c: static int tr2_dst_overloaded(const char *tgt_prefix)
    +@@ trace2/tr2_dst.c: static int tr2_dst_too_many_files(const char *tgt_prefix)
      
      static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
      {
     -	int fd;
    -+	int overloaded;
    ++	int too_many_files;
      	const char *last_slash, *sid = tr2_sid_get();
      	struct strbuf path = STRBUF_INIT;
      	size_t base_path_len;
    @@ trace2/tr2_dst.c: static int tr2_dst_try_auto_path(struct tr2_dst *dst, const ch
      	strbuf_addstr(&path, sid);
      	base_path_len = path.len;
      
    --	if (tr2_dst_overloaded(tgt_prefix)) {
    -+	overloaded = tr2_dst_overloaded(dst, tgt_prefix);
    -+	if (!overloaded) {
    +-	if (tr2_dst_too_many_files(tgt_prefix)) {
    ++	too_many_files = tr2_dst_too_many_files(dst, tgt_prefix);
    ++	if (!too_many_files) {
     +		for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
     +			if (attempt_count > 0) {
     +				strbuf_setlen(&path, base_path_len);
    @@ trace2/tr2_dst.c: static int tr2_dst_try_auto_path(struct tr2_dst *dst, const ch
     +			if (dst->fd != -1)
     +				break;
     +		}
    -+	} else if (overloaded == 1) {
    ++	} else if (too_many_files == 1) {
      		strbuf_release(&path);
      		if (tr2_dst_want_warning())
      			warning("trace2: not opening %s trace file due to too "
    @@ trace2/tr2_dst.h: struct tr2_dst {
      	int fd;
      	unsigned int initialized : 1;
      	unsigned int need_close : 1;
    -+	unsigned int overloaded : 1;
    ++	unsigned int too_many_files : 1;
      };
      
      /*
    @@ trace2/tr2_tgt_event.c: static void event_fmt_prepare(const char *event_name, co
      		jw_object_intmax(jw, "repo", repo->trace2_repo_id);
      }
      
    -+static void fn_overload_fl(const char *file, int line)
    ++static void fn_too_many_files_fl(const char *file, int line)
     +{
    -+	const char *event_name = "overload";
    ++	const char *event_name = "too_many_files";
     +	struct json_writer jw = JSON_WRITER_INIT;
     +
     +	jw_object_begin(&jw, 0);
    @@ trace2/tr2_tgt_event.c: static void fn_version_fl(const char *file, int line)
      	tr2_dst_write_line(&tr2dst_event, &jw.json);
      	jw_release(&jw);
     +
    -+	if (tr2dst_event.overloaded)
    -+		fn_overload_fl(file, line);
    ++	if (tr2dst_event.too_many_files)
    ++		fn_too_many_files_fl(file, line);
      }
      
      static void fn_start_fl(const char *file, int line,
-- 
2.23.0.581.g78d2f28ef7-goog

