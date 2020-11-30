Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D1AC63777
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 23:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC6B2076C
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 23:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="d6vt3C67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgK3XHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 18:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbgK3XHe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 18:07:34 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C7DC0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 15:06:48 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so2267pgg.13
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 15:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=kFwzmwEMrEjIro43c4w8TSeK59MCyufNq30hfgb6sMQ=;
        b=d6vt3C67CVOalLCloZNHVOVGW8yRAQ140+PtwoShXePWVa18WMiDChMrsVpBopGlF9
         D7fIqfB2D5KjUsVTu3Ng7hlWuawDBWBu9VwT3rjFcJoqZbhxcCiLm44Y+SpvwLka+DXH
         RmCg8r5ZzXyKWRN8kliJx7o/aGExNLBXMRLl//++kF5oIPuswxn4jXIALIW3BhZqoxin
         +nDvR94TNYQCxgrDtmL6sh+njxgj8j2MaiL0DlBF5kHpd46091feNuLHuF8qCPwRzVtU
         6EGCUN0A6A7Ta7GgLcW3QaOvyEC+nUutUjyLVxaZshWiWqHhlWQSjeje4MqlIrykF76M
         xOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kFwzmwEMrEjIro43c4w8TSeK59MCyufNq30hfgb6sMQ=;
        b=oNCxVF8/ZAlpSlj7VcrHo1qaDOETKCnowztmbLJUuli0n2JyQOr7X+ep7S5QtkOyHi
         GG2mRr9zH5MaVpREqQuO+dFq+rwg6MH48OPLpBkGHW97cOfIGhJ7SFoJ3eJ9a6IwuikQ
         kkR6e0m9b5sBcc171SFKbHHDLfFGYu/fRjAeprYzUgvZb5cglfyoKQIj8IUgKpJ8UCgR
         Q2wCOfTZ8UkGJi4MAsEH1Lka7UITUNsEgcEFimK+dW+o5WQk6ajRpve8lMR+SScZUR97
         2l4txdqd9wZ8EwFqgQm3986fmao74kPtX3YNPyneU405PDDaEvCg2LBGvVZ5Wi8HUnhp
         LUPQ==
X-Gm-Message-State: AOAM531KTkywy6XUnA5xetslzNJYzCJuNwtcK0VN5DzLS0xQFQNeWiCZ
        BY4jYb3VHAJx0SalDQeJGcKk47l4pgUKdM22
X-Google-Smtp-Source: ABdhPJwzVo0xx/96TJF+85EvbIAkDCxHiELdZ5IfAE3nZDjfJZdslAmFIgvcNPFAjGdh1gsJKPzeuQ==
X-Received: by 2002:a63:2d86:: with SMTP id t128mr20432458pgt.5.1606777607451;
        Mon, 30 Nov 2020 15:06:47 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 199sm18714680pfb.219.2020.11.30.15.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:06:46 -0800 (PST)
Date:   Mon, 30 Nov 2020 18:06:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com
Subject: [PATCH] builtin/bugreport.c: use thread-safe localtime_r()
Message-ID: <27fc158339c91f56210f00dae9015da1d6c781ec.1606777520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To generate its filename, the 'git bugreport' builtin asks the system
for the current time with 'localtime()'. Since this uses a shared
buffer, it is not thread-safe.

Even though 'git bugreport' is not multi-threaded, using localtime() can
trigger some static analysis tools to complain, and a quick

    $ git grep -oh 'localtime\(_.\)\?' -- **/*.c | sort | uniq -c

shows that the only usage of the thread-unsafe 'localtime' is in a piece
of documentation.

So, convert this instance to use the thread-safe version for
consistency, and to appease some analysis tools.
---
Some folks at GitHub sent me the output of a static analysis tool run
against our private fork, and this usage of 'localtime()' showed up.

This is purely academic, since this clearly isn't a thread-unsafe usage
of that function, but it should appease any other static analysis tools
that folks might run.

 builtin/bugreport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 3ad4b9b62e..ad3cc9c02f 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -125,6 +125,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	struct strbuf report_path = STRBUF_INIT;
 	int report = -1;
 	time_t now = time(NULL);
+	struct tm tm;
 	char *option_output = NULL;
 	char *option_suffix = "%Y-%m-%d-%H%M";
 	const char *user_relative_path = NULL;
@@ -147,7 +148,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	strbuf_complete(&report_path, '/');

 	strbuf_addstr(&report_path, "git-bugreport-");
-	strbuf_addftime(&report_path, option_suffix, localtime(&now), 0, 0);
+	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
 	strbuf_addstr(&report_path, ".txt");

 	switch (safe_create_leading_directories(report_path.buf)) {
--
2.29.2.533.g07db1f5344
