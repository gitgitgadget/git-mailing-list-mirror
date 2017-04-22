Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AABE207D6
	for <e@80x24.org>; Sat, 22 Apr 2017 05:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041717AbdDVFmH (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 01:42:07 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33821 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1040868AbdDVFmG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 01:42:06 -0400
Received: by mail-io0-f195.google.com with SMTP id h41so36058999ioi.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 22:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smkent.net; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=c1OEmqR5SgORj5tvdENQEm0jJfx/kvGy46xGPZhsW2Y=;
        b=SURlCRXyqlvHtoZ98y+etmyV00c3nzjfoybJxkjZnMph6pW4Dq2JInKsmtlHOyDBgc
         +Xp1ceL0vUyrgJZ8gz0RIQ/Z5z8sGwA80uQbTbwiDO05zbe4I4mQ22MUrKYh3/CI7aB/
         ArpjAlRHK8gwCSV77Fz92WSegocpr/IiQNv9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=c1OEmqR5SgORj5tvdENQEm0jJfx/kvGy46xGPZhsW2Y=;
        b=UXB6oEjfZ1cni34rYHewc87ysMNR+7RoYA3N6tm/SJxAxkBwwqKZxNe0lKLegpEzJT
         5M4TuJz162YaQfIN2iYdVVWVGgeoPBw8Wz4i0TGl/Q7bJd93UjS4s/xHTU2SlSlBvOXT
         HzIZLPhty2r45JiTwPh+2zKKcTM+ac8SD6ZY1/Smv9iUeX3Ygs44hzterlvFj/XPM9oH
         0+eNRpFWouvvLFz6116TAm0yOPj9cYHS0TGqOz4vj3WcIEKG8VQp+gPuF26lngboIGJF
         aVza5xE8IHGkezCc4b/BRNCYheHLJkDxu1lhtbIRYdvaNaYmhme29GCEz7tb51s6wHPJ
         al+A==
X-Gm-Message-State: AN3rC/50Y7nN2tarrLLUp2uS+Jg5MxQpkArx/KkYcq/E1SFLV576eQn8
        w7tTe/8KQUrfNpnj0t4=
X-Received: by 10.98.207.196 with SMTP id b187mr15640509pfg.167.1492839724862;
        Fri, 21 Apr 2017 22:42:04 -0700 (PDT)
Received: from localhost (c-73-53-29-115.hsd1.wa.comcast.net. [73.53.29.115])
        by smtp.gmail.com with ESMTPSA id 29sm18998312pfo.9.2017.04.21.22.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Apr 2017 22:42:04 -0700 (PDT)
Date:   Fri, 21 Apr 2017 22:42:02 -0700
From:   Stephen Kent <smkent@smkent.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] status: add color config slots for branch info in
 "--short --branch"
Message-ID: <201704939828871.4296cfa6a746a5004d28db265800a@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add color config slots to be used in the status short-format when
displaying local and remote tracking branch information.

Signed-off-by: Stephen Kent <smkent@smkent.net>
---
 Documentation/config.txt               | 5 ++++-
 builtin/commit.c                       | 4 ++++
 contrib/completion/git-completion.bash | 2 ++
 t/t7508-status.sh                      | 5 +++--
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874..96e9cf8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1137,7 +1137,10 @@ color.status.<slot>::
 	`untracked` (files which are not tracked by Git),
 	`branch` (the current branch),
 	`nobranch` (the color the 'no branch' warning is shown in, defaulting
-	to red), or
+	to red),
+	`localBranch` or `remoteBranch` (the local and remote branch names,
+	respectively, when branch and tracking information is displayed in the
+	status short-format), or
 	`unmerged` (files which have unmerged changes).
 
 color.ui::
diff --git a/builtin/commit.c b/builtin/commit.c
index 4e288bc..43846d5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1263,6 +1263,10 @@ static int parse_status_slot(const char *slot)
 		return WT_STATUS_NOBRANCH;
 	if (!strcasecmp(slot, "unmerged"))
 		return WT_STATUS_UNMERGED;
+	if (!strcasecmp(slot, "localBranch"))
+		return WT_STATUS_LOCAL_BRANCH;
+	if (!strcasecmp(slot, "remoteBranch"))
+		return WT_STATUS_REMOTE_BRANCH;
 	return -1;
 }
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1150164..f0542b6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2377,7 +2377,9 @@ _git_config ()
 		color.status.added
 		color.status.changed
 		color.status.header
+		color.status.localBranch
 		color.status.nobranch
+		color.status.remoteBranch
 		color.status.unmerged
 		color.status.untracked
 		color.status.updated
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index fb00e6d..7d42085 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -610,7 +610,8 @@ test_expect_success 'status --porcelain ignores relative paths setting' '
 test_expect_success 'setup unique colors' '
 
 	git config status.color.untracked blue &&
-	git config status.color.branch green
+	git config status.color.branch green &&
+	git config status.color.localBranch yellow
 
 '
 
@@ -675,7 +676,7 @@ test_expect_success 'status -s with color.status' '
 '
 
 cat >expect <<\EOF
-## <GREEN>master<RESET>
+## <YELLOW>master<RESET>
  <RED>M<RESET> dir1/modified
 <GREEN>A<RESET>  dir2/added
 <BLUE>??<RESET> dir1/untracked
-- 
2.10.2

