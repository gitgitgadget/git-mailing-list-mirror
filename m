Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738C0C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 16:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbhLPQNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbhLPQNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 11:13:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C013C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 08:13:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e5so11691758wrc.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 08:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5sdtls0qkuJiYusI35JI3atU6pS13AMJMmDf+mNHOnk=;
        b=oUpzBjf9N+6mj7ypeh9I2rUeqUvyDCeQyDagUj/Kh6xavdzeadauI5yBJlPnfl5tuE
         LzIC/LZqDX+3ojv62PMkhphTA7kIAys/o514cUyOJ4om87XCZdcT1SdVnqJtj2EXu3YS
         NSjdAphbEaSdEFII6QZxfa7Fj0bjSYqFA5p6PLmzjpY+msR02xFgp0u68w8LCSjBvNc3
         wYhLYlGn7cr/BuiUlvZyf9ZM921hZhchgNIw8vpCQ0PJmob64gtiC65rqvr/rUsMygOM
         rLcTyWxf7+sjIepJLd47f05S+p1pfP0NH3OmNHNO0igRcogWbJKr84SURVKfspza9EnE
         mTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5sdtls0qkuJiYusI35JI3atU6pS13AMJMmDf+mNHOnk=;
        b=YVntO3gW8Ycowf9SdBW0bMIDkuAStLKASNFSrAS+K7iFyhF70qxGnlwuxh2AdKM3/A
         t5fy4+y1hjhvyJvXTR81jeT4q1+zfbpGa+MpqYHQ7RfAjEtfgqPZ3PY00zH57s6w4RCt
         JYxhK51uVIsslYxWL7/mWQNMMjUrTeNt1HLIhnclSfe0xoPiLxEPEGcFpR2Fn+XB9rny
         elSROaqMv+rxcoDSsqmPIHZIj10XNEPxWPcSokTutsKhzwYAkgMU8CKBI/ivcrPhTcDE
         NiHJ+p8+H5j9K7xvAAXJKM0/mZKeyNVpRrc5CoDR0oOzORFHv+0k2WKQHzqIo3rZe9Je
         LInA==
X-Gm-Message-State: AOAM530suRT98TSUdRcfi9LnxfZhrMgbiUvljEcvaPORsM8DsIyg418S
        bTYfYubsTzcDSuQgNTrcP+h3kGfgK+s=
X-Google-Smtp-Source: ABdhPJw1w6c2KByvA4cu97EP9E21zcXtIDgV4J3yn5Pf/NnGMOmObmoTEk2qSrE5PifhjZmnLsM12A==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr9461102wrs.529.1639671225789;
        Thu, 16 Dec 2021 08:13:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm5123790wri.6.2021.12.16.08.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:13:45 -0800 (PST)
Message-Id: <3fd625290a318f853c7a96cbc10be76308ef2a3d.1639671222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.v4.git.1639671222.gitgitgadget@gmail.com>
References: <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
        <pull.1069.v4.git.1639671222.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 16:13:41 +0000
Subject: [PATCH v4 2/3] sparse-checkout: fix OOM error with mixed patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a test to t1091-sparse-checkout-builtin.sh that would result in an
infinite loop and out-of-memory error before this change. The issue
relies on having non-cone-mode patterns while trying to modify the
patterns in cone-mode.

The fix is simple, allowing us to break from the loop when the input
path does not contain a slash, as the "dir" pattern we added does not.

This is only a fix to the critical out-of-memory error. A better
response to such a strange state will follow in a later change.

Reported-by: Calbabreaker <calbabreaker@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          |  2 +-
 t/t1091-sparse-checkout-builtin.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index d0f5c4702be..9ccdcde9832 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -483,7 +483,7 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 		char *oldpattern = e->pattern;
 		size_t newlen;
 
-		if (slash == e->pattern)
+		if (!slash || slash == e->pattern)
 			break;
 
 		newlen = slash - e->pattern;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 3921ea80138..1f877ced0c8 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -103,6 +103,17 @@ test_expect_success 'clone --sparse' '
 	check_files clone a
 '
 
+test_expect_success 'switching to cone mode with non-cone mode patterns' '
+	git init bad-patterns &&
+	(
+		cd bad-patterns &&
+		git sparse-checkout init &&
+		git sparse-checkout add dir &&
+		git config core.sparseCheckoutCone true &&
+		git sparse-checkout add dir
+	)
+'
+
 test_expect_success 'interaction with clone --no-checkout (unborn index)' '
 	git clone --no-checkout "file://$(pwd)/repo" clone_no_checkout &&
 	git -C clone_no_checkout sparse-checkout init --cone &&
-- 
gitgitgadget

