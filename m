Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581511FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbdFHXmF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:42:05 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36629 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdFHXmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:42:03 -0400
Received: by mail-pg0-f50.google.com with SMTP id a70so20695106pge.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qbNN63JiQz8gIekCn6LqO8KjUOexfcrnCGyhogdZwPs=;
        b=Lz+bXgmta2pTf3b/Jl0SbJwndy4ex3mSXsxMgxMS3bpSsW3SaZmnlU3sJ5yuB4gaP/
         4l08wvoqCbgSQY/Gbu0U53uU5LlkzsyXhsM90hjwUmKvcR2gF1CB0PHsUAFHuGsjIeIk
         +k9O61nVej0OechOJTgMtmjcjAQufXPXdb/5sIwvfEihAPvacDgkOtjljfrlKUNV+7Jc
         kVEJVtUZc7TMJkGGTxC+cbRRMWE6LyN4XYryK8nbjtzLJ1XesNklap7HIQcWDfzJHMtR
         Wyf78OC1qmapB4nbAkCcbnN1o0AndoyatV/fSed9bzMgb4pDrPIkltZ5j7Fmr+BvTDJQ
         bErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qbNN63JiQz8gIekCn6LqO8KjUOexfcrnCGyhogdZwPs=;
        b=goOSoNgPQ43ASpQvcFsqvLSZk7uNNnGarrNt+da6pJIiSvMxbQaVyuHuxaAvKVMrsb
         mqTtZV4poetJJxiBPpmSqUPrHT6MOCwUdiZlD9UdLNQI4dLNLAk65O/UJYzG+/NqgxuA
         uuTwBfDGFLHfSg0hjfx9OGqPX7NRuyGQclq7vtpYDvcZFPHeldWQUF70u3U8+/NvWqq4
         /r5Tv94vo5c7vNuJrD88BBFjjkp6v4KOssNtZhE3fqtIKJmD3vzDZl8m+o5qHsxvgPvC
         2TZ5z8IQ4i3sjzEr457JnlErUL3kDmXddqD9xnr1dzMLhuaDj6hkIIH3xoy6YmSWtvcI
         /5uQ==
X-Gm-Message-State: AODbwcA+rzeR2hnWEzKaPm848+2/7w1QeN+i4sUKLAz9lhrfj7LLG4Pd
        sxaRmaYQ80UeD0E44dBofQ==
X-Received: by 10.84.130.33 with SMTP id 30mr25204573plc.240.1496965316817;
        Thu, 08 Jun 2017 16:41:56 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:55 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 25/32] ls-files: convert show_other_files to take an index
Date:   Thu,  8 Jun 2017 16:40:53 -0700
Message-Id: <20170608234100.188529-26-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f9578cf9f..d00ca7810 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -109,13 +109,14 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 	write_name(ent->name);
 }
 
-static void show_other_files(struct dir_struct *dir)
+static void show_other_files(const struct index_state *istate,
+			     const struct dir_struct *dir)
 {
 	int i;
 
 	for (i = 0; i < dir->nr; i++) {
 		struct dir_entry *ent = dir->entries[i];
-		if (!cache_name_is_other(ent->name, ent->len))
+		if (!index_name_is_other(istate, ent->name, ent->len))
 			continue;
 		show_dir_entry(tag_other, ent);
 	}
@@ -337,7 +338,7 @@ static void show_files(struct dir_struct *dir)
 			dir->flags |= DIR_COLLECT_KILLED_ONLY;
 		fill_directory(dir, &the_index, &pathspec);
 		if (show_others)
-			show_other_files(dir);
+			show_other_files(&the_index, dir);
 		if (show_killed)
 			show_killed_files(&the_index, dir);
 	}
-- 
2.13.1.508.gb3defc5cc-goog

