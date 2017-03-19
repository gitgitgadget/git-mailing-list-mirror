Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9310420323
	for <e@80x24.org>; Sun, 19 Mar 2017 20:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbdCSUYO (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 16:24:14 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35878 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbdCSUYG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 16:24:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id l37so15653703wrc.3
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/A3NsEfZAzAuPJYs3vgD6Bp4aqxxeWFSLpcMiZr2+Lw=;
        b=K48VlbsI8ysGYCEmXFhqhLT9ahMRS0qf/PPkWLmpODBz/RjZW+hRm/78di+wYp9Zqn
         A4kncVlemDX/rQRMiwuyrmQngkvxoOQFI82CVRQIgIKHRZDoK4OAtE8sBRmdIvi3zAL0
         SNzKx0IbaymQou5+XCyjGx+Cc6ejZj7HuJx5EL2FLAJ0Tue/IfHHL9gQylds/HLzKWzd
         3u6ROGshGrcS1xjFigrCiw3aXhwrQSWua/QtYyg2mOJ4vy5bo6JNEZLfImyGXXQHrRVi
         ml1xi9BMGigaJrpo4EkMtnpOUmzdd82evVX6Rdlr4YcRUzgqHbO+QqA+btFqvQ+Oa473
         3dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/A3NsEfZAzAuPJYs3vgD6Bp4aqxxeWFSLpcMiZr2+Lw=;
        b=QxfYjbk0nVqV8Ijkm2K6BpkmgyUUtaGIknQ+CVk11b5fyLXyBBXiXmGi/LrcJ0+aB3
         Zfdhcq9aOxB2VagguULxcFP71YEuYWkXFail2V3z5rZIkar7wIaUCcNahCKvCC4goANK
         4BHTQAxKGflpMxloy1lq6VzWjmjpoQFeygXdULsn8xFGrd0YwLqTJt5CqAqDIb0SwX60
         SAL2OrdxMusRvT4ztZPGcKGw8sbR761QrhfhL5miwfr4D/R0SWyCWBvvtwMSLEhsHAS4
         SvE2p7ECVNbDrMSb7rxGCqxmKQPWMMlhcqNyMROl95juK61mgckNR0q5WXUkIUnZJN2Y
         emAg==
X-Gm-Message-State: AFeK/H13mXEiuQmGfzM2jrliQuZ3e2KICGVW+GI3BkAxtoT7npb0AFbMZ7cDEQZeNkcK5Q==
X-Received: by 10.223.164.83 with SMTP id e19mr21931490wra.201.1489955020969;
        Sun, 19 Mar 2017 13:23:40 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 11sm17992651wrb.10.2017.03.19.13.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Mar 2017 13:23:40 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC 2/3] stash: make push -p -q --no-keep-index quiet
Date:   Sun, 19 Mar 2017 20:23:50 +0000
Message-Id: <20170319202351.8825-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.483.gad4152297
In-Reply-To: <20170319202351.8825-1-t.gummerer@gmail.com>
References: <20170318183658.GC27158@hank>
 <20170319202351.8825-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when using "git stash push -p -q --no-keep-index", the -q flag
is not passed to the git reset which is executed when --no-keep-index is
also passed in.  This means that git stash is somewhat verbose in this
mode even when the -q flag is passed in.  This was always the case since
"git stash save -p" was introduced in dda1f2a5 ("Implement 'git stash
save --patch'", 2009-08-13).

Properly pass the -q flag on to git reset, to make "git stash push -p
-q" as quiet as it should be.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 59f055e27b..c58f98f1d6 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -322,7 +322,7 @@ push_stash () {
 
 		if test "$keep_index" != "t"
 		then
-			git reset
+			git reset ${GIT_QUIET:+-q}
 		fi
 	fi
 }
-- 
2.12.0.483.gad4152297

