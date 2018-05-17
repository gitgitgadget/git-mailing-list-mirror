Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A0B1F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeEQWwi (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44849 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeEQWwc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:32 -0400
Received: by mail-pl0-f68.google.com with SMTP id e6-v6so3384169plt.11
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l3JXYE7qhtjQTbPbkbcZySpU8vBsLL53tU75Vk7yYQM=;
        b=b2vLWnzcmVP0qnet2Ya0TVchmBikEQxfslKzTVEqx7b1ntj4iO7if10A0Gkk2wt5+k
         xED0T+CKIHsvY8/KJoUHxP3aAubaOjkF3z3JAtLkqNT11x0Bjsl+ySFZ+h7vCInSyabl
         2WZM+vuKlWQMhJEKw/Rm8D+4cfDhtBekWKGZ2kh56WWo6Eb9vvjwJqzjIHYzs9sTrsUS
         WzsBqRLCaDkQDu+5Ul+RmcDirguaRLozWot+BAkoq6NUvwK2jgI06iTCVBQdlpGLvJxP
         QhTupI8ly7ItegxB2bZlt/66iIV26n4QBXuNBKxumt6i4WwCzsamd5Og5ytvb23TAgS2
         7KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l3JXYE7qhtjQTbPbkbcZySpU8vBsLL53tU75Vk7yYQM=;
        b=uJKh/UXd+AMlVICTbbEx2xW72MjA8pyeu/QpE3DSAl0QXI8LgrHzNpG/KECGx8zK2J
         CxP8cHIqWI+LtgTta9VpLPDozOL9xr4HgI6YvIuFqfwtukGpVygrfhB1Ke/Z+UY5U4Zq
         oNIonFIOD1KJNsCSFOBMmMG9cU3LvgVZAJ+ybXf607jFIlIJrvcGXKxEvpZ/5YQz4IsB
         VR709S1PCCxxuWsgrgiw3148YGvb5Hx1M66nC4GdPiWvaGF7kf5AD8mKtKbWIohP9Wjb
         GmmxHTUG5/m4fVeM7IB7+fx2OWB4pjTCNK/P9q8AUAg9N3iLpNb2FcpiltqF3xxRohBZ
         rGGg==
X-Gm-Message-State: ALKqPwdoXKs2SZfQSF6pWvRuWGVbIGg+SoBI3id7+Q2yIZmAXYeGlWzl
        lLYY2jVrc40HMhzUDveIRzL+Vw==
X-Google-Smtp-Source: AB8JxZrY1gDQKE0Ne+sPxmU4kRhz/UvaUIIszmaRs2BBD+bvrOzcHuP1H7rm1ANF4AYP53IaUTbyiQ==
X-Received: by 2002:a17:902:e8:: with SMTP id a95-v6mr6971376pla.274.1526597552056;
        Thu, 17 May 2018 15:52:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id n26-v6sm4336197pgf.89.2018.05.17.15.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/19] cache: convert get_graft_file to handle arbitrary repositories
Date:   Thu, 17 May 2018 15:51:50 -0700
Message-Id: <20180517225154.9200-16-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This conversion was done without the #define trick used in the earlier
series refactoring to have better repository access, because this function
is easy to review, as all lines are converted and it has only one caller.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h       | 2 +-
 commit.c      | 2 +-
 environment.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index ab716011b7e..cb1aeb1dcbf 100644
--- a/cache.h
+++ b/cache.h
@@ -476,7 +476,7 @@ extern const char *get_git_dir(void);
 extern const char *get_git_common_dir(void);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
-extern char *get_graft_file(void);
+extern char *get_graft_file(struct repository *r);
 extern int set_git_dir(const char *path);
 extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 extern int get_common_dir(struct strbuf *sb, const char *gitdir);
diff --git a/commit.c b/commit.c
index 3fcb2fd66ce..24028fd257a 100644
--- a/commit.c
+++ b/commit.c
@@ -204,7 +204,7 @@ static void prepare_commit_graft_the_repository(void)
 
 	if (commit_graft_prepared)
 		return;
-	graft_file = get_graft_file();
+	graft_file = get_graft_file(the_repository);
 	read_graft_file(the_repository, graft_file);
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
diff --git a/environment.c b/environment.c
index 87d9e52ffde..ab42346e563 100644
--- a/environment.c
+++ b/environment.c
@@ -316,11 +316,11 @@ char *get_index_file(void)
 	return the_repository->index_file;
 }
 
-char *get_graft_file(void)
+char *get_graft_file(struct repository *r)
 {
-	if (!the_repository->graft_file)
+	if (!r->graft_file)
 		BUG("git environment hasn't been setup");
-	return the_repository->graft_file;
+	return r->graft_file;
 }
 
 int set_git_dir(const char *path)
-- 
2.17.0.582.gccdcbd54c44.dirty

