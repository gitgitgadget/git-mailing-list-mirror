Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A74EB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 20:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjGBUKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 16:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjGBUKb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 16:10:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22281BCC
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 13:09:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6686708c986so3179415b3a.0
        for <git@vger.kernel.org>; Sun, 02 Jul 2023 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688328547; x=1690920547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH+0M82oXpk3+tPNq9YIb5JydDFq4Isoi54/18fUW8c=;
        b=if0NTZ42Rl3rn9bSm1TDKJ5b61eGWVx15/85DZ176uIgDoGRaJTW/oN4Z97+khRa8u
         rwczmQvBZ3bs4HNW6fWQoLsVvO8j3ie7SFiKumrdKS7/XLImriwBr8UqMh8sWAMdCDAM
         VDRDc+q4wG9Zgc4kl4isXJarkFgpXbARpj0tyaSf6vo6lzwE9i2Bm8DGe5Ws9F8whYXz
         /X7oeb+MKWY1vxXBMLbsq51K9brWu7JYUCQeBvmfLwVdEiVGsKiCcrEfJTP469BLcWAc
         yJbODMDE8hlHd/w3lKQ+0p+GS7CxFwdVO7ZFyZMJHmaJJUT4ULisyKbBX10ime2lhhF3
         Nc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688328547; x=1690920547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LH+0M82oXpk3+tPNq9YIb5JydDFq4Isoi54/18fUW8c=;
        b=RLwU10lOhpoK/Bh1aIW6H4J+fLjMrvVFoeuT9E4J3Tq4g/hi+fimmI8sk6J8CVDfZb
         a9zVLux+zgflvF60MwGWCVL8lEtAK/egvx44le0ziZ0URS0ktrf4WazeAFnBGHRx1wU1
         J2ZmCZjRv9ePcxDdwZLRWdMN/XR+SO8if8gkWmdGbSk/g7n0D6ufGFwn9a1QUjW+Q5XQ
         t43RmuIhqTkAlcx1XMcfBVCjHZYKsIgblqLofQ55mkKRx2tpWWf17uUDddc/hwNOuOLf
         PgeFoyve37aJou7XVDqW6Wd14qke1G7udafGCKwYTarVfNY/kai6WRQ5WSTiiE2WkDLc
         xtjg==
X-Gm-Message-State: ABy/qLbb4hJlOXjMtDMfXWe59WgNxqEloJi4MBjBLQZhUvEq03MigB19
        GGPvIQcNXZwKXJheH13KfdpdPBy8t9Y=
X-Google-Smtp-Source: APBJJlHMFu9I/2VT6WFWJfa5rlDEt1OdRRCEgkgI5cbcL0qAbBm0Ulati6UhVOY7gT1Qt4OVu2pPWg==
X-Received: by 2002:a05:6a00:c85:b0:64d:46b2:9a58 with SMTP id a5-20020a056a000c8500b0064d46b29a58mr12913986pfv.26.1688328547247;
        Sun, 02 Jul 2023 13:09:07 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id c14-20020aa78c0e000000b0067b24701daasm9342937pfd.86.2023.07.02.13.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:09:06 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 1/2] remote: advise about force-pushing as an alternative to reconciliation
Date:   Sun,  2 Jul 2023 14:08:16 -0600
Message-ID: <20230702200818.1038494-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702200818.1038494-1-alexhenrie24@gmail.com>
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, don't imply that `git pull` is only for merging.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 remote.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index a81f2e2f17..161d0cfe96 100644
--- a/remote.c
+++ b/remote.c
@@ -2323,7 +2323,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			base, ours, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
-				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
+				_("  (use \"git pull\" to reconcile your local branch with the remote branch,\n"
+				  "  or \"git push --force\" to overwrite the remote branch with your local branch)\n"));
 	}
 	free(base);
 	return 1;
-- 
2.41.0

