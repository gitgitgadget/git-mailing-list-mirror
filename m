Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E56E2070F
	for <e@80x24.org>; Fri, 16 Sep 2016 00:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757417AbcIPAMz (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:55 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34837 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757263AbcIPAMc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:32 -0400
Received: by mail-qk0-f194.google.com with SMTP id w204so4450476qka.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=glxCouqcxtYSvl50qzxcOccVGGCVfkY1r0EDKRcAtR8=;
        b=NS4G9wYwwcnkQXAd7VLxx5CTkfPTJPizvAfSsC2IrNP4nczKMj7fDz75NiSxqZhDAP
         LvK8ucof7RDFjp3r3QWO583AxEfJFMcPgIWtucXU9LaJrPboSX6bQULCbZf6EGF7Z4BK
         4ZwWNHM24k19l4k0Rq1gd0MbBRRUtvsNUcDkiGsb1lUHvot+bkE+BUKAODVnb1KTFdlz
         jlI1RprKjaE0aoQotONrd0yf5iZJQK1dKogaGhjIezArqc/xomiXqJ4+Dd53JCjpOfhv
         bHzbVLlNKgBwipbJhEMnJn8FW+zYfjzywBazkBuBaC257LA5khs3waOZkO5bvjyuelM1
         dA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=glxCouqcxtYSvl50qzxcOccVGGCVfkY1r0EDKRcAtR8=;
        b=E1jGP/PUAfBP4zH5tysb67/wjNYscpl/dSA1dsjwntwOuMgRxuvn8EU86oiJF1VlFG
         Evr7bfRohDKZW6irBxncqAAKr0Y95Q5TIXyMmtzHPn49pCGmEKqlD9xvWBfYgO4rjWVA
         9sL7xNDUtbakckiAdYRZuXaeEi7AGvWTNlwT0dVhbbMuy5lVVyE3YU0vvLKylnPiCVOE
         QVFYb+bNJd2t8E6L2F3PTa6zgh6MDwN1PAulQVRz5THasv3q057FJiG3R1dhMoPrX/nD
         gVDORVAX7jqaSqhPywSqlMOuIgQifshMthSvdCbj7WggqgDotNwk5hOnX9MyCPaxryt0
         uDdg==
X-Gm-Message-State: AE9vXwOAd06JhMTUxKX9OSS/1N8XHYh32+VZrh8JhB056QOJinO3CqIUgPg9v3PsLZy64w==
X-Received: by 10.233.216.194 with SMTP id u185mr12859969qkf.173.1473984751326;
        Thu, 15 Sep 2016 17:12:31 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:30 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 09/11] path: add resumable marker
Date:   Thu, 15 Sep 2016 20:12:20 -0400
Message-Id: <1473984742-12516-10-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create function to get gitdir file RESUMABLE.

Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
---
 cache.h | 1 +
 path.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/cache.h b/cache.h
index d7ff46e..1f4117c 100644
--- a/cache.h
+++ b/cache.h
@@ -811,6 +811,7 @@ const char *git_path_merge_mode(void);
 const char *git_path_merge_head(void);
 const char *git_path_fetch_head(void);
 const char *git_path_shallow(void);
+const char *git_path_resumable(void);
 
 /*
  * Return the name of the file in the local object database that would
diff --git a/path.c b/path.c
index 8b7e168..9360ed9 100644
--- a/path.c
+++ b/path.c
@@ -1201,4 +1201,5 @@ GIT_PATH_FUNC(git_path_merge_rr, "MERGE_RR")
 GIT_PATH_FUNC(git_path_merge_mode, "MERGE_MODE")
 GIT_PATH_FUNC(git_path_merge_head, "MERGE_HEAD")
 GIT_PATH_FUNC(git_path_fetch_head, "FETCH_HEAD")
+GIT_PATH_FUNC(git_path_resumable, "RESUMABLE")
 GIT_PATH_FUNC(git_path_shallow, "shallow")
-- 
2.7.4

