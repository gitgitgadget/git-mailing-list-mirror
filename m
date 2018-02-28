Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C84F1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeB1BGR (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:17 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36002 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbeB1BGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:16 -0500
Received: by mail-pg0-f65.google.com with SMTP id i14so319764pgv.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KUxn4RHlMjfnJXzsI0vhsobdQmo8CTmrmVrTT+tC0cU=;
        b=j3NHFgsrk2qiGCDDbwVO9Y9saNi5/R3a6dQMvba2CdKBbHrjriK+8BJ9jDLSZg2NNV
         LgWwiCkXKEycnSIPSVTmoel9Dx9pIwA259n0pPKKx3UQjKDz1hPE7RMLIG7xgev3+YfL
         k+SgsLQwxnm70RH27WFvOpl5P5IjWSltKVOLu8X4LZNpLzx8YPVb17lN9HhF0jm24exw
         XIF5eCBRm+OUOAsXXPaOwUYybcvfTmpKwJOwLtsfw7JFS57KQ4x9rpG8eQHBrIQC464F
         32X618/5LZJ/eJOuUPgtSe1g0Y8mKWG8z+xtGuGncZpruedQG/Tm750dnHnzS1IMUGCx
         0BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KUxn4RHlMjfnJXzsI0vhsobdQmo8CTmrmVrTT+tC0cU=;
        b=hNCtT+3pkCRvcoar+RuGBbOe9sdYHICFEggIxngwy2rKpZUAmlF39o5hebD9OBzVjo
         GBDgtiPo4NQi1abKr66zXJYneaddOgqoy6tZGfHRvRqhn2BQJ8FksW36MwGS94lMxZzL
         uWqBsYJA8h1HQQ+75915QTy4x/tDRjmelip/6WS9v3bZ+8DEQO/gfEzO0WFFoWwKJOxg
         WcbQqDsjl521X8/QWDxY5gBKuV7z1WQvx6Nb/eZQbqo2pbSiuORMltqnhu8qx7O5Hjha
         KBLEpPIxmjKTrbbNb4/j7CN5JMGGwRPP1vlJ8N5qUNgC2oHh0GlWpb7Jp8ZKF5+rqm/n
         MEKA==
X-Gm-Message-State: APf1xPAUr+sPsNZLpDt2ZGrg1N4p5rgwu2q1RPy0J/eXpdTLsWzeI5SZ
        CxOuKIJLlnasj12BMn2hP1GtSzLKGV0=
X-Google-Smtp-Source: AH8x227Ontr5qn8X45vdYplQ7lPmYyd7F0gLqrqmIyNolPipVsEEUtDnarOvHaTzooJ+9Ik0/vSCYg==
X-Received: by 10.98.64.146 with SMTP id f18mr16011189pfd.30.1519779975491;
        Tue, 27 Feb 2018 17:06:15 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 5sm486667pfh.133.2018.02.27.17.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/11] packfile: allow prepare_packed_git_mru to handle arbitrary repositories
Date:   Tue, 27 Feb 2018 17:05:58 -0800
Message-Id: <20180228010608.215505-2-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180228010608.215505-1-sbeller@google.com>
References: <20180228010608.215505-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This conversion was done without the #define trick used in the earlier
series refactoring to have better repository access, because this function
is easy to review, as all lines are converted and it has only one caller

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index ccfe084642b..b844b653265 100644
--- a/packfile.c
+++ b/packfile.c
@@ -873,14 +873,14 @@ static void rearrange_packed_git(void)
 		set_next_packed_git, sort_pack);
 }
 
-static void prepare_packed_git_mru(void)
+static void prepare_packed_git_mru(struct repository *r)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&the_repository->objects.packed_git_mru);
+	INIT_LIST_HEAD(&r->objects.packed_git_mru);
 
-	for (p = the_repository->objects.packed_git; p; p = p->next)
-		list_add_tail(&p->mru, &the_repository->objects.packed_git_mru);
+	for (p = r->objects.packed_git; p; p = p->next)
+		list_add_tail(&p->mru, &r->objects.packed_git_mru);
 }
 
 void prepare_packed_git(void)
@@ -894,7 +894,7 @@ void prepare_packed_git(void)
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
-	prepare_packed_git_mru();
+	prepare_packed_git_mru(the_repository);
 	the_repository->objects.packed_git_initialized = 1;
 }
 
-- 
2.16.2.395.g2e18187dfd-goog

