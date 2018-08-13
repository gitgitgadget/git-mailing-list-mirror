Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077121F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbeHMS63 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36629 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMS62 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id b22-v6so11660600lfa.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FjNTNcEszrQT/szigXF+6pGil7koBNy8qu0gB4f93eg=;
        b=Tn6QCXczqN6jJLnzmpWkcmDn093mdk5mzHHFAhRtU3A4IExq5/AqLOSWLnL66GFe5j
         0+mQMaHNJ+GEuXcWAxcLQsF8Sc+hCh1tTLDuGr/zOBFMza+lwq3JC2eieKvF7dBcoQGz
         fTeoKppKaZIEyjIU3Oy7eGdZho7M/TXTmI5u7ySRPt7OcZ5KmuVUzDrMdnOcbxOSFeO1
         Iy3FX8NX+hStcG6iGokk9ZNdZxoFP1HapJtlkDpKegCatRl6pszud+HlaBcjTR538WU2
         j27pTlAdUcyX7BNXfIVLShvNX8UiEmUnS3yg1MR/8CZb0Zzh/SBcQUQdFHgSfp7yNmvn
         81nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FjNTNcEszrQT/szigXF+6pGil7koBNy8qu0gB4f93eg=;
        b=nMGzuvuTagau+4jHZp1J/2Xz5b5x6mVnSlHx+cnRRdfFP4IGlyz42gjWidflDnDxt9
         NBPfKalhshy57esYJKiBnsQw2e3wpZoCzKJ7n5t/EkSoGrGXLtzeBHiU4Nm8f5EXnT5L
         bbyhX0xHs05GPbKi3s0vdZ2OcOLw1FGPfM2u82LDYG+f0eclxykPsa6hfOr1jReP4eOT
         9xppPQbOdY4oqVGyz9FPXkrH8oywANKM1e7VTWU5HVpR/dGJkLlQPOUynNGgTCB6D7Ib
         pH2VYx5L/sk017sMCPJzeFtpf4S7Y5GItjE8yVnJ2vcOC1oT5cFpGQridGKXEM8VISDy
         phWQ==
X-Gm-Message-State: AOUpUlF3Lqbh9exN5BT8K26LKICwQP0HjP+uZZuhJ88OlQD4HTNzHmXq
        DnVF2WlStKu7lvNC6yq0YxqHtCs6
X-Google-Smtp-Source: AA+uWPxyN2wPG9xoLWqFdQUXKLz17W0c/MkMO+ius/IUSh8hWfQKIo70l7BVmwCbTXnQZUja0+GpGw==
X-Received: by 2002:a19:db44:: with SMTP id s65-v6mr11579620lfg.109.1534176933615;
        Mon, 13 Aug 2018 09:15:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/24] pathspec.c: use the right index instead of the_index
Date:   Mon, 13 Aug 2018 18:14:30 +0200
Message-Id: <20180813161441.16824-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
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
2.18.0.1004.g6639190530

