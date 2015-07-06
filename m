From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 05/23] Documentation/git-worktree: split technical info from general description
Date: Mon,  6 Jul 2015 13:30:42 -0400
Message-ID: <1436203860-846-6-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:33:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAH0-0000PK-LX
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbbGFRdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:33:35 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36062 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbbGFRbe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:34 -0400
Received: by iecvh10 with SMTP id vh10so118194824iec.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pQ0xpMy6+7tSmRXKz9xxW8Q6/sC7rLktPLw/jydzd8o=;
        b=P6LvxrrWFdQc+z8xGZZUhHuLzjnI2wzKqN7eCXRXcgNqxnFbx7r/h7rlZVr45fc7kQ
         AwV0MmrgdThjxl/ggncV6R88EXB+jpZlVeYi9sOO/rGnVIcdKoirptERc3TSBhFz3wCX
         sZxh35xkoguLwY0kkQZ5f4PWm3qMyBoo+nX+eCw4I232xd65Tra/8pqwy5ue+/TZ3+eI
         h64Xs9NlqR5V1WhoZNEzXOh2OQyxT7Ci0i9rMijG8STBJxPDMbYqRSeJ+StqcoZTQDVl
         Zsc3yVdRObJtNYNz9fRJpzSG1XutIXOVU8buuPWG5lDgX+1B/5OLKCEjBFxQZuHX8Fkr
         +vrg==
X-Received: by 10.43.34.205 with SMTP id st13mr37053705icb.4.1436203893836;
        Mon, 06 Jul 2015 10:31:33 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.32
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273435>

The DESCRIPTION section should provide a high-level overview of linked
worktree functionality to bring users up to speed quickly, without
overloading them with low-level details, so relocate the technical
information to a new DETAILS section.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 70 ++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index bf6a1e2..2954dc6 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -24,47 +24,18 @@ tree is associated with the repository.  This new working tree is called a
 init" or "git clone".  A repository has one main working tree (if it's not a
 bare repository) and zero or more linked working trees.
 
-Each linked working tree has a private sub-directory in the repository's
-$GIT_DIR/worktrees directory.  The private sub-directory's name is usually
-the base name of the linked working tree's path, possibly appended with a
-number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
-command `git checkout --to /path/other/test-next next` creates the linked
-working tree in `/path/other/test-next` and also creates a
-`$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
-if `test-next` is already taken).
-
-Within a linked working tree, $GIT_DIR is set to point to this private
-directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
-$GIT_COMMON_DIR is set to point back to the main working tree's $GIT_DIR
-(e.g. `/path/main/.git`). These settings are made in a `.git` file located at
-the top directory of the linked working tree.
-
-Path resolution via `git rev-parse --git-path` uses either
-$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
-linked working tree `git rev-parse --git-path HEAD` returns
-`/path/main/.git/worktrees/test-next/HEAD` (not
-`/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
-rev-parse --git-path refs/heads/master` uses
-$GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
-since refs are shared across all working trees.
-
-See linkgit:gitrepository-layout[5] for more information. The rule of
-thumb is do not make any assumption about whether a path belongs to
-$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
-inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
-
 When you are done with a linked working tree you can simply delete it.
-The working tree's entry in the repository's $GIT_DIR/worktrees
-directory will eventually be removed automatically (see
+The working tree's administrative files in the repository (see
+"DETAILS" below) will eventually be removed automatically (see
 `gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
 `git worktree prune` in the main or any linked working tree to
-clean up any stale entries in $GIT_DIR/worktrees.
+clean up any stale administrative files.
 
 If you move a linked working directory to another file system, or
 within a file system that does not support hard links, you need to run
 at least one git command inside the linked working directory
-(e.g. `git status`) in order to update its entry in $GIT_DIR/worktrees
-so that it does not get automatically removed.
+(e.g. `git status`) in order to update its administrative files in the
+repository so that they do not get automatically pruned.
 
 To prevent a $GIT_DIR/worktrees entry from from being pruned (which
 can be useful in some situations, such as when the
@@ -97,6 +68,37 @@ OPTIONS
 --expire <time>::
 	With `prune`, only expire unused worktrees older than <time>.
 
+DETAILS
+-------
+Each linked working tree has a private sub-directory in the repository's
+$GIT_DIR/worktrees directory.  The private sub-directory's name is usually
+the base name of the linked working tree's path, possibly appended with a
+number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
+command `git checkout --to /path/other/test-next next` creates the linked
+working tree in `/path/other/test-next` and also creates a
+`$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
+if `test-next` is already taken).
+
+Within a linked working tree, $GIT_DIR is set to point to this private
+directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
+$GIT_COMMON_DIR is set to point back to the main working tree's $GIT_DIR
+(e.g. `/path/main/.git`). These settings are made in a `.git` file located at
+the top directory of the linked working tree.
+
+Path resolution via `git rev-parse --git-path` uses either
+$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
+linked working tree `git rev-parse --git-path HEAD` returns
+`/path/main/.git/worktrees/test-next/HEAD` (not
+`/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
+rev-parse --git-path refs/heads/master` uses
+$GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
+since refs are shared across all working trees.
+
+See linkgit:gitrepository-layout[5] for more information. The rule of
+thumb is do not make any assumption about whether a path belongs to
+$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
+inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
+
 BUGS
 ----
 Multiple checkout support for submodules is incomplete. It is NOT
-- 
2.5.0.rc1.197.g417e668
