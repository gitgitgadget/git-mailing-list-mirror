Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9785C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6F560EDF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhKBMaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhKBMaK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 08:30:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D6AC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 05:27:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso1748270wmd.3
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufHwRkxGYi92p2eh9JHC4nqjBONEttk0ji459/spTtw=;
        b=JA7Sd51CYlMgFhtqqHfSkhdVHW9TAT80B9IGQLNMgVVI+qoQyxyBz5LHq1e3xhw5ag
         9u4JzFVaYCJOlwWA5eqpaBHdAeIkA9+YdVOpizNM6up15Lg1YWoNJwtQOMsIqI+VDNJc
         aSMyllzEc0jBeO1w2GigvBSPz8pqXKjXi2LklQrXCx2rUzH/oyck1F9qvk5wYv9+7nSu
         O+XG/Oi3i6VvU9MrkwCwHAHRmfxyMcurj1tJEFckpaMO6PCzdeGcwmF9N1zLYTRCvVoh
         egsoOFCdd6OFZ8WQH9SlaxhzSCpC5yv9OrFpIwSoIiI4+IAazV9k9AcrbQ7pxG+ESivc
         oYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufHwRkxGYi92p2eh9JHC4nqjBONEttk0ji459/spTtw=;
        b=i0E3wenSvE2nLREtzpxRUM9I/luX1LRc0+iJjWxsZTqkcx41Gm10KJQGcDGmn98efs
         xxUV+cFCbt6ZscgpLZPG5Fe5XABmBzdFlU5vsbgo+u5472+AgVmEvM1PU8OjJpogwYqo
         nLR5RiCddYMcfKqgqOjM6XhORgiWmdPZ3bOyYlFehFPZ8x/qEQ/N/LGXKrhclwt6CUys
         b/gztx4Bw1o+aDVradzgBt8PHcdkcV63ZQRj1CjfWjxHNPlLcSt1oR8Oo28qRDTvV6Sx
         02rU60FU9ycQI6MRNsL2mOKsWsvLDM+yHWjTDmFbWMA/K6gjzSx9l42QrLAb47kJ4eXu
         Cf/Q==
X-Gm-Message-State: AOAM533GJy3g2kUKXZ/ZbLP56cG9pbMTKmx5yR+xYkQGinP8K+GcgFZi
        eC+6GUDTo42CmBIT8y5ybY+A6mU95jDw2Q==
X-Google-Smtp-Source: ABdhPJy5rAjlM/df1cyCpbiWl3iMDJYZSV8WhUFZk3zsM4aW9THi2LeQ+SZPD+HBTMYDLp+GeClEeg==
X-Received: by 2002:a7b:cd03:: with SMTP id f3mr6645764wmj.89.1635856054034;
        Tue, 02 Nov 2021 05:27:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q84sm3332236wme.3.2021.11.02.05.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:27:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 1/8] leak tests: fix a memory leaks in "test-progress" helper
Date:   Tue,  2 Nov 2021 13:27:23 +0100
Message-Id: <patch-v6-1.8-88d89652831-20211102T122507Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
References: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com> <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
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
2.33.1.1570.g069344fdd45

