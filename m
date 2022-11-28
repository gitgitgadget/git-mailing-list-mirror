Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C3C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiK1OTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiK1OTB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:19:01 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE77E17
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:18:58 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ho10so26200957ejc.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eefsvac+24WybhDYjdTQaOoeGLlmtlKg82+f6Zs/ruE=;
        b=jRUPxk9/thMSr/bDNxLZatTPs5XG6y0aWRww5txxAny2vmIT91Dg3xt+BX1LM0x8ea
         xRL89oIZqLhNFV0I23sQTJ1oMhPr2rViPQnofkMcJ1lgtpZLHkmFCA2TQrErX0p3GcYd
         gYNhnfuj83aUHN9KCGKqUFq6TsNv12zSjZiXUh98h6YYrHEzhlI9m28f+kIf4tDTjm71
         VJHqreSx5vKddQ88+BL3KcZWYuwLolJ8sJpCzVgyugEQVkFseuMUf14/SV7qWtGtMkIb
         2mcXdaTKXjipD630d3XU7SHM28qF4YfEm1KVVU5a72Xqif9Mhw1DVW6e9T654kWavGVs
         G8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eefsvac+24WybhDYjdTQaOoeGLlmtlKg82+f6Zs/ruE=;
        b=QJ8DAhOEFIjD83zwa2NZI4hgXmZVpfvqE7UBLnZBCyUkIZ6NXZob/+v9zmEkqS0oSR
         YX0Of969mnwT+rVSXN1rK1mrOXBHEGTpgraLs2VMKLzc8aDQ22C25OK9lFKM7dXPHbxr
         FDFGy7o8bDd5pIKq0K6WOOUDrZtoqMiU877tnG+mO1f9vTsi6jQlNCrKb7jUe7OLfxA9
         dU9vRSUK9MruqgWWXjo9QCpRYeJSJQiT5vkQ4kfdWyap0+uThr3oJjv81oCdjSGaBwSG
         x/q6sbCH5iYEesr8oik4wUrzz3y7dcP+G5qn4YIlq7drn1YTe86a1mSlivRV1sPo4vDJ
         rRyQ==
X-Gm-Message-State: ANoB5pnM+u8CbFwfadBBXaeFihLwzdrt7Kfe9yiB5BB+RQ7GYyWmaf3l
        lFyt4oUYvb34v2sPasrwt/7iztyj0eLZMw==
X-Google-Smtp-Source: AA0mqf6gEdoGvkF9a2B0D9fx4FAv2/fM5adscpvyyaOrHU12Uoc/ktIhQYPwgeBGPHlrZUbU7N4FLA==
X-Received: by 2002:a17:906:6dd5:b0:78d:a633:b55 with SMTP id j21-20020a1709066dd500b0078da6330b55mr45363431ejt.106.1669645136993;
        Mon, 28 Nov 2022 06:18:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id oy7-20020a170907104700b007ad69e9d34dsm5098561ejb.54.2022.11.28.06.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 06:18:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] t5314: check exit code of "git"
Date:   Mon, 28 Nov 2022 15:18:55 +0100
Message-Id: <patch-v2-1.1-ca77a7249e6-20221128T141818Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.962.g4ca4168c9ac
In-Reply-To: <patch-1.1-45b240740eb-20221128T115740Z-avarab@gmail.com>
References: <patch-1.1-45b240740eb-20221128T115740Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the test added in [1] to check the exit code of the "git"
invocations. An in-flight change[2] introduced a memory leak in these
invocations, which went undetected unless we were running under
"GIT_TEST_SANITIZE_LEAK_LOG=true".

Note that the in-flight change made 8 test files fail, but as far as I
can tell only this one would have had its exit code hidden unless
under "GIT_TEST_SANITIZE_LEAK_LOG=true". The rest would be caught
without it.

We could pick other variable names here than "ln%d", e.g. "commit",
"dummy_blob" and "file_blob", but having the "rev-parse" invocations
aligned makes the difference between them more readable, so let's pick
"ln%d".

1. 4cf2143e029 (pack-objects: break delta cycles before delta-search
   phase, 2016-08-11)
2. https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/
3. faececa53f9 (test-lib: have the "check" mode for SANITIZE=leak
   consider leak logs, 2022-07-28)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Range-diff against v1:
1:  45b240740eb ! 1:  ca77a7249e6 t5314: check exit code of "rev-parse"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    t5314: check exit code of "rev-parse"
    +    t5314: check exit code of "git"
     
    -    Amend the test added in [1] to check the exit code of the "rev-parse"
    +    Amend the test added in [1] to check the exit code of the "git"
         invocations. An in-flight change[2] introduced a memory leak in these
         invocations, which went undetected unless we were running under
         "GIT_TEST_SANITIZE_LEAK_LOG=true".
    @@ Commit message
         under "GIT_TEST_SANITIZE_LEAK_LOG=true". The rest would be caught
         without it.
     
    +    We could pick other variable names here than "ln%d", e.g. "commit",
    +    "dummy_blob" and "file_blob", but having the "rev-parse" invocations
    +    aligned makes the difference between them more readable, so let's pick
    +    "ln%d".
    +
         1. 4cf2143e029 (pack-objects: break delta cycles before delta-search
            phase, 2016-08-11)
         2. https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/
    @@ t/t5314-pack-cycle-detection.sh: TEST_PASSES_SANITIZE_LEAK=true
     -	} |
     -	git pack-objects --stdout |
     -	git index-pack --stdin --fix-thin
    -+	grp1=$(git rev-parse "$2") &&
    -+	grp2=$(git rev-parse "$1:dummy") &&
    -+	grp3=$(git rev-parse "$1:file") &&
    ++	ln1=$(git rev-parse "$2") &&
    ++	ln2=$(git rev-parse "$1:dummy") &&
    ++	ln3=$(git rev-parse "$1:file") &&
     +	cat >list <<-EOF
    -+	-$grp1
    -+	$grp2 dummy
    -+	$grp3 file
    ++	-$ln1
    ++	$ln2 dummy
    ++	$ln3 file
     +	EOF
     +	git pack-objects --stdout <list >pack &&
     +	git index-pack --stdin --fix-thin <pack

 t/t5314-pack-cycle-detection.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t5314-pack-cycle-detection.sh b/t/t5314-pack-cycle-detection.sh
index 73a241743aa..82734b9a3c4 100755
--- a/t/t5314-pack-cycle-detection.sh
+++ b/t/t5314-pack-cycle-detection.sh
@@ -63,13 +63,16 @@ TEST_PASSES_SANITIZE_LEAK=true
 # Note that the two variants of "file" must be similar enough to convince git
 # to create the delta.
 make_pack () {
-	{
-		printf '%s\n' "-$(git rev-parse $2)"
-		printf '%s dummy\n' "$(git rev-parse $1:dummy)"
-		printf '%s file\n' "$(git rev-parse $1:file)"
-	} |
-	git pack-objects --stdout |
-	git index-pack --stdin --fix-thin
+	ln1=$(git rev-parse "$2") &&
+	ln2=$(git rev-parse "$1:dummy") &&
+	ln3=$(git rev-parse "$1:file") &&
+	cat >list <<-EOF
+	-$ln1
+	$ln2 dummy
+	$ln3 file
+	EOF
+	git pack-objects --stdout <list >pack &&
+	git index-pack --stdin --fix-thin <pack
 }
 
 test_expect_success 'setup' '
-- 
2.39.0.rc0.962.g4ca4168c9ac

