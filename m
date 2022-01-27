Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E68C4321E
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 11:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbiA0L4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240560AbiA0L4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A7CC06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u15so4332367wrt.3
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18mKGpPhWp9hWHyTBzRMEw5kkCkYFPrzmva0o5ZN9gY=;
        b=oy1BuJSJNGbMTRbOg0Mar5iJhgt84kzvLe+ydpo28eN7rYRvpja0y7+FTD20B8+aSE
         0tEc6TrbfsDD7JAAc842RA5rQzjloO6+/2B24muf2+jhwbbbqR7MeNseSJUsNp3EgShb
         rzz8blTa9eXmiYPdSKs7v9DlFs8syRztLaijxIIMJxItNf9TKPz6qZLzMgSVy9GzeS6Y
         wkVIhS8Nh8uFxfDyatzzKtjp6AkwqB4iiDspKM+xPM4SE2tTVGD31J4lqUjghDwLSDwA
         CQRIw1v2b94a/JdNTsbTaL3/HHdDz4gNSO8LhYgwnO8cNLjHrt2qlTeHDsnuc5KuU9EN
         VTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18mKGpPhWp9hWHyTBzRMEw5kkCkYFPrzmva0o5ZN9gY=;
        b=oKr/e0E4IG4pc2srf17qnz5rs3OdMOhQst8IqRu8HpL3+frBmx8MVNMvbggXtG4wWg
         BorAp4IWuM8BCGCQ/JMXeMVc274Z/NReAO0QLFRm6Cu/ZtaHiVI7OPe48/Shfz1Nq6he
         ezwVMzkbVHzfWvhQxxu5ha2otnaenuVSkzWK0Ye7mIuuRVqNWp6bYgDukVKlhEBaKmA/
         8aEBQELN2dEF1n2KRcswrFfPy+XuM2usKvQ7K3kVGE0qOGQiac1TEEijMvgzzDXAIEkV
         eZI3vq2Bw2gpL5DterxRaVFu2AaIAIxBLc8RnTdnxyAQB3TUd4yXr6ETsxn08TfAmtLX
         h/ew==
X-Gm-Message-State: AOAM531plQ67Q1PUyYATFpFFBd5Rd5b6nCHcwZSsVYuXTn4fwHIc5to5
        FTCXFcW2aF4XCO1JBquQ9jsnyWdB8vYW8Q==
X-Google-Smtp-Source: ABdhPJxWmxAmREUQq2nm47w3/SAG8GZ9Mwd8h/ZtEp3+jcpLCGk1C0b8pB4AwY9BMdwiNltrWnI6xg==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr2807368wrw.343.1643284597121;
        Thu, 27 Jan 2022 03:56:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i94sm1910663wri.21.2022.01.27.03.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:56:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 2/9] log tests: check if grep_config() is called by "log"-like cmds
Date:   Thu, 27 Jan 2022 12:56:24 +0100
Message-Id: <patch-v9-2.9-30219a0ae9d-20220127T115058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
References: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
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
2.35.0.894.g563b84683b9

