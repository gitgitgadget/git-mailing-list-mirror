Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A413520958
	for <e@80x24.org>; Mon, 20 Mar 2017 19:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754951AbdCTTWv (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 15:22:51 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35952 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754339AbdCTTWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 15:22:42 -0400
Received: by mail-pg0-f50.google.com with SMTP id g2so81647884pge.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8mTrid0i86SyQO6BEQEbWQ02vHPecBwcbEzMXiaX9Y=;
        b=Ps40e4tcREQO1AFS0pK+jvhwHVXVp3edVo2k2tXFZpTy8y7KEiygi+QiFtivFKmLNf
         vyOur+R0lMF3r2pejlZxfPfU/CjpjVihxm9VlJsuqxAQeiAU4PpzSCNZsJIMuGUZCrY3
         uWKkizgqWCS3Hh+nm4lurualRjIHaN+9Crd0GP9qrKgMt+0Ia2yRmz2G4WL/o38mF2F5
         hhWcy3XiGQhZqTF7PuW2eO0PiVjFrDfx4LvYUxyOZNiZYJvXf7tXMWcz8GPBtyOyXAXu
         PQjSKA3mxktQ2KW7+5JIkYYzCoIcoYSUOhx+cwBL3R9lGxdU8FMpNd56fM6Y7pvMKMZg
         JdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8mTrid0i86SyQO6BEQEbWQ02vHPecBwcbEzMXiaX9Y=;
        b=eUA2q0Lrgn9mlZfHA4KF4jhmupLRyqxyOp/ZD+7ThnywEmx+9oxNhKD3sk0ycZlkM2
         IE7QPIJ17Qy+c5LBpxyIJY0IOnu/pK8S/apQM5XYYSaPHnfcPOo5QVyHQlZ2b1J/TNGK
         oLxdIa8nmxjBj1EPUnZFxV8sjkdk/OrpkZmxXSS2cUAENIA+Z/e9bx8X7XHMMsniRbV8
         FYOAhbgsmgDTzSYKumujYKa4NCCqPiX1zNLFL2WjvtukeijjHDTanCOrYG0bTW8Op03A
         WUG3giNRDQ9cH/YXkULKBbW5JfcIVhtp9WR/bbQ0J4qw9HPfYYOUmgZlV35q0UgqNqiF
         3LlA==
X-Gm-Message-State: AFeK/H0mbJ/oJVWUiI/sWgg8WQ8Rb8snkV8Ay1/PE+UedFJTPNlYAjra+HOe7i9U2Q2629j/
X-Received: by 10.99.48.68 with SMTP id w65mr33063953pgw.203.1490037754269;
        Mon, 20 Mar 2017 12:22:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:38a6:f549:ebc4:4d51])
        by smtp.gmail.com with ESMTPSA id x21sm34999129pgf.15.2017.03.20.12.22.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 12:22:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] git.c: introduce --working-tree superseding --work-tree
Date:   Mon, 20 Mar 2017 12:22:24 -0700
Message-Id: <20170320192225.18928-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.306.g4a9b9b32d4.dirty
In-Reply-To: <20170320192225.18928-1-sbeller@google.com>
References: <20170320185038.GU26789@aiede.mtv.corp.google.com>
 <20170320192225.18928-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Discussion on bf0231c661 (rev-parse: add --show-superproject-working-tree,
2017-03-08) pointed out we are inconsistent with the naming of "working
tree" and "worktree" even in user facing commands and documentation[1].

Introduce the new --working-tree option, which is the same as
--work-tree. As --work-tree is considered slightly incorrect[2], stop
mentioning it in the documentation.  But we need to keep its functionality
as it is plumbing.

An alternative was considered off list to rename the newly added option
'--show-superproject-working-tree' by dropping the part mentioning the
working tree to side step this discussion. However we need to make sure
that option still refers to the working tree, as a new option
'show-superproject-git-dir' might be considered useful in the future,
and we do not want to take the canonical '--show-superproject' now.

[1] https://public-inbox.org/git/20170317222842.GP26789@aiede.mtv.corp.google.com/
[2] https://public-inbox.org/git/xmqqo9wy4hxa.fsf@gitster.mtv.corp.google.com/

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git.txt | 12 ++++++------
 git.c                 |  5 +++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index df0941d456..763f3b5563 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git' [--version] [--help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
-    [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
+    [--git-dir=<path>] [--working-tree=<path>] [--namespace=<name>]
     [--super-prefix=<path>]
     <command> [<args>]
 
@@ -551,12 +551,12 @@ help ...`.
 	<path>`.
 +
 This option affects options that expect path name like `--git-dir` and
-`--work-tree` in that their interpretations of the path names would be
+`--working-tree` in that their interpretations of the path names would be
 made relative to the working directory caused by the `-C` option. For
 example the following invocations are equivalent:
 
-    git --git-dir=a.git --work-tree=b -C c status
-    git --git-dir=c/a.git --work-tree=c/b status
+    git --git-dir=a.git --working-tree=b -C c status
+    git --git-dir=c/a.git --working-tree=c/b status
 
 -c <name>=<value>::
 	Pass a configuration parameter to the command. The value
@@ -602,7 +602,7 @@ foo.bar= ...`) sets `foo.bar` to the empty string.
 	setting the `GIT_DIR` environment variable. It can be an absolute
 	path or relative path to current working directory.
 
---work-tree=<path>::
+--working-tree=<path>::
 	Set the path to the working tree. It can be an absolute path
 	or a path relative to the current working directory.
 	This can also be controlled by setting the GIT_WORK_TREE
@@ -892,7 +892,7 @@ Git so take care if using a foreign front-end.
 
 `GIT_WORK_TREE`::
 	Set the path to the root of the working tree.
-	This can also be controlled by the `--work-tree` command-line
+	This can also be controlled by the `--working-tree` command-line
 	option and the core.worktree configuration variable.
 
 `GIT_NAMESPACE`::
diff --git a/git.c b/git.c
index 33f52acbcc..a76ff97232 100644
--- a/git.c
+++ b/git.c
@@ -149,9 +149,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_NAMESPACE_ENVIRONMENT, cmd, 1);
 			if (envchanged)
 				*envchanged = 1;
-		} else if (!strcmp(cmd, "--work-tree")) {
+		} else if (!strcmp(cmd, "--work-tree") ||
+			   !strcmp(cmd, "--working-tree")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No directory given for --work-tree.\n" );
+				fprintf(stderr, "No directory given for %s.\n", cmd);
 				usage(git_usage_string);
 			}
 			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
-- 
2.12.0.306.g4a9b9b32d4.dirty

