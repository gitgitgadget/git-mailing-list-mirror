Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7987C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775DB20872
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9rmjykT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgJGHqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 03:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgJGHqB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 03:46:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9485C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:46:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j8so630053pjy.5
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lhXdMKhEuNvMflMcwvNPqgs7kFhCLTSl8UJinkkQjJ4=;
        b=f9rmjykTgcSo9JV57nOqhsgX4Z/t4c5Vn9qDCWtCr0j0Z8x3Ak2XZzsQqmFNeatIcR
         N5FKmgvHFsZHtRkGPqWrCKKuJzCrXhH24WB/KtHMzmoxSRQ73MuB+jRFtfCSORglDgj3
         HgBG/RAvF+aa1b9qLHt1kbcCVFAZmwee24A2Z+rhKanm6MdZHGu7SQNIPVem2SvbRu6X
         g86EZ8KyWpBLRCGnjURRQgSD2l72pETMXozq20GLqRMQ/7sqfjrFqXhVQjMabuEFvoVt
         hcUZZawGvTwxOF9Rr7q50BdNb+5s9JC3rKVy91GOQ+1Wq9C1zCzHZ6YWeB8r7Y3YRnNr
         0Y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhXdMKhEuNvMflMcwvNPqgs7kFhCLTSl8UJinkkQjJ4=;
        b=lZnYaohw0INpyb6zAAUWVvlLZZwR1UAcxSiDwoGzYBauPxAs2MYeWCuhCICFKfJL75
         KdYNR3AGfIoVyvWFlLRTTi88ru4QSy7nTfTm4sDnUIR1EWd/kOImlV0K/aY7OIT6y2DC
         i+lSSRHzPH2ADtbcrO+jgpF6IyBcqR5FWeop0MnKv7wPoDn2qoRJZdnnTHTXM4cUnlTz
         tTemnLP9ce4YJMSWA/MIqGnBA7KknnmMDTqAyNyGLp/+VaiVXczcUKAEBe6ZOGuc12st
         42Bt7op4/ERlAcaO5f4tj6aCeLKbrZUX9XgcqFK20y05y48z2MoZmLYiV3je6AOkNYqM
         39Rg==
X-Gm-Message-State: AOAM532OYFNINXrwRn/U6N6yP1ah4PO9C3coWgbs986sHv9wM01DAyWJ
        bjgmyzQQESz+gvdja8KoRmLtA+JhxxxIpg==
X-Google-Smtp-Source: ABdhPJxF/Oa9eSHX+Qmi1dyKOpB0LuHR5k+EmQU3coZQ5puRm3Cme4HmexzcWcDncyBYgtWP3dnKSw==
X-Received: by 2002:a17:90a:fad:: with SMTP id 42mr1846262pjz.108.1602056760704;
        Wed, 07 Oct 2020 00:46:00 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.141])
        by smtp.gmail.com with ESMTPSA id o17sm1273728pji.30.2020.10.07.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:45:59 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2 3/3] t7400: add test to check 'submodule add' for tracked paths
Date:   Wed,  7 Oct 2020 13:15:38 +0530
Message-Id: <20201007074538.25891-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
References: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test to check if 'git submodule add' works on paths which are
tracked by Git.

Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7400-submodule-basic.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 4ab8298385..d9317192e0 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -193,6 +193,17 @@ test_expect_success 'submodule add to .gitignored path with --force' '
 	)
 '
 
+test_expect_success 'submodule add to path with tracked contents fails' '
+	(
+		cd addtest-ignore &&
+		mkdir track &&
+		git add -f track &&
+		git commit -m "add tracked path" &&
+		! git submodule add "$submodurl" submod >output 2>&1 &&
+		test_file_not_empty output
+	)
+'
+
 test_expect_success 'submodule add to reconfigure existing submodule with --force' '
 	(
 		cd addtest-ignore &&
-- 
2.28.0

