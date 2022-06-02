Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2272AC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiFBMZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFBMZo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:25:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76855176D46
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:25:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s24so6240914wrb.10
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpI6WxfUd26/Kia+FMCoLeJgKHukZwCQeRVo2K6go4M=;
        b=ObuMwOf7SLbYR9bLfsE9wjZ3Po83mkJj8/wwduvieKUZxiaBQQrxH9/X/wF65ZmwUP
         x0hl8D13lvIYtgdr0bUwtVHMJwxbEr5+KxkRhknj9DbJB3jgzVA7PJ8yb6AICv+GOHR0
         rAcVAvZLU8DFzi7aBTLnEGbbysKfVvTZHZNwfyq6ycifoVYzuRr6/0W/4Q9XAr9gQBwl
         kqUhGxqYHzgErR/MRhSN43aCA6RdCwM/D6GsibfHj9TOt9vCgVR4XnKQ7MAnSpbIVBcO
         kutkg7cy1+g6wPdtVUVj1DUyiH714RspPg/u2DFErxMiD4yjNnQxoCZc6QvHSKCgQKwr
         bfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpI6WxfUd26/Kia+FMCoLeJgKHukZwCQeRVo2K6go4M=;
        b=leC1R3FOjdB3VckcQrrulQyrIKrv0Jom+Rr9fpVEEDwrLwR6K12BpLchxtYBqT89QA
         j/Dfe1W7OI6ytI9MFqNlg+W4OFxgQ+uiV2P9U/tXpWkMecXC+FDw7hgVfFuSivhcoIwN
         IrHmNgHQoKxvoqEBhVf6TtVIp/1rwOFcKDkgidqZ0z1ELF3oY0Oi+DwXjOEA6EBC3R6K
         WDRpS8mJXGFOnFN4s0YB/DCnV8GLeebAf1dpeOEynfPu7cVPYzhzQN3QnI3aJLelIOTP
         NnaRD34Y4lnjZDGRs0VSPG1SGYHsenwi3uBIUSKHJGmLCAiSJ1sO7eHfr8BiaYyXBFEG
         CRtA==
X-Gm-Message-State: AOAM533U5tyrSQ8Q4HpbB5/YVL0dXDen4gw/uOiiwfm34JSF7u6/6AEI
        e9k/rGJshgxJPn+pNtUZW7aoJn4afyL+Fw==
X-Google-Smtp-Source: ABdhPJy67IeGuDNXCoprHbCMS3trUymBVLldEyHSKktI24UPLVnJfVwGGOmN0BeQcqgNDif6QIsGxQ==
X-Received: by 2002:adf:bc04:0:b0:211:800a:7788 with SMTP id s4-20020adfbc04000000b00211800a7788mr3524307wrg.46.1654172740257;
        Thu, 02 Jun 2022 05:25:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0020e615bab7bsm4305100wrt.7.2022.06.02.05.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 05:25:39 -0700 (PDT)
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
Subject: [PATCH v3 0/6] usage API: add and use a bug() + BUG_if_bug()
Date:   Thu,  2 Jun 2022 14:25:31 +0200
Message-Id: <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
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

Changes since v2[1]:

 * Fix up commentary in 1/6 to address Junio's suggestions, and
   de-duplicate previously added commentary (just the one existing
   comment in git-compat-util.h sufficed).

 * The BUG() function itself now clears bug_called_must_BUG, as
   suggested by Glen. This simplifies things, and allows "BUG()" to be
   called after a sequence of "BUG()" instead of "BUG_if_bug()". That
   pattern is now used in 6/6.

   I pondered adding a message that BUG() would emit in that case,
   i.e. to say that we'd previously called bug() and were now calling
   BUG(), but left it. I think the result in 6/6 is better as a
   result.

 * Used "else if" in 4/6 and got rid of "break" to exhaustively log
   errors.

 * Got rid of a "below the fold" part of a commit message.

1. https://lore.kernel.org/git/cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  common-main.o: move non-trace2 exit() behavior out of trace2.c
  usage.c: add a non-fatal bug() function to go with BUG()
  parse-options.c: use new bug() API for optbug()
  parse-options.c: use optbug() instead of BUG() "opts" check
  receive-pack: use bug() and BUG_if_bug()
  cache-tree.c: use bug() and BUG_if_bug()

 .../technical/api-error-handling.txt          | 24 +++++-
 Documentation/technical/api-trace2.txt        |  4 +-
 builtin/receive-pack.c                        | 16 ++--
 cache-tree.c                                  |  6 +-
 common-main.c                                 | 28 ++++++-
 git-compat-util.h                             | 14 +++-
 parse-options.c                               | 53 +++++++------
 t/helper/test-trace2.c                        | 29 ++++++-
 t/t0210-trace2-normal.sh                      | 76 +++++++++++++++++++
 trace2.c                                      |  8 +-
 trace2.h                                      |  8 +-
 usage.c                                       | 33 ++++++--
 12 files changed, 230 insertions(+), 69 deletions(-)

