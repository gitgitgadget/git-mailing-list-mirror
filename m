From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 06/23] Documentation/git-worktree: add high-level 'lock' overview
Date: Mon,  6 Jul 2015 13:30:43 -0400
Message-ID: <1436203860-846-7-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:33:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAH0-0000PK-2f
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464AbbGFRdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:33:32 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35503 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbGFRbf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:35 -0400
Received: by iecuq6 with SMTP id uq6so118017956iec.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jrGSwofqYGW+F0y6bLivzAt8XVatqJTr3jVuEYKlXes=;
        b=e2qR0GAc0iGfTgCgwWLIzGQSmciA9q6sGV5BjgJWfApCbxMUZyz4xYp+wN+tFVfsW6
         VyQedRst5QYOxAkj7lXhfSu/lZEGOs/bnpbRmhL6ER7hn0DlUmQicKgqzoGHvx9grBgX
         D9LtWoc/NK0BUbYlwGYhhrxMsYm2BHOUl2VpXCvHd6ReZ3wc/Abta/NBUV1eqdRgj/8y
         Eryd7NGPWfxjObb8zzR3NZk1MBfvqjlbIdKAWEIoNwLw/bo3LQdgPv3A1D/32kmbiPHX
         bCtCQITKpBzYBWy5jZ6z16pLoLsjKdwH0NY2pqyvfuK3rRSQUUFCJ2IFnsd/O9CfKS2F
         y1VA==
X-Received: by 10.43.19.131 with SMTP id qk3mr37451442icb.15.1436203894637;
        Mon, 06 Jul 2015 10:31:34 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.33
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273436>

Due to the (current) absence of a "git worktree lock" command, locking
a worktree's administrative files to prevent automatic pruning is a
manual task, necessarily requiring low-level understanding of linked
worktree functionality. However, this level of detail does not belong
in the high-level DESCRIPTION section, so add a generalized discussion
of locking to DESCRIPTION and move the technical information to DETAILS.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 2954dc6..0385e9a 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -37,15 +37,11 @@ at least one git command inside the linked working directory
 (e.g. `git status`) in order to update its administrative files in the
 repository so that they do not get automatically pruned.
 
-To prevent a $GIT_DIR/worktrees entry from from being pruned (which
-can be useful in some situations, such as when the
-entry's working tree is stored on a portable device), add a file named
-'locked' to the entry's directory. The file contains the reason in
-plain text. For example, if a linked working tree's `.git` file points
-to `/path/main/.git/worktrees/test-next` then a file named
-`/path/main/.git/worktrees/test-next/locked` will prevent the
-`test-next` entry from being pruned.  See
-linkgit:gitrepository-layout[5] for details.
+If a linked working tree is stored on a portable device or network share
+which is not always mounted, you can prevent its administrative files from
+being pruned by creating a file named 'lock' alongside the other
+administrative files, optionally containing a plain text reason that
+pruning should be suppressed. See section "DETAILS" for more information.
 
 COMMANDS
 --------
@@ -99,6 +95,16 @@ thumb is do not make any assumption about whether a path belongs to
 $GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
 inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
 
+To prevent a $GIT_DIR/worktrees entry from from being pruned (which
+can be useful in some situations, such as when the
+entry's working tree is stored on a portable device), add a file named
+'locked' to the entry's directory. The file contains the reason in
+plain text. For example, if a linked working tree's `.git` file points
+to `/path/main/.git/worktrees/test-next` then a file named
+`/path/main/.git/worktrees/test-next/locked` will prevent the
+`test-next` entry from being pruned.  See
+linkgit:gitrepository-layout[5] for details.
+
 BUGS
 ----
 Multiple checkout support for submodules is incomplete. It is NOT
-- 
2.5.0.rc1.197.g417e668
