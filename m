Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B8CC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiBCVk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346643AbiBCVk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:40:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35725C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:40:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v13so7552330wrv.10
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LGR9v8jgDa064A6lFqXuC3ANrQPDF7L/rPhH0SbCZq4=;
        b=ezjH7yH4P2eFY5GrPfXgRS/8uXVDM9K8WbsxEpGEWoPUNzYGV6vQ+tOu8WSgo0ESAF
         GrtNXIxy5Qg8k9WCohtQMr4IOGvPw1jRqW7Fn7BRjGAt5Dzg36XI9vegymbCT46jPuYO
         lfNMSx7ui+m/jbdC/ZEMkEJ0kEbz6g5Xaww2R7H4FEWELhcIgsPlA1aWkSncOIEG7Hvq
         c73zpsp8ZZkZDdMixf5yenNQaYgpzi+TYQjnsRTX+ZLvX5aFFdYBg4nRk8edchnlNQ1x
         J/ZpmKh4TI+g0soATKgQOkRcqt+7YY+Hl+4yqSggMiSph31BLa3FCI+i5ZOOWB5+Yu6+
         16qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGR9v8jgDa064A6lFqXuC3ANrQPDF7L/rPhH0SbCZq4=;
        b=HrMFhsr/ztYpXQ5n6b9Kwye5fa58+ZqPn75AtWH5Kjagp4RGEZTqvHvBJ7ntzBg1XT
         NGJ0HK0+AGq78q4+Wk8lpksKC8PY3xYEV+AvEXR9VAP3L7XWPFExVdRffy+71qE2r8wM
         Ap/gxqumyu1t1wRnAtEqcIlHrd03Llgguj4sCumkxUxL0F5fVMhg9hyP3WybEF6ewyFQ
         tQ3OlOlGPLsNTaehoV+WeKj1F81Qm+92YLlw1GH+fvkQNkNlbifM0/T+lgr/4Js5IgSo
         F5lDun64D1UXG7Ll+htM52MaWx4qLlzXrU4nNn9ZpLX8tTsuIK/+gUQWiLjIe5erwsVZ
         b3cQ==
X-Gm-Message-State: AOAM531253aDpTjwmhMvcRx7LmxJBphQrq4hzS14B+JysAI33mB84xAM
        wP/GcdrKkdXVVaZ69boIs63kvj+vaes=
X-Google-Smtp-Source: ABdhPJwpGTv74h3hZNUdqLMxC/F2zp9w6ybNq36NVHK0lpmC30AJM+Bp0x87X++S1AwGR6mJKAGHGQ==
X-Received: by 2002:a5d:6da4:: with SMTP id u4mr30766207wrs.611.1643924425509;
        Thu, 03 Feb 2022 13:40:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm10637wrf.3.2022.02.03.13.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:40:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 1/9] leak tests: fix a memory leak in "test-progress" helper
Date:   Thu,  3 Feb 2022 22:40:11 +0100
Message-Id: <patch-v9-1.9-dc304df9468-20220203T213350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.939.g42bf83caa3d
In-Reply-To: <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
References: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in the test-progress helper, and mark the
corresponding "t0500-progress-display.sh" test as being leak-free
under SANITIZE=leak. This fixes a leak added in 2bb74b53a4 (Test the
progress display, 2019-09-16).

My 48f68715b14 (tr2: stop leaking "thread_name" memory, 2021-08-27)
had fixed another memory leak in this test (as it did some trace2
testing).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-progress.c    | 1 +
 t/t0500-progress-display.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 5d05cbe7894..9265e6ab7cf 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -69,6 +69,7 @@ int cmd__progress(int argc, const char **argv)
 			die("invalid input: '%s'\n", line.buf);
 	}
 	stop_progress(&progress);
+	strbuf_release(&line);
 
 	return 0;
 }
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 22058b503ac..f37cf2eb9c9 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -2,6 +2,7 @@
 
 test_description='progress display'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 show_cr () {
-- 
2.35.1.939.g42bf83caa3d

