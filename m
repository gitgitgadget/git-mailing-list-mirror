Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE61FC433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF3E22D5B
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbhAET0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhAET0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:26:01 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C09C061793
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:24:33 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 23so1001822lfg.10
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4bMS6s9GDEzd2LBRxyMovj8EJhSLVBgBIFQSHH4LAM=;
        b=Lfn+IpHGbYGIQjRj8atnMhID5HGRWphUA6YyCMJrLzgRCTc+zo2zGy7u8thTBZOFe0
         aW+N1f4lM0gh6P6QyJKKhPXtBUPEqqeQlKC9UBMPcHg4wGXZnjslXnSZg6xyUNA5Ps4r
         go5VFAV+9e0DO55LJuMZrbrgBHnWFSj7vHML6yYTvsUfTeLpdg0s6rNmWgo2SC52+mJq
         7tpbczEt134+VMuZFDC1mLmFUmQDW1sHA4JNP/WYShJoSbAuQt7vINLVgbn1jE+HE4YW
         3V0s+jrJiT9Y33w6WoPSHNzmLHSGbp8jm+/rQBQ0ubYUkneCeJF2iRDz7ABb4XIcwNk7
         R6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4bMS6s9GDEzd2LBRxyMovj8EJhSLVBgBIFQSHH4LAM=;
        b=pZJOOlylojB+DUbRirDIAsTN6otlw7RB7JWRgDB23H4CEpw8KKbWuuNAuzJ7Wmq990
         KcHO5x4ULbrV7HBCHNsD+uh/9UCn5VfdyEpia69rW5oNDA4Vfy/7l3R/vt6mj832WDwM
         ZKrjx17sZpeImn9Hygv2fO5L9e5cadpWBrpulbZOzd/EZv11k0k8cPbdWYYEihCbAqLE
         zir++clWYUgmo2t6JZD9MzWRHTx0IRxbso6z3OlqquszkYgR/H/6RLC8PQtvx+F3ic38
         3OhIJ/L2yymvVtHu8l0aHUIkYjbAw9OGrTECEyDhKnMNnOJaRL3070wmzOCA2w9qpJsl
         3kIQ==
X-Gm-Message-State: AOAM533sWRZVqt7p67I9tOWn0s0eCPJYSD/lbLEHaJa7xfUNlJ4+OGg1
        wmdvCrgqd3YhZCCKcAmyZ08zJkQtjCA=
X-Google-Smtp-Source: ABdhPJxm40g6dJ+ZvbDZAvTZ6MQ2nBy8i2WMcNR/ZFQ9rWCNGaYrMVHGXF5oXoF+Py4BZIekfLiRTw==
X-Received: by 2002:a2e:b8d0:: with SMTP id s16mr491451ljp.423.1609874672237;
        Tue, 05 Jan 2021 11:24:32 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id h1sm9116lfc.121.2021.01.05.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:24:31 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 0/5] avoid peeking into `struct lock_file`
Date:   Tue,  5 Jan 2021 20:23:45 +0100
Message-Id: <cover.1609874026.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I made a comment in [1] about how we could avoid peeking into a `struct
lock_file` and instead use a helper function that we happen to have at
our disposal. I then grepped around a bit and found that we're pretty
good at avoiding such peeking at the moment, but that we could do
a bit better.

Here's a series to avoid such `lk.tempfile.foo` in favor of
`get_lock_file_foo(&lk)`.

[1] https://lore.kernel.org/git/CAN0heSrOKr--GenbowHP+iwkijbg5pCeJLq+wz6NXCXTsfcvGg@mail.gmail.com/


Martin Ågren (5):
  builtin/gc: don't peek into `struct lock_file`
  commit-graph: don't peek into `struct lock_file`
  midx: don't peek into `struct lock_file`
  refs/files-backend: don't peek into `struct lock_file`
  read-cache: try not to peek into `struct {lock_,temp}file`

 builtin/gc.c         |  6 +++---
 commit-graph.c       |  6 +++---
 midx.c               |  2 +-
 read-cache.c         | 12 ++++++------
 refs/files-backend.c |  4 ++--
 5 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.30.0

