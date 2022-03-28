Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D433FC433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 21:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiC1VXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiC1VXv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 17:23:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C80E12D095
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 14:22:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b24so18433279edu.10
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZgeofnDA5HCaxIR7RnaKqH37oZy28Ex3lQ3Oba6SUQ=;
        b=D03vbTEED/0AZUWxDKQihKScgbHf8V9fcXcxIKkcQmhC5NP/uf7Ad8xyI1FuwnlZfk
         glbq0AkuCeD/nTdnTzYy305sPSnVMEUvZhjmG+VcSLApOtRvLqd5dFznHOQ1vFdVXXyO
         zSNgjJti4lhzTzjK1rnIZFkSHbtnPGmU043h1CSaM1hZdoLILqFWMY98yJPWg/PEZQLk
         ww01aNM6KtIZ+N4+agqrk9BnGQSocPOWu69ADFnFurpYMd7iD6UTzoaypXOwMLTtBSsp
         Hj4fhZshljUvyB2yDjFUIZnNu/yrzXKR6PrAYLsZVQkQRoCwEN/QeiQFxd0fc0a2lDyZ
         tzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZgeofnDA5HCaxIR7RnaKqH37oZy28Ex3lQ3Oba6SUQ=;
        b=GSlMYVCPePEWNlB5kfcNPu8CHOdF1+UNJIYm2tVqo1JPPz/xPw8nRvpEe/Zu2Rx7XM
         GdB2VTRXJmr6bXaipg5ZhEbKjflrmUuuYSzyWxmYKYJS8dyTAlbVjQKbzdoytqYfDsFg
         ztH2FN677XrIQ7Z5UTm8rc+bdYK7lUVGyhsyo/FylUHNPG+Ax/WqrCTq8TJmsZwz+uxi
         e0B9UnhOVRhBkxb/mYePbfckTda8Zw9b7Rf2ACtxUdBWDkK0tNqNBNtETHituNz4AGNK
         UE34NX/J4rPNF7ID2P8Xd0IwgQuYXtGL3DTVvn5L5AjkgvLdmVGuPY6pSI4PE5iFupt0
         pUsg==
X-Gm-Message-State: AOAM530EqSLoy2d5YkehNRFtnyEl9KiRVj1vjlLopG4r7KABpqPvOuWd
        wstnpf2aK+BI32f4st+ZmkI1xMAublY=
X-Google-Smtp-Source: ABdhPJxDofYQLnZY087YtpJ02J9wjjWX2/GBJYr3OGizr3rLeE+mMzGUxom7TyHv97Yib9wdiJA0Eg==
X-Received: by 2002:a05:6402:b63:b0:419:2d75:de88 with SMTP id cb3-20020a0564020b6300b004192d75de88mr18822526edb.389.1648502521036;
        Mon, 28 Mar 2022 14:22:01 -0700 (PDT)
Received: from buzz.local (78-131-17-231.pool.digikabel.hu. [78.131.17.231])
        by smtp.gmail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm7640398edj.49.2022.03.28.14.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 14:22:00 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] reflog: fix 'show' subcommand's argv
Date:   Mon, 28 Mar 2022 23:21:52 +0200
Message-Id: <20220328212152.589491-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.35.1.1272.g0ee9eb8209
In-Reply-To: <patch-8.8-618e975f8b2-20220317T180439Z-avarab@gmail.com>
References: <patch-8.8-618e975f8b2-20220317T180439Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_reflog() invokes parse_options() with PARSE_OPT_KEEP_ARGV0, but it
doesn't account for the retained argv[0] before invoking
cmd_reflog_show() to handle the 'git reflog show' subcommand.
Consequently, cmd_reflog_show() always gets an 'argv' array starting
with elements argv[0]="reflog" and argv[1]="show".

Strip the name of the git command from the 'argv' array before passing
it to the function handling the 'show' subcommand.

There is no user-visible bug here, because cmd_reflog_show() doesn't
have any options or parameters of its own.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/reflog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6c4fe1af40..c943c2aabe 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -225,7 +225,7 @@ static int cmd_reflog_show(int argc, const char **argv, const char *prefix)
 		      PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
 		      PARSE_OPT_KEEP_UNKNOWN);
 
-	return cmd_log_reflog(argc - 1, argv + 1, prefix);
+	return cmd_log_reflog(argc, argv, prefix);
 }
 
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
@@ -425,7 +425,7 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 		goto log_reflog;
 
 	if (!strcmp(argv[1], "show"))
-		return cmd_reflog_show(argc, argv, prefix);
+		return cmd_reflog_show(argc - 1, argv + 1, prefix);
 	else if (!strcmp(argv[1], "expire"))
 		return cmd_reflog_expire(argc - 1, argv + 1, prefix);
 	else if (!strcmp(argv[1], "delete"))
-- 
2.35.1.1272.g0ee9eb8209

