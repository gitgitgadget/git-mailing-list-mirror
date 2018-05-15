Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C8E41F406
	for <e@80x24.org>; Tue, 15 May 2018 23:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeEOXmu (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:42:50 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40517 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeEOXmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:45 -0400
Received: by mail-pg0-f65.google.com with SMTP id l2-v6so727269pgc.7
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oZAqRZ/4ge+T/8ofWFB3AXwjWcFB0QZM4hgmxuzgusc=;
        b=h4xbyy6jlfGls6hrD5mqaYGK53hNF5AlepG71sWZsSt1/abASz14BA8KX+LDpIESzy
         bBe1x2MVSexNV2kmDK0wh9eMSM+MFWwdJg+G57vA7PDRF7mylWWiqjqOIBctdIG8juuO
         eYb1bbPZ+a0wWg3ToCpdxXASDC1KcAvCQ7GhxZKCZh1dKmFsIxd1pQ3J/xyg0FAyJPYU
         /Mmm7JTdf8H3VSXsPI///UKao6uV4c8Hc9NB1NR6rOu38JwQm+0Wka7UWk5U1VkSE+wa
         wtl/J1GcbpJAVTLXMOZu0Lwq2kns6KbOkegWg726mAXA+g0yOpq2NzBW6PF1l7Jkf35a
         Fpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oZAqRZ/4ge+T/8ofWFB3AXwjWcFB0QZM4hgmxuzgusc=;
        b=Z5qZMN3cYN7twXB3Rsfqo8A2a5rd5e1bLMTzrxaa5TZ6YKCk19eZ52JKJ7ENcC1iKw
         mIIbrbRxw9uxpr+jbvFSAA+kk620SJSD08WCbvLRRPAt7c1noBkWhojcX4HSGUDaP7Ge
         a247IOc/KW68udj2XSq0GjKqi1lQbOBjCflO2EY1jqMQc4u9zdROL2ZrES1Y6R1n1rTl
         B5Yb4pM+aA5tAQ1EV8arGL2NVrFp3KJHFl0yd0dYtysaV8WmK7whR/l1PLVXSP2eKWBC
         gUiJChW5nrZN6nbM9Rpz9njqpWJ3JBlD9dmGLhixB9EEDwb5Yb4ixvI2ZEMn2z5nosmh
         mQVw==
X-Gm-Message-State: ALKqPwesHBks82st5LaJeYIDKZHL90mCWzb/FNPfGbtZ2hZkd7udGiWw
        XmwYDw4j1FzHzk1Np24Z/nm29th74Uk=
X-Google-Smtp-Source: AB8JxZr/cWI13IbeXXvKVOmbrTyhj30fhIRboMesI2VUzNsnEr6ODPl1+Otq4CFGt1zm2+2u8PDVMQ==
X-Received: by 2002:a62:1211:: with SMTP id a17-v6mr17246321pfj.104.1526427764914;
        Tue, 15 May 2018 16:42:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id z129-v6sm1325253pfb.108.2018.05.15.16.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/19] commit: add repository argument to prepare_commit_graft
Date:   Tue, 15 May 2018 16:42:20 -0700
Message-Id: <20180515234233.143708-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow the caller of prepare_commit_graft
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index b5c0aec24a0..a0400b93a1e 100644
--- a/commit.c
+++ b/commit.c
@@ -197,7 +197,8 @@ static int read_graft_file_the_repository(const char *graft_file)
 	return 0;
 }
 
-static void prepare_commit_graft(void)
+#define prepare_commit_graft(r) prepare_commit_graft_##r()
+static void prepare_commit_graft_the_repository(void)
 {
 	static int commit_graft_prepared;
 	char *graft_file;
@@ -214,7 +215,7 @@ static void prepare_commit_graft(void)
 struct commit_graft *lookup_commit_graft(const struct object_id *oid)
 {
 	int pos;
-	prepare_commit_graft();
+	prepare_commit_graft(the_repository);
 	pos = commit_graft_pos(the_repository, oid->hash);
 	if (pos < 0)
 		return NULL;
-- 
2.17.0.582.gccdcbd54c44.dirty

