Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A11C4332F
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 01:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhLMBis (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 20:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhLMBim (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 20:38:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5CBC0613F8
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 17:38:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t18so24497044wrg.11
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 17:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DoW6Cssmdx4/oELxnAahGG9A2rEag2YKF+0sojoejQk=;
        b=Ox1y5Uv4tHQtWE/SQR+IEigMsSgI0EBoCfAztz59Q5NgNNe/YDrskOJdAtm74+5jf0
         2rheMA0gPC475fyGkqcVTuM0s3FHrxwYOOT9YyXgNo0FDrYZpzYUIIY2yNxI0KH1gHjC
         W2QUpVUf0njeWgpQp0Gc+RvM73C9xKpIkk2yi/Hr++B2jDI/96X56tY+w6aeZTXraqaf
         FJitsAcRVsdJPj5XNwVwyKXz2ZKlw2ddC7rYKBzF6SMBNJ4N76xYTLBQFOQmIIOSGFud
         OnJBOqBMPoeTKDAClJQ4MoKAi2FQ2GewvSISeBbiKA8NiwZwkFZRZJb7C3hnQD3Ks62W
         M78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DoW6Cssmdx4/oELxnAahGG9A2rEag2YKF+0sojoejQk=;
        b=YXzl/jSeY/HEeHqj+P5gHfIlwLJHjbruFUuhrrtDFgn9dJMPVZBc23ex2oLGNbmrsa
         k9Ob7Z/qeAShZHWPTb/T38NuSZcKeK7iwJA3LvZxxDY1n0mM5E33rnWjJUkMI6ImR8YO
         kaXpJRajzzMJld6W4IjjfIQHiiOm2BUkgq3+9YO22tfteJMaHuErxuFh1ieFIAZjkNuX
         rC46BNY7E6apdCGDfuSYVP5g0w/Zh3FMgmj9KiWRro5Cq6e4h9ilNT9/Tn3EMHkF0zyC
         3i7Ublh3FxBCRfkwCwtSIjxnQhLy9JXMG0CFHit3mgADfBJALlzYPepKk4WD/lLL0ijY
         06rQ==
X-Gm-Message-State: AOAM532FR53Rky8+U10e5mPghCh15LEXgR3wT74G/Q4JjZfHUUdNGnaO
        B+3fPf/sWyeK9Kw6cUUGxSYbBYSV79tfLQ==
X-Google-Smtp-Source: ABdhPJwuiHXAHtDkQIYiuiSHCh3KyHzzrqOIyEHGhBSNigaZFdvDxqZd0nAb9N9wEeZ6DtiR6kfd3A==
X-Received: by 2002:adf:fc88:: with SMTP id g8mr28587859wrr.334.1639359520522;
        Sun, 12 Dec 2021 17:38:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm11571303wrs.59.2021.12.12.17.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 17:38:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/3] test-lib.sh: remove the now-unused "test_untraceable" facility
Date:   Mon, 13 Dec 2021 02:38:35 +0100
Message-Id: <patch-v4-2.3-60883fd95cb-20211213T013559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1024.g573f2f4b767
In-Reply-To: <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
References: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com> <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
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
 t/test-lib.sh | 23 -----------------------
 2 files changed, 26 deletions(-)

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
index 57efcc5e97a..ddfa0567e9e 100644
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
-- 
2.34.1.1024.g573f2f4b767

