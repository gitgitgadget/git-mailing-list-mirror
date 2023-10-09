Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00907E784AF
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 22:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378888AbjJIWVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 18:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378321AbjJIWVd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 18:21:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E099B9D
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 15:21:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8188b718so80167267b3.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696890090; x=1697494890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hR4JqEIEvfHbS0zbWUmK2DqWyk+wePuHYyMeiq7RlC8=;
        b=jrb1z8oQj0l2OOO8FmoxrHlr5PN0vUKsPDRWBfDWIOhFedgCPX8eoMuv40kxDCfiUc
         pkP1wPSelbj3soYtfA5FJ0oVqBr7Xh7apup+RC3kufJHgTJLBNM0enNWeEVTLtmWgPEP
         8+PvNcU5OGgP7y+Y6+pBfGxgA5Oxw7bqECRjK36kvDQzddG51b0cv2n3lqzd0Qr5Gcof
         +j8x0k2FrbhZkmoY0KKj14YreXcyIC8juFhfKXLcrA2KCQ7YooORTZ+d/BlKICxbb/8K
         DXsBs3nljMnnA57vKpioPGczFQEYeyJ7RMmEajICkdq+Hi7B3nTifGd41xbJMBKI8bRt
         jh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696890090; x=1697494890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hR4JqEIEvfHbS0zbWUmK2DqWyk+wePuHYyMeiq7RlC8=;
        b=pnLgq6oMS+4dgQgZI6XK3vF6Jboghpb5ER4dKHGKSuvbiq1ZDUnDWvNtkzv33ZePAP
         AVIuvEgC4qzh+YY3a/PJhkAsD2FR03jjW+SI34D78DvPRsxvHtasnMR7NEKshmGqmbqf
         hFJyBY3lOB57BpNU/HodmNZM0T8CKSMYgXS1u5GH+lMyD9GeOsID1/6HT8E7h7DZux45
         C/jI3z+1ObSl2ZCGst2/Gdvfom1TRIImljYIfTcQIW1hnJ6QSREVpqKAe4gzX81VNNhH
         BAnzeQMi0gHDveGDRW5BXi09Gp2OlWjp945CTJgDX655f2yO3uEKE36sskIw6mRa6SEG
         VWsA==
X-Gm-Message-State: AOJu0YxqGfmP8wqPLExZQ/dBIF3gtzBbrdPUzalB7URibLMLeDHw2L/S
        vo2HrGKCTZRecD7mlaucGV9j/HNOkvcW3x+NHh+16xV/4MvE4/aw1OC/hOFbA/eB5pzVluAiBzA
        zym04lcXmG8QE1DX9jppMinJQrMRjqcZAEDqC1jiknqEsrNpo2AGnvB1DavXcxTM=
X-Google-Smtp-Source: AGHT+IHrPfDXA0OsDbPqIaDoxeqPV2k4hU3N4Dhbj9UMpU1zLame/iAArCTegUcoY/IG2ufX2mMXTILyf3zSlQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:bbb3:af9c:b456:cb2a])
 (user=steadmon job=sendgmr) by 2002:a25:1503:0:b0:d9a:42d7:583 with SMTP id
 3-20020a251503000000b00d9a42d70583mr25947ybv.10.1696890090003; Mon, 09 Oct
 2023 15:21:30 -0700 (PDT)
Date:   Mon,  9 Oct 2023 15:21:19 -0700
In-Reply-To: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <cover.1696889529.git.steadmon@google.com>
Subject: [PATCH v8 0/3] Add unit test framework and project plan
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, linusa@google.com, calvinwan@google.com,
        gitster@pobox.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our current testing environment, we spend a significant amount of
effort crafting end-to-end tests for error conditions that could easily
be captured by unit tests (or we simply forgo some hard-to-setup and
rare error conditions). Unit tests additionally provide stability to the
codebase and can simplify debugging through isolation. Turning parts of
Git into libraries[1] gives us the ability to run unit tests on the
libraries and to write unit tests in C. Writing unit tests in pure C,
rather than with our current shell/test-tool helper setup, simplifies
test setup, simplifies passing data around (no shell-isms required), and
reduces testing runtime by not spawning a separate process for every
test invocation.

This series begins with a project document covering our goals for adding
unit tests and a discussion of alternative frameworks considered, as
well as the features used to evaluate them. A rendered preview of this
doc can be found at [2]. It also adds Phillip Wood's TAP implemenation
(with some slightly re-worked Makefile rules) and a sample strbuf unit
test. Finally, we modify the configs for GitHub and Cirrus CI to run the
unit tests. Sample runs showing successful CI runs can be found at [3],
[4], and [5].

