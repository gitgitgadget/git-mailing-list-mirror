Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9CDC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15E923A7C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbhANXgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731036AbhANXgm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:36:42 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A15C0613ED
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d26so7480448wrb.12
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sppC0A3AFUYEJV/vqVfz1ehePKLKV7Ud5KYw9wg+ybg=;
        b=GRciIQRnpqhxapuYdio8EuibLiLR683KO93MRc7YXO0hBNW+TPf9Upyw3Z2ZgkNsZN
         Q7udTUgZvaOJ0eTYfQoKYm8JOPUwa90SxfYDYPTBJNBZ45cRDRJrvWu7ACDlTq+N+FmQ
         6+siTrJhxQe0cG0E3vL7DBPuRR1Gp8BRuoolTXI/Vhw8u39vyRxc5+iQvYwQgq0wC6dL
         8FhqxtDzx3qkF09FgbXyUCMvdwgsF1+vd4C4fZe6v3A6EIRngj0i0t9vMnXmmOwNV0QJ
         /9IYgzRvfOJMxfCd3knczGgj1beEGvvq57rwBLBoKhZ2FMHVh1bbD5WcT1Dtym20Ys/C
         AErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sppC0A3AFUYEJV/vqVfz1ehePKLKV7Ud5KYw9wg+ybg=;
        b=PYYTsvWDK7BPggYpm7ZNRivcEmaS4Pylx9T/TQ8bdeMYivaclnTffz3FohdOECWNn+
         Cn4LMo1MkTRf88pB5ES9iAqKJ0MuqT3Cegl+MZhrfn0sbwDIrGrj7gdLcN6od2pu2jlf
         9FzIM//TTIZG4mZqyQVIsXrRKNYQUn4QSrTFuT3FQXnrlmUq3rNFTApCfQpiIBNvVLfn
         ZsUS/KW9205RnlgSr3E+qnv3chAilvH20OLUUvL/rN5hsdoYj0TenyKeOFHi4+L9T3sR
         A/OBPGgvvosD3pwFvHH2f0DnMT2YrJpKdSvBFOkRmPxPMWEihV3FjK20g9vHdoP+wlWq
         DfOQ==
X-Gm-Message-State: AOAM533z3qf1alCFNkA18BWfqsWvvZJErdAiquN0+oTUAbCnqa8El04s
        Mv7GXttmQe8JRaftxrlnz/NG/FNpDnUtCQ==
X-Google-Smtp-Source: ABdhPJxheMwlBItNekb3MrBpi4WNtCuU9H7CF5gycnSUaUTyKosw0ri/ZEmz47QY+JhRkx7HSWxwOA==
X-Received: by 2002:adf:c5d3:: with SMTP id v19mr10179449wrg.365.1610667329258;
        Thu, 14 Jan 2021 15:35:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d13sm12352118wrx.93.2021.01.14.15.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:35:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] tests: add a "set -o pipefail" for a patched bash
Date:   Fri, 15 Jan 2021 00:35:15 +0100
Message-Id: <20210114233515.31298-7-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20191115040909.GA21654@sigill.intra.peff.net>
References: <20191115040909.GA21654@sigill.intra.peff.net>
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
upstream. Vanilla bash ignores SIGPIPE under "set -e" since version
3.1. It's only under "set -o pipefail" (added in 3.2) that it doesn't
take account of SIGPIPE, in a seeming omission nobody bothered to fix
yet.

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

Makes it useful for something like the git test suite. With vanilla
bash and GIT_TEST_PIPEFAIL=true we'll fail 4 tests in my one-off test.

With my patched bash the only tests we need to skip are those that are
explicitly testing that a piped command returned SIGPIPE.

As Jeff noted in [3] that count isn't reliable, as more will fail in a
way that's hard to reproduce due to the racy nature of vanilla "set -o
pipefail"

1. a378fee5b0 (Documentation: add shell guidelines, 2018-10-05)
2. https://lore.kernel.org/git/cover.1573779465.git.liu.denton@gmail.com/
3. https://lore.kernel.org/git/20191115040909.GA21654@sigill.intra.peff.net/
4. https://github.com/bminor/bash/compare/master...avar:avar/ignore-sigterm-and-sigpipe-on-pipe-fail

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README              |  6 ++++++
 t/t0000-basic.sh      | 14 ++++++++++++++
 t/t0005-signals.sh    |  4 ++--
 t/t5000-tar-tree.sh   |  2 +-
 t/t9902-completion.sh |  5 +++++
 t/test-lib.sh         | 29 +++++++++++++++++++++++++++++
 6 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index c730a70770..d9f65bfa6b 100644
--- a/t/README
+++ b/t/README
@@ -439,6 +439,12 @@ GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
 use in the test scripts. Recognized values for <hash-algo> are "sha1"
 and "sha256".
 
+GIT_TEST_PIPEFAIL=<boolean>, when true, run 'set -o pipefail' to catch
+failures in commands that aren't the last in a pipe. Defaults to true
+on bash versions which know how to ignore SIGPIPE failures under the
+'set -o pipefail' mode (as of 2021-01-14 only in an out-of-tree patch
+to bash).
+
 Naming Tests
 ------------
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 930cf9d1b7..e70cc37139 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1350,4 +1350,18 @@ test_expect_success 'test_{must,might}_fail accept non-git on "sigpipe"' '
 	test_cmp badobjects out
 '
 
+test_expect_failure BASH_SET_O_PIPEFAIL 'test_{must,might}_fail ok=sigpipe under bash "set -o pipefail"' '
+	grep string </dev/null | true
+'
+
+test_expect_failure BASH_SET_O_PIPEFAIL 'test_{must,might}_fail ok=sigpipe under bash "set -o pipefail"' '
+	test_must_fail grep string </dev/null | true &&
+	test_might_fail grep string </dev/null | true
+'
+
+test_expect_success BASH_SET_O_PIPEFAIL 'test_{must,might}_fail ok=sigpipe under bash "set -o pipefail"' '
+	test_must_fail ok=sigpipe grep string </dev/null | true &&
+	test_might_fail ok=sigpipe grep string </dev/null | true
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
index a1c4f1f6d4..3414ac56f4 100755
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

