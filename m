Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A7C1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965600AbdCXS3K (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:29:10 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36477 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965043AbdCXS3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:29:07 -0400
Received: by mail-pg0-f44.google.com with SMTP id g2so4873884pge.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1pNPCNeAe4BJtQEkw5azEqrTaZgvptLLoYp0oBwbPq4=;
        b=IVVh1ZZFtpJfLZh3PFl2e5Se/SWrZwIa7Q6VbBeOZQTJw+y4Lpnn/fwBGxLWCfzRRQ
         cIL8AQWPJ6+xLmHOVywD+0/yw0SYKgyP0bmL2X4iyeg+IC0QRx0QuL0BVzdXz6e97Nzl
         +MYVqi+6oj0T6yIZI3Hp5v+AArEgswS/FJWuVU1rxL2UEYcT+zLwOEQA2QNTV4NAg/He
         GftVnpwfpVXILyKoRmAxkI2WrvI+un2tKKrX5UfWzbfC23OZhi59+9b4oLdrzTDnzOC2
         by86PMyXXkVa+acuSDmDdDx8XQY0qTZzKMNt8ZBGO4kUiYxfc3+2CD/aVzLQuec7AMzp
         qbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1pNPCNeAe4BJtQEkw5azEqrTaZgvptLLoYp0oBwbPq4=;
        b=Y38XSvuXUu5Aw9we9LCCtFCA/ecY+cgxfnFcfsF/qdkwjlfmjjsHD0O4nbsf3208bF
         rJVbsg0TeAZCsU2gcC4zIw/w3Oqm1/4tSu54o/Q7mxGG51IeTb3DSfF7yHJXEqVmevy8
         D22GLlRNWXtMj/yuSyMoudQ0gtgUxYsDb0/YMmJRTQdwSfqKQKfu/IcfDmGWrNppZNc9
         5Y5o475l15SDRZ+4xsUBbxaFDfzf9OQCbVSNAxWNrpN3jXi12CUvLZCNr9DHVd46yJ+x
         uHejj8mD3uXx97+nN3uUZ3Yy82/XAF+F6qcgRDnsG9ExhTk0sLhxUNs4iVYWpdjJtYXW
         FJ1A==
X-Gm-Message-State: AFeK/H1bTMaJGhuPKwmvlytuSoVfixuVfuv5uPVJ50D8lBonnpwar0IssJEgpMmervXRURlf
X-Received: by 10.99.67.1 with SMTP id q1mr10910306pga.210.1490380146144;
        Fri, 24 Mar 2017 11:29:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id a62sm6003420pgc.60.2017.03.24.11.29.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 11:29:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/7] submodule.c: use argv_array in is_submodule_modified
Date:   Fri, 24 Mar 2017 11:28:56 -0700
Message-Id: <20170324182902.19280-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.437.g2b7623d507
In-Reply-To: <20170324182902.19280-1-sbeller@google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct argv_array is easier to use and maintain

Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.12.1.437.g2b7623d507

