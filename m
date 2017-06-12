Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569FA20401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbdFLWOq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:46 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:32934 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbdFLWOk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:40 -0400
Received: by mail-pg0-f48.google.com with SMTP id f185so50814789pgc.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=StjciFVyXXxwzfeWHDfpiLCu8n5HPH+oABI8UVGwSIw=;
        b=aJLkpbpgqCV6hldMsBvswckz9qNFacsmL5qnzQ5CnhwWtiuHDLjnFFFNPJg+J2Kq75
         o17xh7HcTgvcM4qwHCfm1FySMa/c+bOhkiqsUN/q4h+23r2hX16/ExDigDotO+6q8k5G
         35ontPDyB3wFGNNU5fKp0kMVFwwaiiMMtuScKg3RrDgCnioy2So59VQeALN4TIOnLzlO
         Kq6KxrzkrJepXTd1VFeKCsMK1FXEEoGE5srLwKrtXYliyJ3cpyTm9C3n5EdZZMvUEI57
         YHCs5dlJD/kn2bnDxxrzWTjlq01Q4jWbAtjgDDiPziHUWzov7Q95IByUGOUBj0/v+DuJ
         r5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=StjciFVyXXxwzfeWHDfpiLCu8n5HPH+oABI8UVGwSIw=;
        b=C1z7S/88+jOsRj9xe9pgwzTOkoQdP68siQMsQNYqJBKwL+wCeHeTEK2PAm0wGcCk6h
         5DTZuAXfbCeMRjL+OojktWa3+Ep5uzp8z8ttLpsLQ49xroyxM6Yqo5DJRhBPa82wYff4
         poTuZCYCp+O/rhTyxkWMlYubN3bZ23Nqyx+1vyl5/LZ7ZgznlDgib5q2gQ4Z2IBflAxQ
         4zFWOT8Dhllr74DEuaYpcKoIvBwQQ4lkq05lKIdGOMmhR18jiLo/j7OGdveZYFZvWhtM
         Eq6brQDx6wCROw7yLGWssyvKKw7J0mWaaOvtF1e8VvRrrZdrhLmxfHbtPt0nNgfKBssi
         dYuQ==
X-Gm-Message-State: AODbwcAPwu1U5nYb/xCMIvw3T6DzswqDfyfFiFd433uf+Q0xD6wnC8yT
        7Gc2wtCEeUT6EMdorFURPA==
X-Received: by 10.84.217.200 with SMTP id d8mr58337694plj.270.1497305674081;
        Mon, 12 Jun 2017 15:14:34 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:32 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 10/17] ls-files: convert show_other_files to take an index
Date:   Mon, 12 Jun 2017 15:14:01 -0700
Message-Id: <20170612221408.173876-11-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b82b78036..5dbff9496 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -108,13 +108,14 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
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
@@ -336,7 +337,7 @@ static void show_files(struct dir_struct *dir)
 			dir->flags |= DIR_COLLECT_KILLED_ONLY;
 		fill_directory(dir, &the_index, &pathspec);
 		if (show_others)
-			show_other_files(dir);
+			show_other_files(&the_index, dir);
 		if (show_killed)
 			show_killed_files(&the_index, dir);
 	}
-- 
2.13.1.518.g3df882009-goog

