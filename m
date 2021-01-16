Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA533C43381
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C2A23750
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbhAPRL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbhAPRKy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B6C061357
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l12so7002392wry.2
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NuKxZuHw81S+Gh3GNFDhLjTWj9poRt5Y51aSmfVI/Kg=;
        b=f6wAH45i6gtiiQjhcjGjHmWMBh6/8e6mlJnpKA2s/ygH8/l4pshriBgAkTxyxxP4Bc
         bSz7MX4jg3Z+/xEfIP7kRk2epLD6KPoSpAAaP4WvrIuhvpwwn+uwyLk7mLGWTzCxpoOW
         cbkfhxNcgqK33NpP7ChKoWYEoHNkF9Ad31pP3X/k4cX7xXodBYfFK4kp3vJb7/XTJXs/
         6QyKFNjwufO3xFktEx0tQE8NOEo0oymcfoNrULmmuH4qhgNTs+x1HOgUo8DxtGVrUgQG
         u/RIDcftQt0JfU6qg+f0ekOQnhFOwOQa2zMHIW/FOS30Uu4rlr1L7PZANT04iF5jzGvG
         SKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NuKxZuHw81S+Gh3GNFDhLjTWj9poRt5Y51aSmfVI/Kg=;
        b=YDqhSxoWNt5PCvsJA8kQodh+2N3vAI/Frw5MetATtiN5M77gCvmW7Mtu2H/56JcUQq
         5hBwIXTaxyj3gLbjxTRc+3zhxei1ggB/zu+Y7dKVlhVVpkYbvFt8UTUqy/4aFpVxJHIq
         htHoSiwcLX7GY+A4S6hsqMTSAhuUyWGXejGShbxQjclR1/IuBDDo39Ati+Ry6qyDiTDO
         iZBCbtZR780MYpdrjrpDn+i3gN9YDImV0fYWBORACSksp/x+QpfB7Btcws4TkxNvrtKV
         Y9HPZDkRYPHRLAuXlTeN2GwnkIlYF47b20LdhG1rgVpZzZtcPh6aNQRZqX1NDo6Vnw98
         +XwA==
X-Gm-Message-State: AOAM530khnotXKQRj7/WLlBXXSllj8olNma+heUsxTy4WCeXNkkn5UTc
        +v5Jy9xtCOU6du/1AV5D0f1j1GpPBGdzsg==
X-Google-Smtp-Source: ABdhPJyV5vp9qW3VOFZLuFd7pb8Mrp4o8YYZ7s8IxiO8gp+8/t8P39UMF96NynmvJ+N3a0FRCAPHAg==
X-Received: by 2002:adf:fb49:: with SMTP id c9mr18553708wrs.72.1610811371485;
        Sat, 16 Jan 2021 07:36:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:36:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/11] tests: add a "set -o pipefail" for a patched bash
Date:   Sat, 16 Jan 2021 16:35:54 +0100
Message-Id: <20210116153554.12604-12-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "set -o pipefail" test mode to the test suite to detect failures
in "git" its output is fed directly to a pipe. Doing so is a pattern
we discourage[1] in the test suite, but we've got plenty of tests like
that. Now we can reliably detect those failures.

There was a previous attempt in [2] to add such a test mode, but as
noted by Jeff King in [3] adding it is a matter of peeing against the
wind with current bash semantics of failing on SIGPIPE.

This series relies on a patch of mine to bash, which I'm submitting
upstream, while not breaking anything for vanilla bash users. They
won't have GIT_TEST_PIPEFAIL turned on for them, and will only get
breakages if they turn it on explicitly with "GIT_TEST_PIPEFAIL=true".

Vanilla bash ignores SIGPIPE under "set -e" since version 3.1. It's
only under "set -o pipefail" (added in 3.2) that it doesn't take
account of SIGPIPE, in a seeming omission nobody bothered to fix yet.

Patching bash[4] with:

    diff --git a/jobs.c b/jobs.c
    index a581f305..fa5de82a 100644
    --- a/jobs.c
    +++ b/jobs.c
    @@ -2851,8 +2851,14 @@ raw_job_exit_status (job)
           p = jobs[job]->pipe;
           do
     	{
    -	  if (WSTATUS (p->status) != EXECUTION_SUCCESS)
    -	    fail = WSTATUS(p->status);
    +	  if (WSTATUS (p->status) != EXECUTION_SUCCESS
    +#if defined (DONT_REPORT_SIGPIPE)
    +              && WTERMSIG (p->status) != SIGPIPE
    +#endif
    +              )
    +            {
    +              fail = WSTATUS(p->status);
    +            }
     	  p = p->next;
     	}
           while (p != jobs[job]->pipe);

Makes it useful for something like the git test suite.

Under this test mode we only tests we need to skip those tests which
are explicitly testing that a piped command returned SIGPIPE. Those
tests will now return 0 instead of an exit code indicating SIGPIPE.

Forcing the mode to run under vanilla bash with
"GIT_TEST_PIPEFAIL=true" doesn't fail any tests for me, except the
test in t0000-basic.sh which explicitly checks for the desired
pipefail semantics. However, as Jeff noted in [3] that absence of
failure isn't reliable. I might not see some of the failures due to
the racy nature of how vanilla "set -o pipefail" interacts with *nix
pipe semantics.

