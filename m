Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817D0C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD3B6100A
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFWWAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFWWAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:00:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8FBC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 14:57:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id w13so2593505wmc.3
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7BmoOqJThW4TtHUSoWWHnrsVWuPxM0Jf1kqefXwxhFo=;
        b=rfhQdG9iSlvdFF5FzyxKDlLehBqn/fhRa7viyWWYiJXD5GQQFjO1qpQ/eNoLnjpvoP
         ryRF9q0muhypmplUz774/4vTVFCsIvMPmIwXx3qWdeG/XfgYQZT8dBIZkQhVNKPiV3aA
         L2lRt6c9mRf550u9gZ3/EyHpNGy3hu92DCnxf1HPicBQ4/Te5mBXAhvRsjNR/Jf1Q/ps
         2M05Mgb5fQ/r1IPUO/t8c7Ll9/61jXGzOyXmOgQA2B6aj508wLyUprfGVaSXIi4t3H8n
         NSfVwdnkpezDmB1RnDxgmc7kCskGBzXGsQf5E/MCB7BRFw5jxgdgvaLFH6Aob1IYFab1
         x1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7BmoOqJThW4TtHUSoWWHnrsVWuPxM0Jf1kqefXwxhFo=;
        b=SMxAPutwfzUp9nC+7kfCFntPeE+eCeeKF2HM+qLX8uy11FlhtYuGjjNgSqf8RUJHgB
         bzQTaymJ/qUbX+NtqHIhDScSJ6nawqK/MqzMVnhQvNBo3UmFql6t7Qc/Om5c8AahqscS
         D6JZoWiQQD2YskYBI82DA7EuNnTH4xzHx/gGc4Cc3lcLtHntMGyYClRo/9sMVp/DkJ8M
         4aXPWWUmB21oKUM5WTwO/8v176cY0TdlwP9cGbyIntdFLtA1wft0WAbO9SSL5zDN49vz
         llwAU8ad1d73CWvUbMa8hlY8w4swNrSqTuZSwqQYbdyd0S/LtcaP6MvY+U8g+YgKn3Ca
         UrKA==
X-Gm-Message-State: AOAM530I7K+Iwzjp1pijrgcQ+pAjst6PEk6xJlKfSWTTB2ndfZff2VOO
        hnGHr1X56XnQUHeaDtlT9GaXAeTnvRY=
X-Google-Smtp-Source: ABdhPJzhD3jd6f1TWmdMFIA5l6V8FHZTfnKCHO0a0caVqVbw5DZ6M1p6myKHrr1xn5wCFLcme8KFIQ==
X-Received: by 2002:a7b:c187:: with SMTP id y7mr276261wmi.13.1624485469291;
        Wed, 23 Jun 2021 14:57:49 -0700 (PDT)
Received: from localhost.localdomain (94-21-146-91.pool.digikabel.hu. [94.21.146.91])
        by smtp.gmail.com with ESMTPSA id q11sm1192348wrx.80.2021.06.23.14.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 14:57:49 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/4] preload-index: fix "Refreshing index" progress line
Date:   Wed, 23 Jun 2021 23:57:36 +0200
Message-Id: <20210623215736.8279-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210623215736.8279-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210623215736.8279-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 preload-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/preload-index.c b/preload-index.c
index aae6e4a042..757dbeced6 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -86,7 +86,8 @@ static void *preload_thread(void *_data)
 		struct progress_data *pd = p->progress;
 
 		pthread_mutex_lock(&pd->mutex);
-		display_progress(pd->progress, pd->n + last_nr);
+		pd->n += last_nr;
+		display_progress(pd->progress, pd->n);
 		pthread_mutex_unlock(&pd->mutex);
 	}
 	cache_def_clear(&cache);
-- 
2.32.0.289.g44fbea0957

