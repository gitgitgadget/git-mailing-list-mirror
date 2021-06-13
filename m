Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24281C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 06:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7058611CE
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 06:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFMGkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 02:40:25 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:43796 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhFMGkY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 02:40:24 -0400
Received: by mail-oi1-f176.google.com with SMTP id x196so10807294oif.10
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 23:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+dwL0mhAlJfg1HkIlHpLtLtoeqqoWFje+ZS26UInkA=;
        b=ezWNpKyKNsbG4pCte99RT+Gyems1mDgHyLNZmtZXG49eC6Cd1OpzFvTjCfFdKETjRu
         Bw42ALUSEgJmtSf/iTkwKLTVkC/L9hzwHF8SHZS8qBIeNxuBBOViquvRX1NeY6+yEXyB
         l6Qlw0t/NyQ3hpr0SfWnDVU2AJZmU9lm1spz2mwjW3QzQbhH11ziYVtwo3fsjw7DEFIW
         /MMaT+gwoQKPtZbqBJyCYIf16icpRonLLxc2TnPHKnz2CiZ5NRTcbnkO5b7Bq02Gywg7
         6BTVuFCs4NjHsl5Kbgy4hmih8K3Hsjmf1JQDkfR1V8tsu7X72b88zZvv4D+S7834eg+u
         zxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+dwL0mhAlJfg1HkIlHpLtLtoeqqoWFje+ZS26UInkA=;
        b=TBRL+hCYk0sT6e+lMrVcZN+Ggu2VpHbYhwWyhTNGE4m7Jpe8ToDM66QLV5Kuzuw6or
         XTxrdLAdzOzgiWayzsV0Q+SlUD00hC1O06aCsZZ3TVXOjctQtBXH9ZATCWNJ9x9A3H68
         UgsmcqiTEjGCdcpJONjMU2ptuWfarFRNnv+witc9adXCAZljrlj9VcsZjHuPqChfNLhR
         JOyn2NmkOKbyCLk0NqYr0zM6raWQL3UWRjqxFFpPUS/S/5cln51SzrXrQbSJd4Z9HoY7
         McBAbCWfCA6miXJ6LD/o3Zs70/SY84mWuBoj0KJ5YJtrWLbdfBv4lphdzYdxl6DLytKq
         1MEg==
X-Gm-Message-State: AOAM533BXsJJK/6yOZbFgbJVsfEeb2QfkEbmdSuYXmJN0B/vjA9Zf+sB
        iHxtFuqKgI+fkPCV0ZLXisg9PM7Tj47Uow==
X-Google-Smtp-Source: ABdhPJzUo7H/VuwXhRduhZXZoH2AUnohAGxvi+FbNq7sDU3zEAX03Ag0I9mKmtpbwmQBN+UQp8DmwA==
X-Received: by 2002:aca:c441:: with SMTP id u62mr17974768oif.31.1623566228337;
        Sat, 12 Jun 2021 23:37:08 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id t63sm2181750oih.31.2021.06.12.23.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 23:37:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] add: avoid yoda condition
Date:   Sun, 13 Jun 2021 01:37:02 -0500
Message-Id: <20210613063702.269816-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613063702.269816-1-felipe.contreras@gmail.com>
References: <20210613063702.269816-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

18 is younger than person's age.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index b773b5a499..8c2a5a5094 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -510,7 +510,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	argc--;
 	argv++;
 
-	if (0 <= addremove_explicit)
+	if (addremove_explicit >= 0)
 		addremove = addremove_explicit;
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
-- 
2.32.0

