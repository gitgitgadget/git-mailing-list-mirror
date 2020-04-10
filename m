Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255D9C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86BC20A8B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rycox+0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDJPLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:11:00 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:44173 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgDJPLA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 11:11:00 -0400
Received: by mail-lj1-f180.google.com with SMTP id z26so2225942ljz.11
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGahhmMZYd5tIb2oknkM+br/LfVUoJTkbUaej9jwxWc=;
        b=rycox+0b8nS77sxcytYM2iNi26kMa4jAItFsOset3SFeFrL8rekVng5KU3e/3a0Dlv
         x3VM9ux1QcidEQ0uK3nHotMnXtysjGAFqzAbiyyzkQXjVyTpz/XNeZpTD0x+4yjh+EVK
         q5pPAslvLi+CBb307YAmSk8r0vcrtTnEoo2wBYSTVQvkOThZVNUGBJpV69MaDL4KOUR7
         c4AMgJQE5Zm/zyoqB7q+06LctxgQsJpmw4TaryFtg4QOzRA91KDijcLjDwSgpLKUL/kU
         Z2XeN4yfDRpaiPsgLPMud/HEUL5oo/Q5NwfneFodLzcG2qY/PQ4dvdJm2G+H4gdONhc3
         8x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGahhmMZYd5tIb2oknkM+br/LfVUoJTkbUaej9jwxWc=;
        b=JFx6SnfDeqFP9pK9YlGGRT62JWajMLJP64aSgOxcs4ByMqk5b/wlT3BMBCCVL5+II4
         Ch3V5WIW1NgWtLjKRYeZN3J4FldFj6TyAFSw9dqFqNDOd3NvJ0cAaRjy//P5hnIlf4dH
         gFcsiN/w/4xcKjuvpO8asWpPU/5wr7qRRVLrtEnQJLL9cAgwDPqIQlI1T9iU2EM8COaZ
         Y+4cClsIJT7VR5DnLoKGb0WPiWjMLkZENb5cCTsbN6IOBD0DKGKIWvytp28hpF2s1Zq0
         NHSLwP6/olVggJGKm16V6mv5o6jteZ2PnYrAbKwUa69PtyK5PGQybm53aO3akAB8nyVp
         ATNA==
X-Gm-Message-State: AGi0PuaUidZ/XDcXahKSCoxB/7hcTf4brlAGhrIo6zoxd/kiuN53t26/
        Lw2zYM77+zaMOqMDWtvZKRo5WcD/
X-Google-Smtp-Source: APiQypIM2eJezpYa/qYzFzB3qo5rmlevS5KiGc0A2yAP8E2OxEuPY5iF2s0sdU/f+kaWkWnOmqu5wA==
X-Received: by 2002:a2e:9ac9:: with SMTP id p9mr3275867ljj.222.1586531458034;
        Fri, 10 Apr 2020 08:10:58 -0700 (PDT)
Received: from localhost.localdomain (host-189-203-22.junet.se. [207.189.203.22])
        by smtp.gmail.com with ESMTPSA id w7sm1243112lji.92.2020.04.10.08.10.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 08:10:57 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] merge: use skip_prefix to parse config key
Date:   Fri, 10 Apr 2020 17:10:32 +0200
Message-Id: <20200410151032.23198-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using `starts_with()`, the magic number 7, `strlen()` and a
fair number of additions to verify the three parts of the config key
"branch.<branch>.mergeoptions", use `skip_prefix()` to jump through them
more explicitly.

We need to introduce a new variable for this (we certainly can't modify
`k` just because we see "branch."!). With `skip_prefix()` we often use
quite bland names like `p` or `str`. Let's do the same. If and when this
function needs to do more prefix-skipping, we'll have a generic variable
ready for this.

Adjust the indentation while we're here.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---

 worktree.c also matches "strcmp.*strlen" and could see a similar patch.
 I'm working on a longer series for that file and this fell out of that
 work. This feels independent enough that I'm posting it on its own.

 builtin/merge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d127d2225f..bde5f14f05 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -597,10 +597,10 @@ static void parse_branch_merge_options(char *bmo)
 static int git_merge_config(const char *k, const char *v, void *cb)
 {
 	int status;
+	const char *str;
 
-	if (branch && starts_with(k, "branch.") &&
-		starts_with(k + 7, branch) &&
-		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
+	if (branch && skip_prefix(k, "branch.", &str) &&
+	    skip_prefix(str, branch, &str) && !strcmp(str, ".mergeoptions")) {
 		free(branch_mergeoptions);
 		branch_mergeoptions = xstrdup(v);
 		return 0;
-- 
2.26.0

