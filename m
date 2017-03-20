Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548D620958
	for <e@80x24.org>; Mon, 20 Mar 2017 19:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754851AbdCTTWq (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 15:22:46 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33911 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754788AbdCTTWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 15:22:42 -0400
Received: by mail-pf0-f171.google.com with SMTP id p189so46743045pfp.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v+LXVaUZ8KktJY51fNE15Y/Culwt7y+677QZn5IUnJQ=;
        b=pkHE5TlNrT46Pn2+xfqH9Uq4iW9/RyAHTobr3C2z1YkrlrAt/X375OPbBch470AXfx
         VA3RYpT5C+X3ygXoJD1mKQnKP7eTsoBCuLi5RDMUlu1Z0HI5Ig+PGfdSlS1qr6BNavrG
         06sO1YSkU2NuYPYMw63G/V8F9UKD0LitFH4+TMPeAGrCQe9VAJjZKpjlMQzHvCtNPZMe
         fQJ3nQw4UxeF8B1+h1KHGPCu+nU9dAUtE6Qwf8yWz6zElLob0hivPot8TdK3kfmffquJ
         XsncLIyHTsWk4zKQXygJDjTvoGyTj8Ri4oq38ZKQn7lGMowlDTJlVGztvD2kvP0FMeoS
         qkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v+LXVaUZ8KktJY51fNE15Y/Culwt7y+677QZn5IUnJQ=;
        b=Atcus9L//fRc6LimJJUgUO10bioaC8jMvnsDwFCSXecgGtuMZUCYaUayAGiNsW4WQL
         TA+2ZIM401KiD+lDMsQGu6qwpmhd3vEhTMLUq27Rcoec8O98lE+AbiWKIT/J0L8JB0zd
         4GQW8Zq8fGGN8rPZRb919WU+BzV1nvyK8gzOTb/ghAZAxEuF0Ktqu5uWHafUk4gsjwKg
         Xe6PYPNJDxgDlp6c6OERdEzDFL1puEl7K4yPSJIenHUJkvP3fM/WbT9K61zd9h5+CbVC
         DjicC2vrZNBc/QWs1ffem5DlCvw9FIZKStdFThBfWntBAqg1mAhV796Llf8+4fEn3Ak4
         uUUw==
X-Gm-Message-State: AFeK/H2f39H3+R1ThSxu+1wiC8alT7UkchCvG8NcT2C1vbRjxOR9uDSYYOYr8W80RbVpAieX
X-Received: by 10.99.113.81 with SMTP id b17mr11665296pgn.180.1490037755378;
        Mon, 20 Mar 2017 12:22:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:38a6:f549:ebc4:4d51])
        by smtp.gmail.com with ESMTPSA id u29sm28686690pfa.123.2017.03.20.12.22.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 12:22:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] revparse: introduce --is-inside-working-tree
Date:   Mon, 20 Mar 2017 12:22:25 -0700
Message-Id: <20170320192225.18928-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.306.g4a9b9b32d4.dirty
In-Reply-To: <20170320192225.18928-1-sbeller@google.com>
References: <20170320185038.GU26789@aiede.mtv.corp.google.com>
 <20170320192225.18928-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This behaves the same as 'is-inside-worktree' and supersedes it.
See prior patch for discussion of "working tree" vs. "worktree"

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-rev-parse.txt | 4 ++--
 builtin/rev-parse.c             | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index c40c470448..55ee3bde55 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -228,8 +228,8 @@ print a message to stderr and exit with nonzero status.
 	When the current working directory is below the repository
 	directory print "true", otherwise "false".
 
---is-inside-work-tree::
-	When the current working directory is inside the work tree of the
+--is-inside-working-tree::
+	When the current working directory is inside the working tree of the
 	repository print "true", otherwise "false".
 
 --is-bare-repository::
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2549643267..04da518058 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -851,7 +851,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 						: "false");
 				continue;
 			}
-			if (!strcmp(arg, "--is-inside-work-tree")) {
+			if (!strcmp(arg, "--is-inside-work-tree") ||
+			    !strcmp(arg, "--is-inside-working-tree")) {
 				printf("%s\n", is_inside_work_tree() ? "true"
 						: "false");
 				continue;
-- 
2.12.0.306.g4a9b9b32d4.dirty

