Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DEDC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8598761413
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhGAQFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhGAQFm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:05:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6B9C061764
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:03:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5268016wmc.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GXZ41+jgPdyF00+igEeNjUAal2iSsNHeuyjHsFuewTY=;
        b=FGXVqHLFFwdq7BnxsKWglAAcPIUwLaTgjvG6qvIQ7GtLT/VYWcKQ1d7yHDDc4VF13f
         ebDstEEZIbvfEnxQcs8OfYzepzuzeJEnHECCSBioAD3koTSXUJ4vWh48rKGe51u2UVP6
         CKnP03hHhG9IQvDiIshK2sn5oVc+RFxKDkCF3I2VSJEjdUEbqZffYCjsV+mRYem7WUQO
         soa+BpOBXJ+WaDspLsNiFpicTeLK+H1moEF95sssorJ8K7yNjezK9MLsEYXmfBmVzaYW
         QmEVzZMW/SCXcsgiTz9ZWRYE+F8Dg9f4tvWAHW+raKJb6VSCFIBNULYhOPXHGqpuAZ+U
         anxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GXZ41+jgPdyF00+igEeNjUAal2iSsNHeuyjHsFuewTY=;
        b=FPQws/WRUCRwUyhGkNdRgVTeEc1gODC+F+hMQPyaPR+zo8F8mYJ0MJVkQM4/E6Axav
         3HFE8IIvrmQGEDm8outwVkCYmDEDjcz6trUTkF4gzQ1udy89rP+qUqY6Q87HiJj3Q+7l
         q1WStejGWM87tbMZtuey7+9N2nvc3QlRRgpIku+jebsZNGI4FApyNYDJuYbsxgLA5Vjz
         r2qyey3VEer0tVhstYf07zMI2VUg+vzKjbIOJP5lmCeicCsg82F8IGj08LgoorsyvPUb
         B4oBidweTaRdIodBxqlBRw4WKcfJ4espeTSK6QlZbOteHuYo2ej2xAXSl5fggNzWWMGg
         Br3Q==
X-Gm-Message-State: AOAM533BmQTnWwRe9nqzNN4BAJBmNwCXZR87/WwQtZVqTszyEki11L8z
        hMTfjm1M4LKCUlcXgGTAtjdq9+X7jUA=
X-Google-Smtp-Source: ABdhPJy/frOYVHtGLc8JWQBxRp+F7hGyhYzXCKc/B4TEr3AuOv3He1+mwBlJ9CI3hp3PfNeVlo03Fw==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr453563wmi.170.1625155389708;
        Thu, 01 Jul 2021 09:03:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm406768wrx.26.2021.07.01.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:03:09 -0700 (PDT)
Message-Id: <cc8f09baba94546a13087e923e9c2374284c8136.1625155388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
References: <pull.66.git.gitgitgadget@gmail.com>
        <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:03:06 +0000
Subject: [PATCH v2 1/2] tests: exercise the RUNTIME_PREFIX feature
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

