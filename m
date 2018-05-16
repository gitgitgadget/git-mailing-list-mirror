Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC841F406
	for <e@80x24.org>; Wed, 16 May 2018 22:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeEPWWG (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:22:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40690 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbeEPWVi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id f189-v6so1043097pfa.7
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IV4VBwc0Kkt6pmYhxYFjTn2zcjylg4BbtTzPPHS8rRE=;
        b=OB7yH4UOAfMk6pI1ziH1sv3Mgwt2v52pjBQWVX5mi9NES4Hnr/tN6Zc74Jl/oIxJMB
         yrTXH9/d6+wvF/OTCGatdF6Cpgvx4Dkti9F1Lt45NK9B1iuKnl6Nv6o3jwjLb8tVu3P2
         NOzpTmuPGhad519ou0jOAYGmpno05tONUB2LRNYbO9LJp6K32+ON5q3vKmKL30R79EtZ
         QA46uLtT/st9QD/sXnt05ETT+MRWnHacna2GEbJnqFLEXiNux4+//TG63lUIU9P6vu5r
         1NRJYXrdhxFrvcxEHJMWF7ga39KKUZM7RA1gDfyunI9CdZD2iX8qjCkfHL+Ks9iuzxMi
         D14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IV4VBwc0Kkt6pmYhxYFjTn2zcjylg4BbtTzPPHS8rRE=;
        b=ojgWFynf+2X5DaecgqUdisbR1MeChKMP/y0qETXjW8YlQ8rZH27zoBKlLOIkl+W5pD
         0OtmeHSq6pFEvYHh3kHoFBqzCYKUTmc6dxsJtpYdZXuIbZ/BvaQrEMU0CpvFz85fKPIz
         M0tRXa8r6F497XYZP/EVlz1MHJBLhTaE+PMebwtZj+qVnqzXGAZ4ZYApGFVq2C4qtQL4
         SfoG20TNa0dxCZZQmRBuor2N54l6J3sHRQLJUDPHnx5nzVj66U1nFxNq7qgHNLQnSDAG
         FmdrFlqXHWq+iQmRRv2k7rCDu4hzK0qW7vz9gJdFxBl+C+TVzxBglc3Ru7MHwMh5B6iy
         7qEQ==
X-Gm-Message-State: ALKqPwf++0GW1zDh3iE+a/APJLZ4SMvUEN6B9kYF/o7Mj6T+12zq0w3t
        MacNSfnwbTGmZfD0eIPGy9UmkQ==
X-Google-Smtp-Source: AB8JxZr8wlL2KK+wY6jU7prOqlbQo6lwF9Z78UFsHvGUnsm9OaUIX6q87dmKD5Kjsn0zn5uCxi0H9A==
X-Received: by 2002:a65:5105:: with SMTP id f5-v6mr2159809pgq.232.1526509297307;
        Wed, 16 May 2018 15:21:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id m72-v6sm7037124pfk.110.2018.05.16.15.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 04/11] submodule: use repo_read_index_or_die
Date:   Wed, 16 May 2018 15:21:11 -0700
Message-Id: <20180516222118.233868-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180516222118.233868-1-sbeller@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code is used by the fetch command, which is a main porcelain command,
so we should localize its error messages.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 74d35b25779..71c042e1371 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1333,8 +1333,7 @@ int fetch_populated_submodules(struct repository *r,
 	if (!r->worktree)
 		goto out;
 
-	if (repo_read_index(r) < 0)
-		die("index file corrupt");
+	repo_read_index_or_die(r);
 
 	argv_array_push(&spf.args, "fetch");
 	for (i = 0; i < options->argc; i++)
-- 
2.17.0.582.gccdcbd54c44.dirty

