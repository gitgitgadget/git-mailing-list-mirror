Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B26C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhK2WXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhK2WVy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:21:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725DAC21885E
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:13:28 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d9so18529172wrw.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jwBtOMrpFLLJEXEaf6wA3J1VBielWmgta3mDIEewTI=;
        b=d4qCzu3QBThCcrZrToZEYULJ33p0ECDGwKGDOp6+VvaFTUwluXpVFnOwERNm6xW99b
         /l5SKgrrS9T9kBc+BDo22UfkMp3MvQoIldwMESpCeFuC7eDogdNynAzrmQP5Qejh6L54
         BBirlv3juzUOB5VGsRijeJLqCDy1hoSNgMW4U4PJikxhXObDLzfpE0BP9ru0r3La3Fqh
         ZFjU+jXLatT6iQNYBX6WaGKSdORApiDd7hP19RMZyOyTtDkW/hDVNbMOVJzzmLEj8Kf1
         lwerlpAY7wahOd8b3V4CrEgxjtR3WsM33fYzCAARWb0dr7cRTgV5Lq9rqOyaNPPiDENf
         A3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jwBtOMrpFLLJEXEaf6wA3J1VBielWmgta3mDIEewTI=;
        b=LWBesqDONlvuk7yUwcYA5OdeYgbhRxqUoXek0pCY1Q7v0wY/WK8f2HVvdTc+deeWde
         OrAiuyMR3j7XWrbOjsH3TSkNg117nRm2xqXjOeiPqvNxlGtO3zCLgBDGJcKxH3vEvlFx
         qBlNXnPHUTk47VonB8euFDWVM7AGwfWEsKTWwhkQh/+Zpc1IIq5FAJq+6oym+4EAtHCZ
         aYPHs18Lt6e5tD4jhw4gAb6mw8L1tJSNy3jmiGVbsi1v6KVIOzSxyyTckQuytQWurHf4
         kk2gdMS5NQDMVcVS59IjMK6yrnRoWVzQonS8R3Q7tL7SNcIl2GzuRHwHphDNLVfwziRt
         roLA==
X-Gm-Message-State: AOAM531uMndyVC5TywLoJJVlCk87SVFyk5a+ogK+btWUkXHDg16es2Zs
        H43APr9pfnSohrgKlq3kiWQWMHBw4lBy2g==
X-Google-Smtp-Source: ABdhPJyutGgynelqN6wQby1cay9P6m5OAfF7OwZd1Q80+9HoOWHsD5UZYjmKpKlVizGx/0NgYgnsWQ==
X-Received: by 2002:a5d:4846:: with SMTP id n6mr36427641wrs.249.1638216806698;
        Mon, 29 Nov 2021 12:13:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e12sm19333767wrq.20.2021.11.29.12.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:13:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-lib.sh: have all tests pass under "-x", remove BASH_XTRACEFD
Date:   Mon, 29 Nov 2021 21:13:23 +0100
Message-Id: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.ge54f711571c
In-Reply-To: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "t1510-repo-setup.sh" test to use a new
"test_must_be_empty_trace" wrapper, instead of turning on
"test_untraceable=UnfortunatelyYes".

The only reason the test was incompatible with "-x" was because of
these "test_must_be_empty" checks, which we can instead instead skip
if we're running under "set -x".

Skipping the tests is preferable to not having the "-x" output at all,
as it's much easier to debug the test. The result loss of test
coverage is minimal. If someone is adjusting a "test_must_be_empty"
test a failure might go away under "-x", but the new "say" we emit
here should highlight that appropriately.

Since the only user of "test_untraceable" is gone, we can remove that,
not only isn't it used now, but I think the rationale for using it in
the future no longer applies.

We'll be better off by using a simple wrapper like the new
"test_must_be_empty_trace". See 58275069288 (t1510-repo-setup: mark as
untraceable with '-x', 2018-02-24) and 5fc98e79fc0 (t: add means to
disable '-x' tracing for individual test scripts, 2018-02-24) for the
addition of "test_untraceable".

Once that's been removed we can dig deeper and see that we only have
"BASH_XTRACEFD" due to an earlier attempt to work around the same
issue. See d88785e424a (test-lib: set BASH_XTRACEFD automatically,
2016-05-11) and the 90c8a1db9d6 (test-lib: silence "-x" cleanup under
bash, 2017-12-08) follow-up.

I.e. we had redirection in "test_eval_" to get more relevant trace
output under bash, which in turn was only needed because
BASH_XTRACEFD=1 was set, which in turn was trying to work around test
failures under "set -x".

It's better if our test suite works the same way on all shells, rather
than getting a passing run under "bash", only to have it fail with
"-x" under say "dash". As the deleted code shows this is much simpler
to implement across our supported POSIX shells.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I hacked this up the other day when looking at the --verbose-log
v.s. -v failure[1] that's now being addressed in[2].

