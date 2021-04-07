Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B379C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A1161242
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhDGW4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhDGW4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:56:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EF7C061762
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:56:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s17so22658096ljc.5
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lhQ+fJBRJyQWN/9jDex6ODU49KsIhHVvz0QPimAkkH8=;
        b=UCM2FYU6V2E7KYFDAfGEuHXXkzuwPjVWlau+eXt0ibr5wUu4Yr1VEHaleS68mbB0sg
         OKmGANy6X95zN4LmHuBTAA5Eq4BhIKwNiPvXXfkSiJClU3X/m/G7Eg6ON2TyybelxsX5
         v3sR3c5BGjSu6OXCCnuXZ3mAKNqSV6hMM07+rKCgI3SCjhU/ztB7Ky6aXqWYNGLqgdnI
         y2jcGrq0DtYpW4vxixEl9+ZTgoz/7NunoynH1Re/2dxDASmYZNdkEE5axAs5r2ZIdjUi
         6QEht7so2bF6Sw/9JrdvwZwWym+FsVaJvyikhJ6//eTn24d1wocd6+UGOS1Bsp4sM05x
         kkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhQ+fJBRJyQWN/9jDex6ODU49KsIhHVvz0QPimAkkH8=;
        b=Kx1iQdKGYj8MZn/HiuJN2FMAvzlGlo3GPvrSkkE7PBXSiRVIu6P9u3kN71uuDe8jbG
         swgUeOTDuA2XfIGpE41EwMlFc9yDV3xs+pl7KAEvCTQ3BLcUoFQvPgd5900qhAiSaeqU
         GbqlSNGDJymF7Kzxzf0a8cvYUxni/EZx7DtRoqTDFCIDXHvhFNZQAPXIGpJ8EDHI6OkZ
         b7Rz1f+KdKFD1z6NJ1U6nyi/tknbF5oE/eIc4QGJ4YvzxtST+fi8tfjok9v4/N50M4xo
         JOANpAl//w/78BMTuTSXYeO1Cv8xvkCBUe8d4j0LtYZmfJTU6q7NvU+DMetJcDqOJYoP
         aCYA==
X-Gm-Message-State: AOAM5316oCl5bKk1K07BcymM6QR+PMMcTIBOCp6eJJYBObVbLDu1uUGo
        eYxbzoNwckYGCw0/KEakvpOV43UUHIE=
X-Google-Smtp-Source: ABdhPJycFMqjz+w5I2eGS9ATG0ivAB7sGI5uvlxVgCA2c1ORV9sJO/u3X4qe0DOf978dj5OEMLcBHg==
X-Received: by 2002:a2e:1649:: with SMTP id 9mr3765846ljw.74.1617836188939;
        Wed, 07 Apr 2021 15:56:28 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t25sm2580101ljo.102.2021.04.07.15.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:56:28 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 9/9] doc/config: document log.diffMerges
Date:   Thu,  8 Apr 2021 01:56:08 +0300
Message-Id: <20210407225608.14611-10-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407225608.14611-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Added documentation for the new log.diffMerges configuration option.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/config/log.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 208d5fdcaa68..456eb07800cb 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -24,6 +24,11 @@ log.excludeDecoration::
 	the config option can be overridden by the `--decorate-refs`
 	option.
 
+log.diffMerges::
+	Set default diff format to be used for merge commits. See
+	`--diff-merges` in linkgit:git-log[1] for details.
+	Defaults to `separate`.
+
 log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
-- 
2.25.1

