Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7BF520756
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbdADSFl (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:05:41 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35332 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757849AbdADSEY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:24 -0500
Received: by mail-pg0-f52.google.com with SMTP id i5so164987195pgh.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aJmDjRuB+puF/+AReJDXV7SRewFZ27eBtScBd3WApbs=;
        b=feVP/9fnU53vMVAHf4n7UdwugvWlahMsOBhSac8feGpsH/1RUryfZsYOoiKmXQcSJX
         awRs25xafHsmOkHiN0ADR6oLpPjubdXpEGAmkwGYYuSQMAugHXJhDrMsHT69FRrxCU8/
         Lb1IrsAnaQxzOHYiE0f3/IKs7TgupG0OdIGgAwhXsT+t24Zw6S0rH4pLOJyr+3u1oFye
         dcXFkVRSRTpHR1tCH5ZATR2CKQ9jcok3007aiY3ZE/82iHTS5WJGy5mZd/F802vSTtID
         Sdjf7nHgpF6/Ns6Q7Gn9M1TQe17QI/HjxR/Kc76SJePUD18LfVRr0fdreCTmXCMNbk1l
         28bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aJmDjRuB+puF/+AReJDXV7SRewFZ27eBtScBd3WApbs=;
        b=EhS2q+YojaZtfaJZXHqK+I6sGA7/L/NYdM6Ndubz0ODbTzZwb6292wbV/5+FuUokWC
         8s6bv81niZju1bTfdpGYrO3BmPLm/qYqMXpP9YEvmz86h/6aKGDc4TLxV+Z19OorYuVk
         U8n7Amel+tLZucmujdKWm3NBUKk32vn5OYf4OZgXzFq5A0YB6oLyhfT/27/rZD2K/NYl
         H1xToqwDz0UPnTbZh6NdZ4xy6NP5t0tI5TqbyyN/BrephNiSIsCns+CqPjq8wBmh6NyP
         OJk84U+iBTt7rN8JGn726hhGHx3MU3A305toK+x2AdQe1hFmNzumOLd8Bx/LijG7RDow
         CluQ==
X-Gm-Message-State: AIkVDXJZsMZsN0HlBX/FnYG8DaqEeKc+H/hPwAHlwhjIsAKZh0IuVTbidxF6J1gH85Ya1Daq
X-Received: by 10.84.211.144 with SMTP id c16mr85122538pli.37.1483553063391;
        Wed, 04 Jan 2017 10:04:23 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:22 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 03/16] dir: convert fill_directory to use the pathspec struct interface
Date:   Wed,  4 Jan 2017 10:03:58 -0800
Message-Id: <20170104180411.150000-4-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'fill_directory()' to use the pathspec struct interface from
using the '_raw' entry in the pathspec struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 9ae454dde..bc5ff7216 100644
--- a/dir.c
+++ b/dir.c
@@ -174,17 +174,21 @@ char *common_prefix(const struct pathspec *pathspec)
 
 int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
 {
-	size_t len;
+	char *prefix;
+	size_t prefix_len;
 
 	/*
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	len = common_prefix_len(pathspec);
+	prefix = common_prefix(pathspec);
+	prefix_len = prefix ? strlen(prefix) : 0;
 
 	/* Read the directory and prune it */
-	read_directory(dir, pathspec->nr ? pathspec->_raw[0] : "", len, pathspec);
-	return len;
+	read_directory(dir, prefix, prefix_len, pathspec);
+
+	free(prefix);
+	return prefix_len;
 }
 
 int within_depth(const char *name, int namelen,
-- 
2.11.0.390.gc69c2f50cf-goog

