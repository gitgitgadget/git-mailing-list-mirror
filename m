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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7AAC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0BB64F07
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhBXT6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbhBXTyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:54:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1747C0611BE
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b3so3044023wrj.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/fsd2VG4GOQiR+Nooo9Lnum3PSHeDE72mO1dzh5WAE=;
        b=mtJ4q0zOegNKcL96OV9E6rBCkxlcflMy3iNDUB3CBkqvEEpgp/pmBeV2ywgQHNpiXO
         8DUtnFMFmL1BYu7Jau0/0k3Ycn1NwHL5JkD3LrJeZXN09A6RCwYRg40KRbUktICZqxIL
         MpsIpq6526EW1e6HMw5EPR9CEedvk6wvTDlBFkP1xJD6RzYKa9n5ZQlp2WSkAZxq4Ghz
         Fb1hvMqXWYshTtFFWzqW9TkJzT6BTPnzGhn5/jxBJBqovGKSQhs3khpKA2d+UFrm6TpH
         6sZx6nuhDYw1o7p5mrxhGdtwWlMcJNkWU23Kjne2vvhtJDil5zqytC8ufE4ohaTNMkFb
         B3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/fsd2VG4GOQiR+Nooo9Lnum3PSHeDE72mO1dzh5WAE=;
        b=V6ji4+E+0KDxMXWTVbtoAB3T6adMdBRTrqr1/AYanE6f+Cod75b1F5yeqG+61k1v84
         QA6n4PVJUOQ9gwpBChyGnPLCG5viJbrx2XfSM7jAdYayIrbEKKgpvrQBIpamTmwpTa4u
         XgS+T2Zs0bArZS3GOOU3IgadIjtPQJAsGg3Kz0ykX/C2s9qNJp78yVelshpPpDOvTbG+
         tjuaRwBduIfIwvLYFHOx/Iwa6tLKfjHEb6fsaMa5UN8M7N4I/Qul9TRhe2FAhaQVNcW0
         uHg0Y+2bXWF41KqDWTQg5EecBm1depem1T0zVLcx20r0tDnt+nZ52sQk8kP5MI+yZCZu
         4eAg==
X-Gm-Message-State: AOAM5324Kew+pX1wFJy2mSXkDSJxdqGwgR5mhOzAPMbnK3Q9dnzFIdHx
        f4Y5wIynyJdElayXHlT1U00sNRZFVjGKZA==
X-Google-Smtp-Source: ABdhPJxS/tpkq8wU9XY16GWIr9cZiAHHMOcAMg660O9gSeJYbGZVRlZnxJ3/3ia57cJuUwJbmUDaVw==
X-Received: by 2002:adf:d239:: with SMTP id k25mr34532472wrh.308.1614196338106;
        Wed, 24 Feb 2021 11:52:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 30/35] userdiff golang: simplify and correct matching regex
Date:   Wed, 24 Feb 2021 20:51:24 +0100
Message-Id: <20210224195129.4004-31-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the regex for the golang driver added in
1dbf0c0ad6c (userdiff: add built-in pattern for golang, 2018-03-01) to
remove redundant constructs.

There's no point in having a regex like this:

    .*(foo)?

When we can just write:

    .*

In the "func" case, since the "(foo?)" match isn't mandatory it won't
matter for the end result, and in this case we're not using the
capture pattern. Not that it would matter since it's followed by a
greedy .*, so we'd only get the empty string.

In the "type" case we would stop at the "{", since it was not preceded
by a ".*". This was a bug, if we have a comment or something else on
that line we should include it.

I'm also changing the "func[ \t]*.*" rule to "func[ \t].*" while I'm
at it. We should always get whitespace after "func", so this narrows
down our match. Let's do the same in the new "type" rule.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/golang | 2 +-
 userdiff.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4018/golang b/t/t4018/golang
index 70bf0d936bb..72a35d66008 100644
--- a/t/t4018/golang
+++ b/t/t4018/golang
@@ -46,7 +46,7 @@ type RIGHT struct {
 }
 
 t4018 description: struct with comment after {
-t4018 header: type some struct {
+t4018 header: type some struct { // comment
 type some struct { // comment
 	a Type
 	b ChangeMe
diff --git a/userdiff.c b/userdiff.c
index 55f4f769bd3..698eca5ad35 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -129,9 +129,9 @@ IPATTERN("fountain",
 	 "[^ \t-]+"),
 PATTERNS("golang",
 	 /* Functions */
-	 "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"
+	 "^[ \t]*(func[ \t].*)\n"
 	 /* Structs and interfaces */
-	 "^[ \t]*(type[ \t].*(struct|interface)[ \t]*(\\{[ \t]*)?)",
+	 "^[ \t]*(type[ \t].*(struct|interface)[ \t].*)",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.eE]+i?|0[xX]?[0-9a-fA-F]+i?"
-- 
2.30.0.284.gd98b1dd5eaa7

