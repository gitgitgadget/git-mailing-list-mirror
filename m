Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85596C3DA7D
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiL1SAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiL1SAd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AB9167DB
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:32 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso1560037wmq.1
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXWIagbtD2cbO2YSWei28RkhNOZXX5YB0XQXtnbi628=;
        b=HNZVyr7Dq7sbgpaQsf/mRGGC8oTRueCpZ/AQemifgUeJAKH8BNaU9Cn6yO2TL7tI7x
         NYUQFMsAspeT4M6Gem1w+ziplInm2FlWS6eNai7+yqNd56g8fig5goRisMlHNcLPkTRS
         iCEtYCnfycwErrxJ1aWQ3fm84ehejF+YtcyoI0ASTvlpxDknDreo3Thw3yi8S8CZ1dGN
         yyY5Ouj08m6NmbpsciIObXY/t3l+mMqFjsltrFRXm0FOI8kxK3AxMVfFEOr7ZqCrF0M8
         RYNo1Hy0OyBwPD5RRYBoddQEk4n0zVnXJoGsTiF1+bwqLTePPI/yHxYnm7ygnSGb1imZ
         w7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXWIagbtD2cbO2YSWei28RkhNOZXX5YB0XQXtnbi628=;
        b=tT7RFPJNYMQytOm1X5JlEHVm9PKb631ITHo4G8QmW0k8VXbw85TaNSRAoyVrix6itS
         gvrua8/xuymzenUc2ZKEDjegMVA2PSNPHQ00iBNbteWa4t+vgDBZJJ4mBJQftuq9hdB5
         87KYzBpVTnux4m63uevqC4Yd9749oxugXnvk5PwCj19/LhYiUk0o/PjDprCSuDyMDUE8
         +FJf1vNlHiBOuJ5641dZxqH53fZ+IhLNLyGiXGEL6ibQUgsJUaH7SbSOex5NSs2qWBPD
         ICXJnmyeLULjwuOO7M0L+7oRpFNHWkK9+A+3gnr6uK1dFKivW5zhlohNzI641+PksyJY
         tDbg==
X-Gm-Message-State: AFqh2kqGERhnP3Clb2F5cx9f+k+HbTxC3SB9HtYsYi7xWxgG1JW+nDeB
        Pa6par9o9cFxDDoCWyTzcl+/cPMydap+HQ==
X-Google-Smtp-Source: AMrXdXummI7vwJWlBvJtpHtRrZnPcSL7i/61F59qG6U2xifYK+/GY6GCghjPaPiR7t56WUAd9OUmQw==
X-Received: by 2002:a05:600c:1ca5:b0:3d1:d746:7bca with SMTP id k37-20020a05600c1ca500b003d1d7467bcamr18404854wms.4.1672250430308;
        Wed, 28 Dec 2022 10:00:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/20] commit-graph: use free() instead of UNLEAK()
Date:   Wed, 28 Dec 2022 19:00:04 +0100
Message-Id: <patch-04.20-5be87f9720c-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 0bfb48e6723 (builtin/commit-graph.c: UNLEAK variables, 2018-10-03)
this was made to UNLEAK(), but we can just as easily free() the memory
instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index e8f77f535f3..b6e5726b082 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -67,6 +67,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix)
 	int fd;
 	struct stat st;
 	int flags = 0;
+	int ret;
 
 	static struct option builtin_commit_graph_verify_options[] = {
 		OPT_BOOL(0, "shallow", &opts.shallow,
@@ -111,8 +112,9 @@ static int graph_verify(int argc, const char **argv, const char *prefix)
 	if (!graph)
 		return !!open_ok;
 
-	UNLEAK(graph);
-	return verify_commit_graph(the_repository, graph, flags);
+	ret = verify_commit_graph(the_repository, graph, flags);
+	free(graph);
+	return ret;
 }
 
 extern int read_replace_refs;
-- 
2.39.0.1153.gb0033028ca9

