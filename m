Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC1BC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4677D6109E
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352018AbhIHPZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348081AbhIHPZg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:25:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3CC06175F
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:24:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso1865015wmc.1
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gp44aEWKZgvTJql8gqXKwd/kYJBrfjaR6lyZoEfbONI=;
        b=C6/+t3JiAAJsB8/q573U28IZiiX/Pvui9hPqqkAun4XZWpIw7pf+qhTXXjrwSxPS86
         JJQSsaqogAxlrI+799TD6FqW60ShhqIWpPzDVHx+wEu15WdZd9OeF4S4rzktsHD1/bWI
         0JqtmfRHYKwHf1FOP5zwXbRRU+7DSmPA4tlCLO5MFlKYCdaJn5x6RpbNcVE9/ef7C092
         EMHmTpFIEgHDWIVnepnxKBWLpZIMgZew1uJQ2ezcINRcBmHk+AIdV3wPM7/yYB7oHn5q
         +WEeOxdiDFn+HDamk9V32WBZ2H1z9+TC+QIQ1+10kMXUzi1PZiFnb5a8zbMl+ssfzqeE
         xd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gp44aEWKZgvTJql8gqXKwd/kYJBrfjaR6lyZoEfbONI=;
        b=imNE+W7YtZA1wf2NymkngKSH841HZ1NUjpYen9AHdylBfGBbK17ljCunElvFd5XRs8
         PcE/E0/bnKDD/wHTbMUR4mAM4MHkVT8BabI8NEzMWxFfqkHDUPB2k+bPvlp/NMFGDEHR
         YXMoLJRMzqoLuUaND0d/29/wgSfleyrCWTxaSfQDeHok8LYqIRnng70LkYMtQYB+eOAh
         o/yGNEWe8YmXouBxd9o3bkVYXC4vd+AFFoBChpAGlTw8+9RYKRzTFX+k3sfn0SLNCXpT
         ilaZX0eTEzaiN0eLIiPWKShmk+S6/iQPq0vd8fk8IAGZjr8bngYpOvi6r4JlG+XJ55ri
         nkpA==
X-Gm-Message-State: AOAM531r8gurqTluzmwgAqNzJCexGzg3UgHWNfaM91k93ObfZpb/i7AM
        cnG0sfaZMk++XaWeczlk9op98eddH3vrMg==
X-Google-Smtp-Source: ABdhPJzbdSYv5NgwN+Fnwtqe1ye9t/cdfjAQUD5+wZB3Pd7xp1TjUhOR77ytaut7AWGgNzf21UJfjA==
X-Received: by 2002:a1c:a181:: with SMTP id k123mr4157612wme.90.1631114666920;
        Wed, 08 Sep 2021 08:24:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x21sm2365240wmi.15.2021.09.08.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:24:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] help: correct the usage string in -h and documentation
Date:   Wed,  8 Sep 2021 17:24:17 +0200
Message-Id: <patch-1.6-b5c79d87847-20210908T151949Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify the usage string in the documentation so we group e.g. -i and
--info, and add the missing short options to the "-h" output.

The alignment of the second line is off now, but will be fixed with
another series of mine[1]. In the meantime let's just assume that fix
will make it in eventually for the purposes of this patch, if it's
misaligned for a bit it doesn't matter much.

1. https://lore.kernel.org/git/cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt | 2 +-
 builtin/help.c             | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 44fe8860b3f..568a0b606f3 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git help' [-a|--all [--[no-]verbose]] [-g|--guides]
-	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
+	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
 
 DESCRIPTION
 -----------
diff --git a/builtin/help.c b/builtin/help.c
index b7eec06c3de..44ea2798cda 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -59,7 +59,8 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	N_("git help [--all] [--guides] [--man | --web | --info] [<command>]"),
+	N_("git help [-a|--all] [-g|--guides] [--[no-]verbose]]\n"
+	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
 	NULL
 };
 
-- 
2.33.0.825.g2bf60429931

