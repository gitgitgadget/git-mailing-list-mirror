Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D35C5519F
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD0B221F8
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTLwDMU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgKQQMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgKQQMd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:33 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C545C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:32 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k2so23787883wrx.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uFf/6xSX7E+6jNyGq0NSZ/TSaTJ/LkXm0TtRomb+Z68=;
        b=cTLwDMU7UVxm6xIFUTpxM/TbNVJXJ3AHplJKMNTfJ3ghNNFPY9mKO+0LN43iclZDHT
         WSI63Cu0KUHJOJeugMlsksXDPuqMPsc4XXVlMMAVHxjfyZ3Sx0nJjPt11IXXO2h1pimU
         kB5YFRdRqGp2N33ut0RPAWHUVaYYs6cDhdz2RUCqLG57/BMAlTWLbRE6+CqeOhUSy/fP
         YCu2KpPRsMqLxLdmd99Y4TPO84NjRP2wOEXqffoQ1MowSZq7QEgqVuCmH0UPNUmLGArn
         o34XyeI3CmoOuhSbluvfi8+LxfOn+ICEw4eCGdWTx8Is7T8sJG6avkXPlhHhCPRIUDSE
         4tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uFf/6xSX7E+6jNyGq0NSZ/TSaTJ/LkXm0TtRomb+Z68=;
        b=ZHlGltr4Vs84Qzm29LOKOwG2HWCwtW/5d2c/UxLBJOVbDIPN8skN+vis2Aa+PXNlee
         nRLnU3GFScGwgyjD51aaOVHeEgTKLCQM71bpYOzR43Uyn6ZhLqVIjbsOqxgllMjcBxTE
         kYDtbKjxjZVRTa4/MokhtDryM4V1uCyvQphY3n4tInNXR3BUpbe1MeSBTywONlBGZdwo
         wBQdiGC95QE2CDdpo6UPDn5AmML1Dk3ud8Wp3Ym/tG/2FUN488UupT5d6OY+bCe1of+E
         JMnC4IORMn5W0UdTwHozT0v07D6/Vrhj03UpoV0B+6r0gwEMHbJc1q7tVFFVj9Gn+wgf
         jxYA==
X-Gm-Message-State: AOAM532tbd9ncJxxfVQLBkqWVjJYaSc/unf8y9nV8jilAuV61+pl+qQZ
        pryJ2ltwJej4L1HdTqcgRffFMZnKFVg=
X-Google-Smtp-Source: ABdhPJzEbMSOCU22PknJ12eNZXQuAJzfC92sH6WoaQOomzcqKPKq13PTfGZWml7raN1JHG9DPVbOsQ==
X-Received: by 2002:adf:9d84:: with SMTP id p4mr261566wre.370.1605629551099;
        Tue, 17 Nov 2020 08:12:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n128sm4572445wmb.46.2020.11.17.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:30 -0800 (PST)
Message-Id: <0a05d319c0fc2e88b94ebe488af8d02a0ef63821.1605629548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:01 +0000
Subject: [PATCH v2 01/27] t0060: preemptively adjust alignment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to adjust t0060 for the new default branch name `main`.
This name is two characters shorter and therefore needs two spaces more
padding to align correctly.

Adjusting the alignment before the big search-and-replace makes it
easier to verify that the final result does not leave any misaligned
lines behind.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0060-path-utils.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index b2e3cf3f4c..928eebbdc0 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -312,8 +312,8 @@ test_git_path GIT_COMMON_DIR=bar info/sparse-checkout     .git/info/sparse-check
 test_git_path GIT_COMMON_DIR=bar info//sparse-checkout    .git/info//sparse-checkout
 test_git_path GIT_COMMON_DIR=bar remotes/bar              bar/remotes/bar
 test_git_path GIT_COMMON_DIR=bar branches/bar             bar/branches/bar
-test_git_path GIT_COMMON_DIR=bar logs/refs/heads/master   bar/logs/refs/heads/master
-test_git_path GIT_COMMON_DIR=bar refs/heads/master        bar/refs/heads/master
+test_git_path GIT_COMMON_DIR=bar logs/refs/heads/master     bar/logs/refs/heads/master
+test_git_path GIT_COMMON_DIR=bar refs/heads/master          bar/refs/heads/master
 test_git_path GIT_COMMON_DIR=bar refs/bisect/foo          .git/refs/bisect/foo
 test_git_path GIT_COMMON_DIR=bar hooks/me                 bar/hooks/me
 test_git_path GIT_COMMON_DIR=bar config                   bar/config
-- 
gitgitgadget

