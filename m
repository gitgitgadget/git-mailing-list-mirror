Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9841F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeDFXWG (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33512 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeDFXWE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id f15so1800202pfn.0
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R3Fonizgf03aUxU8srt2UfW9BBFgJe1Vvi7UfJiz/fk=;
        b=OmKbA563HlcezCAHMPYUcOjv5TyWDUAGUJntMiSt2ehAZ9Y9FfcdORenfoBbGPU5wL
         k3Cz9WqbnDgPMttBAbZtEAbmlNQdJ2m7bhfNzBpC4HhBPo1gyaz7iNs8O3a++AIH1jSo
         TpVJKFgeU/zUierhUbCAEYmFdzhUTLZfe+Zm6zkoDPtazkajuNvbMYqoDuNnqbk8KGye
         jdDUMZ/7hsSObrWABp1t4v0T7ptIrbS6ifw7UInvdkg7B3B8GM6Aihve7YywHCU8tFtP
         k30kLvzaRxUO1gVYjuLeaYn7mK8kDtQma1kKljn9kw8NDSlKBrr2yMf72o5zDk5+umYQ
         lIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R3Fonizgf03aUxU8srt2UfW9BBFgJe1Vvi7UfJiz/fk=;
        b=eAnpY6fPeufzcKNi7+oxiYCorKbj7apo+zmHRRNyFNzTWaJxcI/HaqAmYgHeeZdO6R
         zEy5YrE4ERkZ4jj4/EayVdQGPEhFZFyvU4/71VADxAYweDkJfpZkHw59bTrJTCmgM5Zn
         SXU+zzr4ludxP5yIChRlqXAPQWTM7yXfKBzHumd6E9S2futMW4bxmvimrxUpVc7tpxF8
         fW8e+vMLBrGRSaCITtLS74VG8TedFAQGN/dtyG5d+KBg1XaMyfFcrDYToEGs4eN+zAt/
         m5ZgO5+DjxoX3W/EE9sf0Ctsw5P0mcmRfBcjJx5VJegLMdF21FS98cARJLcG+Td/Laak
         P/0Q==
X-Gm-Message-State: AElRT7GO4oUb5yjmQFzfpcp63vI7A+i8fqUqZQNNwRZ8YJQ5BAnZQ5dJ
        FlSc7JYo1TlviSLotQOg1WltWA==
X-Google-Smtp-Source: AIpwx49Butf0b3lmxuKFpBJXCPCNnC1gpbrRy1svckTOhZfCrvkFEboxUXYpg3vlhKLcn6asBAYWFQ==
X-Received: by 10.98.15.195 with SMTP id 64mr21577193pfp.63.1523056923121;
        Fri, 06 Apr 2018 16:22:03 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o9sm14047403pgv.74.2018.04.06.16.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/19] replace-object: add repository argument to register_replace_object
Date:   Fri,  6 Apr 2018 16:21:26 -0700
Message-Id: <20180406232136.253950-10-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the register_replace_object caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 52fc59c4f7..e9aa964978 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -21,8 +21,10 @@ static int replace_object_pos_the_repository(const unsigned char *sha1)
 			replace_sha1_access);
 }
 
-static int register_replace_object(struct replace_object *replace,
-				   int ignore_dups)
+#define register_replace_object(r, rp, i) \
+	register_replace_object_##r(rp, i)
+static int register_replace_object_the_repository(struct replace_object *replace,
+						  int ignore_dups)
 {
 	int pos = replace_object_pos(the_repository, replace->original);
 
@@ -67,7 +69,7 @@ static int register_replace_ref(const char *refname,
 	hashcpy(repl_obj->replacement, oid->hash);
 
 	/* Register new object */
-	if (register_replace_object(repl_obj, 1))
+	if (register_replace_object(the_repository, repl_obj, 1))
 		die("duplicate replace ref: %s", refname);
 
 	return 0;
-- 
2.17.0.484.g0c8726318c-goog

