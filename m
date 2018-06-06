Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D09E1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbeFFRDu (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:50 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34095 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932977AbeFFRDG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:06 -0400
Received: by mail-lf0-f65.google.com with SMTP id o9-v6so10238196lfk.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30hotWIBWoDivitANapfqlVKyg6vIfCasdbSQv7mPYw=;
        b=AAsU2eqP/AMaddxRvK3uuGm2jW179TFj4MQae/25a0WGnlBOeLqbLOE1CI4H/bQ1cw
         j9QJBY67flNfk2o/nm9X2xN9xyZfmXvu6Y6/RScc5f89shlGM6bKoBTrTsidPj7ES2FA
         CwQeSo9wZgSlVXTxdqGtdvdrrLUE1H0PE/x8dYyFuIyg4VHRJhvcy4lnPum8SujS27EJ
         cHTQux+WlwRCZ0J8UKJqz49s/17TeHQRcKURoZOUENEf0R/ltWWG5leZMYpQ1PYqNuq0
         NBnwtecNNmb1oaMzxc+zFk5VJ469fHW5EOOEDTEFYTjlQ76P0MRrjYezKZi02r3yAI+A
         LfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30hotWIBWoDivitANapfqlVKyg6vIfCasdbSQv7mPYw=;
        b=ncOFUVl6864xNVmewS/Uu3qkqymvH06s+IMobvaMBOLigjH3twn1EuW8RttdCA6ARs
         DfAU189M9nNoklA+Sr+/Wy/TGh2EgNvzE9AIc05Fq9BSMljS/zU6BOEODhK2Hm3Fbubo
         shUmtl4qTegNvaIydz9PT24NgNO3mVyhwJTUmC7m+cN9OshHJ298OxO5hCnnuRoWsr1L
         pAFlwzFMx0rtSjInRinSGSob1rIElQMgQly96JDw87wXPVP9brNy9/tO/1abcr9tY/im
         kWTJipO+B4LAE+wsV6HhZ5xDk6KnGsZONpzVYMJLAKwl4vtnXBZKJPfgiEd8FrrVwNAS
         UZEw==
X-Gm-Message-State: APt69E3hgo6ChqbnWwWr38E953NBTSNjnT3Paoy0ffY1eB+Nrkom9pRX
        dmMvhiHNZm7QLcRB254DBbg=
X-Google-Smtp-Source: ADUXVKIJWbI1ks7Gcx0zFz3bw7mRMlcEct4CfG1q+3osqdOU/NrN71fK8B5/Jm90/A3nc8UxW8nzSw==
X-Received: by 2002:a19:f03:: with SMTP id e3-v6mr2499822lfi.145.1528304584856;
        Wed, 06 Jun 2018 10:03:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 12/23] pathspec.c: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 19:02:32 +0200
Message-Id: <20180606170243.4169-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
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

