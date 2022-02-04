Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B41C433FE
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241882AbiBDVVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241259AbiBDVU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:20:58 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA1C06173E
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 13:20:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso4509483wms.2
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 13:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/hEoLuFM7vuTVAeVe9AYxZvcfR1hBYsPwmrcpJ8trw=;
        b=FjVkCD5WK5u5c+9UjTAgJbo2SZJ0/Lhe0dC1Xb14fkFXVV4isVxlScmTVN7LLV4lID
         EL03WRKs/g1tUH3Zl5s1AEovt3r+kIKNHRU6lrM0FuRFdaNbp/Z6dyTfRPGlUVez21sK
         tNRIzTcxK0AT2LTduQZL9pr23NomD51RVQXUeFRD3TNHjWQkQ26nPQCqjYzer7Q5Mpmx
         y3xZ3lSlc0Mj4874hZGTwfgUio+EEz84A4bpnQ4AbFapSDH9H3NNbMh6BnTVeoEVP5tQ
         jRVikNBT8HlmdfVWxAyM+0ccqAFYWcxj+ujvMqXu6BhdCcEMqyX6CpAa7r1yD/gv95Hq
         D+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/hEoLuFM7vuTVAeVe9AYxZvcfR1hBYsPwmrcpJ8trw=;
        b=HJnMUkSZMuAJua2JCjVWPCc6VPgUH4DR6LmBcxJ5x/3jFgi5DcYpVGErnMjvlzB/uI
         tQpgcJWOMpr70fgRYEAfcpJ73yKe849pbkuPBYWwvP44GW1wrDsgWVcp7qTaN7Ok8TaY
         AiEYhM9eNS8fxeB5nNkiKvakgrp7YHnZQZIPhNuGilqeYZJ5aGcAqvf5chzQUfRus1Pc
         NjQnZF1Xuw0Bh3ax+/Bn7pwx3vyvVmLfG3hiNsJyouVRtFEw37JegvbxCQe+dhfvTGks
         +WCaCp0X+Sh9mP8wdYpc/FGR/yqBr9dTiQ6r5j1x3+Da4w+CBxUaUSRLd3/gVk1T6jum
         Qp+w==
X-Gm-Message-State: AOAM532QJnMpfGPl1AmYshXfUHYhCh7vsQboE8SZ327SqpgHRR1/lRUt
        o9gHFPRTY+vo84bIVJupUNC1v5xzpuqcWw==
X-Google-Smtp-Source: ABdhPJyOrmdhT0+fQe8EuwlchoVd8L4A83qMk5ScYzW2zOve9lF7W7dKmRd342Mco4zWb3rIWTRpLQ==
X-Received: by 2002:a05:600c:2e02:: with SMTP id o2mr519956wmf.34.1644009656301;
        Fri, 04 Feb 2022 13:20:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o21sm2321598wmh.36.2022.02.04.13.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:20:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 2/9] log tests: check if grep_config() is called by "log"-like cmds
Date:   Fri,  4 Feb 2022 22:20:44 +0100
Message-Id: <patch-v10-2.9-ac397cc6a18-20220204T211534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
References: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com> <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
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
index 50495598619..e775b378e4b 100755
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
2.35.1.940.ge7a5b4b05f2

