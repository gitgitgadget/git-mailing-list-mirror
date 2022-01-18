Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C774C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346095AbiARPze (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiARPzd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:55:33 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68DC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:32 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so6885584wmo.5
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PL4wpSjoF8uf4oVqlcrEZ+XNhgLG2HLlzjpO6lMpTTA=;
        b=LmClfM75/ZmBKBUHvKOubFtfi2Hhr4ISUNthnPMdHnTwEYmb3Y94qrUtAx/+8Ep8GQ
         9ZDqjCeF+6zgE3V+R+u1CpemntMd2QTcwW/BbR3caIGhyQDCcZTg3FyRBeliX/bbKRHP
         QOfu5VNy89OjmhtlDw/+5H3sgbbICDWtcfP5cHXKyTp4/iD+v9xKrkBApRufl6vMWehW
         Z6N6xG6r+IUX9An5WpBYa+hbW7Tbvjv8hJqJCjjk7Rxqsr7MQ1GO6yzezIUIFUL8lGzM
         WsIXi92vn+LILuq9iNvNv1xLvh2KFmBi8LsT2tfwq+nbXV3YT5pyBAWZvSFGanaZSiRm
         cK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PL4wpSjoF8uf4oVqlcrEZ+XNhgLG2HLlzjpO6lMpTTA=;
        b=nPjelSX0p45556I4UIXefHWcEsDnL87iCq0SSb5Q6H2WZngDzXP7U3fS5LHIS9pjXK
         HFf1MxV02SXXZegyieHUFtnDeK2zm4v8Dhjc3z8UYHkiTk/pIoHpw6/jAzOYvboasdb+
         7Hv3gePf1KnUi7HMTCOA3jEzRcdMKoTRQOFsuWJ9ZodSR0MFzpZ89rhehy7jCrUc3neq
         G6qXP/+7QZAfXUJ/Fp1tDxfYM84frCoS0SIX4q5mR3zP6EspNLuIA5nPClZDrGCtrC6m
         9bxBum7j1qRTO8E1gnIN9tDZtkb4Po1YLttPWk4d1HUe/LpWGvw3YBzY2LN+1nCl9HdC
         OmRQ==
X-Gm-Message-State: AOAM530KdTmjsGAD33RFotToncm3ForKLO8PVzqTUob3a/YSyMLesXL7
        Yxl28J15qOpy7kNa4UNsPKu3hOCQ+/FP8A==
X-Google-Smtp-Source: ABdhPJyCNCeteX3dehc7RywePX/10lUPqg+Q4AE8watHjp0eaQTbeW9A3geEfvmchRzttjQFqF7rXg==
X-Received: by 2002:a5d:488a:: with SMTP id g10mr24502903wrq.653.1642521331081;
        Tue, 18 Jan 2022 07:55:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f15sm1220522wrd.45.2022.01.18.07.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:55:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 02/10] log tests: check if grep_config() is called by "log"-like cmds
Date:   Tue, 18 Jan 2022 16:55:14 +0100
Message-Id: <patch-v8-02.10-e4981fa3417-20220118T155211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com> <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
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
2.35.0.rc1.864.g57621b115b6

