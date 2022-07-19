Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E512C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbiGSVFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbiGSVFq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:05:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6760243E6D
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso96847wms.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZyMgehcYw8VfzhylaYnH/VwTzxeQBPBi8S4WwJZZeA=;
        b=VwvuturGrjF/htiKJTYTcyH3fRezMPi4QaYSTpRyjWrOfHbX3BkGv+tUWA8LzUZ/bE
         3juScouPSMWoEiKaNelYpRK2fxSXQ+FRIXBHLjCvk9co0GVBAtpQhaavfvtCWHme1bgt
         MsFZPMXbYb8lu59XVq/4bNJwFCzaE1zhFbrsQ0YXaalruODAIdkKGKH2CZFbDwoXSlll
         9Zy8+i613xHk1scM4RmnhSvDIT6xQTWf/nW762qb5xjNaG1aio3br42Gf0pgpHplNDfC
         RolwMjXSEDWDqY2r3D8BTjoxtffHeK+kyl6tifpGeyBG9xXNomzFDPh9WVQTgCnhWAvX
         mVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZyMgehcYw8VfzhylaYnH/VwTzxeQBPBi8S4WwJZZeA=;
        b=zhTd28FOoLfzrsq4PzFcUCkFMbb1/psM2F+svqR9vHdAYOogQj/dwuqi0+lYdlpzQT
         3061xKyRn7mplShsHKbYlHgdqRtiN5YMYVN59HktGT5gyUpNe+x9PtCHRDSaVO2MrcsY
         0pM1o4UF3fm+jyCYbVSD/21wfKf38dRNjSlrdRZiDeKtDtCbn+opJ8krakgVOMHItKoW
         iSGit+1su9+ywy/ipUrL1N1EaZFHTskmgiOQwoZ+ut28JChAMPGKiFqiaKgbdCQiUxBc
         jOb8U+1dWEuM2QxedYkMgDoio48vBGMIzEL0vW/2mbFKZN/yNbFe+MfjE3YhoPLz5gmf
         dYMw==
X-Gm-Message-State: AJIora88KiNkVBJt4/1+SlKy2k2THl9OTU4WRyVupxkfaDHqTUqGC5yN
        uJb6fZAvY+VUS4eh4kke45mSxSxMFU5POA==
X-Google-Smtp-Source: AGRyM1sR38tZYNdvSIavWr2ODhHOs/ozLV9kMdmaSX6/EyeG6cGy4EOOcjv1oeFU79ZiYgbq3aupFg==
X-Received: by 2002:a7b:cb47:0:b0:3a3:24f4:434 with SMTP id v7-20020a7bcb47000000b003a324f40434mr895013wmj.195.1658264738655;
        Tue, 19 Jul 2022 14:05:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c461800b003a050a391e8sm75091wmo.38.2022.07.19.14.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:05:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] test-lib: add a SANITIZE=leak logging mode
Date:   Tue, 19 Jul 2022 23:05:20 +0200
Message-Id: <patch-06.10-ad1395f45af-20220719T205710Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1063.gd87c5b8cc23
In-Reply-To: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      |  6 ++++++
 t/test-lib.sh | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/t/README b/t/README
index 7f409392537..c2f996656d3 100644
--- a/t/README
+++ b/t/README
@@ -371,6 +371,12 @@ declared themselves as leak-free by setting
 "TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
 test mode is used by the "linux-leaks" CI target.
 
+GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
+"test-results/$TEST_NAME.leak/trace.*" files. Useful in combination
+with "GIT_TEST_PASSING_SANITIZE_LEAK" to check if we're falsely
+reporting a test as "passing" with SANITIZE=leak due to ignored exit
+codes.
+
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7f730b0f94f..73600c4d887 100644
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
@@ -1455,6 +1459,23 @@ then
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
 	BAIL_OUT "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
-- 
2.37.1.1062.g385eac7fccf