I'd originally run into that because I was trying to debug
t1510-repo-setup.sh and found that -x inexplicably didn't work, only
to discover it was he only consumer of "test_untracable".

1. https://lore.kernel.org/git/211125.86pmqoifp8.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/pull.1085.git.1638193666.gitgitgadget@gmail.com/

 t/README              |  3 --
 t/t1510-repo-setup.sh | 34 +++++++++++++---------
 t/test-lib.sh         | 66 +++++--------------------------------------
 3 files changed, 27 insertions(+), 76 deletions(-)

diff --git a/t/README b/t/README
index 29f72354bf1..3d30bbff34a 100644
--- a/t/README
+++ b/t/README
@@ -86,9 +86,6 @@ appropriately before running "make". Short options can be bundled, i.e.
 -x::
 	Turn on shell tracing (i.e., `set -x`) during the tests
 	themselves. Implies `--verbose`.
-	Ignored in test scripts that set the variable 'test_untraceable'
-	to a non-empty value, unless it's run with a Bash version
-	supporting BASH_XTRACEFD, i.e. v4.1 or later.
 
 -d::
 --debug::
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 591505a39c0..7eb65a52c08 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -40,8 +40,14 @@ A few rules for repo setup:
     prefix is NULL.
 "
 
-# This test heavily relies on the standard error of nested function calls.
-test_untraceable=UnfortunatelyYes
+test_must_be_empty_trace () {
+	if want_trace
+	then
+		say "$TEST_NAME does not check test_must_be_empty on \"$@\" under -x"
+		return 0
+	fi
+	test_must_be_empty "$@"
+}
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
@@ -235,14 +241,14 @@ test_expect_success '#0: nonbare repo, no explicit configuration' '
 	try_repo 0 unset unset unset "" unset \
 		.git "$here/0" "$here/0" "(null)" \
 		.git "$here/0" "$here/0" sub/ 2>message &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 '
 
 test_expect_success '#1: GIT_WORK_TREE without explicit GIT_DIR is accepted' '
 	try_repo 1 "$here" unset unset "" unset \
 		"$here/1/.git" "$here" "$here" 1/ \
 		"$here/1/.git" "$here" "$here" 1/sub/ 2>message &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 '
 
 test_expect_success '#2: worktree defaults to cwd with explicit GIT_DIR' '
@@ -269,7 +275,7 @@ test_expect_success '#4: core.worktree without GIT_DIR set is accepted' '
 	try_case 4 unset unset \
 		.git "$here/4/sub" "$here/4" "(null)" \
 		"$here/4/.git" "$here/4/sub" "$here/4/sub" "(null)" 2>message &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 '
 
 test_expect_success '#5: core.worktree + GIT_WORK_TREE is accepted' '
@@ -280,7 +286,7 @@ test_expect_success '#5: core.worktree + GIT_WORK_TREE is accepted' '
 	try_repo 5a .. unset "$here/5a" "" unset \
 		"$here/5a/.git" "$here" "$here" 5a/ \
 		"$here/5a/.git" "$here/5a" "$here/5a" sub/ &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 '
 
 test_expect_success '#6: setting GIT_DIR brings core.worktree to life' '
@@ -377,7 +383,7 @@ test_expect_success '#9: GIT_WORK_TREE accepted with gitfile' '
 	try_repo 9 wt unset unset gitfile unset \
 		"$here/9.git" "$here/9/wt" "$here/9" "(null)" \
 		"$here/9.git" "$here/9/sub/wt" "$here/9/sub" "(null)" 2>message &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 '
 
 test_expect_success '#10: GIT_DIR can point to gitfile' '
@@ -403,7 +409,7 @@ test_expect_success '#12: core.worktree with gitfile is accepted' '
 	try_repo 12 unset unset "$here/12" gitfile unset \
 		"$here/12.git" "$here/12" "$here/12" "(null)" \
 		"$here/12.git" "$here/12" "$here/12" sub/ 2>message &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 '
 
 test_expect_success '#13: core.worktree+GIT_WORK_TREE accepted (with gitfile)' '
@@ -411,7 +417,7 @@ test_expect_success '#13: core.worktree+GIT_WORK_TREE accepted (with gitfile)' '
 	try_repo 13 non-existent-too unset non-existent gitfile unset \
 		"$here/13.git" "$here/13/non-existent-too" "$here/13" "(null)" \
 		"$here/13.git" "$here/13/sub/non-existent-too" "$here/13/sub" "(null)" 2>message &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 '
 
 # case #14.
