Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64816C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F80206D4
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfvhXFwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbgFWRrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733253AbgFWRrU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:47:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F7BC061755
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so2122967wmj.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c/zMv9Pl8Px8pPuhdc4kPadMp54xcVAZZhck8gDDyHc=;
        b=DfvhXFwA6LlwvnSTt72akRIxC/5hOOc+rDOEFhog3SDKLPgN+VtreedhFN0zCJUSDM
         y2rEFh9dzS8hvXywEzIgepmvBac8sE5QXYNyR1R3/P/3bDxBoP18PU09V4hfowDjMCuW
         jB+8jfySxyF2nKMo+N/U2U++EjtYgiByqKHuLrn8UG7x0E8zv1je8lIIZUrTcl3d/zH+
         2sl8a+6STnVn2OPDDai20DigNXDJQbKS3T93O9U6MeAizyB0xBqREgVUd7KxcuAl12OG
         JhcP1D/jPwyIF9+bchSamQgBZ91hr2bpu+gDoF4o1ytZomLTs5enryUin38HuwNUfTVJ
         jHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c/zMv9Pl8Px8pPuhdc4kPadMp54xcVAZZhck8gDDyHc=;
        b=Lah5eyUaE/d3c3l3VkUlKvZh/C5z46+jmxbznep9JZ4beHa03nPEkfszXi1y3P+iC3
         BVq2BaZPdvpumQFf7Th7xQcEg9LuLiD7fWvoL7joC9WrCKHqDWeaqUlGziKP3nMWkDI9
         lrDfXQo3pWXC8J0t+c9OqRcY3RHmSarDk+KzOUlMqxR8VLfCqrL8N8m5U/r93mmVPSWM
         knurL0gPrvoi24PmiPhfJLPUioH+JxLYY+iR/DVOecM3yvW9lx9mKnBU/iC72Hy4iGUT
         Jem/N9jKJHKzFIUPBUjbgrhoqyxHEWJIAAQ1lzQDs8qQC5RWcdjtMN65kDjkUI+RjmZb
         nmUg==
X-Gm-Message-State: AOAM533RgurmKgQptKUe7AQQPQCL7Vo3nx+3pfjQ2HEJvqgJyeEQ/wEv
        g9OIZylEKo+RqwBYO3V326erchBs
X-Google-Smtp-Source: ABdhPJytEh+RO3enMT8HoWLbiIHqVLF24kmw1gDqBEO0OSFk3IZ73fWedaMUI7BoYriLbFX5FSgVSA==
X-Received: by 2002:a1c:2e58:: with SMTP id u85mr24970864wmu.123.1592934438583;
        Tue, 23 Jun 2020 10:47:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm25571185wru.27.2020.06.23.10.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:47:18 -0700 (PDT)
Message-Id: <0bcfc1f05126767ab6d6125a2b04d6d7392eb519.1592934430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:47:07 +0000
Subject: [PATCH v2 08/11] revision.c: fix whitespace
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Here, four spaces were used instead of tab characters.

Reported-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index c644c66091..ed59084f50 100644
--- a/revision.c
+++ b/revision.c
@@ -697,11 +697,11 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 
 	/* remove single trailing slash from path, if needed */
 	if (pi->match[last_index] == '/') {
-	    path_alloc = xstrdup(pi->match);
-	    path_alloc[last_index] = '\0';
-	    path = path_alloc;
+		path_alloc = xstrdup(pi->match);
+		path_alloc[last_index] = '\0';
+		path = path_alloc;
 	} else
-	    path = pi->match;
+		path = pi->match;
 
 	len = strlen(path);
 
-- 
gitgitgadget

