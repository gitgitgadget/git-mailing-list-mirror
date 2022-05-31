Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BD8C433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 16:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346257AbiEaQ7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbiEaQ7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 12:59:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A916C68986
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so1550215wmz.2
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGpQ+ZTTt1k1UM6XQDaXptDYn6ah+wsnVHE0WIef1Sg=;
        b=Q78tI7i8yJt3dDKwvl1L/S0JZ6EXhCyCqnUzLLeE5YY9otzqS8hN9r64iiPqhcouTk
         vDsIZwhRt7xkbqOi8OkqefIM0QbJlWzxBVbHEGLAKQQdlQ0K0VwM5sWgKhkHL6sVhNkl
         Dig3X+vUvt21GdnbtO14Tw+NNwF23qWgTqSOvQEt6ryOxrm2coGJELeCebDaEM6trIGf
         RObzuziZjXpRMC7eFvRHyOuH93Sefvo3mJQCgPf6Wq5Zu3r+KUjD84OQNfklrMM5YgaA
         rPBPzMHI7ceEfwWaUU3juez2ZZmJCaPNwXu/qxk3LaGaCF3qffijNO7+Sg3xvBhU/MHA
         Dqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGpQ+ZTTt1k1UM6XQDaXptDYn6ah+wsnVHE0WIef1Sg=;
        b=jBPQLwlJuaCQffHN7Pk+x01xmtjST5ZvZBElj/Yb8X5bHDEcVLlfB4INwLPqG2Y7xU
         RviDGbzerBFkhnivaGA54Un+nBgHSgiU4dhkFWRecjth43CB2wXzgn4HgDuDk+0OardL
         LWMKiWjytU/coZWmOC5/0m3DRGuYCGEyoFYiwxp3jMvA8PubgqSFE47wVPJvVdurSiPX
         3j2M8IgaMy7aVqz2VF8snTiySeTpa7fwJl8/bxvoSG7932JVlZOiHplqC4AO4Pw3XrR2
         bvM7GZjlV/WbezfoDR5sHTkLqZcqm5A3k7Balc8QITnTAjf4v8sCryGriN+TC9PIEbCp
         pZvg==
X-Gm-Message-State: AOAM530O0XcW6orJV5f6wiPj0n4bmIG9lGcVlrmvSA7DLA872zXehtA7
        FK7qNwLh9o1+XfO+eDxuF2kgPUB2QEg=
X-Google-Smtp-Source: ABdhPJwLhAcZkGs+VYBdjBa4bsWyCvQBJcdAi1Lt/3nhiGmE1wVAU8GcYUF6q24mo5XqQbB82RqsKQ==
X-Received: by 2002:a05:600c:3ac3:b0:399:323:3a8d with SMTP id d3-20020a05600c3ac300b0039903233a8dmr11155798wms.101.1654016343486;
        Tue, 31 May 2022 09:59:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d47c3000000b0020d0cdbf7eesm12829820wrc.111.2022.05.31.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 09:59:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] usage API: add and use a bug() + BUG_if_bug()
Date:   Tue, 31 May 2022 18:58:42 +0200
Message-Id: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1100.g16130010d07
In-Reply-To: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a bug() (lower-case) function to go along with
BUG(). As seen in 3-5/6 this makes it much easier to handle the cases
such as parse-options.c where we'd like to call BUG(), but would like
to first exhaustively accumulate the N issues we spot before doing so,
and not merely BUG() out on the first one.

