Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584A6C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDBF6115B
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhDHUmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhDHUl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 16:41:57 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C641AC061763
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 13:41:45 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id o11so1597882qvh.11
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzlqepSB5YW9EkwryvXGaZm1hwL18SR1M+qa9N7XmQU=;
        b=Ca2bDCZH3QxL5WmnVLX/Ehnh8TImHeYXMQ2vBv5QLDzH8d9lTAqCzCA4P3hcwJ0EiB
         MkFvl1uERRmEuPoZij7WTP2eNSOvpBYKb7wIubgK8orZDJBtKpUtBbRkvdT4SKclfs0Q
         aZpX4uQGLJg1DrL0oqeiWc0nIGJOFhaa/6csNAcaOTG+xPwi9r6JEWdg/GK6vsJIha16
         a+dNXi/6/B7wzjtHBH38JV0xv1Xm4nhQoVCM/BdNLvH29Ju5hZISs/ryjaSE/aqn+aP5
         y758Sfv508s53Gpo1WKb+wqN3DAcS8nBw5EPX6WHMwRvsL3YY0rihw2jaLSiZRsmbqi5
         z5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzlqepSB5YW9EkwryvXGaZm1hwL18SR1M+qa9N7XmQU=;
        b=jVcSWEWK3Ab7SusudQUuUdStAmibugEkvD7r/Sthxv+rnBu34LXnWHwljZ9wxCtrn7
         yJbMLyYrSd8XfJWzcPvujI9lqofoDMbeVNmgUFi+ElxYP0g3/04NngacOF3tHQ9u9bsF
         GQH4tOokMMIwA4A2GUW013vYjiAKMBf+vuspQQXjHDpF/ZdnVEePiy7TUqzKarhc3BTb
         tNwGFNlHCLLLfec/OArKCnBzQo6EA17il8GxvZCJ/S6YWFyXGEiyifLzdq/2eo8OKmV2
         8QOJp6kc9XFCneUk5bN+qL5cjxL8enngJ1byjsoFGp5Hsq4wfAUVo8xOxLOxwhr/cFbW
         wtVA==
X-Gm-Message-State: AOAM530TAscdbEHUwU+nyg6SCtGOvs+kmgfnFjnwpVOYoSUiphq5oXpg
        YTjNameEPkI+ZzHvbe8QfSk/74HYjK5tLQ==
X-Google-Smtp-Source: ABdhPJxYlG2+341gpdXcLRPe4TCiKPfEx1QhooNO38pTkiJ9EBlm22D7QM8empPxfsm4MY1WXE6fYQ==
X-Received: by 2002:a0c:e2cd:: with SMTP id t13mr10934372qvl.21.1617914504757;
        Thu, 08 Apr 2021 13:41:44 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id c73sm384733qkg.6.2021.04.08.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:41:44 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v4 5/7] refresh_index(): add flag to ignore SKIP_WORKTREE entries
Date:   Thu,  8 Apr 2021 17:41:26 -0300
Message-Id: <4330f509303c76521ab3e4d342065ce4025ec6f1.1617914011.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617914011.git.matheus.bernardino@usp.br>
References: <cover.1617914011.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refresh_index() doesn't update SKIP_WORKTREE entries, but it still
matches them against the given pathspecs, marks the matches on the
seen[] array, check if unmerged, etc. In the following patch, one caller
will need refresh_index() to ignore SKIP_WORKTREE entries entirely, so
add a flag that implements this behavior.

While we are here, also realign the REFRESH_* flags and convert the hex
values to the more natural bit shift format, which makes it easier to
spot holes.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 cache.h      | 15 ++++++++-------
 read-cache.c |  3 +++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 148d9ab5f1..19c03fb6e7 100644
--- a/cache.h
+++ b/cache.h
@@ -879,13 +879,14 @@ int match_stat_data_racy(const struct index_state *istate,
 
 void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, struct stat *st);
 
-#define REFRESH_REALLY		0x0001	/* ignore_valid */
-#define REFRESH_UNMERGED	0x0002	/* allow unmerged */
-#define REFRESH_QUIET		0x0004	/* be quiet about it */
-#define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
-#define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
-#define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
-#define REFRESH_PROGRESS	0x0040  /* show progress bar if stderr is tty */
+#define REFRESH_REALLY                   (1 << 0) /* ignore_valid */
+#define REFRESH_UNMERGED                 (1 << 1) /* allow unmerged */
+#define REFRESH_QUIET                    (1 << 2) /* be quiet about it */
+#define REFRESH_IGNORE_MISSING           (1 << 3) /* ignore non-existent */
+#define REFRESH_IGNORE_SUBMODULES        (1 << 4) /* ignore submodules */
+#define REFRESH_IN_PORCELAIN             (1 << 5) /* user friendly output, not "needs update" */
+#define REFRESH_PROGRESS                 (1 << 6) /* show progress bar if stderr is tty */
+#define REFRESH_IGNORE_SKIP_WORKTREE     (1 << 7) /* ignore skip_worktree entries */
 int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 /*
  * Refresh the index and write it to disk.
diff --git a/read-cache.c b/read-cache.c
index 5a907af2fb..8381935b84 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1514,6 +1514,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int quiet = (flags & REFRESH_QUIET) != 0;
 	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
 	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
+	int ignore_skip_worktree = (flags & REFRESH_IGNORE_SKIP_WORKTREE) != 0;
 	int first = 1;
 	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options = (CE_MATCH_REFRESH |
@@ -1556,6 +1557,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		ce = istate->cache[i];
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
+		if (ignore_skip_worktree && ce_skip_worktree(ce))
+			continue;
 
 		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
 			filtered = 1;
-- 
2.30.1

