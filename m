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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E91C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 06:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6EB611ED
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 06:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhFMGjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 02:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMGjI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 02:39:08 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B52C061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 23:37:07 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m137so10807572oig.6
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0fFnPjEE3Uw/puOE22dXNei2U/hAUwHp2fzJpXmVis=;
        b=gWDmCXSpiwwLIhC0Btwlilk/QWFNrsvWl5wKqpPtUR01LMlcD4NzI0/XlrBXAniU52
         P1JkO62mBbmWutyXpsg2gwkgc0iqGRWu9Mdx1/NxgIoBmHsOFJBj8FDyIkmseIcYxMyV
         RkUTwfezAmSumM+kUSFwWvJOeShJXMEKhBdUjBbf15l/eODJ4g4MoPre4q4m3kSj5Hz7
         g/+wtCYwEyWZmSe3Ex5ysp8K//6x6ZMG/U6WAnr1Je1+HYzsfScgXIAIirD+Mq+FDF+s
         cjlf896lzFEFDat3i7ZrEOx0geNJR2sPeeqfJxKXS8X4rlbc17gYsuXSyOua7CAQkkm2
         hGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0fFnPjEE3Uw/puOE22dXNei2U/hAUwHp2fzJpXmVis=;
        b=HhBapYaNqhnaMrI3rilBMkDoch1NXOZsIM1yHqPXzPE8b6DwaKxNrKpA0Qs9iHz/Ty
         ujPLenRxkKeaf0NvRHBE4x/EMetXGbcwGybOQ2vMkoE6WcIUyyyOq5yZMwGL7sxjG4/r
         YAQRha9HdphQofUaHojg5G4WJrC8J+uhIPiRxP1wIOU9LkisIOEah3wltqnwkiGylLLF
         DeLsTOiUf0MiOnQt4cu9L5cETqJA3aAMQNzMc/SIX9DWPd1iF9lU4WYQveqNO4TcCtdo
         du04QhwlZtsjpLRJos7thEUtAhvxKUOgP4gwFTW/lw7uNOjdmTIJOlPIN5sndnng+e4H
         ASpw==
X-Gm-Message-State: AOAM533vWQO0LPQ+8MSdH2sTdi2JKD39Zg4NVCDuHborZFvyFoc9aDZE
        eEQ0i5uypEEgC2XUAQ1UxRzWRXNalmq5aA==
X-Google-Smtp-Source: ABdhPJxahFsQerGA8I+xqNK3bd7EIoA2LJkDhFKEMBlXIOazlIGYS8STb0CkjgK8dtTCSv8lb3CZ3w==
X-Received: by 2002:a54:4690:: with SMTP id k16mr18443294oic.57.1623566226781;
        Sat, 12 Jun 2021 23:37:06 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l8sm2287411ooo.13.2021.06.12.23.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 23:37:06 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] config: avoid yoda conditions
Date:   Sun, 13 Jun 2021 01:37:01 -0500
Message-Id: <20210613063702.269816-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613063702.269816-1-felipe.contreras@gmail.com>
References: <20210613063702.269816-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index f9c400ad30..7094530b04 100644
--- a/config.c
+++ b/config.c
@@ -1232,7 +1232,7 @@ static int git_parse_maybe_bool_text(const char *value)
 int git_parse_maybe_bool(const char *value)
 {
 	int v = git_parse_maybe_bool_text(value);
-	if (0 <= v)
+	if (v >= 0)
 		return v;
 	if (git_parse_int(value, &v))
 		return !!v;
@@ -1242,7 +1242,7 @@ int git_parse_maybe_bool(const char *value)
 int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
 	int v = git_parse_maybe_bool_text(value);
-	if (0 <= v) {
+	if (v >= 0) {
 		*is_bool = 1;
 		return v;
 	}
-- 
2.32.0