[1] https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com/
[2] https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation/technical/unit-tests.adoc
[3] https://github.com/steadmon/git/actions/runs/5884659246/job/15959781385#step:4:1803
[4] https://github.com/steadmon/git/actions/runs/5884659246/job/15959938401#step:5:186
[5] https://cirrus-ci.com/task/6126304366428160 (unrelated tests failed,
    but note that t-strbuf ran successfully)

In addition to reviewing the patches in this series, reviewers can help
this series progress by chiming in on these remaining TODOs:
- Figure out if we should split t-basic.c into multiple meta-tests, to
  avoid merge conflicts and changes to expected text in
  t0080-unit-test-output.sh.
- Figure out if we should de-duplicate assertions in t-strbuf.c at the
  cost of making tests less self-contained and diagnostic output less
  helpful.
- Figure out if we should collect unit tests statistics similar to the
  "counts" files for shell tests
- Decide if it's OK to wait on sharding unit tests across "sliced" CI
  instances
- Provide guidelines for writing new unit tests

Changes in v8:
- Flipped return values for TEST, TEST_TODO, and check_* macros &
  functions. This makes it easier to reason about control flow for
  patterns like:
    if (check(some_condition)) { ... }
- Moved unit test binaries to t/unit-tests/bin to simplify .gitignore
  patterns.
- Removed testing of some strbuf implementation details in t-strbuf.c


Josh Steadmon (2):
  unit tests: Add a project plan document
  ci: run unit tests in CI

Phillip Wood (1):
  unit tests: add TAP unit test framework

 .cirrus.yml                            |   2 +-
 Documentation/Makefile                 |   1 +
 Documentation/technical/unit-tests.txt | 220 +++++++++++++++++
 Makefile                               |  28 ++-
 ci/run-build-and-tests.sh              |   2 +
 ci/run-test-slice.sh                   |   5 +
 t/Makefile                             |  15 +-
 t/t0080-unit-test-output.sh            |  58 +++++
 t/unit-tests/.gitignore                |   1 +
 t/unit-tests/t-basic.c                 |  95 +++++++
 t/unit-tests/t-strbuf.c                | 120 +++++++++
 t/unit-tests/test-lib.c                | 329 +++++++++++++++++++++++++
 t/unit-tests/test-lib.h                | 143 +++++++++++
 13 files changed, 1014 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/technical/unit-tests.txt
 create mode 100755 t/t0080-unit-test-output.sh
 create mode 100644 t/unit-tests/.gitignore
 create mode 100644 t/unit-tests/t-basic.c
 create mode 100644 t/unit-tests/t-strbuf.c
 create mode 100644 t/unit-tests/test-lib.c
 create mode 100644 t/unit-tests/test-lib.h

