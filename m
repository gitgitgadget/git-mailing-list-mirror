Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BB6C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbiBPAB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:01:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244916AbiBPABY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:01:24 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B80CA70D
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:10 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so623624wrg.11
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+c6XKXP1CBZPfxKHkPCsEzanZuL8obpYAOgdcHXjuxw=;
        b=iSDibtZD7nzrd/EawWRcOJHZhvMl9392ncvYcKph4Ia8otvweDZFN8MhoyN0rCnXyb
         /vxGcMNi4fjupD/rc1ZL1oKU4xqu87ljLbme6z0rCqhNik9rsBCqWbd3GOHAlLIap6oX
         3MjGLVua8oYKAUHSSRRivODbyAsiTXfp0PY2A+ta47yMxhlxzzBoYdYq8K6B6wFKaiQN
         12D6pejGHZ0hcLrUMJfXStj5AxugGQHXHa2f6lwkvfHtXj6OE2MkWEpQp5tqdlKarsOf
         wUhzvFa6CT5F0/15EcgSlaJNnU+MWEVENZIZmOOv3WD4KU/h78j8XUACa0L++xnDma3n
         N6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+c6XKXP1CBZPfxKHkPCsEzanZuL8obpYAOgdcHXjuxw=;
        b=cMdzo6nnTm6ewmIv3Cjidc0hRsjkDFyOP0HVeMleEwE98fmY2of0JchiX/6DfaWdh1
         GRbBBtUtOU+cjA0BeD0UHoyG3+5mkgSGql3ekxo/DW8xch8CY5nAoYrkTVWpUuXisl3l
         gVgdMbpoC6YFAdaT2pdIj0VdurkYPXBQaEoXmTU88a6ACrx4SfCfIbiVXfrCFNJ4YcxJ
         FQZIPb8Jb7zeszWL/ZNoslScCdQmk1TbZBToeGeoSW4hjIPYKpI/vFY+qatt9InOZEeV
         Sx7X87T2n3J2qhT1kpuInpSSlqXhUvl66Z8/1mk4SzGoVefFOAnE5rFKUz/7Ooq8hn26
         VXPw==
X-Gm-Message-State: AOAM530O4KIvKzIptZBMqQ1aXGwrZLOdFJuiYd7rXI0F4UYikmKbAQR3
        alE3QgZ2tCPkueyBm2/f5YRn/mI8/2dlLQ==
X-Google-Smtp-Source: ABdhPJzvtZGL3B71JkiB+V0/tf0Cne6Z2F13oVfVvaUxIXfe/g8IGwIMMPhftH8KZKUoYdStlz4gPg==
X-Received: by 2002:adf:f70c:0:b0:1e3:133d:615b with SMTP id r12-20020adff70c000000b001e3133d615bmr247715wrp.33.1644969668831;
        Tue, 15 Feb 2022 16:01:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a12sm17260542wru.99.2022.02.15.16.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:01:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 02/10] log tests: check if grep_config() is called by "log"-like cmds
Date:   Wed, 16 Feb 2022 01:00:31 +0100
Message-Id: <patch-v11-02.10-b275d23f0a8-20220216T000006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g9479bb34b83
In-Reply-To: <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
References: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com> <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests added in my 9df46763ef1 (log: add exhaustive tests
for pattern style options & config, 2017-05-20) to check not only
whether "git log" handles "grep.patternType", but also "git show"
etc.

It's sufficient to check whether we match a "fixed" or a "basic" regex
here to see if these codepaths correctly invoked grep_config(). We
don't need to check the details of their regular expression matching
as the "log" test does.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index dc884107de4..5c4385c745b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -449,6 +449,30 @@ test_expect_success !FAIL_PREREQS 'log with various grep.patternType configurati
 	)
 '
 
+for cmd in show whatchanged reflog format-patch
+do
+	case "$cmd" in
+	format-patch) myarg="HEAD~.." ;;
+	*) myarg= ;;
+	esac
+
+	test_expect_success "$cmd: understands grep.patternType, like 'log'" '
+		git init "pattern-type-$cmd" &&
+		(
+			cd "pattern-type-$cmd" &&
+			test_commit 1 file A &&
+			test_commit "(1|2)" file B 2 &&
+
+			git -c grep.patternType=fixed $cmd --grep="..." $myarg >actual &&
+			test_must_be_empty actual &&
+
+			git -c grep.patternType=basic $cmd --grep="..." $myarg >actual &&
+			test_file_not_empty actual
+		)
+	'
+done
+test_done
+
 test_expect_success 'log --author' '
 	cat >expect <<-\EOF &&
 	Author: <BOLD;RED>A U<RESET> Thor <author@example.com>
-- 
2.35.1.1028.g9479bb34b83

