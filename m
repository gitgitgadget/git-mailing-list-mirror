Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A899FC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3AD61004
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352435AbhESLuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349246AbhESLt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:49:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E672C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j6so15947359lfr.11
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05utSWV2L/QiUJh2+Jr8LiKrgu2RAKe6xUFhGGiDPWs=;
        b=QZo9e6PAQwXAo5OH1lbeFq/Uhff/vtKunNV5Q+bZ6JeOC/USk28Vu8Wkih7PIvgJD2
         H6WEmiBsJNZJajMUbzvDSGkQjVbET8BGGBKfUxXrZzB0sKRRooGkxM+yZwStgL5cGFRI
         YuNeh+nma9pB4fjQML21kR7zwgPbTuMFIIBP6LSOLkvrO9rvy2T9DPzy7AasfJ9AN/za
         7FItsoDYAXU5VD0MldwxeNFpaxHznJh8fuM7Uw5O1oK3PxBaKL74qsnd8GcS+r/dJj0P
         sTW5EpdvDl3ocOgiAGQDFlyqQIA3f5Uj4XZVnVokiENnhX3NaZ0MkVkqHGjeEpYuDsEZ
         gjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05utSWV2L/QiUJh2+Jr8LiKrgu2RAKe6xUFhGGiDPWs=;
        b=XXLV0YwUcJO4DnMk4bqErQzhkOXs+G18h9GV1cOjmBXYKWtLDFf+nXc+wTC/yy271d
         zbnIUKvXIj+9emrpyFNSLRpBBPXjcJthgrS6SZpVPG6AL1XtRX3ddgKpquk0d9hDPae3
         onp6hWj20fAWsJIyA2q8i2YsdgHA2wlRydOFV8JX6+gCDRypJF3+4lWkQ0OOxLg0d5SS
         DwhB0J8ipmxSi6vsB5oBraQBfBGJrOUhQevGgmQAV3DIf4ku8Wjjsab1+yio0GeGtCWJ
         RgJAGicIt2uowdagsS823xQOxWw1Ro72DFi6Ogu/iLhjebN9X07x+Xor2qtE9BtLh/XD
         9XtA==
X-Gm-Message-State: AOAM531YLT8rKPKY2Slp6NUzj4tRB7zgbbg/sQclui06//PMnMHGd3NC
        RHWK5Boo9nULQPTEGyTvxCr6Q+kaf2E=
X-Google-Smtp-Source: ABdhPJwYpoEfgXUtvMqfx6HGrZayn2CD4inSTDcROc5inC9W01XfbpzI6ifXfSjJjH8yltatM06mNg==
X-Received: by 2002:a19:c107:: with SMTP id r7mr5669744lff.247.1621424916831;
        Wed, 19 May 2021 04:48:36 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o2sm1846470ljp.60.2021.05.19.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:48:36 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 4/9] t4013: test "git diff-index -m"
Date:   Wed, 19 May 2021 14:45:47 +0300
Message-Id: <20210519114552.4180-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519114552.4180-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210519114552.4180-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-m in "git diff-index" means "match missing", that differs
from its meaning in "git diff". Let's check it in diff-index.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index e53ca7aa503f..c35cc73d08bd 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -493,6 +493,19 @@ test_expect_success 'git config log.diffMerges first-parent vs -m' '
 	test_cmp expected actual
 '
 
+# -m in "git diff-index" means "match missing", that differs
+# from its meaning in "git diff". Let's check it in diff-index.
+# The line in the output for removed file should disappear when
+# we provide -m in diff-index.
+test_expect_success 'git diff-index -m' '
+	rm -f file1 &&
+	git diff-index HEAD >without-m &&
+	lines_count=$(wc -l <without-m) &&
+	git diff-index -m HEAD >with-m &&
+	git restore file1 &&
+	test_line_count = $((lines_count - 1)) with-m
+'
+
 test_expect_success 'log -S requires an argument' '
 	test_must_fail git log -S
 '
-- 
2.25.1