Range-diff against v2:
1:  d446e4679d4 ! 1:  9c4f8d840e9 common-main.o: move non-trace2 exit() behavior out of trace2.c
    @@ Commit message
     
      ## common-main.c ##
     @@ common-main.c: int main(int argc, const char **argv)
    + 
      	result = cmd_main(argc, argv);
      
    - 	/*
    --	 * We define exit() to call trace2_cmd_exit_fl() in
    --	 * git-compat-util.h. Whether we reach this or exit()
    -+	 * We define exit() to call common_exit(), which will in turn
    -+	 * call trace2_cmd_exit_fl(). Whether we reach this or exit()
    - 	 * elsewhere we'll always run our trace2 exit handler.
    - 	 */
    - 	exit(result);
    - }
    ++	/* Not exit(3), but a wrapper calling our common_exit() */
    ++	exit(result);
    ++}
     +
    ++/* We wrap exit() to call common_exit() in git-compat-util.h */
     +int common_exit(const char *file, int line, int code)
     +{
    -+	/*
    + 	/*
    +-	 * We define exit() to call trace2_cmd_exit_fl() in
    +-	 * git-compat-util.h. Whether we reach this or exit()
    +-	 * elsewhere we'll always run our trace2 exit handler.
     +	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
     +	 * to e.g. turn -1 into 255. On a POSIX system this is
     +	 * redundant, see exit(3) and wait(2), but as it doesn't harm
     +	 * anything there we don't need to guard this with an "ifdef".
    -+	 */
    + 	 */
    +-	exit(result);
     +	code &= 0xff;
     +
     +	trace2_cmd_exit_fl(file, line, code);
     +
     +	return code;
    -+}
    + }
     
      ## git-compat-util.h ##
    -@@ git-compat-util.h: static inline int is_missing_file_error(int errno_)
    - 
    - int cmd_main(int, const char **);
    - 
    -+/**
    -+ * The exit() function is defined as common_exit() in
    -+ * git-compat-util.h.
    -+ *
    -+ * Intercepting the exit() allows us to hook in at-exit behavior, such
    -+ * emitting trace2 logging before calling the real exit().
    -+ */
    -+int common_exit(const char *file, int line, int code);
    -+
    - /*
    +@@ git-compat-util.h: int cmd_main(int, const char **);
       * Intercept all calls to exit() and route them to trace2 to
       * optionally emit a message before calling the real exit().
       */
     -int trace2_cmd_exit_fl(const char *file, int line, int code);
     -#define exit(code) exit(trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
    ++int common_exit(const char *file, int line, int code);
     +#define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
      
      /*
2:  2d0527f86dc ! 2:  033f373acaa usage.c: add a non-fatal bug() function to go with BUG()
    @@ Commit message
         flexible. As the tests and documentation here show we'll catch missing
         BUG_if_bug() invocations in our exit() wrapper.
     
    -    I'd previously proposed this as part of another series[1], in that
    -    use-case we ended thinking a BUG() would be better (and eventually
    -    96e41f58fe1 (fsck: report invalid object type-path combinations,
    -    2021-10-01) ended up with neither). Here though we'll end up
    -    converting various existing code that was already doing what we're
    -    doing better with this new API.
    -
    -    1. https://lore.kernel.org/git/YGRXomWwRYPdXZi3@coredump.intra.peff.net/
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/technical/api-error-handling.txt ##
    @@ Documentation/technical/api-error-handling.txt
     +arguments as `BUG()` itself. Calling `BUG_if_bug()` explicitly isn't
     +necessary, but ensures that we die as soon as possible.
     ++
    ++If you know you had prior calls to `bug()` then calling `BUG()` itself
    ++is equivalent to calling `BUG_if_bug()`, the latter being a wrapper
    ++calling `BUG()` if we've set a flag indicating that we've called
    ++`bug()`.
    +++
     +This is for the convenience of APIs who'd like to potentially report
     +more than one "bug", such as the optbug() validation in
     +parse-options.c.
    @@ common-main.c: int main(int argc, const char **argv)
     +{
     +	if (!bug_called_must_BUG)
     +		return;
    -+
    -+	/* BUG_vfl() calls exit(), which calls us again */
    -+	bug_called_must_BUG = 0;
     +	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
     +}
     +
    + /* We wrap exit() to call common_exit() in git-compat-util.h */
      int common_exit(const char *file, int line, int code)
      {
    - 	/*
     @@ common-main.c: int common_exit(const char *file, int line, int code)
      	 */
      	code &= 0xff;
    @@ git-compat-util.h: static inline int regexec_buf(const regex_t *preg, const char
     +void bug_fl(const char *file, int line, const char *fmt, ...);
     +#define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
     +#define BUG_if_bug(...) do { \
    -+	if (bug_called_must_BUG) { \
    -+		bug_called_must_BUG = 0; \
    ++	if (bug_called_must_BUG) \
     +		BUG_fl(__FILE__, __LINE__, __VA_ARGS__); \
    -+	} \
     +} while (0)
      
      #ifdef __APPLE__
    @@ t/helper/test-trace2.c: static int ut_007bug(int argc, const char **argv)
     +	/* The BUG_if_bug(...) isn't here, but we'll spot bug() calls on exit()! */
     +	return 0;
     +}
    ++
    ++static int ut_010bug_BUG(int argc, const char **argv)
    ++{
    ++	bug("a bug message");
    ++	BUG("a BUG message");
    ++}
     +
      /*
       * Usage:
    @@ t/helper/test-trace2.c: static struct unit_test ut_table[] = {
     +	{ ut_007BUG,      "007bug",    "" },
     +	{ ut_008bug,      "008bug",    "" },
     +	{ ut_009bug_BUG,  "009bug_BUG","" },
    ++	{ ut_010bug_BUG,  "010bug_BUG","" },
      };
      /* clang-format on */
      
    @@ t/t0210-trace2-normal.sh: test_expect_success 'BUG messages are written to trace
     +	EOF
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'bug messages followed by BUG() are written to trace2' '
    ++	test_when_finished "rm trace.normal actual expect" &&
    ++	test_expect_code 99 env GIT_TRACE2="$(pwd)/trace.normal" \
    ++		test-tool trace2 010bug_BUG 2>err &&
    ++	cat >expect <<-\EOF &&
    ++	a bug message
    ++	a BUG message
    ++	EOF
    ++	sed "s/^.*: //" <err >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
    ++	cat >expect <<-EOF &&
    ++		version $V
    ++		start _EXE_ trace2 010bug_BUG
    ++		cmd_name trace2 (trace2)
    ++		error a bug message
    ++		error a BUG message
    ++		exit elapsed:_TIME_ code:99
    ++		atexit elapsed:_TIME_ code:99
    ++	EOF
    ++	test_cmp expect actual
    ++'
     +
      sane_unset GIT_TRACE2_BRIEF
      
    @@ usage.c: void warning(const char *warn, ...)
      
      	if (in_bug)
      		abort();
    -@@ usage.c: NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
    +@@ usage.c: static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
    + NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
    + {
    + 	va_list ap;
    ++
    ++	bug_called_must_BUG = 0;
    ++
    + 	va_start(ap, fmt);
    + 	BUG_vfl(file, line, fmt, ap);
      	va_end(ap);
      }
      