Range-diff against v7:
-:  ---------- > 1:  81c5148a12 unit tests: Add a project plan document
1:  3cc98d4045 ! 2:  00d3c95a81 unit tests: add TAP unit test framework
    @@ Commit message
     
                      check_uint(buf.len, ==, 0);
                      check_uint(buf.alloc, ==, 0);
    -                 if (check(buf.buf == strbuf_slopbuf))
    -                        return; /* avoid SIGSEV */
                      check_char(buf.buf[0], ==, '\0');
              }
     
    @@ Commit message
         checked by t0080-unit-test-output.sh. t-strbuf.c shows some example
         unit tests for strbuf.c
     
    -    The unit tests can be built with "make unit-tests" (this works but the
    -    Makefile changes need some further work). Once they have been built they
    -    can be run manually (e.g t/unit-tests/t-strbuf) or with prove.
    +    The unit tests will be built as part of the default "make all" target,
    +    to avoid bitrot. If you wish to build just the unit tests, you can run
    +    "make build-unit-tests". To run the tests, you can use "make unit-tests"
    +    or run the test binaries directly, as in "./t/unit-tests/bin/t-strbuf".
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    @@ Makefile: TEST_BUILTINS_OBJS =
      THIRD_PARTY_SOURCES =
     +UNIT_TEST_PROGRAMS =
     +UNIT_TEST_DIR = t/unit-tests
    ++UNIT_TEST_BIN = $(UNIT_TEST_DIR)/bin
      
      # Having this variable in your environment would break pipelines because
      # you cause "cd" to echo its destination to stdout.  It can also take
    @@ Makefile: THIRD_PARTY_SOURCES += compat/regex/%
      
     +UNIT_TEST_PROGRAMS += t-basic
     +UNIT_TEST_PROGRAMS += t-strbuf
    -+UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_DIR)/%$X,$(UNIT_TEST_PROGRAMS))
    ++UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
     +UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
     +UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
     +
    @@ Makefile: $(FUZZ_PROGRAMS): all
      
      fuzz-all: $(FUZZ_PROGRAMS)
     +
    -+$(UNIT_TEST_PROGS): $(UNIT_TEST_DIR)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS
    ++$(UNIT_TEST_BIN):
    ++	@mkdir -p $(UNIT_TEST_BIN)
    ++
    ++$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS $(UNIT_TEST_BIN)
     +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
     +		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
     +
    @@ t/Makefile: TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
      TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
      CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
      CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
    -+UNIT_TESTS = $(sort $(filter-out %.h %.c %.o unit-tests/t-basic%,$(wildcard unit-tests/*)))
    ++UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(wildcard unit-tests/bin/t-*)))
      
      # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
      # checks all tests in all scripts via a single invocation, so tell individual
    @@ t/t0080-unit-test-output.sh (new)
     +test_expect_success 'TAP output from unit tests' '
     +	cat >expect <<-EOF &&
     +	ok 1 - passing test
    -+	ok 2 - passing test and assertion return 0
    ++	ok 2 - passing test and assertion return 1
     +	# check "1 == 2" failed at t/unit-tests/t-basic.c:76
     +	#    left: 1
     +	#   right: 2
     +	not ok 3 - failing test
    -+	ok 4 - failing test and assertion return -1
    ++	ok 4 - failing test and assertion return 0
     +	not ok 5 - passing TEST_TODO() # TODO
    -+	ok 6 - passing TEST_TODO() returns 0
    ++	ok 6 - passing TEST_TODO() returns 1
     +	# todo check ${SQ}check(x)${SQ} succeeded at t/unit-tests/t-basic.c:25
     +	not ok 7 - failing TEST_TODO()
    -+	ok 8 - failing TEST_TODO() returns -1
    ++	ok 8 - failing TEST_TODO() returns 0
     +	# check "0" failed at t/unit-tests/t-basic.c:30
     +	# skipping test - missing prerequisite
     +	# skipping check ${SQ}1${SQ} at t/unit-tests/t-basic.c:32
     +	ok 9 - test_skip() # SKIP
    -+	ok 10 - skipped test returns 0
    ++	ok 10 - skipped test returns 1
     +	# skipping test - missing prerequisite
     +	ok 11 - test_skip() inside TEST_TODO() # SKIP
    -+	ok 12 - test_skip() inside TEST_TODO() returns 0
    ++	ok 12 - test_skip() inside TEST_TODO() returns 1
     +	# check "0" failed at t/unit-tests/t-basic.c:48
     +	not ok 13 - TEST_TODO() after failing check
    -+	ok 14 - TEST_TODO() after failing check returns -1
    ++	ok 14 - TEST_TODO() after failing check returns 0
     +	# check "0" failed at t/unit-tests/t-basic.c:56
     +	not ok 15 - failing check after TEST_TODO()
    -+	ok 16 - failing check after TEST_TODO() returns -1
    ++	ok 16 - failing check after TEST_TODO() returns 0
     +	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/unit-tests/t-basic.c:61
     +	#    left: "\011hello\\\\"
     +	#   right: "there\"\012"
    @@ t/t0080-unit-test-output.sh (new)
     +	not ok 17 - messages from failing string and char comparison
     +	# BUG: test has no checks at t/unit-tests/t-basic.c:91
     +	not ok 18 - test with no checks
    -+	ok 19 - test with no checks returns -1
    ++	ok 19 - test with no checks returns 0
     +	1..19
     +	EOF
     +
    -+	! "$GIT_BUILD_DIR"/t/unit-tests/t-basic >actual &&
    ++	! "$GIT_BUILD_DIR"/t/unit-tests/bin/t-basic >actual &&
     +	test_cmp expect actual
     +'
     +
    @@ t/t0080-unit-test-output.sh (new)
     
      ## t/unit-tests/.gitignore (new) ##
     @@
    -+/t-basic
    -+/t-strbuf
    ++/bin
     
      ## t/unit-tests/t-basic.c (new) ##
     @@
    @@ t/unit-tests/t-basic.c (new)
     +static int do_skip(void)
     +{
     +	test_skip("missing prerequisite");
    -+	return 0;
    ++	return 1;
     +}
     +
     +static void t_skip_todo(void)
    @@ t/unit-tests/t-basic.c (new)
     +int cmd_main(int argc, const char **argv)
     +{
     +	test_res = TEST(check_res = check_int(1, ==, 1), "passing test");
    -+	TEST(t_res(0), "passing test and assertion return 0");
    ++	TEST(t_res(1), "passing test and assertion return 1");
     +	test_res = TEST(check_res = check_int(1, ==, 2), "failing test");
    -+	TEST(t_res(-1), "failing test and assertion return -1");
    ++	TEST(t_res(0), "failing test and assertion return 0");
     +	test_res = TEST(t_todo(0), "passing TEST_TODO()");
    -+	TEST(t_res(0), "passing TEST_TODO() returns 0");
    ++	TEST(t_res(1), "passing TEST_TODO() returns 1");
     +	test_res = TEST(t_todo(1), "failing TEST_TODO()");
    -+	TEST(t_res(-1), "failing TEST_TODO() returns -1");
    ++	TEST(t_res(0), "failing TEST_TODO() returns 0");
     +	test_res = TEST(t_skip(), "test_skip()");
    -+	TEST(check_int(test_res, ==, 0), "skipped test returns 0");
    ++	TEST(check_int(test_res, ==, 1), "skipped test returns 1");
     +	test_res = TEST(t_skip_todo(), "test_skip() inside TEST_TODO()");
    -+	TEST(t_res(0), "test_skip() inside TEST_TODO() returns 0");
    ++	TEST(t_res(1), "test_skip() inside TEST_TODO() returns 1");
     +	test_res = TEST(t_todo_after_fail(), "TEST_TODO() after failing check");
    -+	TEST(check_int(test_res, ==, -1), "TEST_TODO() after failing check returns -1");
    ++	TEST(check_int(test_res, ==, 0), "TEST_TODO() after failing check returns 0");
     +	test_res = TEST(t_fail_after_todo(), "failing check after TEST_TODO()");
    -+	TEST(check_int(test_res, ==, -1), "failing check after TEST_TODO() returns -1");
    ++	TEST(check_int(test_res, ==, 0), "failing check after TEST_TODO() returns 0");
     +	TEST(t_messages(), "messages from failing string and char comparison");
     +	test_res = TEST(t_empty(), "test with no checks");
    -+	TEST(check_int(test_res, ==, -1), "test with no checks returns -1");
    ++	TEST(check_int(test_res, ==, 0), "test with no checks returns 0");
     +
     +	return test_done();
     +}
    @@ t/unit-tests/t-strbuf.c (new)
     +#include "test-lib.h"
     +#include "strbuf.h"
     +
    -+/* wrapper that supplies tests with an initialized strbuf */
    ++/* wrapper that supplies tests with an empty, initialized strbuf */
     +static void setup(void (*f)(struct strbuf*, void*), void *data)
     +{
     +	struct strbuf buf = STRBUF_INIT;
    @@ t/unit-tests/t-strbuf.c (new)
     +	strbuf_release(&buf);
     +	check_uint(buf.len, ==, 0);
     +	check_uint(buf.alloc, ==, 0);
    -+	check(buf.buf == strbuf_slopbuf);
    -+	check_char(buf.buf[0], ==, '\0');
    ++}
    ++
    ++/* wrapper that supplies tests with a populated, initialized strbuf */
    ++static void setup_populated(void (*f)(struct strbuf*, void*), char *init_str, void *data)
    ++{
    ++	struct strbuf buf = STRBUF_INIT;
    ++
    ++	strbuf_addstr(&buf, init_str);
    ++	check_uint(buf.len, ==, strlen(init_str));
    ++	f(&buf, data);
    ++	strbuf_release(&buf);
    ++	check_uint(buf.len, ==, 0);
    ++	check_uint(buf.alloc, ==, 0);
    ++}
    ++
    ++static int assert_sane_strbuf(struct strbuf *buf)
    ++{
    ++	/* Initialized strbufs should always have a non-NULL buffer */
    ++	if (buf->buf == NULL)
    ++		return 0;
    ++	/* Buffers should always be NUL-terminated */
    ++	if (buf->buf[buf->len] != '\0')
    ++		return 0;
    ++	/*
    ++	 * Freshly-initialized strbufs may not have a dynamically allocated
    ++	 * buffer
    ++	 */
    ++	if (buf->len == 0 && buf->alloc == 0)
    ++		return 1;
    ++	/* alloc must be at least one byte larger than len */
    ++	return buf->len + 1 <= buf->alloc;
     +}
     +
     +static void t_static_init(void)
    @@ t/unit-tests/t-strbuf.c (new)
     +
     +	check_uint(buf.len, ==, 0);
     +	check_uint(buf.alloc, ==, 0);
    -+	if (check(buf.buf == strbuf_slopbuf))
    -+		return; /* avoid de-referencing buf.buf */
     +	check_char(buf.buf[0], ==, '\0');
     +}
     +
    @@ t/unit-tests/t-strbuf.c (new)
     +	struct strbuf buf;
     +
     +	strbuf_init(&buf, 1024);
    ++	check(assert_sane_strbuf(&buf));
     +	check_uint(buf.len, ==, 0);
     +	check_uint(buf.alloc, >=, 1024);
     +	check_char(buf.buf[0], ==, '\0');
    @@ t/unit-tests/t-strbuf.c (new)
     +{
     +	const char *p_ch = data;
     +	const char ch = *p_ch;
    ++	size_t orig_alloc = buf->alloc;
    ++	size_t orig_len = buf->len;
     +
    ++	if (!check(assert_sane_strbuf(buf)))
    ++		return;
     +	strbuf_addch(buf, ch);
    -+	if (check_uint(buf->len, ==, 1) ||
    -+	    check_uint(buf->alloc, >, 1))
    ++	if (!check(assert_sane_strbuf(buf)))
    ++		return;
    ++	if (!(check_uint(buf->len, ==, orig_len + 1) &&
    ++	      check_uint(buf->alloc, >=, orig_alloc)))
     +		return; /* avoid de-referencing buf->buf */
    -+	check_char(buf->buf[0], ==, ch);
    -+	check_char(buf->buf[1], ==, '\0');
    ++	check_char(buf->buf[buf->len - 1], ==, ch);
    ++	check_char(buf->buf[buf->len], ==, '\0');
     +}
     +
     +static void t_addstr(struct strbuf *buf, void *data)
     +{
     +	const char *text = data;
     +	size_t len = strlen(text);
    ++	size_t orig_alloc = buf->alloc;
    ++	size_t orig_len = buf->len;
     +
    ++	if (!check(assert_sane_strbuf(buf)))
    ++		return;
     +	strbuf_addstr(buf, text);
    -+	if (check_uint(buf->len, ==, len) ||
    -+	    check_uint(buf->alloc, >, len) ||
    -+	    check_char(buf->buf[len], ==, '\0'))
    ++	if (!check(assert_sane_strbuf(buf)))
    ++		return;
    ++	if (!(check_uint(buf->len, ==, orig_len + len) &&
    ++	      check_uint(buf->alloc, >=, orig_alloc) &&
    ++	      check_uint(buf->alloc, >, orig_len + len) &&
    ++	      check_char(buf->buf[orig_len + len], ==, '\0')))
     +	    return;
    -+	check_str(buf->buf, text);
    ++	check_str(buf->buf + orig_len, text);
     +}
     +
     +int cmd_main(int argc, const char **argv)
     +{
    -+	if (TEST(t_static_init(), "static initialization works"))
    ++	if (!TEST(t_static_init(), "static initialization works"))
     +		test_skip_all("STRBUF_INIT is broken");
     +	TEST(t_dynamic_init(), "dynamic initialization works");
     +	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
     +	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
    ++	TEST(setup_populated(t_addch, "initial value", "a"),
    ++	     "strbuf_addch appends to initial value");
     +	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
    ++	TEST(setup_populated(t_addstr, "initial value", "hello there"),
    ++	     "strbuf_addstr appends string to initial value");
     +
     +	return test_done();
     +}
    @@ t/unit-tests/test-lib.c (new)
     +	va_end(ap);
     +	ctx.running = 0;
     +	if (ctx.skip_all)
    -+		return 0;
    ++		return 1;
     +	putc('\n', stdout);
     +	fflush(stdout);
     +	ctx.failed |= ctx.result == RESULT_FAILURE;
     +
    -+	return -(ctx.result == RESULT_FAILURE);
    ++	return ctx.result != RESULT_FAILURE;
     +}
     +
     +static void test_fail(void)
    @@ t/unit-tests/test-lib.c (new)
     +
     +	if (ctx.result == RESULT_SKIP) {
     +		test_msg("skipping check '%s' at %s", check, location);
    -+		return 0;
    ++		return 1;
     +	} else if (!ctx.todo) {
     +		if (ok) {
     +			test_pass();
    @@ t/unit-tests/test-lib.c (new)
     +		}
     +	}
     +
    -+	return -!ok;
    ++	return !!ok;
     +}
     +
     +void test__todo_begin(void)
    @@ t/unit-tests/test-lib.c (new)
     +
     +	ctx.todo = 0;
     +	if (ctx.result == RESULT_SKIP)
    -+		return 0;
    -+	if (!res) {
    ++		return 1;
    ++	if (res) {
     +		test_msg("todo check '%s' succeeded at %s", check, location);
     +		test_fail();
     +	} else {
     +		test_todo();
     +	}
     +
    -+	return -!res;
    ++	return !res;
     +}
     +
     +int check_bool_loc(const char *loc, const char *check, int ok)
    @@ t/unit-tests/test-lib.c (new)
     +{
     +	int ret = test_assert(loc, check, ok);
     +
    -+	if (ret) {
    ++	if (!ret) {
     +		test_msg("   left: %"PRIdMAX, a);
     +		test_msg("  right: %"PRIdMAX, b);
     +	}
    @@ t/unit-tests/test-lib.c (new)
     +{
     +	int ret = test_assert(loc, check, ok);
     +
    -+	if (ret) {
    ++	if (!ret) {
     +		test_msg("   left: %"PRIuMAX, a);
     +		test_msg("  right: %"PRIuMAX, b);
     +	}
    @@ t/unit-tests/test-lib.c (new)
     +{
     +	int ret = test_assert(loc, check, ok);
     +
    -+	if (ret) {
    ++	if (!ret) {
     +		fflush(stderr);
     +		print_char("   left", a);
     +		print_char("  right", b);
    @@ t/unit-tests/test-lib.c (new)
     +	int ok = (!a && !b) || (a && b && !strcmp(a, b));
     +	int ret = test_assert(loc, check, ok);
     +
    -+	if (ret) {
    ++	if (!ret) {
     +		fflush(stderr);
     +		print_str("   left", a);
     +		print_str("  right", b);
    @@ t/unit-tests/test-lib.h (new)
     +#include "git-compat-util.h"
     +
     +/*
    -+ * Run a test function, returns 0 if the test succeeds, -1 if it
    ++ * Run a test function, returns 1 if the test succeeds, 0 if it
     + * fails. If test_skip_all() has been called then the test will not be
     + * run. The description for each test should be unique. For example:
     + *
    @@ t/unit-tests/test-lib.h (new)
     +void test_msg(const char *format, ...);
     +
     +/*
    -+ * Test checks are built around test_assert(). checks return 0 on
    -+ * success, -1 on failure. If any check fails then the test will
    ++ * Test checks are built around test_assert(). checks return 1 on
    ++ * success, 0 on failure. If any check fails then the test will
     + * fail. To create a custom check define a function that wraps
     + * test_assert() and a macro to wrap that function. For example:
     + *
    @@ t/unit-tests/test-lib.h (new)
     +
     +/*
     + * Wrap a check that is known to fail. If the check succeeds then the
    -+ * test will fail. Returns 0 if the check fails, -1 if it
    ++ * test will fail. Returns 1 if the check fails, 0 if it
     + * succeeds. For example:
     + *
     + *  TEST_TODO(check(0));
2:  abf4dc41ac ! 3:  aa1dfa4892 ci: run unit tests in CI
    @@ ci/run-test-slice.sh: group "Run tests" make --quiet -C t T="$(cd t &&
     +fi
     +
      check_unignored_build_artifacts
    -
    - ## t/Makefile ##
    -@@ t/Makefile: TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
    - TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
    - CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
    - CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
    --UNIT_TESTS = $(sort $(filter-out %.h %.c %.o unit-tests/t-basic%,$(wildcard unit-tests/*)))
    -+UNIT_TESTS = $(sort $(filter-out %.h %.c %.o unit-tests/t-basic%,$(wildcard unit-tests/t-*)))
    - 
    - # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
    - # checks all tests in all scripts via a single invocation, so tell individual

base-commit: a9e066fa63149291a55f383cfa113d8bdbdaa6b3
-- 
2.42.0.609.gbb76f46606-goog

