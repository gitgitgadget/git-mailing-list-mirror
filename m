Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EAC41F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeBXAsp (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:45 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45483 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeBXAsd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:33 -0500
Received: by mail-pl0-f68.google.com with SMTP id v9-v6so3846369plp.12
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f1CPfOLTq9u6mh0461jmcIqTvhgAKRh0/XQKh/NeJts=;
        b=ZXwnxFjfvfj9rD9D6Sekg6Mz+qn/x2xFvWOzO6+GIjFcnkCUQvXGISSZeLKXKi+c1Z
         oeJdqgALpJwiZSx5MwFs4S8ewe4mXZJ+BkKw8OTAi0QE9+AK68d+4zs0XLewbchPZK+m
         uIaBBLzYGxPjnBiw57sI99f0dLkdwW+0TCExENJix0hZ2aS+l8vji9bMibFPXGIMuk1l
         WuTm9scwoaBBJClTYfdB5LEhSj+wOpGGz3HSBjDAGkv5328r8Pnj1hTi99TK5TFK2eAN
         IJSz9Yza3LmunAIFt+PLZ2k94sBQ6gtEIy7NMBYWJThRq0qtVej06JxXNiLBMF+lfUFv
         DkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f1CPfOLTq9u6mh0461jmcIqTvhgAKRh0/XQKh/NeJts=;
        b=WWrgwXfF5yvdNDot/PXhtytR9lb7/KSy2Jn4GOdgWy2fomlvDwEJLNdWOFb7ow40Cj
         FDPvSX5NzBfhiqzUro1wxmysNb/ckTWyxzSQ3XaDCnFDsHO6lHXG+HK2KAUtDaBqDjYL
         /uSkxcnZ+mL4fBDB0pGjyHLFwvCZkGfOgUkKc7JaORECh7nsyAEOlQl+MpROjyIKJbNU
         iIrWjdHotzflJu+bFyLPMIvHr4N/ToPXYqXY9bqW4ozLAUlyMHzfVgRFfqkoguc8mg+M
         mcNUIGvk5/ndE5TW0kGzKKO3idySELM8cPRlsCUkZt6MJJp2UJao7x5wq94JuS9HJImQ
         IpdA==
X-Gm-Message-State: APf1xPAnHG6S0nvK5kwp/ex6OYV7mYkHl0DZuBl+v5RAcH81yJiwOGAY
        nvU1u0tYgebtNZLPxmVxn2Dknc1ko1Y=
X-Google-Smtp-Source: AH8x2240yi4161lNLVN/iyvyp0DIkukjkS9bCcPKYHBTZ5QcyeZih2xLWyxSgtiyql56Mqkb0CTR+Q==
X-Received: by 2002:a17:902:8605:: with SMTP id f5-v6mr3304848plo.120.1519433312621;
        Fri, 23 Feb 2018 16:48:32 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 10sm5903630pgg.73.2018.02.23.16.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 25/27] sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
Date:   Fri, 23 Feb 2018 16:47:52 -0800
Message-Id: <20180224004754.129721-26-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 73bbe3a3e88..e32f1da6b69 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -931,10 +931,8 @@ static int open_sha1_file(struct repository *r,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-#define map_sha1_file_1(r, p, s, si) map_sha1_file_1_##r(p, s, si)
-static void *map_sha1_file_1_the_repository(const char *path,
-					    const unsigned char *sha1,
-					    unsigned long *size)
+static void *map_sha1_file_1(struct repository *r, const char *path,
+			     const unsigned char *sha1, unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -942,7 +940,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(the_repository, sha1, &path);
+		fd = open_sha1_file(r, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.16.1.291.g4437f3f132-goog

