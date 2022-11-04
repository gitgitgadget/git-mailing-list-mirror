Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7F9C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiKDN0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiKDNZq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE62F3A1
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:24:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y14so13205155ejd.9
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTmtDciAdxFXUf6tSNOzL8gvFNXZQjh9AhRtCQI5YwQ=;
        b=iN3KGQVAdHP610yw+s3rtGaRL7rqeRSm5gZCfpqQumP1LFMZF6grvraOFmzE+8Pkke
         lCwgW+oPlDfyS4VwaAz8T/sEBzDYnA8ega+4TWtAqPYYMP7S4sxStOYf5cC7bFmGnOTb
         kD/Y/YZwRWOF+i2+ZJ27etBWoRaPI7T70xJVbQrdbNBMtkCybh8VxPEiK0FMPKe+1lxn
         9i8K6MGS+gZBWX8UwXedjL8gyI4MTwHpRv/Hug/v64dUE4ecYxDR1JOvORSSFRxBz0mK
         qkLoO/NhQSqAx3af3zfdL1zp47orOrdELnNjjWY28mD6jxHfTw6uY32iZ/f0N3Y1GtmL
         4hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTmtDciAdxFXUf6tSNOzL8gvFNXZQjh9AhRtCQI5YwQ=;
        b=ssSWXbBCVAhfXoz2TJKiCx5H0L7VwIDWUL140rr7+d019g9E8bT8z+I4u9Bg+m4clw
         BKVk0wPvbox/cod3eB6GmYiCaVJa+nbWnREM2akuS0deBYRTnL1qJgIg6+9861aqFYPn
         DdutePy3W3kjZP44HFW6YBAo1i8KZSI59R8AUmQMJmJbo34p22O5l+e8Y0IrvX74NXAr
         f1RcFmb+Y4HbgaW5L9FHqLitD7/2CPPusOXcXdNZvCBcM0ISN5XO2Mg+SKZjXnbZKGZG
         2N+KPCt7ujV2dCRL+5w8uAfIasuYbcgETzyXu/NQT+qYSsXaF1WAq2K3bzYaHO0rKQFo
         vWFQ==
X-Gm-Message-State: ACrzQf2usjKpYo0aFX0fGQhHNHENg7mAlO7fmXCNecKX61fFXMv26T7A
        wBxu2Oe5/pXxZ/a7EyuOMcLWm6/fElALPQ==
X-Google-Smtp-Source: AMsMyM7WQiIxLquUdweWSgx6WaU4hpNjCq9YUB6kyNddyiLDCthE0WUIjxcrSuI1MucSRaOh6n+vfw==
X-Received: by 2002:a17:906:eeca:b0:730:6880:c398 with SMTP id wu10-20020a170906eeca00b007306880c398mr34915756ejb.706.1667568297579;
        Fri, 04 Nov 2022 06:24:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:24:56 -0700 (PDT)
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
Subject: [PATCH 05/13] bisect run: keep some of the post-v2.30.0 output
Date:   Fri,  4 Nov 2022 14:22:42 +0100
Message-Id: <patch-05.13-30626dd507a-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Preceding commits fixed output and behavior regressions in
d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
in C, 2021-09-13), which did not claim to be changing the output of
"git bisect run".

But some of the output it emitted was subjectively better, so once
we've asserted that we're back on v2.29.0 behavior, let's change some
of it back:

- We now quote the arguments again, but omit the first " " when
  printing the "running" line.
- Ditto for other cases where we emitted the argument
- We say "found first bad commit" again, not just "run success"

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c    |  6 +++---
 t/t6030-bisect-porcelain.sh | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index eb66ad491cd..5c0572d0672 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1192,8 +1192,8 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 	sq_quote_argv(&command, argv);
 	strvec_push(&run_args, command.buf);
-	strbuf_reset(&command);
-	strbuf_join_argv(&command, argc, argv, ' ');
+	/* Quoted, but skip initial " " */
+	strbuf_ltrim(&command);
 
 	while (1) {
 		printf(_("running %s\n"), command.buf);
@@ -1262,7 +1262,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			puts(_("bisect run success"));
 			res = BISECT_OK;
 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
-			puts(_("bisect run success"));
+			puts(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'bisect-state"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index dc83034f036..69fad3f94f6 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -288,9 +288,9 @@ test_bisect_run_args () {
 test_expect_success 'git bisect run: args, stdout and stderr with no arguments' '
 	test_bisect_run_args <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	EOF_ARGS
-	running ./run.sh
+	running '\''./run.sh'\''
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 '
@@ -299,9 +299,9 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--" argument' '
 	test_bisect_run_args -- <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	<-->
 	EOF_ARGS
-	running ./run.sh --
+	running '\''./run.sh'\'' '\''--'\''
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 '
@@ -313,9 +313,9 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--log foo --no-lo
 	<--no-log>
 	<bar>
 	EOF_ARGS
-	running ./run.sh --log foo --no-log bar
+	running '\''./run.sh'\'' '\''--log'\'' '\''foo'\'' '\''--no-log'\'' '\''bar'\''
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 '
@@ -324,9 +324,9 @@ test_expect_failure 'git bisect run: args, stdout and stderr: "--bisect-start" a
 	test_bisect_run_args --bisect-start <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	<--bisect-start>
 	EOF_ARGS
-	running ./run.sh --bisect-start
+	running '\''./run.sh'\'' '\''--bisect-start'\''
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 '
-- 
2.38.0.1452.g710f45c7951

