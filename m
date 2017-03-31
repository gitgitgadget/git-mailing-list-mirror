Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C1A1FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 00:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933446AbdDAAAI (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 20:00:08 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34360 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933363AbdDAAAH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 20:00:07 -0400
Received: by mail-pg0-f51.google.com with SMTP id 21so84458241pgg.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 17:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z0i5/aQGsl09Eblq2kH0SxuaHFar4sP5xNDLxHjrRys=;
        b=u5kUV2NCFv90VSYOXChBAdykpyB4YCnwlxSM6GEkJYixk+wlHQKBNoizHtcBnC1e/a
         H7wKJTwf/wzgI5lX6eigZJrcnhR0NafO5g3z8PkA5NrP9VRFtsYADP8zKCSqithHW73r
         uUY7ieLzI4gjX0Ozx6BHSffKqVKnPMOOQqwJZcxQpqWginy7vXI+3xP4yq1COHM7JXUO
         Z2VP+K4ZGmZdr5Nr4+ddteYF0p+YD2K3cKyAmbjgg2F0RKTXANq2wbRYHqR/1DrcwSOv
         PZFIt4/4cClK3Oo7pQQoD2oX84pJZdF1PiH67ICaJxI1nwpfMTT8UrZmoVVHCbkaebFp
         Svmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z0i5/aQGsl09Eblq2kH0SxuaHFar4sP5xNDLxHjrRys=;
        b=gO2mnJxY5g4iVbpWBzJHNjLXnPoYAbD6RjdJLTk9BkcaTsQ07zOC7IJSDAtQlOGxSo
         EosKQS7hz8TmPhXSagFD72nmJ7gtJ5Rrq2/9Lb2Hs/a/sCgrXprCTDm/x8/W2g5t45rq
         O3ogD/9/wuE/gGa452rjYvGjOeBBzIXdd48XTZgY57Z3VL6AmqDnzrtArtNCdKJ6DQcO
         Fk1QueAx0Lthj/nl1ZBt0WVtwvoDd5kuNAcDtSxa8ZikIHhKa5lQ1ziRgch5fDcyLz65
         cXFI6PdoDHR5BxWys4GGTUgPtK33hN2ZPf5539Si8Gj1m1JyzxCGXq4YBuKLNCoggnsl
         BnCQ==
X-Gm-Message-State: AFeK/H2Od8stDP5qerJO9IXyFRtoTnQGZrRpL4yE3d+eqp+5Gn5kHIJ3FZVlBvjfQaqUX1Mt
X-Received: by 10.98.34.86 with SMTP id i83mr4910684pfi.89.1491004806231;
        Fri, 31 Mar 2017 17:00:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1036:daec:97bb:16f7])
        by smtp.gmail.com with ESMTPSA id l29sm12495034pfb.118.2017.03.31.17.00.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 17:00:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH] git-news: obtain latest news for your favorite VCS
Date:   Fri, 31 Mar 2017 16:59:47 -0700
Message-Id: <20170331235947.20010-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.576.g7be6e4ba40.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Today when a user is interested in news regarding the Git, their favorite
version control, it is a challenging task to find out what is actually
happening.  If the user is using a Git in a distribution that packaged
it nicely for them, they may find outdated information in their
distribution using the distributions choice of relaying news.
As Git is a fast paced project, this is not the desired behavior for
most users. They rather prefer the latest news.

One could argue that it is OK to expect the user to read the "What's
cooking" emails or even release notes to get a grasp of the latest
development of Git, but these news do not quite catch the lively
atmosphere of the mailing list with all its polite flame wars and
opinionated arguments on why a patch is written the way it ends up in
the release notes.

It is time to fix the root case of this important user facing problem in
a sensible way that doesn't confuse the user.

Invent a new sub command 'git-news', which presents the latest news
in a way capturing all the interesting tid-bits of the mailing list as
well as the surrounding ecosystem.

As we're rushing the solution of this important problem, we did not
consider alternatives, such that we end up solving it in a backwards
compatible, but forwards incompatible way; clearly nobody in the future
wants to add another command that points to different news source. This is
why we can take the generic name 'git-news', instead of using the rather
specialized 'git-rev-news' command that is harder to remember and type.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 .gitignore            | 1 +
 Documentation/git.txt | 2 ++
 Makefile              | 1 +
 command-list.txt      | 1 +
 git-news.sh           | 4 ++++
 5 files changed, 9 insertions(+)
 create mode 100755 git-news.sh

diff --git a/.gitignore b/.gitignore
index 833ef3b0b7..b2d9c1161f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -98,6 +98,7 @@
 /git-mktag
 /git-mktree
 /git-name-rev
+/git-news
 /git-mv
 /git-notes
 /git-p4
diff --git a/Documentation/git.txt b/Documentation/git.txt
index ecc1bb4bd7..f4629aa39b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -35,6 +35,8 @@ manual page gives you an overview of the command-line command syntax.
 A formatted and hyperlinked copy of the latest Git documentation
 can be viewed at `https://git.github.io/htmldocs/git.html`.
 
+A more entertaining section of news can be obtained via `git-news`.
+
 ifdef::stalenotes[]
 [NOTE]
 ============
diff --git a/Makefile b/Makefile
index 9f8b35ad41..32e50f30a2 100644
--- a/Makefile
+++ b/Makefile
@@ -519,6 +519,7 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
+SCRIPT_SH += git-news.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
diff --git a/command-list.txt b/command-list.txt
index a1fad28fd8..150b287ada 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -91,6 +91,7 @@ git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain           worktree
 git-name-rev                            plumbinginterrogators
+git-news                                mainporcelain
 git-notes                               mainporcelain
 git-p4                                  foreignscminterface
 git-pack-objects                        plumbingmanipulators
diff --git a/git-news.sh b/git-news.sh
new file mode 100755
index 0000000000..1707dc633e
--- /dev/null
+++ b/git-news.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+#
+
+/usr/bin/sensible-browser https://git.github.io/rev_news/
-- 
2.12.2.576.g7be6e4ba40.dirty

