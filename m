Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD9BC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1732060F58
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhKBQuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKBQuv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 12:50:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225D7C0613F5
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 09:48:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y196so6920873wmc.3
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9U3pzATxaPFHAdu5PhrrCFfhD1qmuTlVk5G2GoP+/o=;
        b=hnC+Cjkt5XyjlKUKUN9BuV9MyfAqfiNIUkKlXrU5cq7Q+9L+9/Jp9qALQVf0IvsCkR
         GAOtjzP6li22eN5tyZYQw5eqb8d7GF4ZkauxeOQFQpWpuz0z85uSC0l3xTjGnDbz5lzh
         etN6ThEYKMBF4XyRo9W0FfBHilbHyGbYOtFbg2pA6W2eSjs+X/OP1CH4UxHWS2YHuQRS
         PwtkjSHbLyCMdnz3bkKZmS/1tSrCqSWzHEaA3YGjAiZ68NSBP0H4RN6A8SLXHoU8TuBb
         Pk0RAp6uBFrB08qPBlTbM1gbSIPLsMhvu5PIgS/2l3kOAuwkkm6nweelJrFJtjR2gVOf
         9Hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9U3pzATxaPFHAdu5PhrrCFfhD1qmuTlVk5G2GoP+/o=;
        b=sjN69pO1F+jp/3puiQqR/PoC5ZuKTXF+z/RbP5nPJ+OhetZ08uM9QJf22nqBIKsfre
         3fd/C1j1AHxLY0OgZxmF4NMgX0pIBMi9S+Tu8fhPy47e2od+QvhefkNFRtlDY1Le/gLr
         P1ScTMHuqywNgIIYU1nwYvUyTSbOWEIZz82oBSrBHmjzFxAgYs28NduuzV/WZsfeoLJF
         NizICxxnOK6jf9ztoMpCxwz5lwfLK/U/0VEMhDKba1yyv3bnqLodEYuhkGPl/7pfABJd
         v/zixos6sJzBX7m1QrPRAtn2yAOy/tc9koVvR0TTp5GYtk4hSHaLUlUxIs/6VpjkPb8k
         ppgQ==
X-Gm-Message-State: AOAM530EY8sahFrNYyy6Z2vbBXUwhKoqi+HyS59/LsbwBtLvdp1I+VgG
        zag7hzxGTpKh3QGuAOp9aaXQ/g4dUxPuFQ==
X-Google-Smtp-Source: ABdhPJyjxCWTHHI4XG8SlGK7lpXyIRZ7RPdqn4XR6tetXoiev528XopK41d5t56uWW5nbvYM28LCrA==
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr8767548wmn.98.1635871694440;
        Tue, 02 Nov 2021 09:48:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17203188wrs.19.2021.11.02.09.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:48:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alejandro Sanchez <asanchez1987@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] prompt.c: add and use a GIT_TEST_TERMINAL_PROMPT=true
Date:   Tue,  2 Nov 2021 17:48:10 +0100
Message-Id: <patch-2.2-964e7f4531f-20211102T155046Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
References: <20190524062724.GC25694@sigill.intra.peff.net> <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 97387c8bdd9 (am: read interactive input from stdin, 2019-05-20) we
we fixed a behavior change in the conversion of git-am from a
shellscript to a C program by changing it from using git_prompt() to
using fgets(..., stdin). This ensured that we could run:

    echo y | git am --interactive [...]

But along with that in the subsequent 6e7baf246a2 (am: drop tty
requirement for --interactive, 2019-05-20) we had to remove support
for:

    git am --interactive </dev/null

This change builds on the refactoring of git_prompt() into "normal
prompt" and "wants password" functions in the preceding commit, and
moves "git am --interactive" back to using the prompt function.

This allows us to have our cake and eat it too by adding a
GIT_TERMINAL_PROMPT=true mode to test-lib.sh. Adjusting "git am
--interactive" for use in our tests (see
e.g. "t/t4257-am-interactive.sh") was what 97387c8bdd9 and 6e7baf246a2
were aiming for.

Then more recently in 09535f056b0 (bisect--helper: reimplement
`bisect_autostart` shell function in C, 2020-09-24) we've had the same
sort of behavior change happen to "git bisect"'s interactive question
mode, it now uses git_prompt()'s /dev/tty, not stdin.

It seems to me that using /dev/tty is desirable over using stdin,
these prompts are meant to be interactive, and our acceptance of stdin
was an artifact of how these commands were originally implemented in
shellscript.

So let's move "git am --interactive" back to using
"git_prompt()" (which is called "git_prompt_echo()" as of the
preceding commit), and similarly remove the "!isatty(STDIN_FILENO)"
test added in 09535f056b0, that control flow was converted as-is from
the shellscript behavior.

Let's also change a similar assertion added to "git am" in
6e7baf246a2. Now we'll die on:

    # no arguments provided
    git am --interactive

But not:

    git am --interactive </dev/null

Or:

    git am --interactive <mbox

To do this we'll need to add a GIT_TEST_TERMINAL_PROMPT variable for
use in test-lib.sh, by doing so this "echo input | git cmd ..."
behavior of interactive commands is now isolated to our own test
suite, instead of leaking out into the wild.

Now that we've done that we can exhaustively test the prompt behavior
of "git bisect", which wasn't previously possible.

There is some discussion downthread of the series 97387c8bdd9 is in
about whether we should always accept stdin input in these
commands[1]. I think that's arguably a good idea, and perhaps we'll
need to change the approach here.

