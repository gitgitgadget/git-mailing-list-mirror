Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD53C64E7B
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 19:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895B320809
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 19:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUIfFF9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgK2Txs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 14:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgK2Txs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 14:53:48 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02943C0617A7
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 11:53:02 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id r24so16485007lfm.8
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 11:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGzHyjlffIaWDpyx3tiw/kpoARp3zvSiLJHYiQKp1g8=;
        b=JUIfFF9YEWGB+46hfQ/mJsyHSzftzaJzMfOInfSzqpSB154Mq5XsDdqfvNYtolCyVD
         fysnPrlKfhitfV3/Tpol4EV/VyGX9ZujzcELXEZQ45hUCBy1+PA76r89TlC3eh7qLRgb
         cWp+2DmAA6jJ5N+6ClygC95s1Jk30ru62cSjqS6WyMUnJhb00T3/kjDBR7akDT5aGkWP
         GIeTcAdOZjii5oEzI42OAvKoigq/kpweLzM5/gJfIEpilzgOiM2eNLbVpExs6AO4jFbx
         t0EItG6Lw3deXAei9D7Jg3Xs3esFcna40hf5IlwwK4oLYmRQuWF725LllGU7J5uI9DE9
         PHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGzHyjlffIaWDpyx3tiw/kpoARp3zvSiLJHYiQKp1g8=;
        b=rkvHjaXNdNn0oKH8qF9Sp1xCxJ9Wzlp8ZvSzzHCq5unbYTHbxZi97LDoU+I/6tcrcp
         w5pfDX5QJsNld5o/BwfdddlsaUnokt9mJyjDXxV/Oxdz0tOc8pw5WunAi2+RBx6oAobH
         TPhScj78SZLeyuYDJ3pFc6vechUxqsQbMhP1mjXfHA4HFM8yXLr0pLYDe8MniYzb+Awo
         Ap0WsLtwmo8L7HJcpwnZJLcxIjruM6LGnLLFrl6z9KAL2WBBJsaolPraMs/YjWCJ4hS4
         yzyh9rJl9P+rxSqDWR/FoNInlITWBvdggCAcMWaz5a5BrFX/nObXtCp+NlbKXVo2l/Gt
         eeVw==
X-Gm-Message-State: AOAM530eIDra/LrZSitr5ea9uyRFTDdkBYYXpHWpp43B94BjiB1TWfsU
        Q7MKvZJPaZZE3VTVVJs+6LBY0OHuV6s=
X-Google-Smtp-Source: ABdhPJzD/RwGW3LidEvpM2E2QE2lg8Ow2gWbStFqzAIA2HfDhqEpPCa99H84HSBTnpx6nNIChn05cg==
X-Received: by 2002:a19:cd6:: with SMTP id 205mr7428325lfm.117.1606679580242;
        Sun, 29 Nov 2020 11:53:00 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id w72sm1808707lff.89.2020.11.29.11.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 11:52:59 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 4/4] MyFirstObjectWalk: drop `init_walken_defaults()`
Date:   Sun, 29 Nov 2020 20:52:22 +0100
Message-Id: <977a7b6eca28e50d3a7377164228031b96b19ef0.1606679312.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1606679312.git.martin.agren@gmail.com>
References: <cover.1606251357.git.martin.agren@gmail.com> <cover.1606679312.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a recent commit, we stopped calling `init_grep_defaults()` from this
function. Thus, by the end of the tutorial, we still haven't added any
contents to this function. Let's remove it for simplicity.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstObjectWalk.txt | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 7f4bffc4dd..2d10eea7a9 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -182,30 +182,6 @@ its `init_log_defaults()` sets its own state (`decoration_style`) and asks
 `grep` and `diff` to initialize themselves by calling each of their
 initialization functions.
 
-For our first example within `git walken`, we don't intend to use any other
-components within Git, and we don't have any configuration to do.  However, we
-may want to add some later, so for now, we can add an empty placeholder. Create
-a new function in `builtin/walken.c`:
-
-----
-static void init_walken_defaults(void)
-{
-	/*
-	 * We don't actually need the same components `git log` does; leave this
-	 * empty for now.
-	 */
-}
-----
-
-Make sure to add a line invoking it inside of `cmd_walken()`.
-
-----
-int cmd_walken(int argc, const char **argv, const char *prefix)
-{
-	init_walken_defaults();
-}
-----
-
 ==== Configuring From `.gitconfig`
 
 Next, we should have a look at any relevant configuration settings (i.e.,
-- 
2.29.2.454.gaff20da3a2