Changes since v1
(https://lore.kernel.org/git/cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com/):

 * Move the exit() wrapper to common-main.c, I tried to add a
   "common-exit.c" or just rename "common-main.c" to "common.c", but
   due to how the CMake build system declares it those changes would
   result in a lot of churn, so for now just adding it to
   common-main.c makes more sense.

 * Typo/grammar fixes in commit messages, as pointed out in review.

 * The BUG_if_bug() function is now optional, and the docs have been
   updated to reflect that.

 * The BUG_if_bug() function now takes a va_args like BUG() to
   indicate what the problem was.

 * Updated 3/6 to note that the exit(128) code changes with a
   migration to BUG().

 * Fix logic error in 4/6: We now "break" after calling bug(), to
   behave as the previous code did.

 * Fix logic error in 5/6, which now makes use of the new argument(s)
   to BUG_if_bug().

 * There was some suggestion of ejecting 6/6, but I've instead
   replaced it with the implementation Glen suggested in
   http://lore.kernel.org/git/kl6lk0a6mzp0.fsf@chooglen-macbookpro.roam.corp.google.com

Ævar Arnfjörð Bjarmason (6):
  common-main.o: move non-trace2 exit() behavior out of trace2.c
  usage.c: add a non-fatal bug() function to go with BUG()
  parse-options.c: use new bug() API for optbug()
  parse-options.c: use optbug() instead of BUG() "opts" check
  receive-pack: use bug() and BUG_if_bug()
  cache-tree.c: use bug() and BUG_if_bug()

 .../technical/api-error-handling.txt          | 19 +++++-
 Documentation/technical/api-trace2.txt        |  4 +-
 builtin/receive-pack.c                        | 16 ++---
 cache-tree.c                                  |  8 +--
 common-main.c                                 | 30 ++++++++-
 git-compat-util.h                             | 24 ++++++-
 parse-options.c                               | 67 ++++++++++---------
 t/helper/test-trace2.c                        | 22 +++++-
 t/t0210-trace2-normal.sh                      | 52 ++++++++++++++
 trace2.c                                      |  8 +--
 trace2.h                                      |  8 +--
 usage.c                                       | 30 +++++++--
 12 files changed, 217 insertions(+), 71 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  d446e4679d4 common-main.o: move non-trace2 exit() behavior out of trace2.c
1:  faa1c708a79 ! 2:  2d0527f86dc usage.c: add a non-fatal bug() function to go with BUG()
    @@ Commit message
         usage.c: add a non-fatal bug() function to go with BUG()
     
         Add a bug() function to use in cases where we'd like to indicate a
    -    runtime BUG(), but would like to deref the BUG() call because we're
    +    runtime BUG(), but would like to defer the BUG() call because we're
         possibly accumulating more bug() callers to exhaustively indicate what
         went wrong.
     
    @@ Commit message
         also be able to avoid calls to xstrfmt() in some cases, as the bug()
         function itself accepts variadic sprintf()-like arguments.
     
    -    Any caller to bug() should follow up such calls with BUG_if_bug(),
    +    Any caller to bug() can follow up such calls with BUG_if_bug(),
         which will BUG() out (i.e. abort()) if there were any preceding calls
    -    to bug(). As the tests and documentation here show we'll catch missing
    +    to bug(), callers can also decide not to call BUG_if_bug() and leave
    +    the resulting BUG() invocation until exit() time. There are currently
    +    no bug() API users that don't call BUG_if_bug() themselves after a
    +    for-loop, but allowing for not calling BUG_if_bug() keeps the API
    +    flexible. As the tests and documentation here show we'll catch missing
         BUG_if_bug() invocations in our exit() wrapper.
     
         I'd previously proposed this as part of another series[1], in that
    @@ Documentation/technical/api-error-handling.txt
        i.e. a bug in git itself.
      
     +- `bug` (lower-case, not `BUG`) is supposed to be used like `BUG` but
    -+  prints a "BUG" message instead of calling `abort()`. We then expect
    -+  `BUG_if_bug()` to be called to `abort()` if there were any calls to
    -+  `bug()`. If there weren't any a call to `BUG_if_bug()` is a NOOP.
    ++  prints a "BUG" message instead of calling `abort()`.
    +++
    ++A call to `bug()` will then result in a "real" call to the `BUG()`
    ++function, either explicitly by invoking `BUG_if_bug()` after call(s)
    ++to `bug()`, or implicitly at `exit()` time where we'll check if we
    ++encountered any outstanding `bug()` invocations.
    +++
    ++If there were no prior calls to `bug()` before invoking `BUG_if_bug()`
    ++the latter is a NOOP. The `BUG_if_bug()` function takes the same
    ++arguments as `BUG()` itself. Calling `BUG_if_bug()` explicitly isn't
    ++necessary, but ensures that we die as soon as possible.
     ++
     +This is for the convenience of APIs who'd like to potentially report
     +more than one "bug", such as the optbug() validation in
     +parse-options.c.
    -++
    -+We call `BUG_if_bug()` ourselves at `exit()` time (via a wrapper, not
    -+`atexit()`), which guarantees that we'll catch cases where we forgot
    -+to invoke `BUG_if_bug()` after calls to `bug()`. Thus calling
    -+`BUG_if_bug()` isn't strictly necessary, but ensures that we die as
    -+soon as possible.
     +
      - `die` is for fatal application errors.  It prints a message to
        the user and exits with status 128.
    @@ Documentation/technical/api-trace2.txt: completed.)
      ------------
      {
     
    + ## common-main.c ##
    +@@ common-main.c: int main(int argc, const char **argv)
    + 	exit(result);
    + }
    + 
    ++static void check_bug_if_BUG(void)
    ++{
    ++	if (!bug_called_must_BUG)
    ++		return;
    ++
    ++	/* BUG_vfl() calls exit(), which calls us again */
    ++	bug_called_must_BUG = 0;
    ++	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
    ++}
    ++
    + int common_exit(const char *file, int line, int code)
    + {
    + 	/*
    +@@ common-main.c: int common_exit(const char *file, int line, int code)
    + 	 */
    + 	code &= 0xff;
    + 
    ++	check_bug_if_BUG();
    + 	trace2_cmd_exit_fl(file, line, code);
    + 
    + 	return code;
    +
      ## git-compat-util.h ##
     @@ git-compat-util.h: static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
      /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
    @@ git-compat-util.h: static inline int regexec_buf(const regex_t *preg, const char
     +__attribute__((format (printf, 3, 4)))
     +void bug_fl(const char *file, int line, const char *fmt, ...);
     +#define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
    -+#define BUG_if_bug() do { \
    ++#define BUG_if_bug(...) do { \
     +	if (bug_called_must_BUG) { \
     +		bug_called_must_BUG = 0; \
    -+		BUG_fl(__FILE__, __LINE__, "see bug() output above"); \
    ++		BUG_fl(__FILE__, __LINE__, __VA_ARGS__); \
     +	} \
     +} while (0)
      
    @@ t/helper/test-trace2.c: static int ut_007bug(int argc, const char **argv)
     +{
     +	bug("a bug message");
     +	bug("another bug message");
    -+	BUG_if_bug();
    ++	BUG_if_bug("an explicit BUG_if_bug() following bug() call(s) is nice, but not required");
     +	return 0;
     +}
     +
    @@ t/helper/test-trace2.c: static int ut_007bug(int argc, const char **argv)
     +{
     +	bug("a bug message");
     +	bug("another bug message");
    ++	/* The BUG_if_bug(...) isn't here, but we'll spot bug() calls on exit()! */
     +	return 0;
     +}
     +
    @@ t/t0210-trace2-normal.sh: test_expect_success 'BUG messages are written to trace
     +	cat >expect <<-\EOF &&
     +	a bug message
     +	another bug message
    -+	see bug() output above
    ++	an explicit BUG_if_bug() following bug() call(s) is nice, but not required
     +	EOF
     +	sed "s/^.*: //" <err >actual &&
     +	test_cmp expect actual &&
    @@ t/t0210-trace2-normal.sh: test_expect_success 'BUG messages are written to trace
     +		cmd_name trace2 (trace2)
     +		error a bug message
     +		error another bug message
    -+		error see bug() output above
    ++		error an explicit BUG_if_bug() following bug() call(s) is nice, but not required
     +		exit elapsed:_TIME_ code:99
     +		atexit elapsed:_TIME_ code:99
     +	EOF
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'bug messages without BUG_if_bug() are written to trace2' '
    ++test_expect_success 'bug messages without explicit BUG_if_bug() are written to trace2' '
     +	test_when_finished "rm trace.normal actual expect" &&
     +	test_expect_code 99 env GIT_TRACE2="$(pwd)/trace.normal" \
     +		test-tool trace2 009bug_BUG 2>err &&
     +	cat >expect <<-\EOF &&
     +	a bug message
     +	another bug message
    -+	had bug() output above, in addition missed BUG_if_bug() call
    ++	had bug() call(s) in this process without explicit BUG_if_bug()
     +	EOF
     +	sed "s/^.*: //" <err >actual &&
     +	test_cmp expect actual &&
    @@ t/t0210-trace2-normal.sh: test_expect_success 'BUG messages are written to trace
     +		cmd_name trace2 (trace2)
     +		error a bug message
     +		error another bug message
    -+		error had bug() output above, in addition missed BUG_if_bug() call
    ++		error on exit(): had bug() call(s) in this process without explicit BUG_if_bug()
     +		exit elapsed:_TIME_ code:99
     +		atexit elapsed:_TIME_ code:99
     +	EOF
    @@ t/t0210-trace2-normal.sh: test_expect_success 'BUG messages are written to trace
      
      # Now test without environment variables and get all Trace2 settings
     
    - ## trace2.c ##
    -@@ trace2.c: int trace2_cmd_exit_fl(const char *file, int line, int code)
    - 
    - 	code &= 0xff;
    - 
    -+	if (bug_called_must_BUG) {
    -+		/* BUG_vfl() calls exit(), which calls us again */
    -+		bug_called_must_BUG = 0;
    -+		BUG("had bug() output above, in addition missed BUG_if_bug() call");
    -+	}
    -+
    - 	if (!trace2_enabled)
    - 		return code;
    - 
    -
      ## usage.c ##
     @@ usage.c: void warning(const char *warn, ...)
      /* Only set this, ever, from t/helper/, when verifying that bugs are caught. */
2:  a599cd015a3 ! 3:  4a7089fbbf2 parse-options.c: use new bug() API for optbug()
    @@ Commit message
         been using optbug() that aren't being changed here. That'll be done in
         a subsequent commit. This only changes the optbug() callers.
     
    +    Since this will invoke BUG() the previous exit(128) code will be
    +    changed, but in this case that's what we want, i.e. to have
    +    encountering a BUG() return the specific "BUG" exit code.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## parse-options.c ##
    @@ parse-options.c: static void parse_options_check(const struct option *opts)
      	}
     -	if (err)
     -		exit(128);
    -+	BUG_if_bug();
    ++	BUG_if_bug("invalid 'struct option'");
      }
      
      static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
