Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287FAC19F2A
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 03:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiHEDGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 23:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbiHEDGA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 23:06:00 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72848AE73
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 20:05:58 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s206so1582789pgs.3
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 20:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3DdkBLkm5Ldmt/BWfrdxFk0g0Ma19fIrmqwg6thbro=;
        b=GEx4TC7HaydjCRDl9w+bwM1IuqJ8eJE+cXkOD7fpGVO3kB/dk41WNN+Jh+sgZjZOV7
         u6g+nRG2bFeCvabUIR5juj0lqri5rk8RDYrBh1Kw0B6iVJe5B9zSuL9iZ9Py624HYU+1
         gL9pkgKDUeMJR2cAaTk+JknOMDBJLZ8NDJOLZN9vjS5FAWlFWltEifRfEsyVR/KDao/g
         988cl0v7GhZIUcOJTvVsbsfCIKUIbDeZZiiwC6Jam2BqFxl1ptnA+QvfSsdo98VtqhNQ
         PKD8mhW80BiRb5QWp9nbn5axctoPLVLb5Pg3Ex7pHHpEa+X80CLO1f5Ex1Otx0+mxd6j
         vA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3DdkBLkm5Ldmt/BWfrdxFk0g0Ma19fIrmqwg6thbro=;
        b=hID7Vzv7YbAamcG+I6YDO2AFM43zz9los0I4z9u3cw8fFhr/KWSAa+k83ei5048fv0
         xSN7cdNdyB84BTIHll/3w7OFwEJW5o5DR+XQV7xLsTPQ7TAqTXvRG37TcHehS8Q5MPkn
         42raMp+IOT2XArIkKc0GM3FEAzSz0hJfzcmzFSqc09XxckObfcVzDAce/sfh7c6ULDFN
         jrx28DVFD4UtCubAEr6nWQbC5PnzCJ3t1GEv6UEHzMaW6Mj48RkwdGTevyp9B/zR9qxL
         XHnKcWyRZaapvEjm14fjl04om4LjLcCUc+cjhcau1119kEmg71MSRKThptLwtCUmMd9h
         ZPHw==
X-Gm-Message-State: ACgBeo1Ki9RlOvByQuR81Pvx92MJ59dYhcVVJADczI/FmuxJ8khIUO/T
        OFxRhOEcZj+AWTwYsqZj4AHR+/UzTAmOGey6
X-Google-Smtp-Source: AA6agR4RhPKtpJ/WqxZrpMH5AvvI1+EMI1d6wmnwbA+Z0fBAxv73O8GANEr5rnzNfwzZDlOId0MFIg==
X-Received: by 2002:a62:79c4:0:b0:52d:cd3d:2027 with SMTP id u187-20020a6279c4000000b0052dcd3d2027mr4933090pfc.71.1659668757623;
        Thu, 04 Aug 2022 20:05:57 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.229.239])
        by smtp.gmail.com with ESMTPSA id i6-20020a654d06000000b0040df0c9a1aasm570234pgt.14.2022.08.04.20.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:05:56 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 5/9] mv: remove BOTH from enum update_mode
Date:   Fri,  5 Aug 2022 11:05:24 +0800
Message-Id: <20220805030528.1535376-6-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since BOTH is not used anywhere in the code and its meaning is unclear,
remove it.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index f213a92bf6..1dc55153ed 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -21,7 +21,6 @@ static const char * const builtin_mv_usage[] = {
 };
 
 enum update_mode {
-	BOTH = 0,
 	WORKING_DIRECTORY = (1 << 1),
 	INDEX = (1 << 2),
 	SPARSE = (1 << 3),
-- 
2.37.0