1. a378fee5b0 (Documentation: add shell guidelines, 2018-10-05)
2. https://lore.kernel.org/git/cover.1573779465.git.liu.denton@gmail.com/
3. https://lore.kernel.org/git/20191115040909.GA21654@sigill.intra.peff.net/
4. https://github.com/bminor/bash/compare/master...avar:avar/ignore-sigterm-and-sigpipe-on-pipe-fail

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README              |  5 +++++
 t/t0000-basic.sh      |  4 ++++
 t/t0005-signals.sh    |  4 ++--
 t/t3600-rm.sh         |  5 ++++-
 t/t5000-tar-tree.sh   |  2 +-
 t/t9902-completion.sh |  5 +++++
 t/test-lib.sh         | 29 +++++++++++++++++++++++++++++
 7 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index c730a70770..cecc00442d 100644
--- a/t/README
+++ b/t/README
@@ -439,6 +439,11 @@ GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
 use in the test scripts. Recognized values for <hash-algo> are "sha1"
 and "sha256".
 
+GIT_TEST_PIPEFAIL=<boolean>, when true, run 'set -o pipefail' to catch
+failures in commands that aren't the last in a pipe. Defaults to true
+on bash versions which know how to ignore SIGPIPE failures under the
+'set -o pipefail' mode.
+
 Naming Tests
 ------------
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4ba2e8c85..38e04b9ce0 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1326,4 +1326,8 @@ test_expect_success 'test_must_fail rejects a non-git command with env' '
 	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
 '
 
+test_expect_success BASH_SET_O_PIPEFAIL 'our bash under "set -o pipefail" mode ignores SIGPIPE failures' '
+	yes | head -n 1 | true
+'
+
 test_done
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 4c214bd11c..cc5784a274 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -40,12 +40,12 @@ test_expect_success 'create blob' '
 	git add file
 '
 
-test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
+test_expect_success !MINGW,!BASH_SET_O_PIPEFAIL 'a constipated git dies with SIGPIPE' '
 	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
-test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
+test_expect_success !MINGW,!BASH_SET_O_PIPEFAIL 'a constipated git dies with SIGPIPE even if parent ignores it' '
 	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 4f7e62d05c..7b5d92add5 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -251,7 +251,10 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
 	OUT=$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
-	test_match_signal 13 "$OUT" &&
+	if ! test_have_prereq BASH_SET_O_PIPEFAIL
+	then
+		test_match_signal 13 "$OUT"
+	fi &&
 	test_path_is_missing .git/index.lock
 '
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 3ebb0d3b65..3adcbce84c 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -416,7 +416,7 @@ test_expect_success LONG_IS_64BIT 'set up repository with huge blob' '
 
 # We expect git to die with SIGPIPE here (otherwise we
 # would generate the whole 64GB).
-test_expect_success LONG_IS_64BIT 'generate tar with huge size' '
+test_expect_success LONG_IS_64BIT,!BASH_SET_O_PIPEFAIL 'generate tar with huge size' '
 	{
 		git archive HEAD
 		echo $? >exit-code
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index c4a7758409..947294bebb 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -7,6 +7,11 @@ test_description='test bash completion'
 
 . ./lib-bash.sh
 
+if test -n "$GIT_TEST_PIPEFAIL_TRUE"
+then
+	set +o pipefail
+fi
+
 complete ()
 {
 	# do nothing
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9fa7c1d0f6..118dc80ffc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -36,6 +36,31 @@ then
 fi
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 
+# Does "set -o pipefail" on this bash version handle SIGPIPE? Use it!
+. "$TEST_DIRECTORY/lib-bash-detection.sh"
+GIT_TEST_PIPEFAIL_TRUE=
+GIT_TEST_PIPEFAIL_DEFAULT=false
+if test -n "$TEST_SH_IS_BIN_BASH" &&
+       $BASH -c 'set -eo pipefail; yes | head -n 1 >/dev/null'
+then
+	GIT_TEST_PIPEFAIL_DEFAULT=true
+fi
+# We're too early for test_bool_env
+if git env--helper --type=bool --default="$GIT_TEST_PIPEFAIL_DEFAULT" \
+       --exit-code GIT_TEST_PIPEFAIL
+then
+	set -o pipefail
+
+	# Only "set -o pipefail" in the main test scripts, not any
+	# sub-programs we spawn.
+	GIT_TEST_PIPEFAIL=
+	export GIT_TEST_PIPEFAIL
+
+	# For the convenience of the prereq for it.
+	GIT_TEST_PIPEFAIL_TRUE=true
+	export GIT_TEST_PIPEFAIL_TRUE
+fi
+
 # If we were built with ASAN, it may complain about leaks
 # of program-lifetime variables. Disable it by default to lower
 # the noise level. This needs to happen at the start of the script,
@@ -1552,6 +1577,10 @@ test_lazy_prereq PIPE '
 	rm -f testfifo && mkfifo testfifo
 '
 
+test_lazy_prereq BASH_SET_O_PIPEFAIL '
+	test -n "$GIT_TEST_PIPEFAIL_TRUE"
+'
+
 test_lazy_prereq SYMLINKS '
 	# test whether the filesystem supports symbolic links
 	ln -s x y && test -h y
-- 
2.29.2.222.g5d2a92d10f8

