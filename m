Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF49C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC4E206EF
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAFqKPup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgIALB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgIAK6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:58:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BABC061251
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:58:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so1005681wrp.8
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkvQrPHzQcXlRTRvS/mM0QFX4JpxhrN/wEY0DTY4Lqc=;
        b=uAFqKPupl8yCWX0IWI99Q1ZB9ndVhibsJ54Hxxftpv5b+X3cKV1qDoOlQ/NeitgE6q
         rmB04p6uXPvyn43vVaQz8UmQr8XitqGWQS7sxNhOgZXRsDksF3OOQiEUHycIhINden7n
         jVwojbv2ZXAf/+vTQaJFG8fw0pQKBmBDKY8eiFQCh8o0gxnmn7NOChIYe0NJpEh4qd1s
         /99QxKLavflm4kzEPfFtZNDPYLgK+3jRIjVOBkCWX9o8io8LYtkwkYtFgvVhdHjsAAFu
         X1ofYPSxL7Wkc6c2F9YQobLvVPAzclad/FTqzUcXXuPodblRdAYksOLLfguzEL2mpRxD
         sTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkvQrPHzQcXlRTRvS/mM0QFX4JpxhrN/wEY0DTY4Lqc=;
        b=JWGjENzDEj4BpLlrO8wNdGMEDbYj01/9e8ljWqJWjfCch46LD2pxYHT1tHXkTx3eIS
         VqWhv+TKuKBc9SMMEspztiwXKlYXLI6W+StbqJPlTzoKuqG+BgnleSuPm0SaIEgoGC8v
         FtehZ2UG79INl7qBQVBTWUwBJ1feL7ax4gwqomrIfp/1+oETXfFq+ZXVLFjBqxvZVANy
         OqKD0CQsrde+onZPVdUBkaN4I9mHwZZ6k0O85CBdCw0uVuwTME7+qmkPN3sui1qKHDqO
         UskRVQU+n3iRs0A6D/Yhp+lgTsrjxNlaz8ER2C3DV4483/Cvu7KCEqTMjMk+vyltLI7j
         ePvQ==
X-Gm-Message-State: AOAM532jdagB9V2QHf41XvdXVUX2O8Zd8nmOMx8AVs8ByNsIqAzTxDn2
        WSwiQX501CocPLRjqbYWjhD0gkOSeME=
X-Google-Smtp-Source: ABdhPJzFKsKcYYHZciwm4YmSDuJa5ofG/Kh7wP8ZlDcMlZN+gWwsAg6VB9PofDmXO73s4lOm+ktK3A==
X-Received: by 2002:adf:b306:: with SMTP id j6mr1168679wrd.279.1598957898515;
        Tue, 01 Sep 2020 03:58:18 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.googlemail.com with ESMTPSA id x16sm1705875wrq.62.2020.09.01.03.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:58:17 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 08/11] merge: use the "resolve" strategy without forking
Date:   Tue,  1 Sep 2020 12:57:02 +0200
Message-Id: <20200901105705.6059-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901105705.6059-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200901105705.6059-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 74829a838e..541d9bed02 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -41,6 +41,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "merge-strategies.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -740,7 +741,10 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
-	} else {
+	} else if (!strcmp(strategy, "resolve"))
+		return merge_strategies_resolve(the_repository, common,
+						head_arg, remoteheads);
+	else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
 					 common, head_arg, remoteheads);
-- 
2.28.0.370.g2c2dc3cc62

