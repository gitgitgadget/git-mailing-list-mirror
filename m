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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77077C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 18:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D04E22202
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 18:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbC490ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgKUSbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 13:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgKUSbr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 13:31:47 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57D4C0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 10:31:46 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id t6so2006014lfl.13
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 10:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DUdSd6pQs4jmskCyVGNyzDYV2RBm7j5o4x+7rAAh1I=;
        b=UbC490jaVPm+z2mofaKpcg0pjaSp6wA76oC1GNgt0g8U2XvswUfZD/Lz9RczeiTe2Y
         NVXvZuGOjC8beqududUGffW0UOXBadqHNDzUh5whxWCDpgo1d654Re8+qH7HP14WnsJK
         jduQ5AE1liPBihNawusE1k8zOiehVdT8Y6OAldCDRsgeHjSpwFGr8u635i23zr+an3QL
         R//i268ek+mBsEGo0lYSGpQLBo66oIu8SkRzMs0blNgDMikB+MUEELWrMK1kS/poARKC
         npy8osZW6UOaYjbgQ5DhUoTirXO5biAJeJaS36lUhbGhJ/jvqYfn1dG6auSOilGym9in
         t3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DUdSd6pQs4jmskCyVGNyzDYV2RBm7j5o4x+7rAAh1I=;
        b=o66QreFssjW1Tn86Pkn8+kVSq00M2xYBNrBfdVyXrvejj92uqFDpVBqp1L3zlh94aN
         qbo7pGfYcbZVpLXyYgmg7n46LIuIxPpdQ6dhyfIBYX/0S8XuumEjEHvmllzCa4FAaTTZ
         mXXDHuI4E/eZ9T2ZwTdEBsJD5w4+UNfoClwoHJ9/99+UaQpjqAvC8LyI0GX9L2Y3KU6r
         aBo+zLjBuuLUQZ6RrfAW6kWB26vadv19jYCTsUgDZHSg8PV1yrMdk70cxHORsfBKR9W3
         lIcmSu+w26h/py5BYuz+ZdyQfitFMzDYhrwwnYnJHz16MKRe/hFG6lDB8FWtJslICA6P
         4g2Q==
X-Gm-Message-State: AOAM533bkUDjGieuek8MIgN0NqPFdB+qpTqWWF+7ebN8EwHMrjQ4/fQJ
        zXI5JLQAZWdq8KTpqRWpbBv3akXgZwYPog==
X-Google-Smtp-Source: ABdhPJzSxFxV1vKTZyLcxGnw713tTx/h5I1kgLRbtfyn9myVneNoT5qL15zytB1sC2EjUW/zi0+QXA==
X-Received: by 2002:a19:be14:: with SMTP id o20mr10799108lff.453.1605983504895;
        Sat, 21 Nov 2020 10:31:44 -0800 (PST)
Received: from localhost.localdomain (h-79-136-100-70.NA.cust.bahnhof.se. [79.136.100.70])
        by smtp.gmail.com with ESMTPSA id m7sm786531lfj.113.2020.11.21.10.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 10:31:44 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 4/4] MyFirstObjectWalk: drop `init_walken_defaults()`
Date:   Sat, 21 Nov 2020 19:31:10 +0100
Message-Id: <ca4523ce9e79654f2a51c0fee4909d84bd1f2bba.1605972564.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1605972564.git.martin.agren@gmail.com>
References: <cover.1605972564.git.martin.agren@gmail.com>
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

