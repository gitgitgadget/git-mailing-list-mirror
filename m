Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ED6C433E1
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C86207E8
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOOg3SH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgGCDie (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGCDic (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 23:38:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD7CC08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 20:38:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f2so3017466wrp.7
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 20:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WvLw9uA1lTQvWT517JXIxTV9H4oD+GrzaV2NfCJwdQ8=;
        b=fOOg3SH/tJkb9c59EtvhNXmV+sESvIrOhHaTWUol0id/nK3tb5lg/UYclgrsykwWSK
         bvNIQP0xALQoe4y22Ea4MskdTrIyBiO0P1mzCTcNjSGGpUOwKoGt7Q6301TwDQkc8/3a
         18QSrycosPny24IEeGdSZPD+tS6hr5M28hzEdjQO3Wv4E9LMyVkvBKcQS2295NtcnnA8
         CgaYZQhDQhpCp40+O51cVnpIsVTDF6UqARosJpwk9bJamF2UDB0Y0jEYTJD+wBf1m3ET
         ERy47enPo6P2TNOWWhNDul2H2GD1kocfUNuSOQt63dGRZwaL7mGiHL/X3Rwa1ZVU9pCn
         E2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WvLw9uA1lTQvWT517JXIxTV9H4oD+GrzaV2NfCJwdQ8=;
        b=Y8FNCDBpvi9wCb9HQkhkljQ7Y4f4pH0R5qtGF5VVi3K6kbBUfvyPAMnsqcR3fTA3iy
         AKGFcK8k25L/JXglYtpp62DfYgkUdc/x3zHD9IY99bqnHPRUGGJVs+YJvFQVcjKcQDUj
         oilRCq63Cbau3/Oo5/EbXX5RHloyk7TrA6i64mmzkwNnMqMkb0CYS/XN4GFwhPRUj9wg
         NCxL2szzBcncHWNLKrXIjnrkOBpvD4Bspo4vvxbpNeQX/DrJpU6sXr3uSwcVOG6p9ZkE
         CAZud1kn4/w1/aXvvnDetvrJoxRnMLJ1SDc9Er9BjgQgkUAtZ91nIj3bUF2dhHkKmdju
         FJuQ==
X-Gm-Message-State: AOAM531bx3hOtmCczX3ksFC81QHZA7p09cPsuPa3cwS2kMQ82ppYG0y1
        9tDqVqyfrvZjG0uvIipUrgJObv9A
X-Google-Smtp-Source: ABdhPJyzXjMoLVYl2eFD5B05cQbxwJlBvl06MQB071ZAIA/RaC8C8RTZxVjTLj6V4ENoSl/PhRTqZA==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr37190891wro.201.1593747511028;
        Thu, 02 Jul 2020 20:38:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm12723767wrs.1.2020.07.02.20.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 20:38:30 -0700 (PDT)
Message-Id: <59c48282a094e90b7f4635c4cbcc04b1914b4c0e.1593747509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
        <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jul 2020 03:38:26 +0000
Subject: [PATCH v2 1/4] git-log.txt: add links to 'rev-list' and 'diff' docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Add links to the documentation for `git rev-list` and `git diff`
instead of simply mentioning them, to make it easier for readers to reach
these documentation pages. Let's link to `git diff` as this is the
porcelain command, and the rest of the family (`diff-index`, `diff-tree` and
`diff-files`) are mentioned in the "Raw output format" section of the
`git diff` documentation.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-log.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 20e6d21a74..04ea18d1c0 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -15,9 +15,9 @@ DESCRIPTION
 -----------
 Shows the commit logs.
 
-The command takes options applicable to the `git rev-list`
+The command takes options applicable to the linkgit:git-rev-list[1]
 command to control what is shown and how, and options applicable to
-the `git diff-*` commands to control how the changes
+the linkgit:git-diff[1] family of commands to control how the changes
 each commit introduces are shown.
 
 
-- 
gitgitgadget

