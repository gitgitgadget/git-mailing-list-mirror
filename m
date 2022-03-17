Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F859C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiCQKOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiCQKOo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D71D557C
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x15so6588514wru.13
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLX7KARbDl6Nh19boPl5uDSo/mBMRv59GdpISpzN0is=;
        b=XVR/+mAdMGtCV0m4OP+gguvqODZKN172DE1prEfm77qg5Le/QEqWsCRoqojOwzPBDx
         AjI1IQAfM0WfktG5RtXFi7QfQi/b7R1HLhGVxi42n3mWlykO+qLGHcYJZEjWQFDWXE8y
         ckWZcmdCxjRLZykEeoclSXLMOVnTLWZ5BbEyk9N//NSg/s+u+0NH2SW019nHFmQnCgtW
         LK8PBlY60tnVAQmosam67TBDfCiuOyUeuSD4vsVJSQsagOdkS2TPo0O4yjyzw4dxFGq7
         lUWTCyn8v/EuEenciZ1WiH9jzG0GjyNgoJMXmlxwjOZ3FNGsDlFNg/Q/8haFwwc/x8k2
         8zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLX7KARbDl6Nh19boPl5uDSo/mBMRv59GdpISpzN0is=;
        b=HsH7E5cYDg7pXjMfBgT8zXYPgqE5c6EBbdr6Z6thnwcc9NCyrsmtx3v5l/leZfdB1t
         B/616zamSgQqizMjVzKcxT+MXKAf0IszJQgUU4OBlbZRFU+CZpEIcrbNnEqsq1Pj4Vve
         mj8LNRbf41GAdYTxnPmo8LpZ4vwOcGdaUyqxDTHDFxUSbCa5PJ4QbLMGU8RSosK+bd67
         1YTWu2gaqyjgQh1K/tUVcweHptyvRuWaCoFwQN0GwuSvscvXoNK0Tzv7dy/PzP58FMDI
         7Q28rdKDylppqax6V7nd9alVdexeVqEbpb/AxGWEjAWYTXmTcVtTWuPSh1aqo8Z1AtIR
         zyzQ==
X-Gm-Message-State: AOAM53036BfV4Jbc7uUAgBYDyyxCGAYFOL+yhurOUYyiMti+CWVA8nuS
        dKenrbWNlTUzfTl+zIDB+IYi4UmaqSU=
X-Google-Smtp-Source: ABdhPJxfCWzEqhZsLDDGmFf3YYbSRPD57EyMyk4EcNrLTxdT5r5o7YnxX9fEcXRlcIpzvaH48MoDCg==
X-Received: by 2002:adf:f606:0:b0:203:8dff:f4ac with SMTP id t6-20020adff606000000b002038dfff4acmr3326449wrp.12.1647512005222;
        Thu, 17 Mar 2022 03:13:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/13] hook tests: turn exit code assertions into a loop
Date:   Thu, 17 Mar 2022 11:13:07 +0100
Message-Id: <patch-v3-02.13-aa4ee4da289-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a test added in 96e7225b310 (hook: add 'run' subcommand,
2021-12-22) to use a for-loop instead of a copy/pasting the same test
for the four exit codes we test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1800-hook.sh | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 93540b1fa12..26ed5e11bc8 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -53,31 +53,16 @@ test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
 	test_must_be_empty stdout.actual
 '
 
-test_expect_success 'git hook run: exit codes are passed along' '
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 1
-	EOF
-
-	test_expect_code 1 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 2
-	EOF
-
-	test_expect_code 2 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 128
-	EOF
-
-	test_expect_code 128 git hook run test-hook &&
-
-	write_script .git/hooks/test-hook <<-EOF &&
-	exit 129
-	EOF
-
-	test_expect_code 129 git hook run test-hook
-'
+for code in 1 2 128 129
+do
+	test_expect_success "git hook run: exit code $code is passed along" '
+		test_hook test-hook <<-EOF &&
+		exit $code
+		EOF
+
+		test_expect_code $code git hook run test-hook
+	'
+done
 
 test_expect_success 'git hook run arg u ments without -- is not allowed' '
 	test_expect_code 129 git hook run test-hook arg u ments
-- 
2.35.1.1384.g7d2906948a1

