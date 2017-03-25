Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DBAC1FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 00:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935852AbdCYAgX (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 20:36:23 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33125 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935800AbdCYAgV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 20:36:21 -0400
Received: by mail-pf0-f170.google.com with SMTP id o190so2336377pfo.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 17:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=037zKZ5J8Bm8yAkpOu51RtReDYXqhXxXcYEsTTqOCnE=;
        b=jR9zFQbvfuQX4diMn7eHvrzSUFkAMFG186nqoQ1PeB0ZpZ1WGETyQ6DjhrEt5+Sykz
         Dbo4iZzTF6TJGspIgKzuhSBA+04wXAojbL1hx4S0dEX0itUgQLPg4FOh1lfFxgwDYVQn
         WIryKPpo0ls+W0O0r3ytDpGbPJCgVmgyFLDrxR2y7z7h3YikepgqXUrZuhY0SvggwkC2
         iFa1LNuaBDwez3i13CFnirZ0NE2jer9DLc55tYmbLFN3PLS4BjY9etN48bmqwl0Ui6Kp
         uOabMaYFKx4xIrvvtEqYPueafJTqAFQYLx9E5ndxXEs6zOMtpjIG2f8Enk/pBfAmbX8J
         W0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=037zKZ5J8Bm8yAkpOu51RtReDYXqhXxXcYEsTTqOCnE=;
        b=L2vjF+BO3g+5jLFWZeynC50ubg8e/P1c+pWgtJSuKXL06LI5SYeSR1WeOB5cymYw3O
         hGuERs3uR9yThFTLjA8deNd0xYZepR1JYBK+z2yxnojn+wQXnDdnJ0W6LwYbq2xuYUyc
         xEZEb0TtaVcuYhoaii75zA7rcR4JJD8VnPGGxJTQHhnBxdLzzc6gjS9nrnjyeS/tzbi7
         gJNc8saUXhLn3CRkDwuG1o/69zraReD9bDYssU4GsT7jymBitdBs+fzY2pXOhmAppBio
         WRuZkW1AB0z9LH2q6nPVN7u63+CIfP9//+4z513eTrx0BjXumYZSpTovTEjVShjp59aX
         I9vg==
X-Gm-Message-State: AFeK/H2YhEc2f8eQWWVdHTcEv62CSPY7TxNZ2iMtxljJDruAQI0srZi8pJYDWMyMdd6YFGj7
X-Received: by 10.98.205.7 with SMTP id o7mr12602237pfg.171.1490402180309;
        Fri, 24 Mar 2017 17:36:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id c1sm6736371pfk.112.2017.03.24.17.36.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 17:36:19 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/7] submodule.c: use argv_array in is_submodule_modified
Date:   Fri, 24 Mar 2017 17:36:04 -0700
Message-Id: <20170325003610.15282-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.gdeb397943c.dirty
In-Reply-To: <20170325003610.15282-1-sbeller@google.com>
References: <20170324182902.19280-1-sbeller@google.com>
 <20170325003610.15282-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct argv_array is easier to use and maintain.

Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 submodule.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3200b7bb2b..2c667ac95a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1043,12 +1043,6 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *argv[] = {
-		"status",
-		"--porcelain",
-		NULL,
-		NULL,
-	};
 	struct strbuf buf = STRBUF_INIT;
 	unsigned dirty_submodule = 0;
 	const char *line, *next_line;
@@ -1066,10 +1060,10 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	}
 	strbuf_reset(&buf);
 
+	argv_array_pushl(&cp.args, "status", "--porcelain", NULL);
 	if (ignore_untracked)
-		argv[2] = "-uno";
+		argv_array_push(&cp.args, "-uno");
 
-	cp.argv = argv;
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-- 
2.12.0.rc1.49.gdeb397943c.dirty

