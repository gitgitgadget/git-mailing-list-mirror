Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D971FD09
	for <e@80x24.org>; Sun, 28 May 2017 16:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbdE1Q5c (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 12:57:32 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34898 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdE1Q5b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 12:57:31 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so9773917pfd.2
        for <git@vger.kernel.org>; Sun, 28 May 2017 09:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w+X4oO1RS9YrxUn3LuQOdsrVae/KvSfsDatRXtCTv0U=;
        b=jsBu+xVUI0HkEOHlQCGk/XzS2afzTbwIQqUXR5UDhRKkr/ypYbgb/hiPuZhbJayy9m
         xeJBDfeuwi/hlbQEmEvwVGO+71GwQMAuTVRPDJ0Qx4q1cLg5VUE2VDcCSaC1iNB6b0mp
         Qe8DjhJivv9aedIljXk+8qIAnQ+JQdQak3bTJ9F+I0/Tu0HbKTqxyHT7TTIfl0zG8iR4
         D2IlreKY33UVOWtThEnCjIbVRk+P8D2vvKyxQZ8R3CMymk1+FjiF529jZPdBHldI95/X
         6RppCGsnzfIunTl9jxUFGkuVkbQociGZY3qmM8Axq8pSH3k9XBwSZuwH+2pwKRkxD4Fp
         ZHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w+X4oO1RS9YrxUn3LuQOdsrVae/KvSfsDatRXtCTv0U=;
        b=jdChI1FqmzoiTYhActyCAmMW3/0XHYOAdfX0Um2R8K+GVGpuRswOt6BIPFD46Za35Z
         LQCqD1/LrGN27VCTEWw4wyQ/qPSeX+uSdYDdtwkIlPe6jm6jZZEDkg4/h7s786+p8zK9
         r3eg6/3F7nf1Xz33c+v2VwqZnGYSETuqAPMlSesGjL8DwAFpFLO9ptxjL7H0v18t+HlF
         g6KWkls4e3YS4OYteZg7kygs21w+jhRNJb3CY6U63b3u+UxFK0uTeflMlK5Xt5Kb8OYk
         4w/TE6lPuZgdop3q5vDFoDQbQdjryi2kDXu0JEu8DSLsKpIMx2nVlyGoekgu4SVEbmcG
         MrVA==
X-Gm-Message-State: AODbwcBUNUp8CGj4K4O0FtqtE7wKr4rAoQ79cj+gSvjeonc6uw4VY6tv
        PGDKvBWlSTEOWVDf
X-Received: by 10.84.208.236 with SMTP id c41mr71201316plj.95.1495990650545;
        Sun, 28 May 2017 09:57:30 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id w67sm12511824pfi.2.2017.05.28.09.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 May 2017 09:57:30 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     git@vger.kernel.org, t.gummerer@gmail.com, peff@peff.net,
        Johannes.Schindelin@gmx.de
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v3 2/4] stash: add test for stashing in a detached state
Date:   Sun, 28 May 2017 09:56:40 -0700
Message-Id: <20170528165642.14699-3-joel@teichroeb.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170528165642.14699-1-joel@teichroeb.net>
References: <20170528165642.14699-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index aaae221304..b86851ef46 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -808,6 +808,17 @@ test_expect_success 'create with multiple arguments for the message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create in a detached state' '
+	test_when_finished "git checkout master" &&
+	git checkout HEAD~1 &&
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create) &&
+	echo "WIP on (no branch): 47d5e0e initial" >expect &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stash -- <pathspec> stashes and restores the file' '
 	>foo &&
 	>bar &&
-- 
2.13.0

