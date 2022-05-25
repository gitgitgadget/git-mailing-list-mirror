Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037F2C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbiEYL01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiEYL0X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809BA994F7
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso3149300wmn.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=egLKGOAL6OQbN+jgvrbBVQcSfuL+AN0CAVgLeaD+GMU=;
        b=q176DyNan1BcZ1eUBhRmQ2/6xbOWlPYtcSHsY4xLQNXfDsOanZL87CWuD2Io6yMXV+
         c+0X9DkG4ss0HVYD+EYGaZff9N+BeX3/+pR4bX0W6yu7r8Jd9RmzVJFN9GUB1X19N/wv
         t7zUoA+1tqdyB2PFlXsnZCTknkq9ED8dpCpO3olTqDO6nCKqQ93qtFS0IfuMs+km1xDm
         uFLCONMgmwXbRSPsIbgw9gGk5x/SwdGzpKqQWNy+bG5Te9gElVaO6KnKf12uQe8vD44U
         RA/5z7i5hoIW1snkvC9mpI32Ct9baGgx/W20vWicO0myz4ata3n/M9nphh68VKAPY5Dt
         GXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=egLKGOAL6OQbN+jgvrbBVQcSfuL+AN0CAVgLeaD+GMU=;
        b=HzoW/Glr0FnP+XGSLQ4zJcOxCrqgFmQ5vikgYkGOJd+f2HOY18IdQZ9fbZhpR4IyRw
         gcVYMkhy4uwvCOM3QZSjbE1MLRF1kia9OIcoobplwCMI53vMFQC/chKr5YFCs1NEkQLZ
         Aly0jSF17OsshgLTa8G/ssmRMpFPoVr2+noj3wvZiQbMfFcM0/TzMOgV0/4Mtrg/s1bd
         1cQYHouf1mPlke1lgGpXqu7XFs8fmaTWP2yNCYYaFIep6U6dC2yjcw1syXduO6zzmdwD
         IHUwW+dAqOzSi+M9Sobc9XZZjP7yjZK0M6Mgct9ciJ5YoCMj7dt02lXhavQUQaw5kSuW
         BuUw==
X-Gm-Message-State: AOAM533KVYMedoWTM5QUANE/UJHP9HI6GsSnDuQxFg3seTt3NQjlb2GX
        PdE3oEAny0jgyYdqqbHIRHJbswVrIRG3oQ==
X-Google-Smtp-Source: ABdhPJxerd2C7m08XaiRGBa0sEesFYfWF5IvR/h3uX+NmVaumwA5jI03BQkyx1WNTs6FlHteYeT20w==
X-Received: by 2002:a7b:cd95:0:b0:397:3c5e:9639 with SMTP id y21-20020a7bcd95000000b003973c5e9639mr7842009wmj.12.1653477980847;
        Wed, 25 May 2022 04:26:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 01/14] CI: don't "cd" in ci/print-test-failures.sh
Date:   Wed, 25 May 2022 13:25:50 +0200
Message-Id: <patch-v6-01.14-c10a11fdae8-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the logic in ci/print-test-failures.sh so that we don't need to
"cd" at the top-level, we'll now only do so for the "tar" command.

This way we can remove some duplicate code added in
aea8879a6ac (travis-ci: include the trash directories of failed tests
in the trace log, 2018-08-01), i.e. not have both a $TEST_NAME and
$test_name. The output is exactly the same as before,
i.e. "test-results/" was included in the heading.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/print-test-failures.sh | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index ec395c79ccd..f6736f424e0 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -8,33 +8,36 @@ set -e
 . ${0%/*}/lib-ci-type.sh
 . ${0%/*}/lib-tput.sh
 
-cd t/
-
-if ! ls test-results/*.exit >/dev/null 2>/dev/null
+if ! ls t/test-results/*.exit >/dev/null 2>/dev/null
 then
 	echo "Build job failed before the tests could have been run"
 	exit
 fi
 
-for TEST_EXIT in test-results/*.exit
+for TEST_EXIT in t/test-results/*.exit
 do
 	if [ "$(cat "$TEST_EXIT")" != "0" ]
 	then
-		TEST_OUT="${TEST_EXIT%exit}out"
+		TEST_NAME="${TEST_EXIT%.exit}"
+		TEST_NAME="${TEST_NAME##*/}"
+		TEST_OUT="${TEST_NAME}.out"
+		TEST_MARKUP="${TEST_NAME}.markup"
+
 		echo "------------------------------------------------------------------------"
-		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
+		echo "$(tput setaf 1)test-results/${TEST_OUT}...$(tput sgr0)"
 		echo "------------------------------------------------------------------------"
-		cat "${TEST_OUT}"
+		cat "t/test-results/${TEST_OUT}"
 
-		test_name="${TEST_EXIT%.exit}"
-		test_name="${test_name##*/}"
-		trash_dir="trash directory.$test_name"
+		trash_dir="trash directory.$TEST_NAME"
 		case "$CI_TYPE" in
 		github-actions)
-			mkdir -p failed-test-artifacts
+			mkdir -p t/failed-test-artifacts
 			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
-			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
-			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
+			cp "t/test-results/${TEST_OUT}" t/failed-test-artifacts/
+			(
+				cd t &&
+				tar czf failed-test-artifacts/"$TEST_NAME".trash.tar.gz "$trash_dir"
+			)
 			;;
 		esac
 	fi
-- 
2.36.1.1045.gf356b5617dd

