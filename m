Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BF1C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5671464EDC
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBBJkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhBBJge (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:36:34 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D157C0611C1
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:34:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g3so12155401plp.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AKVyUTQ0PTfwwq76gRTHowmfpb1YnfKrY/iiF8w8GJ8=;
        b=r79VgWQ1SPARulh/JRIyUZ+ckvvqMN4nZkRQ07O9YDvX9NIrILoZE9zM3GgAepfXsY
         p+U+a+TT98nOhNVADiC5CDoIBo2hiU35hfRh7iSsyAQYXdJDdXg4dNv8xOXk0G09xGxa
         cNM0PMx/BxrTbmlukGLKi18zcBu7nmsm4LqW3dR8hz08pJwhATjKBccgmpyvr+jJv7Jv
         iNMVVC7GPLIQnLDYw3geUTRueVQ/2davGeuyFzVt2xYeYp/gaxbcJPzUPbAwS0ZWB+M+
         syQxlv1eaVRX228blvza7naW2+CMvrbfDFqLIWA1rROgi/Sy6NEsgbWBFQaMb8+Ijy3L
         pXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKVyUTQ0PTfwwq76gRTHowmfpb1YnfKrY/iiF8w8GJ8=;
        b=Sm7JTeEHwymtWbVrBk9xHsIq3jJyyGqpT7nINT+k7mnGjuUTUIr5J1/1TH/pyyErYk
         4MqMhAbQ/TmhzkjxMgZXBgQ5XYwHvlseFHGUBknVVx2JdJb8MEnp22NvwrEp0lo0Vx/G
         C+ajNTPtn1GD8i477rFed0ZxqB3cmMSVEw1Q/7op0m0inCYbFY0QGeV5mq7KMg2LxZv5
         gJXDhZRVGFnrd78yLSYqPRhBhu8nYuvg4UWCirYKNA2iWygNsDy6RhyECok6JOQ3hJUF
         ySP7FTkFfH9zCJyGEeJ8GW19eEZlmYNtk4iJoSZd0/Je3Ux3Q4IKDxPBYRGhKPviqhcG
         ku7g==
X-Gm-Message-State: AOAM532/pvnhqOOhGgcL1I9wTbRQmTUgt6KmLRLANiIpFWefF0X8l+E8
        3XejySCeHPHBilmxDlWSWgx4Bvj1OVM=
X-Google-Smtp-Source: ABdhPJz+Sdtly9YNZDG5D7CVRdwvomRi5P0VwCQ463yq47Ylu3v0UlHDrqv5eYZFA7VbnO3RvAamnA==
X-Received: by 2002:a17:90b:358f:: with SMTP id mm15mr3430630pjb.13.1612258459939;
        Tue, 02 Feb 2021 01:34:19 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e21sm20584462pgv.74.2021.02.02.01.34.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:34:14 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 6/9] t3905: use test_cmp() to check file contents
Date:   Tue,  2 Feb 2021 01:33:23 -0800
Message-Id: <4a5dd83ff4269c10e20e0af4867d3c574b04edf8.1612258145.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612258145.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modernize the script by doing file content comparisons using test_cmp()
instead of `test x = "$(cat file)"`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index c87ac24042..b26a97aef4 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -103,8 +103,10 @@ test_expect_success 'stash pop after save --include-untracked leaves files untra
 	git stash pop &&
 	git status --porcelain >actual &&
 	test_cmp expect actual &&
-	test "1" = "$(cat file2)" &&
-	test untracked = "$(cat untracked/untracked)"
+	echo 1 >expect_file2 &&
+	test_cmp expect_file2 file2 &&
+	echo untracked >untracked_expect &&
+	test_cmp untracked_expect untracked/untracked
 '
 
 test_expect_success 'clean up untracked/ directory to prepare for next tests' '
-- 
2.30.0.478.g8a0d178c01

