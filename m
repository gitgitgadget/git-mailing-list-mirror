Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0713C433E1
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D2420724
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3vREqcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391282AbgFXOry (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391254AbgFXOrw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:47:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0BAC061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:47:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s10so2532110wrw.12
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jzq5Z8sPrMzIYKA6uw17FQivGsH+sEOsh8uUK5cMTDo=;
        b=g3vREqcIzVDhwOvHCgal7/VahdxccRXSXeN0nljgmFI8TB3B5uOJgf/jQDp3gFcisA
         oUv0vDZVDXJGt+zHUuLh/fBlWXgG9Ezu/c4Lv2Kum3dOVS5NzZLAIHFN5q/r8m6U6JCE
         p9DaPiTIHFfaN8aAoqJ38R7z4hxXDPuc5WVdF85iWrD3QSQA/kcbn5Uw7XEuqLVc0VK2
         p2pJPBvNIjoGqXGkzH7eSkO+IkeGq1fP+rJsPE7qefzm1scbNxUEhiDs5bAXF4cGl9Uj
         OMBtF9VD5LyDLHKyrMyVURJ452b8b1z81otkJQ/o5pNEVjRyK9qMtu26UKIzH5cbx/kU
         9Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jzq5Z8sPrMzIYKA6uw17FQivGsH+sEOsh8uUK5cMTDo=;
        b=MCHfipCTPrNPwhUXE33Smt5cpYEWplyn1Y7olqxjTnaQ26KXth3o0p2MrvUhgfqdxS
         KuChpzIwNKKwx2NX4iXF6xuPQtoT3nWbAQ2KUHm4PTCU+5hSMlWaVcLrubrPDgTWS2vz
         bKYvzYxaetwIPJx7Jqfb44oG9rEhu3Cs7sj46dMeQ5MWpaxpMjqrRoJuWyD5xrnT7HFD
         qW87wjqgd5BdiMVzt+NXBo8UizD4yXBkegOqxwZDsRRXGdQS58jS9pUFaSgdExYilDFQ
         bKWZSaC4kqRL32WGRrB4bCLTuMF9/uUhwyLTHIJRjdDNo6J8XeOYClUIb/1zk8uhoRDd
         o16Q==
X-Gm-Message-State: AOAM530fhNkDxNMLitKwrShgRLKXFeETcugW4FHaFyEzbJ7Frmjy4/o6
        VfhEjs++dtS1XOKCXmMa0649lcA52Y4=
X-Google-Smtp-Source: ABdhPJyNOeV4wwKRK2i2DfhEpC41+aJKCpFifNCt/gyaypTv8R/ExxYmjfK/S2sDNHbFZKVh5oJmMQ==
X-Received: by 2002:adf:ea06:: with SMTP id q6mr26100548wrm.69.1593010070405;
        Wed, 24 Jun 2020 07:47:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm1919377wrp.10.2020.06.24.07.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:47:49 -0700 (PDT)
Message-Id: <f51cbedd3f3517cc7d097501d2188709b11fc013.1593010066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
References: <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
        <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:47:46 +0000
Subject: [PATCH v3 3/3] difftool -d: ensure that intent-to-add files are
 handled correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In https://github.com/git-for-windows/git/issues/2677, a `git difftool
-d` problem was reported. The underlying cause was a bug in `git
diff-files --raw` that we just fixed.

Make sure that the reported `difftool` problem stays fixed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7800-difftool.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 29b92907e2..524f30f7dc 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -720,6 +720,14 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -N and difftool -d' '
+	test_when_finished git reset --hard &&
+
+	test_write_lines A B C >intent-to-add &&
+	git add -N intent-to-add &&
+	git difftool --dir-diff --extcmd ls
+'
+
 test_expect_success 'outside worktree' '
 	echo 1 >1 &&
 	echo 2 >2 &&
-- 
gitgitgadget
