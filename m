Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A42B1F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeEQWxD (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:53:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37510 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbeEQWwS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:18 -0400
Received: by mail-pl0-f67.google.com with SMTP id w19-v6so3396521plq.4
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VG6irPyoY3Q0EREf5xG3EQ0HqBzqAiFA/lV2HgSaQS4=;
        b=FkMaspOawGzRYHFaFMO73y8wW/z5X2ITkQhBwMI0DnQvBBPnY07k8BTkFtaJvc6XWX
         IEEi6eb+SKUyY0hSFv93Wh0xLSO8vhvuNYRkXEaozcWAJNTC3Rk3gkYWa47Zfk6JgIMA
         bFvM4GrUKMfm0rzjjVJ//+liwmr+DsKEp+lbXRfyve+596ZDiWW0jjCeMGDano/RJGxc
         osJhiSGiM1KS5R1fClzK4P4Se2P0Yf+7FXQ0AoxeFMc1s1LFQ60QlS1QgopQipzNGvdr
         h9uVGm8xNS0S5PrgT4gcVRWr2cKRoLqDGDmJVxjYwdqFWVf0hv7R4YcuCD+J1z8IALmG
         KBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VG6irPyoY3Q0EREf5xG3EQ0HqBzqAiFA/lV2HgSaQS4=;
        b=fyC9FTVmfNoUrfWpDDM8ge2YornfivzTZj9FKnUrVVEq/VL0euASry59uisK2gM64B
         wTkFURqEdyD1wWFVXo0MZoN0R7v8rzf39v5h0hE0Ix3QEHpkj/HwHsNeaH2Nif9IIV7L
         zcmbFI5jqKd92QHm0syYKfOAgoEnoGVGaAfDgyFHt8umpWwJ/3C3Rmq2TdcosTobd+XS
         hWtDAHt3H07zQoNgJHJqHjK1gTIa3tj8Z0enu00gH9avLRDriji0/tLKZZxbUg9W62cL
         J9kOyY+Ka0SSDTxcCnfK2CtbovVHUCe+ZMhkCkaWkmNivITX1DU6w/8mKP/YVT7S7LFh
         NcXg==
X-Gm-Message-State: ALKqPwdIZPEy/+AbIQG3NFXwW3PXuEBJNXHn3lbVcYEmAy5LJ2PDwHtS
        fjDFZDs/ZoQhVcNTKeoRTkgtvdM+PTI=
X-Google-Smtp-Source: AB8JxZqViNNi8qvdsxA0ixAS8h2ccrBjeDOa+vXxxUpV80S7BGWvsYbOLxe/01F+caJJvoTjoJW6Gw==
X-Received: by 2002:a17:902:224:: with SMTP id 33-v6mr6803367plc.309.1526597537845;
        Thu, 17 May 2018 15:52:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v142-v6sm9672220pgb.61.2018.05.17.15.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:17 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/19] commit: add repository argument to prepare_commit_graft
Date:   Thu, 17 May 2018 15:51:41 -0700
Message-Id: <20180517225154.9200-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

