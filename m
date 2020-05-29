Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C6CC433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76316207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS7iQ/Hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgE2IvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2IvC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B60C08C5C6
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so2570470wrv.4
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lJtXgjvmPX0bWg693Puho7kU2Einhh9C74g93LZTZE=;
        b=RS7iQ/HgtqkYuh6M8rGBmfjwcSCG5TsqR8jAw7lIBcs20oHt+6hCMuaMnVRrg/JKAo
         65TQrcbCvov55Qm+YGjM0YS3wvjHY8VWLO/KuJOtgTtdNaAfIPWg0wTv5a0YtzYx5pcH
         CdV/2K0E+nQMSBaz0AWiacOTC7EsBIJ2niTvGRsrwHPIqUx7OsMydznavSxiIT0/fDVm
         QxxuvXnNAXbC0dbfZiRsREkdkb0XKmG1QXJ4EZAW7FJCCBm4ukFXK29Ixr4fG0/UkqOv
         f8oOrHEjCcfSJhyVs5zTT0wrZXMVDDlfu6HSAd52nQeHxSl+hibCXNqKqCfduI/Im7eD
         rHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lJtXgjvmPX0bWg693Puho7kU2Einhh9C74g93LZTZE=;
        b=NJ1aUIHelXqZVzDC8Jumytj8K9/6v52PzrgyxOqWBO5Ui0tOwQOlHNax6v7115oTHT
         uLWFFBR+xdxXLtjJHzk52uUHPfqheixckqG86jMGXvMYQEe2poRQQe6vlplfmq2jBbza
         rSFzRcz+akKMX2Y/8gXl/Uc37G7jEb1nboIXKKD821GLnWvX4TDOGR9k+A6S7VfRUxGb
         xxKWpv77eiRT0HW/GnBxp/BZ0emNY5UvzZJIjDEuNUt4agLuqUCKyYdCfhzI35K8bT5i
         e/Q/YaNeZro6WH3eqfHjxSWQi2rrYtuKKzTU62JU1H/88fK3ArfdjtRKqqBinpjEpY40
         3Ldg==
X-Gm-Message-State: AOAM530N4TD3RPZLzfPnPIKWcs2Gp9Tt2jgmYQ+VbVXCeAml3O36y6vI
        PlbHabvSevtd8lBr9LF5FObE32hw
X-Google-Smtp-Source: ABdhPJyvekspXUrv6ff0YtSThEIw1M1roPlAIv2LG1dBZZVisoaPf2RrpsIa48+Gk0zswwbTrrJyHw==
X-Received: by 2002:a5d:5389:: with SMTP id d9mr8223139wrv.77.1590742260723;
        Fri, 29 May 2020 01:51:00 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.50.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:00 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 03/34] commit-graph-format.txt: all multi-byte numbers are in network byte order
Date:   Fri, 29 May 2020 10:50:07 +0200
Message-Id: <20200529085038.26008-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph format specifies that "All 4-byte numbers are in
network order", but the commit-graph contains 8-byte integers as well
(file offsets in the Chunk Lookup table), and their byte order is
unspecified.

Clarify that all multi-byte integers are in network byte order.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/technical/commit-graph-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index a4f17441ae..efd0f99d8b 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -29,7 +29,7 @@ the body into "chunks" and provide a binary lookup table at the beginning
 of the body. The header includes certain values, such as number of chunks
 and hash type.
 
-All 4-byte numbers are in network order.
+All multi-byte numbers are in network byte order.
 
 HEADER:
 
-- 
2.27.0.rc1.431.g5c813f95dc

