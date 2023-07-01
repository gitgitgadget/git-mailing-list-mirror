Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B4AEB64DD
	for <git@archiver.kernel.org>; Sat,  1 Jul 2023 19:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjGAT1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jul 2023 15:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGAT1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2023 15:27:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA72171D
        for <git@vger.kernel.org>; Sat,  1 Jul 2023 12:27:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so4907925e87.2
        for <git@vger.kernel.org>; Sat, 01 Jul 2023 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688239626; x=1690831626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnjfnG4RjfkFmX0zSLJb0asWaKncjq9Tm6XBrhUnlYk=;
        b=SHJfyHmRZ3hu+CjrYm8euTIdRHPyBoJGL2MF+aB0OOlOCi19/qOKXJQVpzw41EFuTR
         no6s/GzPy4sWKR7wz8U/jQrERD265w9cVvi4duKMK68z7olSl5MuMK5NzDLu5ljE9kDh
         c25yKLOQGOl5MQ5KBKxFk/qq7uZ4Mz0l5tgvSz5P+seHLQjf5nyDw3fkXMIUSZrYEY3L
         UzLwbY+GIXDoossW53gC7T/me8/aOTEMhgdPoOGdGVjjO4yJfNkQ/YvKPlOXY29YnITW
         BzWVFcfulKHwTIOL8HvEL/p4iQwD1A7wwOWYW/zZ7maofdpZiFmnmJdhGXNDjMtP+ByL
         urog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688239626; x=1690831626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnjfnG4RjfkFmX0zSLJb0asWaKncjq9Tm6XBrhUnlYk=;
        b=Bp4KWtZFabC7FsOdAWyoGNcqT4lPvN/P1n/folHfALrfyRWcP1FurhWCW7w7o/mcCc
         KzcR82b9r2VJQt63jUWwQsmWLGQZZ7YJyN6w38t41KvQbWHaUX2wkBQqSZs5+DW1Ewv+
         pdb3U90wF1dr4JmbuV1KZwjG8O9K4KvaxHFMQrWZdB+8nI68dEFJ9QG/PV/ZdRX39wiJ
         ixojMVZ4voMY7q7Nu/oQdGorcbodDMka0WY+HyByBfiRBlFlmbCTSIQHA6xaU+QUrcc4
         M9DzII2mQ4q5kORDwOQgDrs7FsxeCaLoLS3+O4l/aaV7SUVnurakQnLgSDirqe7m7w6X
         00CA==
X-Gm-Message-State: ABy/qLa5vXOnbevqvNQ6AWjMvrXuPv9kREArjQXCUpOfJ7KM+lEm0vRT
        u/eml5uRxuyvlx+Jh46iH5uspo0lVl/csQ==
X-Google-Smtp-Source: APBJJlFs7dt6nD7iG/Pw8gV95cAtzmlbDYwxSFvbY82MMAISP28AedbiwaDTAbpbSM6TqzEkjrBjiQ==
X-Received: by 2002:a05:6512:31d4:b0:4f8:5f32:b1da with SMTP id j20-20020a05651231d400b004f85f32b1damr5376044lfe.24.1688239625618;
        Sat, 01 Jul 2023 12:27:05 -0700 (PDT)
Received: from localhost.localdomain (2-248-185-180-no600.tbcn.telia.com. [2.248.185.180])
        by smtp.gmail.com with ESMTPSA id u15-20020a056512040f00b004faa2de9877sm3312869lfk.286.2023.07.01.12.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 12:27:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] t0091-bugreport.sh: actually verify some content of report
Date:   Sat,  1 Jul 2023 21:26:40 +0200
Message-ID: <20230701192642.647167-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.41.0.404.g5b50783d6b
In-Reply-To: <YHYZTLl90rkWWVOr@google.com>
References: <YHYZTLl90rkWWVOr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the first test in this script, 'creates a report with content in the
right places', we generate a report and pipe it into our helper
`check_all_headers_populated()`. The idea of the helper is to find all
lines that look like headers ("[Some Header Here]") and to check that
the next line is non-empty. This is supposed to catch erroneous outputs
such as the following:

  [A Header]
  something
  more here

  [Another Header]

  [Too Early Header]
  contents

