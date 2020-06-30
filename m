Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF55CC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAEBE20675
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUcNGf5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbgF3PDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbgF3PDc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:03:32 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D21C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 145so16376201qke.9
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sgo7WNu2r3te8+uwmFrMuip8L4ZIsuLTKZ/ygE5LUj0=;
        b=cUcNGf5xWIZ0I+RnKdTxmaZVizRRIPZlA2vncI3qQJMmvTO75rAv2oZYiI2qBI7cZb
         XR5+fwSelyopTrg87MUBUcB1tlYEjWw8yb/daRnkUKBZjyJvWle4brMiITNsdaDb5WSy
         1x2KAR77FqwTEAFSOgub033jm6aTn9mDcq/KEBTUlz9ZH6h4XmNhyS5Hf0FyXEDPZmEk
         43SZ/LUxA3B7Z8BQ17OXSO7Nt2dJKpFChrAysFnahvY+sV7MT8dXUX8j9bPA80oZcq7D
         1LgIQe4Zm3QLJTbTnOjCguNup62vnb/SuIfHoLa17MqqQg8o2CEhlCRRK915ySLdCPEl
         UYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgo7WNu2r3te8+uwmFrMuip8L4ZIsuLTKZ/ygE5LUj0=;
        b=bO9Q7s2EGEIZcsv7j0+YW/gLnd6TzYKZQo/HparLE7WOZEMXFc5KxhWUeBKa0NJ622
         Ytp9CwjRvc1wWz6CXuye385adWQ4lftljjTZtIbQUES2alxmZ98xP6MvJhJd68jD4eiM
         leTnWPDgEJYqB+pmWXr0kalAnmv4FR6tWyDRewwewPwMvHnnMXY2Z7T5ajDb+PvmuJB5
         zD4kt1TT0KqHIAUfhBxlEMpHoo5G1VXlTX5Ok6FoeLZ/oRlDNkCJ6SRSx3eOBUYMZrSd
         Jzu+QMtEEYAqZgvQwuPB6ghn2Qikdk3zX2swwabX71ywJv8GseqYrRXWJ220qHwkTifG
         sQRQ==
X-Gm-Message-State: AOAM532bMKttq2hMj/YKZmMcZ4ugEvxAyKDVEHLTFwlQyYxgzMBlWURC
        6VBiWSisjgYGN46n2uZlPN7+nRXoZb4=
X-Google-Smtp-Source: ABdhPJzGqC/ekKH4qdP69dZ2LaB5k2QUUyC7RZtavpDOQKd1EeE6gLMQl4374SDKrhFYlSmpT6PUQw==
X-Received: by 2002:a05:620a:120b:: with SMTP id u11mr19901275qkj.243.1593529410975;
        Tue, 30 Jun 2020 08:03:30 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id p66sm3209626qkf.58.2020.06.30.08.03.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:03:30 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/5] t5324: reorder `run_with_limited_open_files test_might_fail`
Date:   Tue, 30 Jun 2020 11:03:16 -0400
Message-Id: <aae48a89e50ce1841df33edbbeb17ae932c10d16.1593529394.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1593529394.git.liu.denton@gmail.com>
References: <cover.1593529394.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on only allowing `test_might_fail` to work on a
restricted subset of commands, including `git`. Reorder the commands so
that `run_with_limited_open_files` comes before `test_might_fail`. This
way, `test_might_fail` operates on a git command.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5324-split-commit-graph.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 269d0964a3..9b850ea907 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -399,7 +399,7 @@ test_expect_success ULIMIT_FILE_DESCRIPTORS 'handles file descriptor exhaustion'
 		for i in $(test_seq 64)
 		do
 			test_commit $i &&
-			test_might_fail run_with_limited_open_files git commit-graph write \
+			run_with_limited_open_files test_might_fail git commit-graph write \
 				--split=no-merge --reachable || return 1
 		done
 	)
-- 
2.27.0.383.g050319c2ae

