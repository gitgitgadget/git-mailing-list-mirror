Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE25FC6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 23:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBXXja (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXXj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 18:39:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E816C538
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:39:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so516155wmi.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJwrPboCwSpBVNE+pKPNld24LcC6F4py1/6nxmBMmPg=;
        b=pqqh8xgs490rZCametexU4xWhrROa3RbXr4X5aRnzn4BRDY1UDTggFQ9BOvurLB4PS
         xsZA7lIi+jsE2p7jWvKH1Hvl4PYzimL8uY3tdOiR83vP/2StrpzWH3z00PqjPgl+mQS8
         udAHMqm4slKbBLxawB/I5bg9Gph6hczhSV57Gx4WfJOnJhTBw1rDkQERsRBY3ifRr4m+
         WmGI14XOwhJc5ZhfoKPvUZECzpftIQDsnsM9DnCugj4/Za9gkkO95EVeAAg7K66FNZ1+
         4gI8YnNmxKAew9WM/ds7B9iZuYoCgUe5qLhS+B+phGwWaIjGdu3o7Qu/AjrlHFy+7hC/
         VXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJwrPboCwSpBVNE+pKPNld24LcC6F4py1/6nxmBMmPg=;
        b=OTPSz5+aNX0jYDU67BOEJK2ShNtQO8z2e8COMztDqalS5weAHLPmJr1x44aVc14jf+
         51rJKjG+Ncjhfn09FA17f3wBu2nOOSPR98xcemPlSOXyqPjqyFxPvqs2lUvAdfDFoYYi
         H4VupZlDzsuPKiEDw1HJvvuyl4ubKHLKTSoUdQV4Bmc7bHmMG/v1v3ivjEC6yjTWN1R5
         KTeS71/BckoYApiil0P2/Y/J1F76MbUP8RnT1/VVinK3oDa7ouyVM2VF47ffi5aSxE5I
         a9jgp+OmE3sVbBznzWVfNTowhpfzp5BO6ZCcQ0R4J4Hi6xo3IFVAT80hHhxzyIzrjRZp
         pPkg==
X-Gm-Message-State: AO0yUKX1jHy0vVrKlAxYrF2M+wvUDbP5GJRsZqGurmW8cgWeH/4cKcyF
        qChDQqEiR5QKNK8L80tzHEIT9SiMeXRQNw==
X-Google-Smtp-Source: AK7set82w9k4wj6R/rioiwfrs2VmYhV0aYppiAxkQPsETL7foCtQDqceJAfh962NsvMxeCfDY1gwaA==
X-Received: by 2002:a05:600c:3089:b0:3eb:29fe:7343 with SMTP id g9-20020a05600c308900b003eb29fe7343mr2195337wmn.33.1677281967283;
        Fri, 24 Feb 2023 15:39:27 -0800 (PST)
Received: from DESKTOP-FOQ07IR.localdomain ([2a00:a040:191:caeb:8c12:5f48:cdd4:4a9e])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c35c600b003dc4fd6e624sm709441wmq.19.2023.02.24.15.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:39:26 -0800 (PST)
From:   Roy Eldar <royeldar0@gmail.com>
To:     git@vger.kernel.org
Cc:     Roy Eldar <royeldar0@gmail.com>
Subject: [RFC PATCH 1/2] t7508: test status output for detached HEAD after clone
Date:   Sat, 25 Feb 2023 01:28:40 +0200
Message-Id: <20230224232841.21297-2-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230224232841.21297-1-royeldar0@gmail.com>
References: <20230224232841.21297-1-royeldar0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After cloning a repository, HEAD might be detached: for example, when
"--branch" specifies a non-branch (e.g. a tag). In this case, running
"git status" prints 'Not currently on any branch'.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 t/t7508-status.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index aed07c5b62..d279157d28 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -885,6 +885,18 @@ test_expect_success 'status shows detached HEAD properly after checking out non-
 	grep -E "HEAD detached at [0-9a-f]+" actual
 '
 
+test_expect_success 'status shows detached HEAD properly after cloning a repository' '
+	test_when_finished rm -rf upstream downstream actual &&
+
+	git init upstream &&
+	test_commit -C upstream foo &&
+	git -C upstream tag test_tag &&
+
+	git clone -b test_tag upstream downstream &&
+	git -C downstream status >actual &&
+	grep -E "Not currently on any branch." actual
+'
+
 test_expect_success 'setup status submodule summary' '
 	test_create_repo sm && (
 		cd sm &&
-- 
2.30.2

