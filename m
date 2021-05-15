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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02573C433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB486121E
	for <git@archiver.kernel.org>; Sat, 15 May 2021 20:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhEOUCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 16:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhEOUCi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 16:02:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B430DC061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 13:01:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p17so1643034pjz.3
        for <git@vger.kernel.org>; Sat, 15 May 2021 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/fyEZE5nMBNOjE7AZjp+yfA5RUq89K70VGZNhS/920=;
        b=aWWZYYyD385eE3CDW91z8T4I1JeikD8RnpwceZFjscv8M6jI4R1yhB88g/GuafQbHD
         HYWilMtAgZmWZ1e6csXR2EqLbPlJxnUp2hORWfeUipxiB++LmKE4NmohaEi9q0nu0Hy1
         XN2dqC9v0YRXL4BhHW1Iul+bhXbUAXy1Sz96r9V6sf/UmM66oVcwV/17h+EUdLDyjKJW
         E00Fl0d8/mQEXxKuorq7nB/3v89mgXIW8ncEeYsT3yNaV9bz8Zp3yOtGUbC9zsvqB895
         FUA9ffr/fzRlZ0JBK+egKxmp+NfPnsVsDAMaTgLon0pNvELJaMweGeDz2fDr47Ut6l9a
         VW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/fyEZE5nMBNOjE7AZjp+yfA5RUq89K70VGZNhS/920=;
        b=ECylEbyWyWlSa0hcOvgB/9JB1VUVnrTflznXdmvkuIH/uazu8ReXhte8SvqdPW7d+e
         dB4tty2VPJFCCeVb4+ey2t6TbG7Mqt/Vw3htZ2N8yjNtM1peXx5rfUaTvQWEu+LvpLyT
         hwkILo5R4cCnhxeetSZ+rLgPn80M8TOAJYLlkXv2bkf/A8DceuGJfup7Uv1j86qGmImB
         PIWXn8PZYrHO01rjnaA/N3kpRG6GrewnbZUoOcs5ntZxqcdedZFqZEZYR5xYPaUfuh/t
         qV8XBv4b+XduWTiw0WUa3b+npVaQq0VEM3bAq5fqmkFGSP9YnNqqgpyA2EJ2fRCYL0Iw
         ZlpQ==
X-Gm-Message-State: AOAM533hrSYvBh2LW2zsIpKWmDYjSdAseflwKkek60oDwNVby/gTlHOv
        /hdIAq+ytYXF4ThatojF4Q5bfh7Zmx0=
X-Google-Smtp-Source: ABdhPJzUNzixyXqK5o0RWyxNdm194RUJZkaT3rA8MQKv162sCjjC+ikc/CbbXLMltYh6wlPoS7gLYA==
X-Received: by 2002:a17:90a:9105:: with SMTP id k5mr13204276pjo.48.1621108883716;
        Sat, 15 May 2021 13:01:23 -0700 (PDT)
Received: from xavier.localdomain (24-119-22-118.cpe.sparklight.net. [24.119.22.118])
        by smtp.gmail.com with ESMTPSA id o4sm6680495pfk.15.2021.05.15.13.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 13:01:23 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, pclouds@gmail.com, judge.packham@gmail.com,
        gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] merge: don't translate literal commands
Date:   Sat, 15 May 2021 14:01:11 -0600
Message-Id: <20210515200111.19912-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These strings have not been modified in any translation, nor should they
be.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index eddb8ae70d..a8a843b1f5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -56,8 +56,8 @@ struct strategy {
 
 static const char * const builtin_merge_usage[] = {
 	N_("git merge [<options>] [<commit>...]"),
-	N_("git merge --abort"),
-	N_("git merge --continue"),
+	"git merge --abort",
+	"git merge --continue",
 	NULL
 };
 
-- 
2.31.1

