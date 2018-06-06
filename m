Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AD751F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbeFFHkC (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:40:02 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41288 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932274AbeFFHj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:39:59 -0400
Received: by mail-lf0-f68.google.com with SMTP id d24-v6so7543815lfa.8
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30hotWIBWoDivitANapfqlVKyg6vIfCasdbSQv7mPYw=;
        b=iMTAXWGLEEEKZZSoywPIw2AXbUDmJctJCegPacHy86+aEg4+x/h/wd5Zj1NJ53RzMM
         87Tck3ga21O/1sdnl4P+hKpu3J1RYjRFvopqWZvkyogrro26ksJNbUtSgvM5WImHnXwF
         bMMdGy1y7pRob4LECV5U2nDcRBFWwlRv0M5VqnKDWewyKiZZZlKGAN8cEmuMYTi0cTVB
         5FXzb6XFq+vk3vOIyxk7n1HioxHYc9MJJYn3SiGOGsAOXk7qVdikGiwCNm04UPcvRSnc
         twBYNA/5/hdWyp5j4Hg1W3XUUqY7ZINXoYx4Mn0tB1uzAQNbImzpB4b2xU+v0hAZy/fA
         G9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30hotWIBWoDivitANapfqlVKyg6vIfCasdbSQv7mPYw=;
        b=nYI7gKFnmun+xiu8gakGB927kZiwhBqhwYnU55y/ceHwjlJZ2rBhzkgIxL1asubVGZ
         N/Fz53+N0CUlC7sIDuWHclk7VPuEqxaLW3NrNQgHQU2wXTVFMqG0s8U4AVhjBWsyT/TL
         m+AUHdXHs6xL8evUbgIixN76d4nIcUFqeYYwUDinhdYAptKmDyIvP8xyvkzfprrOMYx8
         Z6OZh0iX4eJmCYJyWSpp9FVeVbvrbmMk1+giefXRlEluZCbTIiG/T4MGZ1+tGAVQOljR
         ZxXx9ay+x28xj49EXqcjDEv3/udnsChXBSa2sRYN2ioNeb11rvNpjJWgW7Y5uEJX9ZPj
         AMhw==
X-Gm-Message-State: APt69E0rZhTGHOluERCc4Xs+Uw7nCW22H3T1Y73PuIoS5zj1q/6sKhZA
        JMtV+VS07RQhhdM3+e9/pkM=
X-Google-Smtp-Source: ADUXVKI5NTdTXVMrMcRz2c2xkBnD8UPazz18Dq4vo5TSkupYKpgsC06v83pg8EyVFsVZ+g+9pSCcDA==
X-Received: by 2002:a19:1a52:: with SMTP id a79-v6mr1170279lfa.43.1528270798410;
        Wed, 06 Jun 2018 00:39:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:39:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 12/20] pathspec.c: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 09:39:25 +0200
Message-Id: <20180606073933.14755-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pathspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 897cb9cbbe..6f005996fd 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -37,7 +37,7 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 		return;
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		ce_path_match(&the_index, ce, pathspec, seen);
+		ce_path_match(istate, ce, pathspec, seen);
 	}
 }
 
-- 
2.18.0.rc0.333.g22e6ee6cdf

