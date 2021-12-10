Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F8BC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbhLJKLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbhLJKLh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:11:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C31C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:08:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t18so13981268wrg.11
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUoPmosUvpRYy1SDWRP8q/Jt118xcHnfZWRhrwmm7e4=;
        b=IYHlcurD4/22H8WLx28FpFDwsq9ediLJAJQDrYC8Crw6OTvMgQA/HeKjryLuOgQ84d
         GEsN+hMUAbbAN8i9MShDEO8F9H1uDH0L6UctNNo3t0Au4vvpA7Jvi4X7210yD6BJFf8O
         rdlmYBXd81zi8NhqcboAQCG9rnpKyIjXTct9HbLye90yG+pG3Yf5OLyH+pB4jy7+MLlZ
         GYopQnqRLDJ/YFzUWHnQWcSCHu4zAWZyIX5P/Hpcglq4SF3Vg/rw/vgIAzeJAGLKPCDh
         VvCsVxBCWYa6po7ccSKPLdoo5CvRz8iGJigTpoWUzB+rq/s1h5WpEWAC/gd6avg9exVq
         +dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUoPmosUvpRYy1SDWRP8q/Jt118xcHnfZWRhrwmm7e4=;
        b=INIcrtqYgyN2uYVLpKuOEu+DzPn7kjRmSy2m7oQuVx8J4ujdY1Wujejd6nwTo8k4ea
         RaL0rq5ymaY9YD1vovwXdP/wf1gWF0rAuw0rAMEKREZtfVERi8+xpYhE4ah9cshh2zRG
         wT6AAAbRHvbxjMxVzZ+mzDrs9QDxRV9SF6ezg2gHWwZFT7IR9lqYswd/R1Ik9HIjXPvN
         VKmDhdeYdJXlXDEzJsOWsDEt5DeIN6JSi4HreJvFIY9u2MWN4/riGIKKDPag6ObOEhlj
         RoSHnXN2fF0iptZAntiimqqAOR7wncTlqStj7cCjEYWL3wXMHBHrRU1s9pOkRC3ZLakf
         eNRg==
X-Gm-Message-State: AOAM533FUiVxFppLeRAdniBVdh2cJQ+BrdsHufx2vK5BxIT1vyh4BlMp
        65WR/MqA7XhiBV0o76oepriWYmvVPUMI+g==
X-Google-Smtp-Source: ABdhPJwhTDbLbwpOSFzQtiC5NfUNkrrzSjqTzgfHQ5MOKxtem/6GSsVVfD1ZOJXbiXvyyVOpCAG6Iw==
X-Received: by 2002:a5d:66cd:: with SMTP id k13mr12814260wrw.517.1639130880510;
        Fri, 10 Dec 2021 02:08:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m3sm2055561wrv.95.2021.12.10.02.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 02:07:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] test-lib.sh: remove the now-unused "test_untraceable" facility
Date:   Fri, 10 Dec 2021 11:07:55 +0100
Message-Id: <patch-v3-2.2-a7fc794e20d-20211210T100512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.932.g36842105b61
In-Reply-To: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com> <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit the use of "test_untraceable=UnfortunatelyYes"
was removed from "t1510-repo-setup.sh" in favor of more narrow
redirections of the output of specific commands (and not entire
sub-shells or functions).

This is in line with the fixes in the series that introduced the
"test_untraceable" facility. See 571e472dc43 (Merge branch
'sg/test-x', 2018-03-14) for the series as a whole, and
e.g. 91538d0cde9 (t5570-git-daemon: don't check the stderr of a
subshell, 2018-02-24) for a commit that's in line with the changes in
the preceding commit.

We've thus solved the TODO item noted when "test_untraceable" was
added to "t1510-repo-setup.sh" in 58275069288 (t1510-repo-setup: mark
as untraceable with '-x', 2018-02-24).

So let's remove the feature entirely. Not only is it currently unused,
but it actively encourages an anti-pattern in our tests. We should be
testing the output of specific commands, not entire subshells or
functions.

That the "-x" output had to be disabled as a result is only one
symptom, but even under bash those tests will be harder to debug as
the subsequent check of the redirected file will be far removed from
the command that emitted the output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      |  3 ---
 t/test-lib.sh | 66 ++++++---------------------------------------------
 2 files changed, 7 insertions(+), 62 deletions(-)

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
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 57efcc5e97a..b008716917b 100644
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
2.34.1.932.g36842105b61

