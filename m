Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D852DC433FE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD246610E9
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhIJKca (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhIJKca (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 06:32:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB52C061756
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:31:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e26so866926wmk.2
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qAtiQuiQg5155ABkEDTXIWjMycRsTD4E0svwYg5cNww=;
        b=bNhmM8yKoamqNDARds4otzMvafSrTgdval0hssMfkJh6L9X/kHu1ZV0Bpk+th/J9xn
         kBHt2uX1O+oEG6IPwIZDPkHzWCqmuxnRGhno+DM9VeBFlFbCY4zgVAyEBn1eJpZfozM+
         h12Q/SFVyJXazQGSHhp0hY3kNzGlqYU0WLVZMpXncThuqtlzTOLtqi5VOfmgAdwqrWNn
         f7w05iECeWPETAtLxkgxEjhoUQQWURBy+6sBn7Zhawz4XrqRiOGuywJYP4uPtEndiRvS
         xfeL29TgTz+v5lQjDFXvO4UlL9THT/xo5FcA3EKtIBHdAdQVz/tCuymZI8HWYiyGVEat
         PNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qAtiQuiQg5155ABkEDTXIWjMycRsTD4E0svwYg5cNww=;
        b=CcleyDqFGQQhVVtMGtBk8Dm4D3fGzJzAxtam9k0Rj7T/WAViVaVOUp4Rcmxrx4WVEL
         70NhwNm4LK3Sgdmqm1jvv5RHBitPVIsyNLKsQH0oprqF6NYvrCy7kasXQAzqFjFjNjzp
         ZJJ2vTCBVcCLqvoH53vl5J3us/iMV7a+SbUFe9r+z+ZL39lo8L0iNfABWJxyigGvX4Zc
         gEV2WkdkVBXE7bOmqL0+bM/A7ZQESHVTgt2QGEoW8XjjI1jS65ptp7Z+IgSeWfvyfnCK
         LpuKV57QIHNrwYBnW/nAuACJIfYZJ9MzGe7xqrmvkPfCR9c+nmkDDMOVSbFdp2fRnbf0
         fynA==
X-Gm-Message-State: AOAM532PIGub2ral1FN+hrAnOqGT6ZpKa/rplC4+x9m3imkB5oObSOj3
        54RsLMN6YclBgZ879gp8a1xD1ezq6dY=
X-Google-Smtp-Source: ABdhPJx6NsHPGigxCuiNIdK03s4IiThyCYQAa7DbgIaluLskFXxpuvq8NBBgmbabphgJ8t1etG7YWw==
X-Received: by 2002:a1c:3584:: with SMTP id c126mr7613986wma.121.1631269877908;
        Fri, 10 Sep 2021 03:31:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16sm4814401wrh.44.2021.09.10.03.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 03:31:17 -0700 (PDT)
Message-Id: <e199df0f3bc5a99e0d77c172316ad119c533f790.1631269876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1087.v2.git.git.1631269876.gitgitgadget@gmail.com>
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
        <pull.1087.v2.git.git.1631269876.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 10:31:14 +0000
Subject: [PATCH v2 1/3] git-am.txt: clarify --abort behavior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Both Johannes and I assumed (perhaps due to familiarity with rebase)
that am --abort would return the user to a clean state.  However, since
am, unlike rebase, is intended to be used within a dirty working tree,
--abort will only clean the files involved in the am operation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-am.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 8714dfcb762..0a4a984dfde 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -178,6 +178,8 @@ default.   You can use `--no-utf8` to override this.
 
 --abort::
 	Restore the original branch and abort the patching operation.
+	Revert contents of files involved in the am operation to their
+	pre-am state.
 
 --quit::
 	Abort the patching operation but keep HEAD and the index
-- 
gitgitgadget

