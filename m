Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD402035A
	for <e@80x24.org>; Tue, 11 Jul 2017 22:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755979AbdGKWES (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 18:04:18 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35499 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754244AbdGKWER (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 18:04:17 -0400
Received: by mail-pg0-f47.google.com with SMTP id j186so2572464pge.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WqOuc/z5yFTA6LJcYYGXEOYD9oaAWsv8pQfp3YLV6aA=;
        b=VRId6p9FEpvVKWNwLuXK/Q6ngKAQH+wMbPUETfBq+rf03Z5NUOIM6FEhgkUJwK5fDT
         NbB/1VftcuyalzG1IG99NSd8hQl0zwKKssbf9T69lkGG2TTh2yAnUVTWs7MGQFLzGFJa
         VP/5T0PhImalv/T7bUqDlNKPOKUV79blOw43PdDAJ2d2XWLGJ6Sae8ChpWfm+hU61fk1
         CsDSprD8qOWtPoM45OSPyGrYz33DLM7ClSbAV23QDDJS2YvJEU+8Lox1WEqkzI94LM1Z
         JgLU5eGfONXmeQ7rEIzP0l/YkXcMwDK4fwDpRGn/N9hFJXswnq5IeMrOwcTWAFAl2wEx
         3QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WqOuc/z5yFTA6LJcYYGXEOYD9oaAWsv8pQfp3YLV6aA=;
        b=Z7aMMTotEDxJTFSigAnX1o0VP1AX+3aVjMOEPabzInp8Ay9B0fTnPtuNLAs7niXepX
         G/s2YZbd5otg6D3xq5cGx365oSi4zav0g2gquOvf/ZzH6y+OQqiIFpqKsI0jBUIWasOq
         Wgs/BwJw1EpzFuvVrR8mQSTRfIeumLzWdBfwQrJpU9xt+Gy8GHbQH/vTebqhZA61nhNT
         3X7y0YFzbX3cy7DFAUR8SrzQ4hLNUPACAuKG+hdo0WjPhEBcIJNa3a337pz2tfupdNMj
         DPMqrj2ob1Egd6uedQfRgqwLj0U9Q2as4FnqR/kVXaFPjrs0d99X5rQUwB7eRnCDx24o
         paIQ==
X-Gm-Message-State: AIVw1100xF5xEDHV0GAzPoDICNy5W+6m8DAe3QnV+NVcS/KPlUXxat81
        yAmiyYPdICrgfjTJxWmnjQ==
X-Received: by 10.84.231.197 with SMTP id g5mr604112pln.71.1499810656405;
        Tue, 11 Jul 2017 15:04:16 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d18sm542782pgn.27.2017.07.11.15.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 15:04:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/3] repo_read_index: don't discard the index
Date:   Tue, 11 Jul 2017 15:04:06 -0700
Message-Id: <20170711220408.173269-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170711220408.173269-1-bmwill@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have 'repo_read_index()' behave more like the other read_index family of
functions and don't discard the index if it has already been populated.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/repository.c b/repository.c
index edca90740..8e60af1d5 100644
--- a/repository.c
+++ b/repository.c
@@ -235,8 +235,6 @@ int repo_read_index(struct repository *repo)
 {
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
-	else
-		discard_index(repo->index);
 
 	return read_index_from(repo->index, repo->index_file);
 }
-- 
2.13.2.932.g7449e964c-goog

