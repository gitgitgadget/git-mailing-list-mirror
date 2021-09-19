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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F97CC433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7373C60F21
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhISBuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 21:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhISBuX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 21:50:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22A8C061757
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:48:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so12919408wmc.0
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tSc0od6Az6ENc+HVeZwXnecYX2Us13ykcu0YSknwnAA=;
        b=cq3773BcwAeJU5GZ8J4Vr4FDtp2cTKWT2stkKRMMtJCO8ag/00VxHEY05QEYwh4JRU
         bVH2L9gHZoNBp7NwyeNk6mZjidKhosmNEu0vRnAdNjYs5rFvERzm6aviuYu1aK/Z/OV4
         EMIXC2+koAYYIpbQSWpS749lKEuyBoJOX1X0+fm53icQM9LCrw7qDmXcTn7+X7RCcHfb
         zMt9K+I4FXq0o7GG3ajEnPAgtcgmFDXLYSRht4wTeuUydE5yOTSVwlUtcAJeJHvqSZnr
         c6+xLkl/Kd8nq2wdemIPz4/nRcgaJfjQtJKPW5auslH+jpor7Y18VWAVOsqEMgQkfGsy
         V+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tSc0od6Az6ENc+HVeZwXnecYX2Us13ykcu0YSknwnAA=;
        b=YiNpngo5HPJmSwO1Jq6mRpOpbdg7mogh4RUg6krIGSUeT+KBolpvSzAr2VgHo6nYCK
         sRvhPgzif3DU3aN3par6fmnYlgoClomWsv0W13cjclDgTTv92Uw2SU9JY1q0PjI6Or6W
         WJ0lQionsoevxPitZuIuzM5KRG/a5wnsud4VbGR4dAHtzqMRR/CjYY+tg1EV0558Y1rp
         Ys3RJswX3QbxYFsJ2T8PhoQ9UwzbypDwR4HjYx+n/KHjL3kbIrpU0C8qDXz1xYmY/FQI
         IRv7B9UwgXdQiHSaXeekegNAcDA9axrBJC3H33qCfm2ioluzn+y+31XgsM0afr8P9vUd
         2RCQ==
X-Gm-Message-State: AOAM530tBR0I17TI4Q8DrwSMxRi/Lhvybdzijmo1LpCWb1KMB6bURrl6
        DRox6N8tcFkcdvQLHvtBnF+wApRxIpI=
X-Google-Smtp-Source: ABdhPJy9MC0b2Ll3F/s+xlu4hiRkEH+R3ZOUXaCUt0lcjgvaOeqFk1bTWflq+8YQ4M6ZnfY75JhzsQ==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr22487252wma.150.1632016137524;
        Sat, 18 Sep 2021 18:48:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u29sm8662468wru.34.2021.09.18.18.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 18:48:57 -0700 (PDT)
Message-Id: <eeebf73185fa54722fc7722eb6ca0e04df95ae69.1632016135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.git.git.1632016135.gitgitgadget@gmail.com>
References: <pull.1093.git.git.1632016135.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Sep 2021 01:48:54 +0000
Subject: [PATCH 1/2] trace2.h: fix trivial comment typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 trace2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace2.h b/trace2.h
index 9b7286c572f..2f450ab5bed 100644
--- a/trace2.h
+++ b/trace2.h
@@ -350,7 +350,7 @@ void trace2_def_repo_fl(const char *file, int line, struct repository *repo);
  * being started, such as "read_recursive" or "do_read_index".
  *
  * The `repo` field, if set, will be used to get the "repo-id", so that
- * recursive oerations can be attributed to the correct repository.
+ * recursive operations can be attributed to the correct repository.
  */
 void trace2_region_enter_fl(const char *file, int line, const char *category,
 			    const char *label, const struct repository *repo, ...);
-- 
gitgitgadget

