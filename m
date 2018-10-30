Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A261F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeJaHEN (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:13 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37851 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeJaHEM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:12 -0400
Received: by mail-pf1-f202.google.com with SMTP id c28-v6so12099550pfe.4
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Si5tqxeGXLH4OHDQBmBGaj2ATNe3+UKeenVXQDU6znI=;
        b=U2NXHf+rKfu8jJU9sp6etsspFhX43Z5kkLyhNjO9IW9sE06lH0fjSTf4MnKXrMFKgh
         JPdvWHLjrRZKYQrjxKiz5BZljiT5laNQeCDyFxXBLS/WbtROk8Y3g4jaEZ/FqR9qgffw
         g/pX2c2xhDmS3aQCs87uV7n+0AJDHm4Hsobn2lpH6x9hFWWpsHHrP2U9Ch6jgvR4Lhbp
         kqzfRNwLxvn4qOS8xAYIzLY0cMGbgGLgO3L06+VLUSbx17M0BoeHyir8M9PVbBqhlZXp
         1u5uAsUCR63xrAnfyb+DTHoOeqx3N6zm2tXqRX/WciY6YfFdM3QEl38CiPxSN5Ryel+e
         iH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Si5tqxeGXLH4OHDQBmBGaj2ATNe3+UKeenVXQDU6znI=;
        b=IO0eh+WAZ657dMnL8Xiw03VVqUJmrV//c/MoRiwIC/JDqz5iLFXxvOtRWaHsTQZoPC
         LWm3B52ycahu+sxPaRKj47HJUISoPlZmIzo4xvSiu03CsfXZQjFmQZh8Q4z0Dl0h0Dlf
         0+g76aWjGqWVL5KBXWRJu2jTHTxhkvjSHKbNxOD3Kan4o4m0N5QDvUKso3PRfqWxWnXC
         rXOJkieb19NOdTKjgSZzEli20czuwA12v95NVi20YSvUs5FXRif1adr2f9oR7SBXOs9e
         5e/wv2nIOYe2DbLH4Pqv3S5XggC8Pnsuk53c5LT2RFzqolsM5llgjQubvhwm/7z1lLeo
         3Pig==
X-Gm-Message-State: AGRZ1gK07RCUKiDNGSdQAy0ungWOS6Mie4pq+cjBZC/g06kYisqTP4vH
        +VjUVdwwzhrlLEjALG/Dub+a1n0bvcgkyNYiXTjUVHKn/VoPXq8xHBEE0bO/jvksd7HZ5dt6iiV
        cjvdM6cgRk+wkK1gr85lxOK7L+ONCGh9SuAIvFfQD3kvcXJDMAoUogBzWFB38
X-Google-Smtp-Source: AJdET5c6D0/bCL12643kXPlhkJJ8O9JnXUHc3VjT2AGbu70m65sxmQfHj3P1x3L3tnOfNQaBVIlmMJQHALZr
X-Received: by 2002:a63:575c:: with SMTP id h28-v6mr249161pgm.71.1540937337059;
 Tue, 30 Oct 2018 15:08:57 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:03 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-11-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 10/24] commit-reach.c: allow merge_bases_many to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
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
index 080ae0a758..4cf471bfaf 100644
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
2.19.1.930.g4563a0d9d0-goog

