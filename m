Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B65C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 04:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiHCEvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiHCEvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 00:51:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C59E26
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 21:51:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f28so7218924pfk.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZYKysQHj+mvXX6SXRY5wmLCSLUeL9vSxQerANzUuAeA=;
        b=W+fBEFTr9cMaMxd3J6l7U0dS0ALWLZm2QKxfGV7AMAK1G7Z90IRTFrvvGNjLjswiE2
         morWhwVSnGzA4Qev6lK17hbfAYS1ys7DgdUfuYejFVPOjm6htQiIV//dF2OHqhQAef4L
         b7KUGbUXkQ5bLRer46eL6B8aUHtS4LeWmt1C2g95lBxkwJhT/5etEYx4ZnwzzWBcLfg1
         UeVVsoQLuJD5RyvuopmBgrSCS2wnE0yYdFdCOYe2qHuGC/4CEg34BVvjDhY6HsgJ2XpH
         dwHfzEMJ5fGdBZ/pwoiRWotqDde5MMyUSgk9uagGDtbYQ3vXWe5oJp77tv+dOJx9miUH
         al6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZYKysQHj+mvXX6SXRY5wmLCSLUeL9vSxQerANzUuAeA=;
        b=SeE2SM6/gEVCMy8HbrMT7s4nmgut8arlf0NScPkva2lx+nSguBKFP/C/tCrLyyafBI
         SXaybgragyMt79Idey0kJM8SbmmlzgoImnfVP4XOGe0hf4I1XgwYaC9EidUo2/63L4Gu
         xDUuj8PEWORH37V9pnTS1dNbDaCxwDZTX7MMkGvCJ+JCSS8l/isaxgVe3pEg7gSRYiTH
         qiAxMnoltHJejnhbtoURH/nGnTMNCW3LtHEYFfvIXZnqV0xlBN1ak6U9QPluvBATYxuV
         Y1Yfw98NauK4QfhbBDvv1kfl3KMzUsx8vfrtO5/x73G95EYvyTB9KN06WvRweo8g9TXA
         Z+Yw==
X-Gm-Message-State: ACgBeo1NWg7iO8R6L4oiCJlEt+PJeuub6g5qBtmlGmSSXKPRwlBx6MbM
        0Xkg6WIskxj4YPTxECf2HDYD7mIZbuPVPZBd
X-Google-Smtp-Source: AA6agR4bXdrzurTy+8PEdriO7C/wPED0ojue/Za+Ttwb05TjpnXPsDbgFjZt+UbHcGzMIsblZlHITQ==
X-Received: by 2002:a63:3143:0:b0:41b:b5dc:e6b6 with SMTP id x64-20020a633143000000b0041bb5dce6b6mr16171973pgx.422.1659502305645;
        Tue, 02 Aug 2022 21:51:45 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.228.71])
        by smtp.gmail.com with ESMTPSA id f131-20020a623889000000b0052e2a1edab8sm470211pfa.24.2022.08.02.21.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 21:51:45 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 3/4] rm: expand the index only when necessary
Date:   Wed,  3 Aug 2022 12:51:17 +0800
Message-Id: <20220803045118.1243087-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, rm a pathspec that is out-of-cone in a sparse-index
environment, Git dies with "pathspec '<x>' did not match any files",
mainly because it does not expand the index so nothing is matched.

Remove the `ensure_full_index()` method so `git-rm` does not always
expand the index when the expansion is unnecessary, i.e. when
<pathspec> does not have any possibilities to match anything outside
of sparse-checkout definition.

Expand the index when the <pathspec> needs an expanded index, i.e. the
<pathspec> contains wildcard that may need a full-index or the
<pathspec> is simply outside of sparse-checkout definition.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/rm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 84a935a16e..58ed924f0d 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -296,8 +296,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	seen = xcalloc(pathspec.nr, 1);
 
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
+	if (pathspec_needs_expanded_index(&the_index, &pathspec))
+		ensure_full_index(&the_index);
+
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
-- 
2.37.0

