Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EC41F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 15:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeJHW3R (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 18:29:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44165 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeJHW3R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 18:29:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id r9-v6so8368029pff.11
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KP51qsoDsnzDw8hwyR/tzMp85bgwLf40on24ZTmcMNw=;
        b=CvEEF9art3sdbvipTGb4KL+TS5zysfg7pcKeQFgLE9t0W09T5+K0g4FpA1taE+YQak
         OqPlnmiHy3qj7j71h/ao4KK+3lkAWTYj/B4S/c12MEbhtF+k3lwxEu7tsaseyJdjNSyS
         y0Y1Ggz3oZgEJ/ZSaYQ84JpS7ukRfMNhnUZOM3VfNfPw7JJKakuZiLmVUbG5HkGpUqdY
         ZU1oxZIitYcCimYR6ZBwRKwR6kC7rTZqVkHZmdPUqtDE+7981oLOUP6iFU/5Yv4Zat05
         vZXK+bghKwE7xbwbujN7MmWYpZbZUjoioUy49/2+RrkJO2AQ/HPvejVnx0essGNFs6IJ
         3n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KP51qsoDsnzDw8hwyR/tzMp85bgwLf40on24ZTmcMNw=;
        b=IvevVERp86MnBrX4u+EAiT3FXOlaCz99NqK4Ds+a6d5lTv0Yqj0FjDAaG280HFJhQP
         PWvfyYnqQaNGdOcyK1oH1Fq7Zhcs6lbd0IhslCpVEtcsBhq7IVUFqabKRc8kmOIBlZJi
         w+7x/ZN8z1cJZX1DRYCoBiY3UBwvZ6yDp6Na3ES0qUiBjZ0c59eArtIyYYCep7yV0Ne8
         bMx3/rqZQiWa1qJGogyJRjYFmDb/gjs4upXXCt/b+DBDmkyeEuJij0z5+ot8zxXhVKXM
         gIYiW14p2xpusHN1nTK546H0F99YlOY/GMGjAr9hMKvfny+1VqE365y1lfpBWOnqqKZr
         E/UQ==
X-Gm-Message-State: ABuFfogOFwGvQtQuYGJ4l2Xf0vHpQTCRtihyukZC2Fi1ISl0RIRg3RY9
        5j2ZcKIniDXrdZbOV4xllWCwXdbY
X-Google-Smtp-Source: ACcGV6111tPnuyWc8/Or2/jtOSvdN3ACE5G1yZ8WUeri42qM5A2zAQA6b8Tzsw1heMds5C15X1WEnQ==
X-Received: by 2002:a63:fd58:: with SMTP id m24-v6mr22098967pgj.132.1539011824275;
        Mon, 08 Oct 2018 08:17:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id v190-v6sm26659773pgb.16.2018.10.08.08.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 08:17:03 -0700 (PDT)
Date:   Mon, 08 Oct 2018 08:17:03 -0700 (PDT)
X-Google-Original-Date: Mon, 08 Oct 2018 15:16:57 GMT
Message-Id: <9fcbbe336dffb16b7cb5f4de0163404a81597af1.1539011820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.27.git.gitgitgadget@gmail.com>
References: <pull.27.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] midx: fix broken free() in close_midx()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When closing a multi-pack-index, we intend to close each pack-file
and free the struct packed_git that represents it. However, this
line was previously freeing the array of pointers, not the
pointer itself. This leads to a double-free issue.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index f3e8dbc108..999717b96f 100644
--- a/midx.c
+++ b/midx.c
@@ -190,7 +190,7 @@ static void close_midx(struct multi_pack_index *m)
 	for (i = 0; i < m->num_packs; i++) {
 		if (m->packs[i]) {
 			close_pack(m->packs[i]);
-			free(m->packs);
+			free(m->packs[i]);
 		}
 	}
 	FREE_AND_NULL(m->packs);
-- 
gitgitgadget

