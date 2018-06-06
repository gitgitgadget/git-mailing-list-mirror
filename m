Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C801F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933812AbeFFRDY (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:24 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46771 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933808AbeFFRDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:20 -0400
Received: by mail-lf0-f67.google.com with SMTP id j13-v6so10207734lfb.13
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6pExQtuTThMGrNN92F/aLzO1P0JUm+yr0dm1zMXanc=;
        b=Lkj0+/tolXX0TVCx4GeaLQP+a1n47OsEDQqRV2tr+H5mM7L8g6lwPXmxNASZNwjkyG
         cfJxIpkmby/TcmqsJFhrN/5ByPMLbMp2OVJjImnjiEqeB/wTA9VWaV4KTPu1r2uSHtZ0
         KVia9c3KQLLH3NG65N/Nzs6R5hDHkq0HBQNCMALTrKyVoI9LUKC40J8EnJ2UMmDZQTGD
         cRgzUIdcTfkLaZR9sfwCcw5DKIw5CFCEWeoLH/sowmbqnqzJlindc5FsnQSZLvZrFNmd
         Lz+eYANb9jmS+J5VSxJQbxqRrHMvqJou0nsVBbe8O4hAlpOl+YK3JzLcOdHt+KInKeWW
         cu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6pExQtuTThMGrNN92F/aLzO1P0JUm+yr0dm1zMXanc=;
        b=WUXB+nsBkqnHMYK2Nu/nGP2jWAzKnd3A8x3gkk9RSooUGTMv0D7V2xCjdh0YKD9Bwo
         /BebsqyF+AsiS32Js1CXgOhtgAuiXtLeQuLPLdwHybuTqSoQ4XeuwKCcG/mNaSMFjM41
         8bMXwmI9y7Y1x+eKbBGYA7Huz9kvQE1huIS0/K2vAVvpR4y71i/i6G18AlDUSmGjtUIH
         JDv3XS00fzsb4SNoM94r/nk504oP2BqyowXusGe5FlG14x9e9d8KXdV5lyUQgcKl20PA
         P+yNgtxDG1owBTcDhowHJxa9DzV6ryEGw8L4JPBSXC9Dhj/IkU4nESY41lkF8y5QK7UP
         nTrg==
X-Gm-Message-State: APt69E1aDJd80R1c9YwjFmyUtinlZ5JlBPsIMoMI6vr61vFbCih+AGzm
        22utJskPFZu0YuwKNeVH+Ufznw==
X-Google-Smtp-Source: ADUXVKIcsznBjrwi9+Xtnzvr8g6QYFbWsSYOWT+7q5ZkwHPmyTMrUVeXh0rF3quQU00wMxc/c5MbTQ==
X-Received: by 2002:a19:e585:: with SMTP id i5-v6mr2312350lfk.63.1528304598065;
        Wed, 06 Jun 2018 10:03:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 22/23] grep: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 19:02:42 +0200
Message-Id: <20180606170243.4169-17-pclouds@gmail.com>
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
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2eae397e92..a8cef2b159 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -497,7 +497,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 		strbuf_addstr(&name, ce->name);
 
 		if (S_ISREG(ce->ce_mode) &&
-		    match_pathspec(&the_index, pathspec, name.buf, name.len, 0, NULL,
+		    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
 				   S_ISDIR(ce->ce_mode) ||
 				   S_ISGITLINK(ce->ce_mode))) {
 			/*
@@ -515,7 +515,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 				hit |= grep_file(opt, name.buf);
 			}
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
-			   submodule_path_match(&the_index, pathspec, name.buf, NULL)) {
+			   submodule_path_match(repo->index, pathspec, name.buf, NULL)) {
 			hit |= grep_submodule(opt, repo, pathspec, NULL, ce->name, ce->name);
 		} else {
 			continue;
-- 
2.18.0.rc0.333.g22e6ee6cdf

