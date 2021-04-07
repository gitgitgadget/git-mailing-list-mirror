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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4235C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A241A61245
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhDGW4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhDGW4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:56:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809ADC061761
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:56:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 12so659152lfq.13
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fSufVESFUZxLaqvuw9F6uJ7WIMbdkU1GY5L/Gl9yax0=;
        b=Hv08iR9yt0fJ9qw5XCvuxmXnu0w/Fwt4fzY6sCyzYknBtdJfhTRizOteqC8dsfiAJS
         RDD8va073jjLfP4CsPnfWDxn4FwyTWRwpAKpkBKlp+Onp6RfU3N/axzJLRA8AyENxeib
         wS894XVOVmAd+DxfDJQfUGupw+ipT3TLTiPD+DYxC1y4V0nvhSnSZZvH3Mm6BBDgiq32
         qaCJqxiqWYTY+YKK17a+s5v6+v9TTNGRbUCr+wnBY8jNe2aWmhRYTnMaRbc9tLsUfQF1
         Kkvd6cDshk9UMFnFh9Vg1ukG+e/OC1Pk0UoT1r3UlEv1OHaneNsvHm42Hu6hqZfRCS0x
         dQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSufVESFUZxLaqvuw9F6uJ7WIMbdkU1GY5L/Gl9yax0=;
        b=fMOp0UQYBiIrNjy5W7xVksaSmk/pAmlA5Y6ng7Wadtqd8K/xktt7yKLcnnwBqMYc+u
         Svt9VkNmveeeglfHZf4FGlj5fmE+XYNuLgBT8+LMls+VmkvD1JrIM9c3AlXQ6Dp5rtlc
         MQZQHEYlm4vcOBUPDgWRP+BsZoyCJvM87rBQpUBD5ok0QjGm27GM7M5rmDXfRBo4qOux
         4vQ6ioLTqAYXkqpVrMO0EemyipfWesrnML0s9mOm8KJdoGaQme5UTDfZ2q+rKaKpZJ92
         Qv7p76uSpDPs1zDNMN5zaZa4Xq4lLoaZan8HrO15uppWunsRGY5ZnVfrKczrkcpAOMxM
         RDhg==
X-Gm-Message-State: AOAM533M7+t0yReYIsAkrSzMJ99w07pagIY77sNkqMCJzyLBBA95mzAR
        gAwiljrrLsxHNeeLt0lk3CE=
X-Google-Smtp-Source: ABdhPJxKKh2u18it4B9timM6pvB2xN0cMGgg/GQeQtwCftzA3fMFDdo3HmroIqJp7zI6uZEJruK/qg==
X-Received: by 2002:a05:6512:1318:: with SMTP id x24mr3675914lfu.376.1617836188100;
        Wed, 07 Apr 2021 15:56:28 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t25sm2580101ljo.102.2021.04.07.15.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:56:27 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 8/9] doc/diff-options: document new --diff-merges features
Date:   Thu,  8 Apr 2021 01:56:07 +0300
Message-Id: <20210407225608.14611-9-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407225608.14611-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document changes in -m and --diff-merges=m semantics, as well as new
--diff-merges=def option.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index aa2b5c11f20b..09b07231b5a4 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -34,7 +34,7 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
---diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
+--diff-merges=(off|none|def|first-parent|1|separate|m|combined|c|dense-combined|cc)::
 --no-diff-merges::
 	Specify diff format to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in which case
@@ -45,17 +45,24 @@ ifdef::git-log[]
 	Disable output of diffs for merge commits. Useful to override
 	implied value.
 +
+--diff-merges=def:::
+--diff-merges=m:::
+-m:::
+	This option makes diff output for merge commits to be shown in
+	the default format. `-m` will produce the output only if `-p`
+	is given as well. The default format could be changed using
+	`log.diffMerges` configuration parameter, which default value
+	is `separate`.
++
 --diff-merges=first-parent:::
 --diff-merges=1:::
 	This option makes merge commits show the full diff with
 	respect to the first parent only.
 +
 --diff-merges=separate:::
---diff-merges=m:::
--m:::
 	This makes merge commits show the full diff with respect to
 	each of the parents. Separate log entry and diff is generated
-	for each parent. `-m` doesn't produce any output without `-p`.
+	for each parent.
 +
 --diff-merges=combined:::
 --diff-merges=c:::
-- 
2.25.1

