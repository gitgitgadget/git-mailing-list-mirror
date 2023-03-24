Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAC0C76196
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 20:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjCXUy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjCXUyq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 16:54:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C043166C0
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so12582098edb.11
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679691283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBmp1WNBu4l5uyQOZwjLHFcbKQroSBy4oBACTiM2LcA=;
        b=XVYM9+8+IUhA68S2YT/ubj//zC3vO67lp7XgxHk3Rl6I0JQNAUO1sxZNaQK+KrZFpp
         bVcVveS55bVaeRG8n92uD/YDxnP9Y2B7WxV3plkf/9GjwE5lQQRgrQDnH6lYfK2UR+nP
         4AiPcMjXYY/sIfOPUQmyd7E9pBK+IBtOI5day/forCfDFB0hquX52j31pNVyx6TzAJ3j
         VT59nPFZjIM6N2aRSRIRqdJWvAIBYdIPrTC6q3EwSWnn8PJqy0s+aLi0LLklJ5fjPk2l
         +W2/ZzqOveozmeLfWEtykOGNaFi4yuzwxIlPvutpCmaja2pfvYE2hJigfoFtWUEqniyx
         rtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBmp1WNBu4l5uyQOZwjLHFcbKQroSBy4oBACTiM2LcA=;
        b=eoqReg736ImiJf8extpIKt3yjh44IcDZOwVKdnSTxCS3CxXV3k0XAChYlTvp3mxLoU
         LzcXKGuDy8UItKarqAwk5UJHr6bJgz41/4iRdRX2GkEFs8WmAG7lTBESHfuZbf/Ni4OE
         /SZ5H5+qDO5+kZS5otQ7DrJcvO2QHCnDCuFYp/CfVIkYAaxHDf5bCFH9+V9ALkvEDbiN
         quaYjo6zCqkwTwIbwxz29PTokUjHmDw2+WICTneoRd6mmlYNsv1HvpXFe84wdTzOPYNm
         LQDWq+x3Om7aWuZCMjOejKKLsegRvDTdF/LJDMvDZatdqyYVohZ8oYcN1rxaZw1mJkjE
         /AKA==
X-Gm-Message-State: AAQBX9fpiQn3d/byOLHG22bBoO076OjvFGfzdfGCThrTwFF7JbHtOZRm
        wuBjgro18qrugZISrAKBhtWGbj0QyKr4/a4s
X-Google-Smtp-Source: AKy350a7r6Ihbw529jZO66ZA1JvXY+EoEk2qQr6GxxmNGxMiVqn/8u1PTgKqN0FqvTvB6fbLtA82Og==
X-Received: by 2002:a05:6402:1285:b0:4fb:6523:2b37 with SMTP id w5-20020a056402128500b004fb65232b37mr4949322edv.15.1679691283373;
        Fri, 24 Mar 2023 13:54:43 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.11])
        by smtp.gmail.com with ESMTPSA id e22-20020a50a696000000b005021c7f08absm2007099edc.29.2023.03.24.13.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:54:42 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 7/7] t1507: assert output of rev-parse
Date:   Fri, 24 Mar 2023 21:54:34 +0100
Message-Id: <20230324205434.93754-8-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324205434.93754-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
 <20230324205434.93754-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests in t1507-rev-parse-upstream.sh compare files "expect" and "actual"
to assert the output of "git rev-parse", "git show", and "git log".
However, two of the tests '@{reflog}-parsing does not look beyond colon'
and '@{upstream}-parsing does not look beyond colon' don't inspect the
contents of the created files.

Assert output of "git rev-parse" in tests in t1507-rev-parse-upstream.sh
to improve test coverage.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1507-rev-parse-upstream.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index c34714ffe3..4458820168 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -258,7 +258,8 @@ test_expect_success '@{reflog}-parsing does not look beyond colon' '
 	git add @{yesterday} &&
 	git commit -m "funny reflog file" &&
 	git hash-object @{yesterday} >expect &&
-	git rev-parse HEAD:@{yesterday} >actual
+	git rev-parse HEAD:@{yesterday} >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '@{upstream}-parsing does not look beyond colon' '
@@ -266,7 +267,8 @@ test_expect_success '@{upstream}-parsing does not look beyond colon' '
 	git add @{upstream} &&
 	git commit -m "funny upstream file" &&
 	git hash-object @{upstream} >expect &&
-	git rev-parse HEAD:@{upstream} >actual
+	git rev-parse HEAD:@{upstream} >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.40.0

