Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92DCC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 01:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhL1BHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 20:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbhL1BHv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 20:07:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11169C06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t26so35199072wrb.4
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2j8GO9kYur/KXKTB2g/WyCaXN5v8fLnutxPbQm220I=;
        b=OxhID/eGZgPCE8jHdxXunE9y5MKp6yWXaeIkGXKRdZrAqGU1giT1s5mkqrNmKvfql5
         gmq397HDH/e962Q4X2mX67o+vTjjOtrlLaQgFmeRuIdICIrPrBZZwjX24ykZ+9p2u9ud
         x3sEJezuSv4OEmtqLCr+cAlutwpz+C/mhWUGnpRcebmnAAtQ5mQUL0qM41CjwXqWUaLI
         odksozg9DxWJeoftT4heHR9mzZg06Lfur5sUafexAiOSgQL6wHA61QIlD3xEx9Z/GzLg
         Fad9sHDORvRLzaic7OMXuzuSyDuoEvD54yTeUEwpjVh+f0X90l+4oq3Q92HBPaGFlBw/
         CJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2j8GO9kYur/KXKTB2g/WyCaXN5v8fLnutxPbQm220I=;
        b=Iz6ruR4Rzqi6aS/9cOhY/5h1X9mkyNNAroRP/tbMR7NfBGUAey7ZKAY+iegwX54XLb
         hr9UEbNsXfwGqVQApDG18OcNEQ6ULUJIeRy0ef9F/jeIzG+fD55iL4ATQ2skIz9TmQoi
         16uTsMyEOxcSMhZhZanxd7DB+psZv1LlTGO+71A05syXvg07n6aMIdlu+jcIYjbzWW4d
         BwZBFJRJaU+Cuf9k02zJ0Nd6dDBwhZQGbfBswiQHVAvpQdgBADYlsTTYAsRM8iBwb35A
         qqc8lH2FgCOsv6mRLu/B1q9RP+cnSc6/t1SMqAB3NwanQ90N+ynBE8YfEEizxtSpH9Mm
         ZVWA==
X-Gm-Message-State: AOAM5336SfPXGNZqRAvmEaxO15SpfPJrp3bRRP7As9mGbdLZBE6pZpc5
        22V1J/4NJCpLnqOUZXm0x3gllTdKPYcwEQOX
X-Google-Smtp-Source: ABdhPJw44B4ZKdKRGEJrzGDFAcSvk+Jg6PjNeENIMYoEx7qdJHz+ASrhXT83GYqiIR/RA330uislbw==
X-Received: by 2002:adf:f70f:: with SMTP id r15mr13979130wrp.552.1640653669472;
        Mon, 27 Dec 2021 17:07:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b197sm16910973wmb.24.2021.12.27.17.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 17:07:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 02/10] log tests: check if grep_config() is called by "log"-like cmds
Date:   Tue, 28 Dec 2021 02:07:37 +0100
Message-Id: <patch-v7-02.10-0edcdb50afd-20211228T004707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1250.g6a242c1e9ad
In-Reply-To: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
References: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
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
2.34.1.1250.g6a242c1e9ad

