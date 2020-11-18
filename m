Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAAAC6369E
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F338246AA
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoLvnMDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgKROtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKROtM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 09:49:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D20C0613D6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:49:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a186so486599wme.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2mNOzwo2Tn5UKz5LNBWBBqX0xWHHgQYpZhjmTdgrWPA=;
        b=QoLvnMDX+SbusGZcMtisS2OfiuYZYtuZV3Bqy7sT4IMy0VDiP5J7kG4XNALT6N9acI
         sgBkBxRbd+KIULkZGraiF2zB/mALT4NDdSXG9w/BIbJj9lenlxzlaO937lhtd6v+aMxm
         53aEXcpyrXApzFP9pPg3wBmII6jawm5RaEYJPVQYkgceN58FlQOwYgA7yxMIk/2/+aZg
         1pc6rHFyt/NymDE+fwZL1CeLn44Kf/2OG6/oFH44Qph5yjrnOWgtCWIwDvKn7XsPngoe
         bLLgcw+r/Cjg8KvTsB5fBqKIP6R4wlq0kzewN4tBZGHHtP5R2iz1QeUOMEa6hH0vC/P5
         WW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2mNOzwo2Tn5UKz5LNBWBBqX0xWHHgQYpZhjmTdgrWPA=;
        b=F7U2aoqoWcvXL5VFfXQSpzhohrgQWNufUWmAumwf9BjFHELtVx2c17PTXnJBzUBCYT
         1xiCZfPtFWsx7uMNTY3OTVVMt9w3N8NpbnoopuM1nIaTns0D/cP0anO4KiVDMj+fAE9i
         tCMXm0WoVmAVlVBc7XnCt37y2RWxBjYvStborPIH01r/ub5ksX38zjrjETnlxhWWv5rG
         rRsg7+fGy87sFnGfybIMc4ws5RBZfShhhStpM8EhX4APEu59MoqapCFd2v1gqkwfyC+K
         S+WgR8ma+RUE2rrG+SvgXFP067XovDwiO3NWtG+1ybEMd4Ln6q5/uBcRkC9+7G/Tv8dw
         RwLQ==
X-Gm-Message-State: AOAM533R3FqYn+Y3DUzT4wQqadZV00UbvP0ZPAJieOZnOT5qHWcpAYzp
        zgnoib2uHryJ+hGsXkSClC13IOax83o=
X-Google-Smtp-Source: ABdhPJwJ8u5BbojY/AsCIPW25zv6iC1MjkFhWweCS4HcNAovHY9PifyppNkKRlqJmnlE7kNjfUSGpA==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr420528wmi.174.1605710949339;
        Wed, 18 Nov 2020 06:49:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17sm10517589wma.3.2020.11.18.06.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:49:09 -0800 (PST)
Message-Id: <74828089e672024fd6e4aa23675939fe5b11eda2.1605710947.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.792.git.1605710947.gitgitgadget@gmail.com>
References: <pull.792.git.1605710947.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 14:49:05 +0000
Subject: [PATCH 1/3] t2106: adjust style to the current conventions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We settled on the style where the test cases' code starts by the opening
single quote being on the `test_expect_*` line, and the closing quote
being in its own line after the code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t2106-update-index-assume-unchanged.sh | 30 +++++++++++++-----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
index 99d858c6b7..ff0947f388 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -5,20 +5,22 @@ test_description='git update-index --assume-unchanged test.
 
 . ./test-lib.sh
 
-test_expect_success 'setup' \
-	': >file &&
-	 git add file &&
-	 git commit -m initial &&
-	 git branch other &&
-	 echo upstream >file &&
-	 git add file &&
-	 git commit -m upstream'
+test_expect_success 'setup' '
+	: >file &&
+	git add file &&
+	git commit -m initial &&
+	git branch other &&
+	echo upstream >file &&
+	git add file &&
+	git commit -m upstream
+'
 
-test_expect_success 'do not switch branches with dirty file' \
-	'git reset --hard &&
-	 git checkout other &&
-	 echo dirt >file &&
-	 git update-index --assume-unchanged file &&
-	 test_must_fail git checkout master'
+test_expect_success 'do not switch branches with dirty file' '
+	git reset --hard &&
+	git checkout other &&
+	echo dirt >file &&
+	git update-index --assume-unchanged file &&
+	test_must_fail git checkout master
+'
 
 test_done
-- 
gitgitgadget

