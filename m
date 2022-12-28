Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B907CC3DA7D
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiL1SBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiL1SA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:56 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4C7DF0D
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:46 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y16so15544559wrm.2
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/ZkY45OBd/IOUP/wYq7DxZvgchC9mFdrpb06aLiOI4=;
        b=cTnQQ7UK42Uj6KKnWHlbJle5sEsiP8JMSrZCNaCB01TwLQXz1zGffLFcfYbcVKud6m
         T4l4BaN3XkELKHhmWbIRXBSHBRandSEercuLAmi8QZZfWaYTcleb5x5ohaGG/0mqkx5w
         Dta5UnsfK+NxeUZWTANacx+VDQmkrkUfpTpS/vgVK5Xa9a3O0olinrLkWITQ408NCkAJ
         yLAnXaWf5b6ZiQJ1KKyOQLRiIFH/tF5rnIyqzlyYjfgUrI4IXS8M7pp5TbcVhXFojwmA
         +UNidcqEPhu2JZDAus/D41xKPzKK9lFs78X+2YR2Ao0EFQIXUMPjMJ0XhBRFUsb8LLGj
         pASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/ZkY45OBd/IOUP/wYq7DxZvgchC9mFdrpb06aLiOI4=;
        b=tWhEeYx94h8diV5W86ZKCMf7FCeJO/0XFNIT5e937L6WpuDFJzEkO3BVVrxyHE7zDp
         P2sWhNjt6MjlpmOcCWygEaUJxAPYvfQHn71Z9yTgnCgVkRu8ry3IwwGZAfEeK/eiGfWe
         Zud10bVz5aoTkcq1HfQAh0Rb6zEaFarHL83ll6gLtm84Kmu2mAXA6q2LqHUXr4QRCITV
         7wuVBlQnm+6uxMUL/Q1RWqsYcPv75XGAc6djABxJYNVjuYHfZ6XVyNsxbl0ppbSZ9YmT
         seb7ZIxMw0121yDmNJm6OR7ukAuZeHPlb5wsM+c0ajgq2BeotXkQxbvHHSTw/JggKcoe
         sjYA==
X-Gm-Message-State: AFqh2kr80JSfSYuLceY2C5ws3iwNaypiVMuro5X7BMJT2GB/hDV/aBpN
        sYJZbJ9XoC+FXisQ3BE56T9U7FqR+NQCNQ==
X-Google-Smtp-Source: AMrXdXtR1tSdvRLFj+ROtBvKKgJyaxselYccsJYSodfq7x2nyHpqUCOTlx1yD1P4kGtXOudsQ3p6pA==
X-Received: by 2002:adf:eb4f:0:b0:242:659c:dc7 with SMTP id u15-20020adfeb4f000000b00242659c0dc7mr15067334wrn.61.1672250444391;
        Wed, 28 Dec 2022 10:00:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 19/20] grep.c: make it easier to extend free_grep_patterns()
Date:   Wed, 28 Dec 2022 19:00:19 +0100
Message-Id: <patch-19.20-7928470addb-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before db84376f981 (grep.c: remove "extended" in favor of
"pattern_expression", fix segfault, 2022-10-11) the pattern here was:

	if (!x)
		return;
	free(y);

But after the cleanup in db84376f981 (which was a narrow segfault fix,
and thus avoided refactoring this) we ended up with:

	if (!x)
		return;
	free(x);

Let's instead do:

	if (x)
		free(x);

This doesn't matter for now, but makes the free_grep_patterns() easier
to reason about, as we don't have to wonder why we're doing an early
"return" if and when we add free()-ing of any members that come after
"pattern_expression" in the "struct grep_opt".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 06eed694936..ca75514f8f6 100644
--- a/grep.c
+++ b/grep.c
@@ -791,9 +791,8 @@ void free_grep_patterns(struct grep_opt *opt)
 		free(p);
 	}
 
-	if (!opt->pattern_expression)
-		return;
-	free_pattern_expr(opt->pattern_expression);
+	if (opt->pattern_expression)
+		free_pattern_expr(opt->pattern_expression);
 }
 
 static const char *end_of_line(const char *cp, unsigned long *left)
-- 
2.39.0.1153.gb0033028ca9

