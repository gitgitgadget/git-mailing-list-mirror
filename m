Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711F120A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 22:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeLIW4k (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 17:56:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54285 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeLIW4k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 17:56:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so1692003wmh.4
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 14:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44cHL4pTwmuYMzVmbEhU3gMCEK4RGkyr2I/uvdRi+JE=;
        b=EPvIzs5Qe9ARA19iUM43sUfNYclkyOO3llngpbIEXwz8JD6TgMCrkq/uPl31HlqRVm
         tfQ4o0Rh+rTdKVws1AVmmmeQPpg+NDY8P28sfMkJnPSdOktCJm6Eiju2neD7iundO0HC
         FopMvEtSVJHXtX1xXop4NDVwl/u1ZQ79bafl86PXfIPyLuZE7WC0lYHk7JBzyanxRYW8
         R6buopWzvdSwQvp5bWQKgyKehhIoR/l1se0hdtNEj4mDtQjBUCD/3FVnGT8v/8Q93xLQ
         xj1tow//Sa+oOQ7i/pTymajBXprG2l1q0+xq5qrWlvATeAYVPxzMYzCag61Y6niXDhiQ
         aQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44cHL4pTwmuYMzVmbEhU3gMCEK4RGkyr2I/uvdRi+JE=;
        b=kOyFlC06EZVJdGERe6WTWU09GjH+craQx2QN6wsQE4HwScUTJdTsUCxTTI+8ovwE7m
         bkvi7npU3/PafPRuwCq5tEI6s9cZM4XYiohYZJcPklIlcZEonaDeGzTYYIKuwWVTnf60
         B/ajtTJI3j9MxsnzMt3VLfqvLxzZozFLGAURzLV76TNT+/FU+Urb8EeG70FOnj3JuGVu
         f9wgGMEVjZMUGzq8HCbhvfHfBSl+PbwP5tRHfytlIu3HiRPadn0AOHHQ4pPYH6w67yx5
         lzh2mSsf5sWdKBPYNCceCQXc19/qGGDC78otVOWBihPd708g81l0NS+Dei7RwUN6Zx0L
         vcQQ==
X-Gm-Message-State: AA+aEWY1c2inkR4YvYo9R1NzBixL3eNvgGcB3OYjUBsMLkS4dJHQVkRU
        o9hf46G9uTpKa/fuyxwzGc0WxTvT
X-Google-Smtp-Source: AFSGD/WeCkGsoTdlJlYk1t4ySRpcxOHSYRZJ6KPIs7l+bOeObn8wZhbloacO8xhVcvEK7773GzyGHA==
X-Received: by 2002:a1c:bb42:: with SMTP id l63mr8190705wmf.47.1544396197355;
        Sun, 09 Dec 2018 14:56:37 -0800 (PST)
Received: from localhost.localdomain (x4db97970.dyn.telefonica.de. [77.185.121.112])
        by smtp.gmail.com with ESMTPSA id w6sm12581807wme.46.2018.12.09.14.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 14:56:36 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/7] test-lib: translate SIGTERM and SIGHUP to an exit
Date:   Sun,  9 Dec 2018 23:56:22 +0100
Message-Id: <20181209225628.22216-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.156.g5a9fd2ce9c
In-Reply-To: <20181209225628.22216-1-szeder.dev@gmail.com>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now if a test script receives SIGTERM or SIGHUP (e.g., because a
test was hanging and the user 'kill'-ed it or simply closed the
terminal window the test was running in), the shell exits immediately.
This can be annoying if the test script did any global setup, like
starting apache or git-daemon, as it will not have an opportunity to
clean up after itself. A subsequent run of the test won't be able to
start its own daemon, and will either fail or skip the tests.

Instead, let's trap SIGTERM and SIGHUP as well to make sure we do a
clean shutdown, and just chain it to a normal exit (which will trigger
any cleanup).

This patch follows suit of da706545f7 (t: translate SIGINT to an exit,
2015-03-13), and even stole its commit message as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0f1faa24b2..9a3f7930a3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -476,7 +476,7 @@ die () {
 
 GIT_EXIT_OK=
 trap 'die' EXIT
-trap 'exit $?' INT
+trap 'exit $?' INT TERM HUP
 
 # The user-facing functions are loaded from a separate file so that
 # test_perf subshells can have them too
-- 
2.20.0.rc2.156.g5a9fd2ce9c

