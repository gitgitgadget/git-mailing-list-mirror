Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4946C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893CC64E8F
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhBHT20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbhBHT15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:27:57 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2907C061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:27:15 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n10so10873915pgl.10
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOSvAfDTxn+UDyajn4iN1QcQ+1uMdr46owQWL88ItPs=;
        b=u36o58t4LisyFQaX/HHJT1F3JIfikbWpGwqH3adUJJiG8eDJLe7S1LuxM2G5QC7t/5
         ZWmkFCgFDxX0gA46yurqua0wlb/Uh1W4G5xvLEGIEFGsgz4/PIMZznw6vdIqc4ato4ZG
         vlH8sZoRXc3sqAGKq34yXAszTQ4szcZqHhx4aaAVgGEZEIGrqXCklXSdmNj5jR6wOg5r
         gRI1uzNJQifVLfgKSryFgYWk3WRUOOgO/Ez0wrTHYDYU1Q/1RayZNa4NpwzE2bv2MMzQ
         s1HM6exTmdhpyRABaPlRLAhRaubOu31UPXEkwavgnybOmHAQ0p6vCbdPGtw3N8VwjovO
         DAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOSvAfDTxn+UDyajn4iN1QcQ+1uMdr46owQWL88ItPs=;
        b=jQBW2obdmJNMaRDsibamWjUjkI92+nkpb76VVJ2tekaghjYfsc8g5OorbSG8oOpgTw
         a/5hcq+KmO7g3A3Pa/ryj2qUjkJ+MfdxlwveAJylNDQhkgxRjqfuztUt1WCRjfGoTre0
         i70dhJMWQZ8FU2qtfMICcPZbGcml4n3hPv0TkbT6C3ctHmHeHGnUGHuBaLQCoxKhBxhg
         sUzvIC+oSQE00po2sONcgYyKG+c1Zj//ijLb0va2fdwgomLmGQLEQ+R2aSYQLg3CZLlr
         8F0D4H3Aqho/2JUSY6CTH9TjspRlI7OMvGRzyyiKyeDxjy8kni5Y4eEzdNWHSshCSzoO
         KSHQ==
X-Gm-Message-State: AOAM5320hgswcrj3DEy8SHdRrUZkyjEEdek6s7/+LLBXFGP6O5imnQq7
        0QgZ0oWQ1oXPJo/Uuy/5nwNPtLV/qBUA8Q==
X-Google-Smtp-Source: ABdhPJydsopBm0//UwInp9JdjUdFDQwqwrmrRPLz5Qbix7n3BnAz184F9E1O/NsTuPIxn6sddrBwRQ==
X-Received: by 2002:aa7:8016:0:b029:1d5:ea54:d7be with SMTP id j22-20020aa780160000b02901d5ea54d7bemr19363636pfi.29.1612812435121;
        Mon, 08 Feb 2021 11:27:15 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:27:14 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 03/11] rebase -i: clarify and fix 'fixup -c' rebase-todo help
Date:   Tue,  9 Feb 2021 00:55:21 +0530
Message-Id: <20210208192528.21399-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `-c` says "edit the commit message" it's not clear what will be
edited. The original's commit message or the replacement's message or a
combination of the two. Word it such that it states more precisely what
exactly will be edited. While at it, also drop the jarring period and
capitalization, neither of which is otherwise present in the message.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 rebase-interactive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index c3bd02adee..e85994beb6 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -45,8 +45,8 @@ void append_todo_help(int command_count,
 "e, edit <commit> = use commit, but stop for amending\n"
 "s, squash <commit> = use commit, but meld into previous commit\n"
 "f, fixup [-C | -c] <commit> = like \"squash\", but discard this\n"
-"                   commit's log message. Use -C to replace with this\n"
-"                   commit message or -c to edit the commit message\n"
+"                   commit's log message; use -C to replace with this\n"
+"                   commit message or -c to edit this commit message\n"
 "x, exec <command> = run command (the rest of the line) using shell\n"
 "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
 "d, drop <commit> = remove commit\n"
@@ -55,7 +55,7 @@ void append_todo_help(int command_count,
 "m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
 ".       create a merge commit using the original merge commit's\n"
 ".       message (or the oneline, if no original merge commit was\n"
-".       specified). Use -c <commit> to reword the commit message.\n"
+".       specified); use -c <commit> to reword the commit message\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 	unsigned edit_todo = !(shortrevisions && shortonto);
-- 
2.29.0.rc1

