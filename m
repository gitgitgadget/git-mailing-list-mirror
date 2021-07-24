Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78891C4338F
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2EC60C51
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhGXV01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGXV00 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 17:26:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A374AC061575
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:06:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g15so6361558wrd.3
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GXZ41+jgPdyF00+igEeNjUAal2iSsNHeuyjHsFuewTY=;
        b=GISammVPOarrIJNC7lryImld4gM2yqHqOr2d7CKE7MXLgjxFPaI/+sQrfmTwz5NThm
         OBqyOFk4J+yHHJdNjjeixDXgdn9x4TNdcU72vy/J3kaoQeW2kmUJsb5h7T0g/GuB00Ao
         DsERpfP4n2BH2nFalQy5XQ3MEekCMmnkW8CoDG8ANOdhUqdip9Fu6RvuGP/99rFDEqt4
         CpMGm+Pt+GdTXj1jkQysi+KUvtg7W9mRIMfCIKOcH+Ax9mN+XE+JDfy8ULVaxWWDzvQy
         HD+1xA7KQ/hZT+yiutxjmeRti+Sjc3VAUq+IGTOHa/v6u13/19gdOMEAQHcvFh+tK98R
         2/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GXZ41+jgPdyF00+igEeNjUAal2iSsNHeuyjHsFuewTY=;
        b=H7dUQimZs5Wr2PCnoGpPKCwMMMAyMKisFxQmYsix2mEO/JQLfPnMoU/45FaV+bzUIW
         cPMPj3UraIsCeBl2FMNbHUg8+RQPWpP1s/oujtquuIQxL9QmeJBwW9nVEK39wJ5Ex7U5
         zXjqF1L6ru9FEb0ppuIHoiYUjsFvc7fw9fkyDqzYZnxA4o3SKg3ZWBS3ZGIcwzcStpJZ
         W5sdn//2ylbjaIhELEepSzRQBudp49+WQbnRvCmGl1R7uplXM1iPikcJxHbilNQVQeMg
         I7t/qCavJi1k0owL7stHe/YFhfVKXK8GgBaLsI+KFz07k+Hasv2DrV1dYNy1XxRMEC9R
         GpEg==
X-Gm-Message-State: AOAM532BSY7pswV4YSr7fML0DzvgL+Nl3jx9yfljp3VNyvzijtyAE4+x
        RnuaT0oEH9r25eaDP31820X3iwjaE+U=
X-Google-Smtp-Source: ABdhPJw1wa0gZ7dHFO09rwSfN0cyN+JzhOLCgl8Lf5wXh0V0uYXVQiV/AyB18euFjCrFtrM8khWyMg==
X-Received: by 2002:a5d:598f:: with SMTP id n15mr11491096wri.133.1627164416347;
        Sat, 24 Jul 2021 15:06:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d29sm45136938wrb.63.2021.07.24.15.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 15:06:55 -0700 (PDT)
Message-Id: <cc8f09baba94546a13087e923e9c2374284c8136.1627164413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jul 2021 22:06:49 +0000
Subject: [PATCH v3 1/5] tests: exercise the RUNTIME_PREFIX feature
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Originally, we refrained from adding a regression test in 7b6c6496374
(system_path(): Add prefix computation at runtime if RUNTIME_PREFIX set,
2008-08-10), and in 226c0ddd0d6 (exec_cmd: RUNTIME_PREFIX on some POSIX
systems, 2018-04-10).

The reason was that it was deemed too tricky to test.

Turns out that it is not tricky to test at all: we simply create a
pseudo-root, copy the `git` executable into the `git/` subdirectory of
that pseudo-root, then copy a script into the `libexec/git-core/`
directory and expect that to be picked up.

As long as the trash directory is in a location where binaries can be
executed, this works.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile              |  5 +++++
 t/t0060-path-utils.sh | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Makefile b/Makefile
index c3565fc0f8f..4c3e4ccabcd 100644
--- a/Makefile
+++ b/Makefile
@@ -2826,6 +2826,11 @@ ifdef GIT_TEST_INDEX_VERSION
 endif
 ifdef GIT_TEST_PERL_FATAL_WARNINGS
 	@echo GIT_TEST_PERL_FATAL_WARNINGS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_PERL_FATAL_WARNINGS)))'\' >>$@+
+endif
+ifdef RUNTIME_PREFIX
+	@echo RUNTIME_PREFIX=\'true\' >>$@+
+else
+	@echo RUNTIME_PREFIX=\'false\' >>$@+
 endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index de4960783f0..a76728c27bf 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -525,4 +525,22 @@ test_expect_success MINGW 'is_valid_path() on Windows' '
 		"PRN./abc"
 '
 
+test_lazy_prereq RUNTIME_PREFIX '
+	test true = "$RUNTIME_PREFIX"
+'
+
+test_lazy_prereq CAN_EXEC_IN_PWD '
+	cp "$GIT_EXEC_PATH"/git$X ./ &&
+	./git rev-parse
+'
+
+test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX works' '
+	mkdir -p pretend/bin pretend/libexec/git-core &&
+	echo "echo HERE" | write_script pretend/libexec/git-core/git-here &&
+	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
+	GIT_EXEC_PATH= ./pretend/bin/git here >actual &&
+	echo HERE >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

