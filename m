Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FFEC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 10:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C3E64E30
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 10:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBKKtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 05:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhBKKqm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 05:46:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1776C061793
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 02:45:40 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v1so98551wrd.6
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 02:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wj/o623F+K3uMEhmQ+niW+r0yptOJJkCIBPXnfF+KWs=;
        b=FRslZdmJz3DDdvzO1PzZmzsjOkIKyK4bjj4rLC2h7TNQUAwN1moUPF6/sRPZCThw3B
         5ReeyC09IzP5gPcEL0m5kqqOCVxDZnfNwmAP7dhZ9Zdc7waGZIuyPsQXGtc0HoygdzCh
         KmzlpfTJPa/avUmCLlKmRpk5TbAWt8PsMjN4+a8tkxXn/pRrjmkwB7CEQ7MKsf6FfrN6
         fDr+NCRrWTxG7vMj4fMBbmg0Qfs8/6HTOZ03XFJls40dViIj9VmYxNqAp62t8Do8Pdma
         bIYWpEhHA6d+uhCB09Do8sDvN65F/zNtXKzg81hD60Kn3EqpSbMjdMRBMPqqW4yYDjsf
         QfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wj/o623F+K3uMEhmQ+niW+r0yptOJJkCIBPXnfF+KWs=;
        b=rioUHlBjhdENOOVcK22boNCpWMo2Am7jd2UDQadftuavDie3cqFcqn5w5e5cNpfM4f
         WSY/FwI/ifUXxK4wsaqqqYKSCUyZJ4rVcQi0fPqar474j1PiWu2i2hUXoqPlW39b0UKF
         ZqD3euIqJN6QNIaua27Dxo53novVrQZT51LNiUOP9/1OoN9OjGrgoG/iWqBkse5Fr/9J
         S3l23lRnxmV0sDQPX64JADgJy6DDejQMaFU0Whx9QwezmNW+FREnKxks6xvJF8joUEc8
         rKJLkMw1d2uX/s1pi3PiH20HkGtMhjMxMJnWz+PUDc0EXM7XSTInlx4QkYcbtDtmxuTm
         uj8A==
X-Gm-Message-State: AOAM533Y0wltfzAPJSE0by9cVmNSGSJ30XnrslHwX1MyCKBOdB7Oxbpg
        eQl6SmvG5uRJ7SCXJGUkRYGa0FHWMGGMOA==
X-Google-Smtp-Source: ABdhPJyD1DF+qab7zvU5tBWuuqZch2JTgW5DtbKuhyhEo4f2G0rrr++yDvT2A/zT75aWAuSgLhuwXw==
X-Received: by 2002:adf:dd45:: with SMTP id u5mr5023314wrm.392.1613040339013;
        Thu, 11 Feb 2021 02:45:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s11sm164767wra.82.2021.02.11.02.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 02:45:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <michal@isc.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] diff: add an API for deferred freeing
Date:   Thu, 11 Feb 2021 11:45:33 +0100
Message-Id: <20210211104535.16076-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <YCUFNVj7qlt9wzlX@coredump.intra.peff.net>
References: <YCUFNVj7qlt9wzlX@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I skipped the rename of the "close_file" flag, and updated the code &
commit messages in response to Johannes's feedback on v1. Hopefully
this is all better now.

Ævar Arnfjörð Bjarmason (2):
  diff: add an API for deferred freeing
  diff: plug memory leak from regcomp() on {log,diff} -I

 builtin/log.c | 23 ++++++++++++-----------
 diff.c        | 32 ++++++++++++++++++++++++++++----
 diff.h        | 15 ++++++++++++++-
 log-tree.c    | 10 ++++++----
 4 files changed, 60 insertions(+), 20 deletions(-)

