Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3F7C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 02:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbhLVC7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 21:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241994AbhLVC7E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 21:59:04 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496FBC06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 18:59:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg2-20020a05600c3c8200b0034565c2be15so2991491wmb.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 18:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62a1o0w8Pk9iAtUhtGeLygphHrIw0v5yGwT58iybur4=;
        b=PctDhI1/Fef7D/vBbjQuq72WhhwC14G9EYrWtJqD15wEry9ni4UiuSB2G6jsOMXd7o
         NIQqzlHNIIVvf10X3ZbuphzrBdHjxijKf4d6VZqEGUPuHhllql4bl67M37yUPIHT7zdv
         UCO6IUtaNtW8j9EBG3wapwUBs+xhv8rqEux711al11vaHeEdq5VABJKWPnlLpuMpjw+0
         fymU0VdDx6pWYWMy3Y4eNy06/hLvWHuve/yJAmZXTUNT/9oYdZEAWJaffpxDUN8i0k7K
         mQhxxhe+B1jNfXqm5r9V6O0a4AEoIxNLpnJRD4YiENdAIZVimohuRkyYJCMGAGdzJHo9
         siaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62a1o0w8Pk9iAtUhtGeLygphHrIw0v5yGwT58iybur4=;
        b=iaGQWOYLijII5vYYsWHBEJ63gRrXLn8F16fpvXDPw0YvfD76y8gtiRsyQoh8tkRK4m
         rSpNmalZ5inP0m2Dp5C6bm/K8w3EIzYMCFOmoJURet+lK1+mA0zk6YSIt/bkkrlcoDyt
         LMIHhzn/LEf/iRvAmozg1feRWA1Bct+/PDJ/3+0TJrJkWh9vnQcV7db90HUbufmaA35o
         sS64iOEFH1VvFiq3Yzrbv3XvCZ1wwebHbGWg1sjluERV8yYjSJRNqZlf2sirkxTcmXT8
         M9A2KMdhHoxwNyByDYwpojejvgefWjaocvEv8rCVSckxHPOVZ7S4tRSputCSYYDQ3TH4
         berw==
X-Gm-Message-State: AOAM530MPLx8jbiTGTo4irOab2Lt3XNPP4qHHplSlv5OxlokfcVMlWcN
        VNBQzQUGeymPixZU84W1MS0uE7pYyS9Emg==
X-Google-Smtp-Source: ABdhPJyKSU1JEBk0tRf9M6BGT4Y3P/2GSTXt7Fv/8KFHijD/PK9kw2ZaSCvxlKx3i0m9KqIsauVIAw==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr828211wmc.149.1640141942501;
        Tue, 21 Dec 2021 18:59:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm611577wru.66.2021.12.21.18.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 18:59:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/7] log tests: check if grep_config() is called by "log"-like cmds
Date:   Wed, 22 Dec 2021 03:58:52 +0100
Message-Id: <patch-v5-2.7-c0d77b2683f-20211222T025214Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com> <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
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
index 2ced7e9d817..2490f2cd5ed 100755
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
2.34.1.1146.gb52885e7c44

