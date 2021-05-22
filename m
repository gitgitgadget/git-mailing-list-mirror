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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A41BC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E388261244
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhEVN7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhEVN6y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E43CC061344
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j14so21974180wrq.5
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wQlllqGY5z+42eIeW/Ax1KavTjRNbCneblIipm+P3nI=;
        b=FvtNrW1t4PcMPIvuSOazSI7FUMeiF6YpjBpjq45YEcRM5+jPst+0MsGMAm0domthwn
         IrpSgmJQa+/rRhyrxrv8ZcabvoGH4G3HevLk0Lls6+rbNQJDsPYRhnQZXcbCpUti6VbH
         /O2HMBnN3WtQ6K3TAwbvnONbICa9TiSK3Gnzrij60TCQmVB6jaDB+t2HLgem06K5udTV
         dE1PxnDufZ0hluMAu7qsBiHrwbmK6zqn2WUDnEGuiQkOB2VNzOSbm9QacOBVXORy0pDG
         gVaT/lIwA7peUG95LElw+EnTnO8Ig/ppPSOIqT7RlxQeW57ovCpZ+F7vy7cB92yfBY0U
         xZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wQlllqGY5z+42eIeW/Ax1KavTjRNbCneblIipm+P3nI=;
        b=bQ1T2C0++OiUayFRgAw/ob2a6gFSMZWJBKjeYgM8TcWhODTUKsiA+kOcqX+UgHMjnF
         9M0rDLZ5M+LLhSztqy72YAAETNjkHsAOfkx8VkARHkUw9oaeFDfKRsuTvcTcemwKQKv1
         g5/nFoVIJ9EP1D6YbUE7gg226DvzqMPMlaYQCLZq2AVoydFv/qCVQFhpdSkDQcsk5bgC
         zvYxRTYQ0TJHJpruzfFqrdEdzo672UqZdb39KK7wIagPrNIWel67RYeOM4ZsHEA1rsHC
         X+fs+wvNeN3069z7cbAq2Ernil8IysjWhMCEKZbM7XQrUIuTCzddYhDdV5GG/cnuEmPf
         b56A==
X-Gm-Message-State: AOAM5313QLCfxsMGw+RmmKePrtDhhG/8kfxyaeWmNF9vpPsd7tK6oA1Z
        RADs1O6tPk74Ne5jE3rdbAQWhT8TF5Q=
X-Google-Smtp-Source: ABdhPJyODAuuDTpypU5pQSgyOGxtWS/zva+Eq7OmOb42CsrdmMkgEDu1deijI9GFS4vjAL4soRMsgQ==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr14167289wrm.397.1621691847869;
        Sat, 22 May 2021 06:57:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm5582440wrw.85.2021.05.22.06.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:27 -0700 (PDT)
Message-Id: <96a3eab819f455e56643158cd135f03530b66be5.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:57:07 +0000
Subject: [PATCH v2 28/28] t/perf: avoid copying builtin fsmonitor files into
 test repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Do not try to copy a fsmonitor--daemon socket from the current
development directory into the test trash directory.

When we run the perf suite without an explicit source repo set,
we copy of the current $GIT_DIR into the test trash directory.
Unix domain sockets cannot be copied in that manner, so the test
setup fails.

Additionally, omit any other fsmonitor--daemon temp files inside
the $GIT_DIR directory.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 601d9f67ddb0..3b97e3fc0f27 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -74,7 +74,7 @@ test_perf_copy_repo_contents () {
 	for stuff in "$1"/*
 	do
 		case "$stuff" in
-		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees)
+		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees|*/fsmonitor--daemon*)
 			;;
 		*)
 			cp -R "$stuff" "$repo/.git/" || exit 1
-- 
gitgitgadget