@@ -566,7 +572,7 @@ test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is accepted (ba
 	try_repo 17c "$here/17c" unset unset "" true \
 		.git "$here/17c" "$here/17c" "(null)" \
 		"$here/17c/.git" "$here/17c" "$here/17c" sub/ 2>message &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 '
 
 test_expect_success '#18: bare .git named by GIT_DIR has no worktree' '
@@ -595,7 +601,7 @@ test_expect_success '#20a: core.worktree without GIT_DIR accepted (inside .git)'
 		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/ &&
 	try_case 20a/.git/wt/sub unset unset \
 		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/sub/ &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 '
 
 test_expect_success '#20b/c: core.worktree and core.bare conflict' '
@@ -627,7 +633,7 @@ test_expect_success '#21: setup, core.worktree warns before overriding core.bare
 		export GIT_WORK_TREE &&
 		git status >/dev/null
 	) 2>message &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 
 '
 run_wt_tests 21
@@ -743,7 +749,7 @@ test_expect_success '#25: GIT_WORK_TREE accepted if GIT_DIR unset (bare gitfile
 	try_repo 25 "$here/25" unset unset gitfile true \
 		"$here/25.git" "$here/25" "$here/25" "(null)"  \
 		"$here/25.git" "$here/25" "$here/25" "sub/" 2>message &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 '
 
 test_expect_success '#26: bare repo has no worktree (GIT_DIR -> gitfile case)' '
@@ -781,7 +787,7 @@ test_expect_success '#29: setup' '
 		export GIT_WORK_TREE &&
 		git status
 	) 2>message &&
-	test_must_be_empty message
+	test_must_be_empty_trace message
 '
 run_wt_tests 29 gitfile
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2679a7596a6..38a0fc558c9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -381,29 +381,6 @@ then
 	exit
 fi
 
-if test -n "$trace" && test -n "$test_untraceable"
-then
-	# '-x' tracing requested, but this test script can't be reliably
-	# traced, unless it is run with a Bash version supporting
-	# BASH_XTRACEFD (introduced in Bash v4.1).
-	#
-	# Perform this version check _after_ the test script was
-	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
-	# '--verbose-log', so the right shell is checked and the
-	# warning is issued only once.
-	if test -n "$BASH_VERSION" && eval '
-	     test ${BASH_VERSINFO[0]} -gt 4 || {
-	       test ${BASH_VERSINFO[0]} -eq 4 &&
-	       test ${BASH_VERSINFO[1]} -ge 1
-	     }
-	   '
-	then
-		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
-	else
-		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
-		trace=
-	fi
-fi
 if test -n "$trace" && test -z "$verbose_log"
 then
 	verbose=t
@@ -650,19 +627,6 @@ else
 	exec 4>/dev/null 3>/dev/null
 fi
 
-# Send any "-x" output directly to stderr to avoid polluting tests
-# which capture stderr. We can do this unconditionally since it
-# has no effect if tracing isn't turned on.
-#
-# Note that this sets up the trace fd as soon as we assign the variable, so it
-# must come after the creation of descriptor 4 above. Likewise, we must never
-# unset this, as it has the side effect of closing descriptor 4, which we
-# use to show verbose tests to the user.
-#
-# Note also that we don't need or want to export it. The tracing is local to
-# this shell, and we would not want to influence any shells we exec.
-BASH_XTRACEFD=4
-
 test_failure=0
 test_count=0
 test_fixed=0
@@ -949,36 +913,20 @@ test_eval_ () {
 	# the shell from printing the "set +x" to turn it off (nor the saving
 	# of $? before that). But we can make sure that the output goes to
 	# /dev/null.
-	#
-	# There are a few subtleties here:
-	#
-	#   - we have to redirect descriptor 4 in addition to 2, to cover
-	#     BASH_XTRACEFD
-	#
-	#   - the actual eval has to come before the redirection block (since
-	#     it needs to see descriptor 4 to set up its stderr)
-	#
-	#   - likewise, any error message we print must be outside the block to
-	#     access descriptor 4
-	#
-	#   - checking $? has to come immediately after the eval, but it must
-	#     be _inside_ the block to avoid polluting the "set -x" output
-	#
-
-	test_eval_inner_ "$@" </dev/null >&3 2>&4
 	{
+		test_eval_inner_ "$@" </dev/null >&3 2>&4
 		test_eval_ret_=$?
 		if want_trace
 		then
 			test 1 = $trace_level_ && set +x
 			trace_level_=$(($trace_level_-1))
-		fi
-	} 2>/dev/null 4>&2
 
-	if test "$test_eval_ret_" != 0 && want_trace
-	then
-		say_color error >&4 "error: last command exited with \$?=$test_eval_ret_"
-	fi
+			if test "$test_eval_ret_" != 0
+			then
+				say_color error >&4 "error: last command exited with \$?=$test_eval_ret_"
+			fi
+		fi
+	} 2>/dev/null
 	return $test_eval_ret_
 }
 
-- 
2.34.1.841.ge54f711571c