3:  5a3e7609854 ! 4:  47d384d0ae5 parse-options.c: use optbug() instead of BUG() "opts" check
    @@ Commit message
     
      ## parse-options.c ##
     @@ parse-options.c: static void parse_options_check(const struct option *opts)
    + 				optbug(opts, "should not accept an argument");
      			break;
      		case OPTION_CALLBACK:
    - 			if (!opts->callback && !opts->ll_callback)
    +-			if (!opts->callback && !opts->ll_callback)
     -				BUG("OPTION_CALLBACK needs one callback");
    -+				optbug(opts, "OPTION_CALLBACK needs one callback");
    - 			if (opts->callback && opts->ll_callback)
    +-			if (opts->callback && opts->ll_callback)
     -				BUG("OPTION_CALLBACK can't have two callbacks");
    ++			if (!opts->callback && !opts->ll_callback) {
    ++				optbug(opts, "OPTION_CALLBACK needs one callback");
    ++				break;
    ++			}
    ++			if (opts->callback && opts->ll_callback) {
     +				optbug(opts, "OPTION_CALLBACK can't have two callbacks");
    ++				break;
    ++			}
      			break;
      		case OPTION_LOWLEVEL_CALLBACK:
    - 			if (!opts->ll_callback)
    +-			if (!opts->ll_callback)
     -				BUG("OPTION_LOWLEVEL_CALLBACK needs a callback");
    -+				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs a callback");
    - 			if (opts->callback)
    +-			if (opts->callback)
     -				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
    ++			if (!opts->ll_callback) {
    ++				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs a callback");
    ++				break;
    ++			}
    ++			if (opts->callback) {
     +				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs no high level callback");
    ++				break;
    ++			}
      			break;
      		case OPTION_ALIAS:
     -			BUG("OPT_ALIAS() should not remain at this point. "
    @@ parse-options.c: static void parse_options_check(const struct option *opts)
     +			optbug(opts, "OPT_ALIAS() should not remain at this point. "
     +			       "Are you using parse_options_step() directly?\n"
     +			       "That case is not supported yet.");
    ++			break;
      		default:
      			; /* ok. (usually accepts an argument) */
      		}
