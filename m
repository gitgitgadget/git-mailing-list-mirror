Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1391F406
	for <e@80x24.org>; Wed, 16 May 2018 22:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeEPWWH (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:22:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40767 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeEPWVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:36 -0400
Received: by mail-pl0-f67.google.com with SMTP id t12-v6so1233754plo.7
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SS4oI7dzdxUWw/tLcyREaNWOuN1W377zDJAIPmZweew=;
        b=kH5hPElHVvnczYh3khNLCVSci31YDgYtbZJzMLET+Dcg/g62LRmGZrLTWbYjSzs4wZ
         BReEMCgF7vzmSL3BUvmNZs2nxP+7beLHAka5Cfkx955sFlsk8uNBqQcSe0/74r8g585H
         c8IhYyc7J+2FRentswZpGnrH24W628YGDqWDfZYROGjA76bjn+m8VFu8jMgJWvgrNiae
         7JTvWdYF0SzB0jkFFYoheR81lwHwRSUAV7Dn5DS+nUErjqD2J9bD78HDEKQOx0ilbto5
         4l7m3CHYLN34wMAmiCxFy+ixmxdMdE9+85jGO8ysI72zVQ448u7goi38JRch7lUNfPwp
         ZDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SS4oI7dzdxUWw/tLcyREaNWOuN1W377zDJAIPmZweew=;
        b=IFY3QgVxvq9lYnIb2ZbOuKT+VYGsEdV3C1jKUl5FhPVT+bGChUe4WmZxsECcJDNX1E
         4PPG6xD1dPrgLu2s4H1NhvBph/uYQ5a8pcOnCbKqYYjBQOtRTk3EHxy+C0SsXMS8o6rz
         VIUxi1l1YSC2pXKvygSOi/uG5qT04xUN207fPMhoS0Vn2QGpY46WZfEkTD82X8tGm5O4
         SkMmn+f7FObtwsml6359bOlVk3seYjzKPYErxKMjOwD5lYvaTOa+zMUJk6g/Hin1Ff42
         prjX5Nd8O6Fhw5HW9H5fH7QMC157LJpjufl+N/9ALEsBOMr38SbIO5CzJCMW3xMO0G06
         Fulg==
X-Gm-Message-State: ALKqPwe8anRetHFCIp0xJM1zyyCtdyRAN2Iz3CI+RUI4sJ0hqOrNbEu9
        qTuPY0ypRyZuIIHWudxZAbeSRQ==
X-Google-Smtp-Source: AB8JxZqVPG8ykE4Su/NnRyjt2StnCxWQrZ7eR0zDeM68y994n+yM0rN8qhtpxuJUE5NSq6pI9BLC1A==
X-Received: by 2002:a17:902:1029:: with SMTP id b38-v6mr2665576pla.277.1526509295788;
        Wed, 16 May 2018 15:21:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b130-v6sm4204606pga.21.2018.05.16.15.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 03/11] builtin/grep: use repo_read_index_or_die
Date:   Wed, 16 May 2018 15:21:10 -0700
Message-Id: <20180516222118.233868-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180516222118.233868-1-sbeller@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

grep is a porcelain command, so translating its error message is a good
idea.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/grep.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 69f0743619f..2c2d6cc6bca 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -488,8 +488,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 		strbuf_addstr(&name, repo->submodule_prefix);
 	}
 
-	if (repo_read_index(repo) < 0)
-		die("index file corrupt");
+	repo_read_index_or_die(repo);
 
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
-- 
2.17.0.582.gccdcbd54c44.dirty