3:  4a7089fbbf2 = 3:  3d8a8e95f4d parse-options.c: use new bug() API for optbug()
4:  47d384d0ae5 ! 4:  58eafa2e04a parse-options.c: use optbug() instead of BUG() "opts" check
    @@ Commit message
     
      ## parse-options.c ##
     @@ parse-options.c: static void parse_options_check(const struct option *opts)
    - 				optbug(opts, "should not accept an argument");
      			break;
      		case OPTION_CALLBACK:
    --			if (!opts->callback && !opts->ll_callback)
    + 			if (!opts->callback && !opts->ll_callback)
     -				BUG("OPTION_CALLBACK needs one callback");
     -			if (opts->callback && opts->ll_callback)
     -				BUG("OPTION_CALLBACK can't have two callbacks");
    -+			if (!opts->callback && !opts->ll_callback) {
     +				optbug(opts, "OPTION_CALLBACK needs one callback");
    -+				break;
    -+			}
    -+			if (opts->callback && opts->ll_callback) {
    ++			else if (opts->callback && opts->ll_callback)
     +				optbug(opts, "OPTION_CALLBACK can't have two callbacks");
    -+				break;
    -+			}
      			break;
      		case OPTION_LOWLEVEL_CALLBACK:
    --			if (!opts->ll_callback)
    + 			if (!opts->ll_callback)
     -				BUG("OPTION_LOWLEVEL_CALLBACK needs a callback");
    --			if (opts->callback)
    --				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
    -+			if (!opts->ll_callback) {
     +				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs a callback");
    -+				break;
    -+			}
    -+			if (opts->callback) {
    + 			if (opts->callback)
    +-				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
     +				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs no high level callback");
    -+				break;
    -+			}
      			break;
      		case OPTION_ALIAS:
     -			BUG("OPT_ALIAS() should not remain at this point. "
5:  fe5c3926675 = 5:  05fb94aee6e receive-pack: use bug() and BUG_if_bug()
6:  cbbe0276966 ! 6:  754a66be365 cache-tree.c: use bug() and BUG_if_bug()
    @@ Commit message
         set of messages via trace2, before this we'd only log the one BUG()
         invocation.
     
    +    We don't replace the last "BUG()" invocation with "BUG_if_bug()", as
    +    in this case we're sure that we called bug() earlier, so there's no
    +    need to make it a conditional.
    +
         While we're at it let's replace "There" with "there" in the message,
         i.e. not start a message with a capital letter, per the
         CodingGuidelines.
    @@ cache-tree.c: struct tree* write_in_core_index_as_tree(struct repository *repo)
     +				bug("%d %.*s", ce_stage(ce),
     +				    (int)ce_namelen(ce), ce->name);
      		}
    --		BUG("unmerged index entries when writing inmemory index");
    -+		bug("unmerged index entries when writing inmemory index");
    + 		BUG("unmerged index entries when writing inmemory index");
      	}
    - 
    - 	return lookup_tree(repo, &index_state->cache_tree->oid);
-- 
2.36.1.1103.gb3ecdfb3e6a

