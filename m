Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3138C19F21
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiG0XOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiG0XN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:13:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A70A4D4C9
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b6so69690wmq.5
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=89J4/LsuXFq/+4absQtheu32r0lGk3u6TrBlHx8EMZM=;
        b=KLV9muENCV+8UnKk/QM04IJNICCYbwisnoLorJvqDO7wzvBTbGuMswXTEC8bpWIB+P
         KtdBUiNTIEAQtIDD0ug9h67blLNFD58AX4Mb++TZnoZSzPn4nWkEXFLuqRoLr2EV0Yky
         paZk41TC1rEMPDLcz8veskUN9/3IWSU13P6N6CLssgV/IJBPTKW2csDsScMMRfg1qdA6
         SahWrlldLbuNEfAobnttA8pj4onsmFJ/4DmP89uzWJ9wje44xDDRcfxB+3Bi04uTfrmt
         Ec+cy1C2WP9PkuSydge2HlAzPvz5Ky1QuRSgliaEy1K9E9lYG7QeVLFp9kGkCJILuW3y
         qHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=89J4/LsuXFq/+4absQtheu32r0lGk3u6TrBlHx8EMZM=;
        b=jjio0adaj8Y+Gh7PROn0felWvEx0RR72jfNMi+Tp+gOz2EJy32pws3IWIXv7TvW77k
         bu4JL9YVJeUrK2nkfmXt2ucFvrzmjrYMWVU7FQEyod2An3iwPIr8aLUEX1JQ5v2Vm8St
         34J3N6asWQ61TC5giinwZhb1nLMP9k0YsgsvDkPG4Uh7e4mOedPV3uGqCApObdyTQqvu
         yo8ZApHdyldNJwpKo9RtsusYSOBq7w2ocr0CY3fOaquqMd4WO5Y/QH5fA46LGM2cUFhv
         goY6pclLF+bGcsF3HhPgVJXDW+Y4DcpozB4jAVxgbcPbA3M12fFK4xYuxsJyZZnVkVFj
         2g7g==
X-Gm-Message-State: AJIora9wRWdabQC1HId9QDh4sKjgizIvWMdHKkkH7gCZ7a9T8a62jFDh
        9kWGtDWwUp4mcZvRwXzQ/iwK220WrsX/fg==
X-Google-Smtp-Source: AGRyM1vxpylstO9+dCNj8i0yWSgX2BAexvuhPDzTtw6gUx8wXjn17KABFKIUDkWY7s/kqTPw/Cv/ug==
X-Received: by 2002:a05:600c:364b:b0:3a3:7e97:8f10 with SMTP id y11-20020a05600c364b00b003a37e978f10mr2983330wmq.152.1658963635480;
        Wed, 27 Jul 2022 16:13:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:13:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/15] test-lib: add a SANITIZE=leak logging mode
Date:   Thu, 28 Jul 2022 01:13:34 +0200
Message-Id: <patch-v3-06.15-4f9b2396c15-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to run the test suite under a new
"GIT_TEST_SANITIZE_LEAK_LOG=true" mode, when true we'll log the leaks
we find an a new "test-results/<test-name>.leak" directory.

That new path is consistent with the existing
"test-results/<test-name>.<type>" results, except that those are all
files, not directories.

We also set "log_exe_name=1" to include the name of the executable in
the filename. This gives us files like "trace.git.<pid>" instead of
the default of "trace.<pid>". I.e. we'll be able to distinguish "git"
leaks from "test-tool", "git-daemon" etc.

We then set "dedup_token_length" to non-zero ("0" is the default) to
succinctly log a token we can de-duplicate these stacktraces on. The
string is simply a one-line stack-trace with only function names up to
N frames, which we limit at "9999" as a shorthand for
"infinite" (there appears to be no way to say "no limit").

With these combined we can now easily get e.g. the top 10 leaks in the
test suite grouped by full stacktrace:

    grep -o -P -h '(?<=DEDUP_TOKEN: ).*' test-results/*.leak/trace.git.* | sort | uniq -c | sort -nr | head -n 10

Or add "grep -E -o '[^-]+'" to that to group by functions instead of
stack traces:

    grep -o -P -h '(?<=DEDUP_TOKEN: ).*' test-results/*.leak/trace.git.* | grep -E -o '[^-]+' | sort | uniq -c | sort -nr | head -n 20

This new mode requires git to be compiled with SANITIZE=leak, rather
than explaining that in the documentation let's make it
self-documenting by bailing out if the user asks for this without git
having been compiled with SANITIZE=leak, as we do with
GIT_TEST_PASSING_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      |  5 +++++
 t/test-lib.sh | 30 +++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 7f409392537..0664aee7ed9 100644
--- a/t/README
+++ b/t/README
@@ -371,6 +371,11 @@ declared themselves as leak-free by setting
 "TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
 test mode is used by the "linux-leaks" CI target.
 
+GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
+"test-results/$TEST_NAME.leak/trace.*" files. The logs include a
+"dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
+make logs +machine-readable.
+
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f8adb92f027..557f77c9717 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -305,6 +305,10 @@ TEST_NUMBER="${TEST_NAME%%-*}"
 TEST_NUMBER="${TEST_NUMBER#t}"
 TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
 TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME$TEST_STRESS_JOB_SFX"
+TEST_RESULTS_SAN_FILE_PFX=trace
+TEST_RESULTS_SAN_DIR_SFX=leak
+TEST_RESULTS_SAN_FILE=
+TEST_RESULTS_SAN_DIR="$TEST_RESULTS_DIR/$TEST_NAME.$TEST_RESULTS_SAN_DIR_SFX"
 TRASH_DIRECTORY="trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
@@ -1447,6 +1451,10 @@ then
 	test_done
 fi
 
+BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK () {
+	BAIL_OUT "$1 has no effect except when compiled with SANITIZE=leak"
+}
+
 if test -n "$SANITIZE_LEAK"
 then
 	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
@@ -1461,9 +1469,29 @@ then
 			test_done
 		fi
 	fi
+
+	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
+	then
+		if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
+		then
+			BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"
+		fi &&
+		TEST_RESULTS_SAN_FILE="$TEST_RESULTS_SAN_DIR/$TEST_RESULTS_SAN_FILE_PFX"
+
+		# Don't litter *.leak dirs if there was nothing to report
+		test_atexit "rmdir \"$TEST_RESULTS_SAN_DIR\" 2>/dev/null || :"
+
+		prepend_var LSAN_OPTIONS : dedup_token_length=9999
+		prepend_var LSAN_OPTIONS : log_exe_name=1
+		prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
+		export LSAN_OPTIONS
+	fi
 elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 then
-	BAIL_OUT "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
+	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
+elif test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
+then
+	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=true"
 fi
 
 # Last-minute variable setup
-- 
2.37.1.1127.g4ecf1c08f67

