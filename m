Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE75C56201
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873C82224E
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 15:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="iFXLM94y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgKTPJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 10:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgKTPJt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 10:09:49 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65226C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 07:09:49 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so7289006qts.5
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 07:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsipUh8egVbRz74eoQkTl/tcP2S7Ww2AW/HHJW28Qt8=;
        b=iFXLM94yGXcVB+Ekivzwqf5Lbz4nZbsHEzgAoZktAruOci36Fhziur/SsIJ/as0pNx
         bcT9PUMHsyKybN46Sso1XLAtjkVsOfmYRIHP1/oo6SNzu2aclRTQxMvj+DOsBjJrc43D
         3NDfoGOELP03XyKlugyQ09rPuLjax8KsAD85VwRYPfqY8yN8PeHj0AxFAMkrNDYLHaR2
         aLKhnyg4worbefRA1am+URO9MJUn0Sb5zmsTVxFSAfAotFh0z8pFFJX9LAwWLpER9JZ4
         xKb9wZM0PhpEUYVBeH98jhs+E2HHFnR2Tsgekn9Zic1brBlfTOcHGoqgbBCscIx0kdbv
         8l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsipUh8egVbRz74eoQkTl/tcP2S7Ww2AW/HHJW28Qt8=;
        b=WzzEcY5OUfDEtMfqOjAd7kcQKAZblgg5OV/04v5D/K052sy1Urs5ZWVH0nx90UHuMS
         3whxRTqmNP32YLr/O6L3yhmbrbL2rVDOn3/dMCLJB3HJhkFHv+5mWVNR4FkhaRGP6Eu1
         sMWF3QwbFmxsZBRx1MNGFwf5TT9fjhGG9rzVabejtBZQ7fjo6BMoSpBN+fHIDgK7i9AG
         VF9gqDzdjF1f417EIttWSEl9lxYdtAH7HE6u7G1c1DyLLaIspadmGgNMgIhAHmtAOvs/
         HKFwEZPnlxBUDinbVW1A2ZiOCK8DvrvtlNHeJsXNdJBGsaPsOaQF3bcoeeWy5vHFYcR1
         ma/g==
X-Gm-Message-State: AOAM531iWhoxgQlHHS2aQNkiJ2SFT0TTtATPDWAQbYOazGge9ivHhhkV
        AF8fsQdPZLvA5DWZ3U2C9HrK2D8nHB0Z6g==
X-Google-Smtp-Source: ABdhPJyGYROc+vaWC1dKoUMSCDrs4jFnBaQ75LgTB4YPQKkPc5bg8m/Wo+0ONoCDas2Q0k/H0PdqrQ==
X-Received: by 2002:ac8:4685:: with SMTP id g5mr16733105qto.173.1605884988161;
        Fri, 20 Nov 2020 07:09:48 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j10sm2050390qtq.59.2020.11.20.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:09:46 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com
Subject: [PATCH] worktree: fix order of arguments in error message
Date:   Fri, 20 Nov 2020 12:09:39 -0300
Message-Id: <1d740e0d4fc08a9f420373c6cd0a554b3b4b1f40.1605883395.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git worktree add` (without --force) errors out when given a path
that is already registered as a worktree and the path is missing on
disk. But the `cmd` and `path` strings are switched on the error
message. Let's fix that.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/worktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index ce56fdaaa9..197fd24a55 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -304,9 +304,9 @@ static void check_candidate_path(const char *path,
 	}
 
 	if (locked)
-		die(_("'%s' is a missing but locked worktree;\nuse '%s -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"), cmd, path);
+		die(_("'%s' is a missing but locked worktree;\nuse '%s -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"), path, cmd);
 	else
-		die(_("'%s' is a missing but already registered worktree;\nuse '%s -f' to override, or 'prune' or 'remove' to clear"), cmd, path);
+		die(_("'%s' is a missing but already registered worktree;\nuse '%s -f' to override, or 'prune' or 'remove' to clear"), path, cmd);
 }
 
 static int add_worktree(const char *path, const char *refname,
-- 
2.28.0