Range-diff:
1:  531fed77f4c ! 1:  045d3f72d15 diff: add an API for deferred freeing
    @@ Commit message
         by setting "no_free" in "diff_options".
     
         This is required because when e.g. "git diff" is run we'll allocate
    -    things in that struct, use the diff machinery once, and then exit, but
    -    if we run e.g. "git log -p" we're going to re-use what we allocated
    -    across multiple diff_flush() calls, and only want to free things at
    -    the end.
    +    things in that struct, use the diff machinery once, and then exit.
    +
    +    But if we run e.g. "git log -p" we're going to re-use what we
    +    allocated across multiple diff_flush() calls, and only want to free
    +    things at the end.
     
         We've thus ended up with features like the recently added "diff -I"[1]
         where we'll leak memory. As it turns out it could have simply used the
    @@ Commit message
         the diffopt.close_file attribute, 2016-06-22).
     
         Manually adding more such flags to things log_tree_commit() every time
    -    we need to allocate something would be tedious.
    -
    -    Let's instead move that fclose() code it to a new diff_free(), in
    -    anticipation of freeing more things in that function in follow-up
    -    commits. I'm renaming the "close_file" struct member to "fclose_file"
    -    for the ease of validating this, we can be certain that these are all
    -    the relevant callsites.
    +    we need to allocate something would be tedious. Let's instead move
    +    that fclose() code it to a new diff_free(), in anticipation of freeing
    +    more things in that function in follow-up commits.
     
         Some functions such as log_tree_commit() need an idiom of optionally
         retaining a previous "no_free", as they may either free the memory
         themselves, or their caller may do so. I'm keeping that idiom in
    -    log_show_early() even though I don't think it's currently called in
    -    this manner, since it also gets passed an existing "struct rev_info"..
    +    log_show_early() for good measure, even though I don't think it's
    +    currently called in this manner. It also gets passed an existing
    +    "struct rev_info", so future callers may want to set the "no_free"
    +    flag.
    +
    +    This change is a bit hard to read because while the freeing pattern
    +    we're introducing isn't unusual, the "file" member is a special
    +    snowflake. We usually don't want to fclose() it. This is because
    +    "file" is usually stdout, in which case we don't want to fclose()
    +    it. We only want to opt-in to closing it when we e.g. open a file on
    +    the filesystem. Thus the opt-in "close_file" flag.
    +
    +    So the API in general just needs a "no_free" flag to defer freeing,
    +    but the "file" member still needs its "close_file" flag. This is made
    +    more confusing because while refactoring this code we could replace
    +    some "close_file=0" with "no_free=1", whereas others need to set both
    +    flags.
    +
    +    This is because there were some cases where an existing "close_file=0"
    +    meant "let's defer deallocation", and others where it meant "we don't
    +    want to close this file handle at all".
     
         1. 296d4a94e7 (diff: add -I<regex> that ignores matching changes,
            2020-10-20)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/add.c ##
    -@@ builtin/add.c: static int edit_patch(int argc, const char **argv, const char *prefix)
    - 	if (out < 0)
    - 		die(_("Could not open '%s' for writing."), file);
    - 	rev.diffopt.file = xfdopen(out, "w");
    --	rev.diffopt.close_file = 1;
    -+	rev.diffopt.fclose_file = 1;
    - 	if (run_diff_files(&rev, 0))
    - 		die(_("Could not write patch"));
    - 
    -
    - ## builtin/am.c ##
    -@@ builtin/am.c: static void write_commit_patch(const struct am_state *state, struct commit *comm
    - 	rev_info.diffopt.flags.full_index = 1;
    - 	rev_info.diffopt.use_color = 0;
    - 	rev_info.diffopt.file = fp;
    --	rev_info.diffopt.close_file = 1;
    -+	rev_info.diffopt.fclose_file = 1; /* log_tree_commit() sets .no_free=1 */
    - 	add_pending_object(&rev_info, &commit->object, "");
    - 	diff_setup_done(&rev_info.diffopt);
    - 	log_tree_commit(&rev_info, commit);
    -@@ builtin/am.c: static void write_index_patch(const struct am_state *state)
    - 	rev_info.diffopt.output_format = DIFF_FORMAT_PATCH;
    - 	rev_info.diffopt.use_color = 0;
    - 	rev_info.diffopt.file = fp;
    --	rev_info.diffopt.close_file = 1;
    -+	rev_info.diffopt.fclose_file = 1;
    -+	rev_info.diffopt.no_free = 1;
    - 	add_pending_object(&rev_info, &tree->object, "");
    - 	diff_setup_done(&rev_info.diffopt);
    - 	run_diff_index(&rev_info, 1);
    -+	diff_free(&rev_info.diffopt);
    - }
    - 
    - /**
    -
      ## builtin/log.c ##
     @@ builtin/log.c: static struct itimerval early_output_timer;
      
    @@ builtin/log.c: static int cmd_log_walk(struct rev_info *rev)
      	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
      	    rev->diffopt.flags.check_failed) {
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
    - 	if (rev.show_notes)
    - 		load_display_notes(&rev.notes_opt);
    - 
    --	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
    -+	if (use_stdout + rev.diffopt.fclose_file + !!output_directory > 1)
    - 		die(_("--stdout, --output, and --output-directory are mutually exclusive"));
    - 
    - 	if (use_stdout) {
    - 		setup_pager();
    --	} else if (rev.diffopt.close_file) {
    -+	} else if (rev.diffopt.fclose_file) {
    - 		/*
    - 		 * The diff code parsed --output; it has already opened the
      		 * file, but but we must instruct it not to close after each
      		 * diff.
      		 */
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      
     
      ## diff.c ##
    -@@ diff.c: static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
    - 	BUG_ON_OPT_NEG(unset);
    - 	path = prefix_filename(ctx->prefix, arg);
    - 	options->file = xfopen(path, "w");
    --	options->close_file = 1;
    -+	options->fclose_file = 1;
    - 	if (options->use_color != GIT_COLOR_ALWAYS)
    - 		options->use_color = GIT_COLOR_NEVER;
    - 	free(path);
    +@@ diff.c: static void diff_flush_patch_all_file_pairs(struct diff_options *o)
    + 	}
    + }
    + 
    ++static void diff_free_file(struct diff_options *options)
    ++{
    ++	if (options->close_file)
    ++		fclose(options->file);
    ++}
    ++
    ++void diff_free(struct diff_options *options)
    ++{
    ++	if (options->no_free)
    ++		return;
    ++
    ++	diff_free_file(options);
    ++}
    ++
    + void diff_flush(struct diff_options *options)
    + {
    + 	struct diff_queue_struct *q = &diff_queued_diff;
     @@ diff.c: void diff_flush(struct diff_options *options)
      		 * options->file to /dev/null should be safe, because we
      		 * aren't supposed to produce any output anyway.
      		 */
     -		if (options->close_file)
    -+		if (options->fclose_file)
    - 			fclose(options->file);
    +-			fclose(options->file);
    ++		diff_free_file(options);
      		options->file = xfopen("/dev/null", "w");
    --		options->close_file = 1;
    -+		options->fclose_file = 1;
    + 		options->close_file = 1;
      		options->color_moved = 0;
    - 		for (i = 0; i < q->nr; i++) {
    - 			struct diff_filepair *p = q->queue[i];
     @@ diff.c: void diff_flush(struct diff_options *options)
      free_queue:
      	free(q->queue);
    @@ diff.c: void diff_flush(struct diff_options *options)
      
      	/*
      	 * Report the content-level differences with HAS_CHANGES;
    -@@ diff.c: void diff_flush(struct diff_options *options)
    - 	}
    - }
    - 
    -+void diff_free(struct diff_options *options)
    -+{
    -+	if (options->no_free)
    -+		return;
    -+	if (options->fclose_file)
    -+		fclose(options->file);
    -+}
    -+	
    -+
    - static int match_filter(const struct diff_options *options, const struct diff_filepair *p)
    - {
    - 	return (((p->status == DIFF_STATUS_MODIFIED) &&
     
      ## diff.h ##
     @@
       * - Once you finish feeding the pairs of files, call `diffcore_std()`.
       * This will tell the diffcore library to go ahead and do its work.
       *
    -+ * - The `diff_opt_parse()` etc. functions might allocate memory in
    -+ *  `struct diff_options`. When running the API `N > 1` set `.no_free
    -+ *  = 1` to make the `diff_free()` invoked by `diff_flush()` below a
    -+ *  noop.
    -+ *
    -  * - Calling `diff_flush()` will produce the output.
    +- * - Calling `diff_flush()` will produce the output.
    ++ * - Calling `diff_flush()` will produce the output, it will call
    ++ *   `diff_free()` to free any resources, e.g. those allocated in
    ++ *   `diff_opt_parse()`.
     + *
    -+ * - If you set `.no_free = 1` before set it to `0` and call
    -+ *   `diff_free()` again. If `.no_free = 1` was not set there's no
    -+ *   need to call `diff_free()`, `diff_flush()` will call it.
    ++ * - Set `.no_free = 1` before calling `diff_flush()` to defer the
    ++ *   freeing of allocated memory in diff_options. This is useful when
    ++ *   `diff_flush()` is being called in a loop, rather than as a
    ++ *   one-off. When setting `.no_free = 1` you must ensure that
    ++ *   `diff_free()` is called at the end, either by flipping the flag
    ++ *   before the last `diff_flush()` call, or by flipping it before
    ++ *   calling `diff_free()` yourself.
       */
      
      struct combine_diff_path;
     @@ diff.h: struct diff_options {
    - 	void (*set_default)(struct diff_options *);
    - 
    - 	FILE *file;
    --	int close_file;
    -+	int fclose_file;
    - 
    - #define OUTPUT_INDICATOR_NEW 0
    - #define OUTPUT_INDICATOR_OLD 1
    -@@ diff.h: struct diff_options {
      
      	struct repository *repo;
      	struct option *parseopts;
    @@ log-tree.c: int log_tree_commit(struct rev_info *opt, struct commit *commit)
     +	diff_free(&opt->diffopt);
      	return shown;
      }
    -
    - ## wt-status.c ##
    -@@ wt-status.c: static void wt_longstatus_print_verbose(struct wt_status *s)
    - 	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
    - 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
    - 	rev.diffopt.file = s->fp;
    --	rev.diffopt.close_file = 0;
    -+	rev.diffopt.fclose_file = 0; /* wt_status owns the s->fp */
    - 	/*
    - 	 * If we're not going to stdout, then we definitely don't
    - 	 * want color, since we are going to the commit message
2:  7192cf01e71 ! 2:  f571524e6d8 diff: plug memory leak from regcomp() on {log,diff} -I
    @@ Commit message
         At that time freeing the memory was somewhat tedious, but since it
         isn't anymore with the newly introduced diff_free() let's use it.
     
    +    Let's retain the pattern for diff_free_file() and add a
    +    diff_free_ignore_regex(), even though (unlike "diff_free_file") we
    +    don't need to call it elsewhere. I think this'll make for more
    +    readable code than gradually accumulating a giant diff_free()
    +    function, sharing "int i" across unrelated code etc.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## diff.c ##
    -@@ diff.c: void diff_flush(struct diff_options *options)
    +@@ diff.c: static void diff_free_file(struct diff_options *options)
    + 		fclose(options->file);
    + }
      
    - void diff_free(struct diff_options *options)
    - {
    ++static void diff_free_ignore_regex(struct diff_options *options)
    ++{
     +	int i;
    - 	if (options->no_free)
    - 		return;
    - 	if (options->fclose_file)
    - 		fclose(options->file);
     +
     +	for (i = 0; i < options->ignore_regex_nr; i++) {
     +		regfree(options->ignore_regex[i]);
     +		free(options->ignore_regex[i]);
     +	}
     +	free(options->ignore_regex);
    ++}
    ++
    + void diff_free(struct diff_options *options)
    + {
    + 	if (options->no_free)
    + 		return;
    + 
    + 	diff_free_file(options);
    ++	diff_free_ignore_regex(options);
      }
    - 	
      
    + void diff_flush(struct diff_options *options)
-- 
2.30.0.284.gd98b1dd5eaa7

