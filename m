Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C071F406
	for <e@80x24.org>; Tue, 15 May 2018 23:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeEOXmq (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:42:46 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46362 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEOXmo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:44 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so952864pld.13
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UdvkBK42vSaaFAvkY3dAiTlSx0PmaoUXJmeOHZT7PXU=;
        b=ThzcahOmCw77MJYJMdq1gwG2m1DKSZ5KfvhWNOv/8aWgdgH58Sm9aln5lLlokLu2Ih
         ClIgPt89W5e8bhuU/t3aZxFpqc1HSwaLkEEy8WUAuwOEEv4PYNAuqO277GiSpUYV7mrJ
         DHk+XNdAPerRn4YnYqnRiC1MelgSne5FsfpfsEoFnBUOVURFZjcf3z4chT2wmyHwwt1N
         TAujbzA2gk6MGdt24rii0OG7Ej1884snk7mG3AetoCZDdEdWy1nTgGtJu5hSiGRSh8ep
         /b52O8ZN5ZVJhvgOfOpgsmD7wIyZtS44tsgSis2hRfJcXk++94A3kRXNwTjJboUbFRFe
         JdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UdvkBK42vSaaFAvkY3dAiTlSx0PmaoUXJmeOHZT7PXU=;
        b=U/Qaua3bJ9RWAlrsUEtQ2sGs34GzoZHne62mB9WxngHBfCQf55a91miQ1rF6q3lzwm
         j3f0jFJydcO29LduWq8oRInS/egHt9xZuf7btu+hqsDYVe31HBzV5WWNkpQABcGlHtpI
         A+9MIKOIGMsu6t+Nic16sb6HUO+mTvJKyC+QtzsdBewAEtBaDKubKOJppUEHWecRdVsO
         IpQChXiPNvKht4nmPz35ZbhBtmVafnzKRrBa0TgleBcDIxOhBuGyegfOYlh/5arSCCp/
         +fLL5u4dBuWYoJsCkqguIIBMFYf08PUxvhS+25O1Hs7EqXyNySi/Ds07U8kLbbl1Hhw1
         X+pQ==
X-Gm-Message-State: ALKqPwcQv8zvSpM+znTFxvbWj+az/sXDshAJSRM8FJmYjzIniFhtYDYf
        ALrH1HJg98TJMED1AGFvaAKmt90oV0c=
X-Google-Smtp-Source: AB8JxZpGk4x5TXS6eKk0ULgQxJJPokLxe5AS5bWofvaQnknKLXztgdeie8ArYIn3pt37uHzX5EM3Vg==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr14741203plg.135.1526427763272;
        Tue, 15 May 2018 16:42:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b28-v6sm1574038pfl.168.2018.05.15.16.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/19] commit: add repository argument to read_graft_file
Date:   Tue, 15 May 2018 16:42:19 -0700
Message-Id: <20180515234233.143708-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow the caller of read_graft_file to be
more specific about which repository to handle. This is a small
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
index 4e8d3488425..b5c0aec24a0 100644
--- a/commit.c
+++ b/commit.c
@@ -177,7 +177,8 @@ struct commit_graft *read_graft_line(struct strbuf *line)
 	return NULL;
 }
 
-static int read_graft_file(const char *graft_file)
+#define read_graft_file(r, f) read_graft_file_##r(f)
+static int read_graft_file_the_repository(const char *graft_file)
 {
 	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT;
@@ -204,7 +205,7 @@ static void prepare_commit_graft(void)
 	if (commit_graft_prepared)
 		return;
 	graft_file = get_graft_file();
-	read_graft_file(graft_file);
+	read_graft_file(the_repository, graft_file);
 	/* make sure shallows are read */
 	is_repository_shallow();
 	commit_graft_prepared = 1;
-- 
2.17.0.582.gccdcbd54c44.dirty

