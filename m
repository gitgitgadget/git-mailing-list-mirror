Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEB2C43460
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E3E613BD
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbhDFOA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhDFOA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 10:00:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39554C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 07:00:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a76so4218857wme.0
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L30JOyTUDiG33bs18mptbYSAy0GY7nwlxVrpycnRwm8=;
        b=CC6QHdridhFYkD//l2j9Lr7LRwdBRWKfZCM6x0W5GMElQUxIt6Ul/YKd8f4rJbosjR
         PUbmAYvqPvMxq4FQRKa/adZj8OVmhuB4bPZBtE21cI49Fd/SOG3MQnjyAV9tT4wq+QAD
         5XWgdcKELlpT/6LbnzlAneAZDPYzFe69GMNHFRySEzOpFhsh9EdUoqY8f2g5igBI5bc1
         eTrFwe+I/N1KKrcEmabXVM/+rPtsUTqXU4L2L+JbFtCR+GGOn7gGKkW1c8lgMqW5uy1+
         wKiia1IKVGurwKb7I9oJeZcOpxq7X2wPIetdMuz0Al/P24oMyH/mSzWZlGZOPDaJcKGX
         WEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L30JOyTUDiG33bs18mptbYSAy0GY7nwlxVrpycnRwm8=;
        b=SuAWwGzaiG3HKzz81Pg//RN5sJgz6UvoMKntv2wlrmctczb7MbxC51Tz4IVNFQgInS
         R+RHam6J11FvPsoDcIA71uzvTjq4PQzyqPer1piuOl5jkwpHmn/nCnpns83Kf620k1YN
         a6eDV0v+HyJnRIq8bcAhrYqGs1h+QpqSphy3dqzHZWaFfL2Qyy4LiIM6g2p7mz13wb/4
         WvpW455G2YiTL9mYRWXSNHy26OOSGae5Qq6Depsf9naZ7fB4fdh6BEsbYrT80LgXXdX+
         jVYcH5cRhP2n/HY0ZhjIaTo50t/dnmTqzvsJw11XUTJ+l20swNlnKqXmUok2/B14+rop
         jClQ==
X-Gm-Message-State: AOAM531T1tPmMxZjNlGlhgKVQJKuyiYlEndmnkbtVZ7rPUjJJdNTB/zF
        2vHVAp96sW7eKZi+zH0hioSTbguTSztqoQ==
X-Google-Smtp-Source: ABdhPJwcQsetEStj9fdj7Iy6bTi3vzR5xq/DugZ21dWUwseh3EVBVnGupGiOpBqalM8Gd0qm1cAgFQ==
X-Received: by 2002:a05:600c:228d:: with SMTP id 13mr4399423wmf.49.1617717648618;
        Tue, 06 Apr 2021 07:00:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h6sm20029696wrr.21.2021.04.06.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:00:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/3] git-send-email: improve --validate error output
Date:   Tue,  6 Apr 2021 16:00:37 +0200
Message-Id: <patch-3.4-8a67afd3404-20210406T135716Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-0.4-00000000000-20210406T135715Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com> <cover-0.4-00000000000-20210406T135715Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the output we emit on --validate error to:

 * Say "FILE:LINE" instead of "FILE: LINE", to match "grep -n",
   compiler error messages etc.

 * Don't say "patch contains a" after just mentioning the filename,
   just leave it at "FILE:LINE: is longer than[...]. The "contains a"
   sounded like we were talking about the file in general, when we're
   actually checking it line-by-line.

 * Don't just say "rejected by sendemail-validate hook", but combine
   that with the system_or_msg() output to say what exit code the hook
   died with.

I had an aborted attempt to make the line length checker note all
lines that were longer than the limit. I didn't think that was worth
the effort, but I've left in the testing change to check that we die
as soon as we spot the first long line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl   | 12 ++++++------
 t/t9001-send-email.sh | 17 ++++++++++++-----
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2dd48621759..175da07d946 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -219,8 +219,8 @@ sub system_or_msg {
 	my $exit_code = $? >> 8;
 	return unless $signalled or $exit_code;
 
-	return sprintf(__("failed to run command %s, died with code %d"),
-		       "@$args", $exit_code);
+	return sprintf(__("fatal: command '%s' died with exit code %d"),
+		       $args->[0], $exit_code);
 }
 
 sub system_or_die {
@@ -1964,7 +1964,8 @@ sub validate_patch {
 		}
 		if ($hook_error) {
 			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
-				       "warning: no patches were sent\n"), $fn);
+				       "%s\n" .
+				       "warning: no patches were sent\n"), $fn, $hook_error);
 		}
 	}
 
@@ -1975,9 +1976,8 @@ sub validate_patch {
 			or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 		while (my $line = <$fh>) {
 			if (length($line) > 998) {
-				die sprintf(__("fatal: %s: %d: patch contains a line longer than 998 characters\n" .
-					       "warning: no patches were sent\n"),
-					    $fn, $.);
+				die sprintf(__("fatal: %s:%d is longer than 998 characters\n" .
+					       "warning: no patches were sent\n"), $fn, $.);
 			}
 		}
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 74225e3dc7a..65b30353719 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -415,7 +415,11 @@ test_expect_success $PREREQ 'reject long lines' '
 	z512=$z64$z64$z64$z64$z64$z64$z64$z64 &&
 	clean_fake_sendmail &&
 	cp $patches longline.patch &&
-	echo $z512$z512 >>longline.patch &&
+	cat >>longline.patch <<-EOF &&
+	$z512$z512
+	not a long line
+	$z512$z512
+	EOF
 	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
@@ -424,7 +428,7 @@ test_expect_success $PREREQ 'reject long lines' '
 		$patches longline.patch \
 		2>actual &&
 	cat >expect <<-\EOF &&
-	fatal: longline.patch: 35: patch contains a line longer than 998 characters
+	fatal: longline.patch:35 is longer than 998 characters
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
@@ -533,15 +537,17 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 		--validate \
 		longline.patch 2>actual &&
 	test_path_is_file my-hooks.ran &&
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
+	fatal: command '"'"'$(pwd)/my-hooks/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
-	test_config core.hooksPath "$(pwd)/my-hooks" &&
+	hooks_path="$(pwd)/my-hooks" &&
+	test_config core.hooksPath "$hooks_path" &&
 	test_when_finished "rm my-hooks.ran" &&
 	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
@@ -550,8 +556,9 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 		--validate \
 		longline.patch 2>actual &&
 	test_path_is_file my-hooks.ran &&
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
+	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
-- 
2.31.1.527.g9b8f7de2547

