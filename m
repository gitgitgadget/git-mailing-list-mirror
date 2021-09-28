Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26272C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1281F61131
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbhI1NQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbhI1NQY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE54C061604
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a131so3474303wmd.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ywvtN6dkRVDSG7f9k+PKUlwxClMBGIgk0+5HPeBmoEs=;
        b=SdS8bvfAkCkQaJ7JWsX3LiY44WGH2qD59EvBz7sKh3QIF/WmSpBxlMmTaUmPgoIfnO
         KWR1bu8VTE5zFeFmlGQSeEiBGxzPrkfSOSQ0fhtyOvCSlREz4VOJqsRpSeyTtytGzPic
         lgfI9hebhEsyfALy4OF7XE/Y49w8YfoBiIRfjJo12opIICZmMpE9hLq6mb+/3747wqNd
         g7bC/fPYuro88EGlLmdaaGjHxLgFt6AN/c6hGF1bFGn+Sx5aublzcYNugaCTIBQDaiiz
         Y8x0KfZr2jSQ953zORJKimN6aNCfLc+n60jL1rVVlZXH8/dB62v1gu3jCLFjlb9ypOWf
         84Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywvtN6dkRVDSG7f9k+PKUlwxClMBGIgk0+5HPeBmoEs=;
        b=DoQ9hyR/FNVz+K2V+LgSIA366R6ZfelI4YdteFxBFyGBAuoIF/8+chluOyLSyObucE
         cw87dnatTBbtlueSwZK1qO4uR9bCbe+Rl/LfjUZ1MDKd+GFKWraJW7wybodx9TfqOorB
         zM/UG0TaVpd+YKGaOucg5sl6pcRSsX9T+E8Lwge2LnXFQayxQqdJfz49EpiFc7JrudZz
         SqN1eEua2DwBECovKXh2fc5TLfo+zO9wo6bUsjK6YNpKFIPNbG/TkzZlAwR4jN5OGkhV
         fP+54NUd+pk6fjZSVJ9BqUUO7b7amyZn/LzPtUFy999udNsMFRCHI0CLHqJ+6v9RghBH
         ycIg==
X-Gm-Message-State: AOAM533kA7rf+N/P4Bku/ehkmrB0iXxsBtnsHoJvphMQxnnh6fG+pjMn
        tbcTe+5aNeq/K2ri5D929j5TlldJbqUwfw==
X-Google-Smtp-Source: ABdhPJzln4/QQApJRLHMVE2dg+y5dG2SZmhPlH7WHM6ydb5Nt+4T5mr2gWidsc/IaK+KrnxKHKeQgQ==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr4653704wmi.125.1632834883604;
        Tue, 28 Sep 2021 06:14:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm2617981wmh.31.2021.09.28.06.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:14:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/10] parse-options tests: test optname() output
Date:   Tue, 28 Sep 2021 15:14:30 +0200
Message-Id: <patch-09.10-ce508fddc8f-20210928T130905Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1339.g53eae12fb46
In-Reply-To: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were no tests for checking the specific output that we'll
generate in optname(), let's add some. That output was added back in
4a59fd13122 (Add a simple option parser., 2007-10-15).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0040-parse-options.sh | 42 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index da310ed29b1..d6f391a497b 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -168,9 +168,45 @@ test_expect_success 'long options' '
 '
 
 test_expect_success 'missing required value' '
-	test_expect_code 129 test-tool parse-options -s &&
-	test_expect_code 129 test-tool parse-options --string &&
-	test_expect_code 129 test-tool parse-options --file
+	cat >expect <<-\EOF &&
+	error: switch `s'\'' requires a value
+	EOF
+	test_expect_code 129 test-tool parse-options -s 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	error: option `string'\'' requires a value
+	EOF
+	test_expect_code 129 test-tool parse-options --string 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	error: option `file'\'' requires a value
+	EOF
+	test_expect_code 129 test-tool parse-options --file 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'superfluous value provided: boolean' '
+	cat >expect <<-\EOF &&
+	error: option `yes'\'' takes no value
+	EOF
+	test_expect_code 129 test-tool parse-options --yes=hi 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	error: option `no-yes'\'' takes no value
+	EOF
+	test_expect_code 129 test-tool parse-options --no-yes=hi 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'superfluous value provided: cmdmode' '
+	cat >expect <<-\EOF &&
+	error: option `mode1'\'' takes no value
+	EOF
+	test_expect_code 129 test-tool parse-options --mode1=hi 2>actual &&
+	test_cmp expect actual
 '
 
 cat >expect <<\EOF
-- 
2.33.0.1340.ge9f77250f2b

