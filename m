Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579E5C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiKDN0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiKDNZn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0252F393
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:24:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q9so13369366ejd.0
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0inKvNSu7oEulSnLOZrmB64qFmoj4b/1adWmaCU06A=;
        b=RK3hcex+AVIzOiyGR3W+CVqPc14SVUJBaWi2AhS8VEhoUNjKdKjMhEiJTfQXrK6Qg/
         RtBb213DyOx0Nyjjapc8y/TPtwNnQjQeHsFW4NOiOcseAfKJ7Bh8V0ubbM3QfK2j67ZC
         HCusNsIdQN48Ud9PXcz44vNzlMVPg5MtMQfY0iuhlEHgwaVIoFQjJTmDT1BUPGgIs9X2
         ImOLKUI3l3raqFvZDhVoXexa92BWve4kRQw9dX1bxftQyHIgFJeLn6LOp/wYMvUVrUZj
         5/tsf9A6DE7zeS3KV71Lc0leCsmuSeTV2NZysLYJ5rMZEyvNOi6+xF5UcmxmTWeEYMMt
         TxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0inKvNSu7oEulSnLOZrmB64qFmoj4b/1adWmaCU06A=;
        b=ugM0ATyArIwHSG78IgNaMVzEp1piOPh/BhOxvadqT3MERR9C4SxHNrOic7MNVM9UwQ
         kRYu6xoP7Pt3Y+wmOwQ56nlJM90hG5h4hnMztEITe5ysrPFtDZxbHwFobbcPCl8P7+bo
         NhbvC0jKAuwiKQrYkEmjjbNCBz5ec+EaXQ1ohXccTXNVHXshcobEi6qNWV7825m83uEm
         12g8yqMqr/1lRIeE/bJfP/ex2A60BbI5ipzvwTkHAJw6JDhNbavIgGwx/x8Snqcj61T6
         1FgUmvfLFPJ1jfyHuJemEEcgn72E8tDCVHHhzTkvwcvaL/Z68eORfaGeynznp5Auey/+
         h1rg==
X-Gm-Message-State: ACrzQf1usQtY16LJjtkIHzfm396ikIeXvqmn/pMaYQqFdWnqo2Ag6Us1
        I/vQIiEBYMNSiKtjBe4AwGt/NkI09xgGsA==
X-Google-Smtp-Source: AMsMyM755A0V16jItWlKTecJYy9hCCgfAeb9r/WdRixFeqgfm0uyg0Y1Tgz7DUqSAibo6GUmSOZCLg==
X-Received: by 2002:a17:907:969e:b0:7a6:fe3:6f11 with SMTP id hd30-20020a170907969e00b007a60fe36f11mr34951976ejc.501.1667568293611;
        Fri, 04 Nov 2022 06:24:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:24:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/13] bisect tests: test for v2.30.0 "bisect run" regressions
Date:   Fri,  4 Nov 2022 14:22:38 +0100
Message-Id: <patch-01.13-beb1ea22a27-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add three failing tests which succeed on v2.29.0, but due to the topic
merged at [1] (specifically [2]) have been failing since then. We'll
address those regressions in subsequent commits.

There was also a "regression" where:

	git bisect run ./missing-script.sh

Would count a non-existing script as "good", as the shell would exit
with 127. That edge case is a bit too insane to preserve, so let's not
add it to these regression tests.

1. 0a4cb1f1f2f (Merge branch 'mr/bisect-in-c-4', 2021-09-23)
2. d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell
   function in C, 2021-09-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 79 +++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 83931d482fb..478e74e1f0f 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -252,6 +252,85 @@ test_expect_success 'bisect skip: with commit both bad and skipped' '
 	grep $HASH4 my_bisect_log.txt
 '
 
+test_bisect_run_args () {
+	test_when_finished "rm -f run.sh actual" &&
+	>actual &&
+	cat >expect.args &&
+	cat <&6 >expect.out &&
+	cat <&7 >expect.err &&
+	write_script run.sh <<-\EOF &&
+	while test $# != 0
+	do
+		echo "<$1>" &&
+		shift
+	done >actual.args
+	EOF
+
+	test_when_finished "git bisect reset" &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run ./run.sh $@ >actual.out.raw 2>actual.err &&
+	# Prune just the log output
+	sed -n \
+		-e '/^Author:/d' \
+		-e '/^Date:/d' \
+		-e '/^$/d' \
+		-e '/^commit /d' \
+ 		-e '/^ /d' \
+		-e 'p' \
+		<actual.out.raw >actual.out &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err &&
+	test_cmp expect.args actual.args
+}
+
+test_expect_failure 'git bisect run: args, stdout and stderr with no arguments' '
+	test_bisect_run_args <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
+	EOF_ARGS
+	running ./run.sh
+	$HASH4 is the first bad commit
+	bisect run success
+	EOF_OUT
+	EOF_ERR
+'
+
+test_expect_failure 'git bisect run: args, stdout and stderr: "--" argument' '
+	test_bisect_run_args -- <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
+	<-->
+	EOF_ARGS
+	running ./run.sh --
+	$HASH4 is the first bad commit
+	bisect run success
+	EOF_OUT
+	EOF_ERR
+'
+
+test_expect_failure 'git bisect run: args, stdout and stderr: "--log foo --no-log bar" arguments' '
+	test_bisect_run_args --log foo --no-log bar <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
+	<--log>
+	<foo>
+	<--no-log>
+	<bar>
+	EOF_ARGS
+	running ./run.sh --log foo --no-log bar
+	$HASH4 is the first bad commit
+	bisect run success
+	EOF_OUT
+	EOF_ERR
+'
+
+test_expect_failure 'git bisect run: args, stdout and stderr: "--bisect-start" argument' '
+	test_bisect_run_args --bisect-start <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
+	<--bisect-start>
+	EOF_ARGS
+	running ./run.sh --bisect-start
+	$HASH4 is the first bad commit
+	bisect run success
+	EOF_OUT
+	EOF_ERR
+'
+
 # We want to automatically find the commit that
 # added "Another" into hello.
 test_expect_success '"git bisect run" simple case' '
-- 
2.38.0.1452.g710f45c7951

