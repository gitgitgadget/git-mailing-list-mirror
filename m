Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB9C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF34613D5
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbhDWHab (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbhDWHa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:30:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6CBC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:29:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so43580594wrt.5
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4orDhuCwS1oOUaDMVfR+25mT4d60rEmkyN0ge/lj8I=;
        b=eheWMxko9G8otS1nJIzXz5k3iLwrdl5Pfjr8Tahr5dAPi96wZEK5kchI0lI2Z0WvYV
         DfbUyk1pPvD1K8foVQJ1qXIyRvfcADrDPymsm3JEJFNNJanu7urHUrvHCXJr1cdHXRtq
         eIhS/jiDjfj46GrTqQpf1q6xdCfws7z7F0puv+k/XC3CRxu2nhqEoAl9Af7FztNaOBHY
         vq9uV4XovNWh7+eGDuJnQfCU7xnwGDaKdIhaa+rzp7lIm6eEsdeR8UgrXIVXnyI2xwF/
         FJBFJYL4xDgAgsR6xopHFzFWmol/Xg2rR9UyxxBnnW8+7RTcNMkBDkaZdMphcakqMfJg
         d7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4orDhuCwS1oOUaDMVfR+25mT4d60rEmkyN0ge/lj8I=;
        b=iYBe+dUbwoOk6kXGP9NvjFdhzhvXiC7XwbOASYakyP/1fvmS36ZD3p11EU13FSTDIi
         vUXmX3PPL1ajDHAA4EJ1RrF85rvP4jt7RSssfYp2Q5WAiSNM7H0SDOFbQeITkDsGLDBQ
         QPacOTvsrLB6lnJcPyvGQvcH5wGHCsoHlIhGIyO4qn/BUFD144UqCku4Is9v+yP2OU5/
         Yvd3REc24YcHTxyEGmTCwJS9XeGt4DclKmKrxdjjey8/wPCVjvOT3tAe1YvuoxJRARd/
         LCFMM42AvdJl+ygH5i27UzCdN5VQr0q25rlh98wzksKxZ9Tgsip1YY/w12SXLtuW/I33
         rIXQ==
X-Gm-Message-State: AOAM530GN9VW8UXyHG95MIx//MdBo3XC19M9rJeFAeIuN/MV1W0o95A6
        d0ONl3rUprTiD8MiAbLGq+AX++JD04hBiA==
X-Google-Smtp-Source: ABdhPJykxqXdIhTwPpCfJAVBXsyaVVG/YeWEXjBLmj+CLvXO9U/ydgs3/jBa2Jrt2vRTL+dRq6SEFw==
X-Received: by 2002:adf:fa49:: with SMTP id y9mr2817920wrr.229.1619162991190;
        Fri, 23 Apr 2021 00:29:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r19sm8681648wmq.33.2021.04.23.00.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:29:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/4] test-helpers: rename "path-utils is_valid_path" to "is-valid-paths"
Date:   Fri, 23 Apr 2021 09:29:45 +0200
Message-Id: <patch-3.4-bf35091a112-20210423T072824Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.734.gdef39492517
In-Reply-To: <cover-0.4-00000000000-20210423T072824Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com> <cover-0.4-00000000000-20210423T072824Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename this utility added in d2c84dad1c8 (mingw: refuse to access
paths with trailing spaces or periods, 2019-09-05) to make it clear
that it expects N number of arguments, and for consistency with
dc2d9ba3187 (is_{hfs,ntfs}_dotgitmodules: add tests, 2018-05-12).

Let's also make it a dashed "is-valid-paths" instead of
"is_valid_path*" to make it easier to grep the helper v.s. the C
function it calls.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-path-utils.c | 2 +-
 t/t0060-path-utils.sh      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 313a153209c..eed3068ffb7 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -454,7 +454,7 @@ int cmd__path_utils(int argc, const char **argv)
 	if (argc > 1 && !strcmp(argv[1], "protect_ntfs_hfs"))
 		return !!protect_ntfs_hfs_benchmark(argc - 1, argv + 1);
 
-	if (argc > 1 && !strcmp(argv[1], "is_valid_path")) {
+	if (argc > 1 && !strcmp(argv[1], "is-valid-paths")) {
 		int res = 0, expect = 1, i;
 
 		for (i = 2; i < argc; i++)
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 0ff06b5d1b3..e7fb748b19c 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -469,7 +469,7 @@ test_expect_success 'match .gitmodules' '
 '
 
 test_expect_success MINGW 'is_valid_path() on Windows' '
-	test-tool path-utils is_valid_path \
+	test-tool path-utils is-valid-paths \
 		win32 \
 		"win32 x" \
 		../hello.txt \
-- 
2.31.1.734.gdef39492517