Using a git_prompt_echo() that we know never needs to handle passwords
should provide us with an easy path towards deciding what to do in
those cases, we'll be able to consistently pick one behavior or the
other, instead of having the behavior of specific commands cater to
test-only needs.

The lack of _() on the new die() message is intentional. This message
will only be emitted if there's a bug in our own test suite, so it's a
waste of translator time to translate it.

1. https://lore.kernel.org/git/20190520125016.GA13474@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c                |  8 +++-----
 builtin/bisect--helper.c    |  3 ---
 prompt.c                    |  8 +++++++-
 t/t6030-bisect-porcelain.sh | 41 +++++++++++++++++++++++++++++++++++++
 t/test-lib.sh               |  4 ++++
 5 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..1e90b9ea0cd 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1693,7 +1693,7 @@ static int do_interactive(struct am_state *state)
 	assert(state->msg);
 
 	for (;;) {
-		char reply[64];
+		const char *reply;
 
 		puts(_("Commit Body is:"));
 		puts("--------------------------");
@@ -1705,9 +1705,7 @@ static int do_interactive(struct am_state *state)
 		 * in your translation. The program will only accept English
 		 * input at this point.
 		 */
-		printf(_("Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: "));
-		if (!fgets(reply, sizeof(reply), stdin))
-			die("unable to read from stdin; aborting");
+		reply = git_prompt_echo(_("Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: "));
 
 		if (*reply == 'y' || *reply == 'Y') {
 			return 0;
@@ -2437,7 +2435,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 				strvec_push(&paths, mkpath("%s/%s", prefix, argv[i]));
 		}
 
-		if (state.interactive && !paths.nr)
+		if (state.interactive && !paths.nr && isatty(0))
 			die(_("interactive mode requires patches on the command line"));
 
 		am_setup(&state, patch_format, paths.v, keep_cr);
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 30533a70b53..dd73d76df3e 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -830,9 +830,6 @@ static int bisect_autostart(struct bisect_terms *terms)
 	fprintf_ln(stderr, _("You need to start by \"git bisect "
 			  "start\"\n"));
 
-	if (!isatty(STDIN_FILENO))
-		return -1;
-
 	/*
 	 * TRANSLATORS: Make sure to include [Y] and [n] in your
 	 * translation. The program will only accept English input
diff --git a/prompt.c b/prompt.c
index 458d6637506..273bc30bf0e 100644
--- a/prompt.c
+++ b/prompt.c
@@ -6,9 +6,15 @@
 
 char *git_prompt(const char *prompt, unsigned int echo)
 {
+	const char *test_var = "GIT_TEST_TERMINAL_PROMPT";
 	char *r = NULL;
 
-	if (git_env_bool("GIT_TERMINAL_PROMPT", 1)) {
+	if (git_env_bool(test_var, 0) && !isatty(0)) {
+		char reply[64];
+		if (!fgets(reply, sizeof(reply), stdin))
+			die("unable to read from stdin in '%s=true' mode", test_var);
+		return xstrdup(reply);
+	} else if (git_env_bool("GIT_TERMINAL_PROMPT", 1)) {
 		r = git_terminal_prompt(prompt, echo);
 		if (!r)
 			die_errno("could not read");
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 1be85d064e7..2afb1b57b45 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -45,6 +45,47 @@ test_expect_success 'set up basic repo with 1 file (hello) and 4 commits' '
      HASH4=$(git rev-parse --verify HEAD)
 '
 
+test_expect_success 'bisect "good" without a "start": no prompt' '
+	cat >expect <<-\EOF &&
+	You need to start by "git bisect start"
+
+	fatal: unable to read from stdin in '\''GIT_TEST_TERMINAL_PROMPT=true'\'' mode
+	EOF
+	test_expect_code 128 git bisect good HEAD 2>actual &&
+	test_cmp expect actual &&
+	test_must_fail git bisect bad HEAD~ 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bisect "good" without a "start": have prompt' '
+	cat >expect <<-\EOF &&
+	You need to start by "git bisect start"
+
+	EOF
+	echo n | test_expect_code 1 git bisect good HEAD 2>actual &&
+	test_cmp expect actual &&
+	echo n | test_must_fail git bisect bad HEAD~ 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bisect "good" without a "start": answer prompt' '
+	cat >expect <<-\EOF &&
+	You need to start by "git bisect start"
+
+	EOF
+	echo Y | git bisect good HEAD 2>actual &&
+	test_cmp expect actual &&
+
+	# We will only get this far with the "Y" prompt
+	cat >expect <<-\EOF &&
+	Some good revs are not ancestors of the bad rev.
+	git bisect cannot work properly in this case.
+	Maybe you mistook good and bad revs?
+	EOF
+	test_must_fail git bisect bad HEAD~ 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bisect starts with only one bad' '
 	git bisect reset &&
 	git bisect start &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2679a7596a6..778a08ffe4b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -476,6 +476,10 @@ export GIT_TEST_MERGE_ALGORITHM
 GIT_TRACE_BARE=1
 export GIT_TRACE_BARE
 
+# Have git_prompt_noecho() accept stdin
+GIT_TEST_TERMINAL_PROMPT=true
+export GIT_TEST_TERMINAL_PROMPT
+
 # Use specific version of the index file format
 if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
 then
-- 
2.33.1.1570.g069344fdd45

