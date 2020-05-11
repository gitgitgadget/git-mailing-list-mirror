Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB89C54E8E
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C61A208DB
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmqTlx33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgEKL4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729872AbgEKL43 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:56:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777F9C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so18869556wmh.3
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=N+OYlNIdFj9SqGVPBqA/nbDPJTmYCtz6vCoqvufPBmg=;
        b=VmqTlx33HtxCwLv4FqyS+gndNwaeEA1kYg3uIekUysjYzTnoKDoRYwnhFMCvA4fihT
         XPCU/1rUgAtMQachLAEzoHUx3Fw/b8DaXRRzO4alRHUzWoCclHCA3Ly3/DBLbGKBVQtD
         Aq715rdUbYKa7oMXLuB8tmpibW+wQObPaQ1M1cw086SjKkzV52SqsqdtyBymDxEiO23+
         0W/1d4ZRI2T4fYArlx/cd+4DAvOToPYcQtXqIUf2wIXETTqyDTUAx2TsbXaXZLTGS2P8
         DfIv/lVYgcJUWFGpcmC8asXJgMwT++KyEylXCB1a9T9r5XO3nbNkKXjKHqQ4c3Rk1XSb
         N/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=N+OYlNIdFj9SqGVPBqA/nbDPJTmYCtz6vCoqvufPBmg=;
        b=M+2ymYFgnXpKEAHd5a+0N654CGDixVYDVyqOBlKcrGp3VajkkfTSWSdYGrvQBKLxU4
         r5OZw7MWJnUe3jMz8ry8nB4MOI+RXZ4cd/1KwP+l+AhZvQtO4BKmszw6C+5qQO0g9mr1
         WaTXVYGhWxroSqFPk2uqS+izk+9LFVYQSVhwvKD1M+tgzpjhvJzod3GJCeuocSZIg1OE
         ureyv7ip7x+b3+Yfm3J6wfQuc+SF/oS0vWb6V121WZ7CnypRoeAuJgBPFy/qen+BNq+4
         XEbqwpP+KL3CS7wNSgf5CHxAYdUoC6FoLmtJpHGXEfeAZgDV0t/ps8YIvD2ApMeCxccR
         G9nQ==
X-Gm-Message-State: AGi0Pub6SYKFR0xOxyOwhJ6XXWx4QBrQdZjPCkq66Lc5RrYlgV18AhCF
        rRIFNRCsDoHLBkKHegmMoBFQy1DV
X-Google-Smtp-Source: APiQypJ80O+Xe+Gc10CYHudu5ZOrk1V+yYSRKKNGQbV6g/OfNEA+a/qdYzxaJtIZRLQOD/f9dhkEXQ==
X-Received: by 2002:a1c:dd09:: with SMTP id u9mr4692699wmg.77.1589198188047;
        Mon, 11 May 2020 04:56:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm14327542wmb.18.2020.05.11.04.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:56:27 -0700 (PDT)
Message-Id: <c3f87ec4379ef31778e5184c81a38ed2b59b3cbf.1589198180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
        <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 11:56:15 +0000
Subject: [PATCH v2 08/12] line-log: remove unused fields from 'struct
 line_log_data'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

Remove the unused fields 'status', 'arg_alloc', 'arg_nr' and 'args'
from 'struct line_log_data'.  They were already part of the struct
when it was introduced in commit 12da1d1f6 (Implement line-history
search (git log -L), 2013-03-28), but as far as I can tell none of
them have ever been actually used.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 line-log.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/line-log.h b/line-log.h
index 8ee7a2bd4a1..882c5055bb8 100644
--- a/line-log.h
+++ b/line-log.h
@@ -46,10 +46,7 @@ void sort_and_merge_range_set(struct range_set *);
 struct line_log_data {
 	struct line_log_data *next;
 	char *path;
-	char status;
 	struct range_set ranges;
-	int arg_alloc, arg_nr;
-	const char **args;
 	struct diff_filepair *pair;
 	struct diff_ranges diff;
 };
-- 
gitgitgadget

