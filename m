Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4A0C433E9
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0389B22527
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgLUTL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbgLUTLy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:11:54 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C037C0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:11:14 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h22so16736621lfu.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7skkKHM5R05UGdkMu1617woWQOZ5h6BpD7foIYbeG8=;
        b=PbxVEfLQIdBUnkMz8ERfIGwUxDMjHlNsX3rI/peShOOxNNqrrZxcAfST5MipFKvgTR
         +z0/VxuVsKpsPdjI4C0BRa83V8Xnijkq7Q30JqjWoimyTL4Kd8qsaTFNYhIbaZbc1/e5
         v76p4bWQ2wjLjVCau+vFsjOcm0hYrETF5eNxPd38lkvVcK79DUOdsbSd0k6Qxq3dVHvD
         2pOBB1cdCew/Qw3/Z8LEyQg4/sNRnSIzDTFkWdaXwzWjXlSolMaZyfNsuvowAx7EoByq
         yyKrPGpjIDBTq+W1cAagipnCYLsTvzla0INZrwdvCH5P3KkuVZMCA+YtEicvNeLyXHkr
         nyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7skkKHM5R05UGdkMu1617woWQOZ5h6BpD7foIYbeG8=;
        b=E3U/JmW/3OP4VuNQuWj076NPdTd4QA22Yk5Sc9nvEGFL202m4Y/Px/yKue3EBCN1km
         OkEXiJ4OXabA7qFQD89o5SmJmTqNga8WrHZ+T4sfU8BwFuUftzT2CgFvJQ9M5xD5PxEu
         Zjm6KaMvLAz395DVYcjLGmO9YrTH7RVdzEXQCjlgXjrZQC9Qog5xQ0Se09hXjdnB3QwH
         vWRMJAxv5LEJrCJAnfL+4hZKdASx3FdN91oObX5MsDqzML0VpNUoI9odGJIwdV3yLZkp
         PzW9Y1ZFi7k54WbmHKzsfnR8EVfGhazWBn6ClOs/Ajvb1Rpv2vA+Vvx9fDdw9XCBEtsT
         hfFg==
X-Gm-Message-State: AOAM530lzpTVUbbGylsrtEcz/g9oAOZnLUau3Q9AhVfj/e8rCwmUMGK3
        3zXk3IqXHs1UltPMsXI9lVAk91Loo5o=
X-Google-Smtp-Source: ABdhPJwXTWtWmRg//EToJsu4UtbrnHuaYAtdKIE92ioRRx4+ApwrQSUO/oIoXR8+WDIgIIAGp83Pgw==
X-Received: by 2002:a05:6512:3212:: with SMTP id d18mr7158359lfe.420.1608564066196;
        Mon, 21 Dec 2020 07:21:06 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:21:05 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 29/32] doc/diff-generate-patch: mention new --diff-merges option
Date:   Mon, 21 Dec 2020 18:19:57 +0300
Message-Id: <20201221152000.13134-30-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mention --diff-merges instead of -m in a note to merge formats to aid
discoverability, as -m is now described among --diff-merges options
anyway.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-generate-patch.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index b10ff4caa6c5..2db8eacc3ec7 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -81,9 +81,9 @@ Combined diff format
 Any diff-generating command can take the `-c` or `--cc` option to
 produce a 'combined diff' when showing a merge. This is the default
 format when showing merges with linkgit:git-diff[1] or
-linkgit:git-show[1]. Note also that you can give the `-m` option to any
-of these commands to force generation of diffs with individual parents
-of a merge.
+linkgit:git-show[1]. Note also that you can give suitable
+`--diff-merges` option to any of these commands to force generation of
+diffs in specific format.
 
 A "combined diff" format looks like this:
 
-- 
2.25.1