4:  c590f4273c0 ! 5:  fe5c3926675 receive-pack: use bug() and BUG_if_bug()
    @@ Commit message
         Amend code added in a6a84319686 (receive-pack.c: shorten the
         execute_commands loop over all commands, 2015-01-07) and amended to
         hard die in b6a4788586d (receive-pack.c: die instead of error in case
    -    of possible future bug, 2015-01-07) to the new bug() function instead.
    +    of possible future bug, 2015-01-07) to use the new bug() function
    +    instead.
     
         Let's also rename the warn_if_*() function that code is in to
         BUG_if_*(), its name became outdated in b6a4788586d.
    @@ builtin/receive-pack.c: static int should_process_cmd(struct command *cmd)
     -			      cmd->ref_name);
     -			checked_connectivity = 0;
     -		}
    -+		if (!should_process_cmd(cmd) && si->shallow_ref[cmd->index])
    ++		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index])
     +			bug("connectivity check has not been run on ref %s",
     +			    cmd->ref_name);
      	}
     -	if (!checked_connectivity)
     -		BUG("connectivity check skipped???");
    -+	BUG_if_bug();
    ++	BUG_if_bug("connectivity check skipped???");
      }
      
      static void execute_commands_non_atomic(struct command *commands,
5:  bb5a53f3b73 ! 6:  cbbe0276966 cache-tree.c: use bug() and BUG_if_bug()
    @@ Commit message
         19c6a4f8369 (merge-recursive: do not return NULL only to cause
         segfault, 2010-01-21) to use the new bug() function.
     
    -    This gets the same job done with less code, this changes the output a
    -    bit, but since we're emitting BUG output let's say it's OK to prefix
    -    every line with the "unmerged index entry" message, instead of
    -    optimizing for readability. doing it this way gets rid of any state
    -    management in the loop itself in favor of BUG_if_bug().
    +    This gets the same job done with slightly less code, as we won't need
    +    to prefix lines with "BUG: ". More importantly we'll now log the full
    +    set of messages via trace2, before this we'd only log the one BUG()
    +    invocation.
    +
    +    While we're at it let's replace "There" with "there" in the message,
    +    i.e. not start a message with a capital letter, per the
    +    CodingGuidelines.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ cache-tree.c: struct tree* write_in_core_index_as_tree(struct repository *repo)
      	if (ret == WRITE_TREE_UNMERGED_INDEX) {
      		int i;
     -		fprintf(stderr, "BUG: There are unmerged index entries:\n");
    ++		bug("there are unmerged index entries:");
      		for (i = 0; i < index_state->cache_nr; i++) {
      			const struct cache_entry *ce = index_state->cache[i];
      			if (ce_stage(ce))
     -				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
     -					(int)ce_namelen(ce), ce->name);
    -+				bug("unmerged index entry on in-memory index write: %d %.*s",
    -+				    ce_stage(ce), (int)ce_namelen(ce), ce->name);
    ++				bug("%d %.*s", ce_stage(ce),
    ++				    (int)ce_namelen(ce), ce->name);
      		}
     -		BUG("unmerged index entries when writing inmemory index");
    -+		BUG_if_bug();
    ++		bug("unmerged index entries when writing inmemory index");
      	}
      
      	return lookup_tree(repo, &index_state->cache_tree->oid);
-- 
2.36.1.1100.g16130010d07

