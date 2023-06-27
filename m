Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E223EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjF0OLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjF0OLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:11:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03052129
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:11:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso2798805e87.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687875073; x=1690467073;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h5YZEnuaAb8g3hVOu9nxfnOonXQsmvQY5+L/jSkb4yY=;
        b=r3TUdwMiOhVw0m/4HcUKx71yt+PPZcSIZr8mO0FPZqFhkDgVjaKwXX+19+4KAKjq4C
         X0rN5uRjp+QU/ph3HYXotVtR/6XIpKRu156JeXZbPOOh517pcwsVX0Kqrd/fsqh0LgLM
         bAFbALA+DUpQ9WOy3nXMTVNYrHmzhJrbXHjbjzrpEl9Ap3FTeCH4vsqqh+fbS+D9JPpa
         0gHvgECjy8fZrJ+UFlUZ7gcfcNChcssiEYSSxJO88orceDVDhzvsZ26BCmD5rD6re8rS
         8Z3CDjoNceRGuKD5K56oAU6Ooz3v83letQLT3QdSQJxWM+xxFAyj2uARAF9yCgGAB63i
         3QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875073; x=1690467073;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5YZEnuaAb8g3hVOu9nxfnOonXQsmvQY5+L/jSkb4yY=;
        b=KBAfSp5+l/QLbLhZ7ETNPd9cjullve/aIpx9mirWHBOitGPnACE/gn3B/fzOxLMKqg
         YGjoZbMbFshc0Vl9+9z+Ei0iPXydgzDX9jmgMri8XiphqmBe5S96To3nXdGHHW53GZeb
         MljK+xeOoCuL/eKVKfCJzUUwSQQ9j6BHWzbSmQkyUyR6K1ogyVz8eYPaR3rvAF+cGLbn
         oecellA2RXi23s1WDW/iOuLr9psjQ5Y24zYNWwZfvX9h2qSQdToT0kRxMCZOO82WW5cC
         goUAktJHXbysjiQzGmIwQ0YffqNoXS2tnJp7OU+BQ9rfKnN62Skh4RvbY+GltZHSqw02
         y1iA==
X-Gm-Message-State: AC+VfDyOaolu37h4hX3lh4irMQmDdP/j2A/24all9arRaG/ktirGCVJ9
        SghSofP4FkRSnU3EiEfrRBUsGQcZgsM=
X-Google-Smtp-Source: ACHHUZ6tsoltyer8rZSPzm7ukqSEx+96ZFgmlaa/fXIM5glf7JbeLVvVsvNhp25Z8WXlbw+i9SJE3w==
X-Received: by 2002:a19:9158:0:b0:4fb:8a0a:31f2 with SMTP id y24-20020a199158000000b004fb8a0a31f2mr575286lfj.69.1687875072621;
        Tue, 27 Jun 2023 07:11:12 -0700 (PDT)
Received: from localhost.localdomain ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003fb9ebb6b88sm2581935wmj.39.2023.06.27.07.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:11:12 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/3] diff --no-index: die on error reading stdin
Date:   Tue, 27 Jun 2023 15:10:14 +0100
Message-ID: <5dad728f3b654f0cee59903cb7563298b2d743e9.1687874975.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.1.852.g22d29fd9ba
In-Reply-To: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there is an error when reading from stdin then "diff --no-index"
prints an error message but continues to try and diff a file named "-"
resulting in an error message that looks like

    error: error while reading from stdin: Invalid argument
    fatal: stat '-': No such file or directory

assuming that no file named "-" exists. If such a file exists it prints
the first error message and generates the diff from that file which is
not what the user wanted. Instead just die() straight away if we cannot
read from stdin.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff-no-index.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 4296940f90..7b9327f8f3 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -60,20 +60,19 @@ static int get_mode(const char *path, int *mode)
 	return 0;
 }
 
-static int populate_from_stdin(struct diff_filespec *s)
+static void populate_from_stdin(struct diff_filespec *s)
 {
 	struct strbuf buf = STRBUF_INIT;
 	size_t size = 0;
 
 	if (strbuf_read(&buf, 0, 0) < 0)
-		return error_errno("error while reading from stdin");
+		die_errno("error while reading from stdin");
 
 	s->should_munmap = 0;
 	s->data = strbuf_detach(&buf, &size);
 	s->size = size;
 	s->should_free = 1;
 	s->is_stdin = 1;
-	return 0;
 }
 
 static struct diff_filespec *noindex_filespec(const char *name, int mode)
-- 
2.40.1.852.g22d29fd9ba

