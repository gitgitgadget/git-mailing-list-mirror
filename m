Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8641E1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbeKNKOh (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:37 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:39146 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKNKOh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:37 -0500
Received: by mail-io1-f74.google.com with SMTP id o8-v6so14299783iom.6
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ts1RZHynoVLLBhU1ZWwveKYofM8UY+3XzaNWeJsLK78=;
        b=hg1aljS3/sfNWMRtB63wFJaZeo0a/bpWCGKWesAYVmpUa2j9itc99y6Jg9s6o44hSW
         X6XX7f2zc0AMQCwLDigT3jZKzglAvkddiovnwTw1sxggxdrW7+ISCqWW8AVANqil18DV
         bpNWnfLESqG9ravn/kPLgNpc4QDrvLQlcUqadymjh/YdViez0D+o0ZF1erKrMWXkTlh8
         op7Aiqv/jBSpPclW8Deoy4NZ6CY1RMYAd0Q6UOrtns0b0/xwBJ21Ehsr8W35sWwua+TB
         RxPg5Ep1K2AVQF58/iVB3NPRdSU8S9EQj78/OxJNY0/NvESPWdBsJkDbmhldOAiHmM+l
         oe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ts1RZHynoVLLBhU1ZWwveKYofM8UY+3XzaNWeJsLK78=;
        b=QiC0KN/CGLOVoulpVVpRWEitxh1Z1aedFQGz7UrL/lM+gaf/GLsSHyoVXR7aB1t7vq
         EZxBk0Iz7x2B3rMS3/WTX0Y8zd6QEGt0F0mGSh2ZHJET6GH/d58bTh2SBZZ+AiMB/rgJ
         1/6b0I7GaqF+ijD5p+fjSZ5zwM64Ej8ZCV+cQGPLqLTLvnb9ZSpUnm+fmzYOaaR1x+Qf
         g+qf2kkP4dGyKYWaoKrgyKj93EC6SPZXv8dL53HytFL7y27tjXhJxphHl7XpdJDg3D3i
         pLPypW6ZuspCiP1TJ6gISmpGYgSNhkIreHy0rfDW9fs5QdLFdpOShA4QPErdZXnP2vbU
         rFfA==
X-Gm-Message-State: AGRZ1gKT11zUMF3OLNx4yOPaSwTQXeoUfSLUn9iIIUVlKJsYwY7keK5U
        xEo0klx+NsYvihTPs8iTSSKnnmeWqfXM
X-Google-Smtp-Source: AFSGD/V6QWCVr/yidMMv+J0lLYFKQk2TR7P1GTLw75O6NxlzoGP2JcrDE0tY6xFWCYQwlE/wHcsDcZ4arlVD
X-Received: by 2002:a24:5e81:: with SMTP id h123-v6mr57630itb.33.1542154434380;
 Tue, 13 Nov 2018 16:13:54 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:52 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-10-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 09/23] commit-reach.c: allow merge_bases_many to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-reach.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 67c2e43d5e..a53b31e6a2 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -95,7 +95,9 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 	return result;
 }
 
-static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)
+static struct commit_list *merge_bases_many(struct repository *r,
+					    struct commit *one, int n,
+					    struct commit **twos)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
@@ -110,14 +112,14 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			return commit_list_insert(one, &result);
 	}
 
-	if (parse_commit(one))
+	if (repo_parse_commit(r, one))
 		return NULL;
 	for (i = 0; i < n; i++) {
-		if (parse_commit(twos[i]))
+		if (repo_parse_commit(r, twos[i]))
 			return NULL;
 	}
 
-	list = paint_down_to_common(the_repository, one, n, twos, 0);
+	list = paint_down_to_common(r, one, n, twos, 0);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -224,7 +226,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	struct commit_list *result;
 	int cnt, i;
 
-	result = merge_bases_many(one, n, twos);
+	result = merge_bases_many(the_repository, one, n, twos);
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
-- 
2.19.1.1215.g8438c0b245-goog