However, we provide the lines of the bug report as filenames to grep,
meaning we mostly end up spewing errors:

  grep: : No such file or directory
  grep: [System Info]: No such file or directory
  grep: git version:: No such file or directory
  grep: git version 2.41.0.2.gfb7d80edca: No such file or directory

This doesn't disturb the test, which tugs along and reports success, not
really having verified the contents of the report at all.

Note that after 788a776069 ("bugreport: collect list of populated
hooks", 2020-05-07), the bug report, which is created in our hook-less
test repo, contains an empty section with the enabled hooks. Thus, even
the intention of our helper is a bit misguided: there is nothing
inherently wrong with having an empty section in the bug report.

Let's instead split this test into three: first verify that we generate
a report at all, then check that the introductory blurb looks the way it
should, then verify that the "[System Info]" seems to contain the right
things. (The "[Enabled Hooks]" section is tested later in the script.)

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 This is a much belated follow-up to v1 [1]. Feedback on that patch
 ranged from not bothering checking the generated report at all to
 implementing `--no-system-info` and `--no-hooks-info` so that we could
 easily test the introductory blurb verbatim.

 I hope I'm hitting a reasonable middle ground here. Verifying the
 contents at least somewhat is in line with the original intention of
 the test. Those `--no-...-info` could probably be useful to bug
 reporters, but it feels wrong to me to implement them just to be able
 to use them in the tests.

 [1] https://lore.kernel.org/git/20210411143354.25134-1-martin.agren@gmail.com/

 t/t0091-bugreport.sh | 67 +++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index b6d2f591ac..9390631b17 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -5,29 +5,50 @@ test_description='git bugreport'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-# Headers "[System Info]" will be followed by a non-empty line if we put some
-# information there; we can make sure all our headers were followed by some
-# information to check if the command was successful.
-HEADER_PATTERN="^\[.*\]$"
-
-check_all_headers_populated () {
-	while read -r line
-	do
-		if test "$(grep "$HEADER_PATTERN" "$line")"
-		then
-			echo "$line"
-			read -r nextline
-			if test -z "$nextline"; then
-				return 1;
-			fi
-		fi
-	done
-}
-
-test_expect_success 'creates a report with content in the right places' '
-	test_when_finished rm git-bugreport-check-headers.txt &&
-	git bugreport -s check-headers &&
-	check_all_headers_populated <git-bugreport-check-headers.txt
+test_expect_success 'create a report' '
+	git bugreport -s format &&
+	test_file_not_empty git-bugreport-format.txt
+'
+
+test_expect_success 'report contains wanted template (before first section)' '
+	awk "/^\[/ { exit } { print }" git-bugreport-format.txt >actual &&
+	cat >expect <<-\EOF &&
+	Thank you for filling out a Git bug report!
+	Please answer the following questions to help us understand your issue.
+
+	What did you do before the bug happened? (Steps to reproduce your issue)
+
+	What did you expect to happen? (Expected behavior)
+
+	What happened instead? (Actual behavior)
+
+	What'\''s different between what you expected and what actually happened?
+
+	Anything else you want to add:
+
+	Please review the rest of the bug report below.
+	You can delete any lines you don'\''t wish to share.
+
+
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'sanity check "System Info" section' '
+	test_when_finished rm -f git-bugreport-format.txt &&
+
+	sed -ne "/^\[System Info\]$/,/^$/p" <git-bugreport-format.txt >system &&
+
+	# The beginning should match "git version --build-info" verbatim,
+	# but rather than checking bit-for-bit equality, just test some basics.
+	grep "git version [0-9]." system &&
+	grep "shell-path: ." system &&
+
+	# After the version, there should be some more info.
+	# This is bound to differ from environment to environment,
+	# so we just do some rather high-level checks.
+	grep "uname: ." system &&
+	grep "compiler info: ." system
 '
 
 test_expect_success 'dies if file with same name as report already exists' '
-- 
2.41.0.404.g5b50783d6b

