From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/23] Documentation/git-worktree: add high-level 'lock' overview
Date: Fri,  3 Jul 2015 20:17:15 -0400
Message-ID: <1435969052-540-7-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAZ-0000B6-C5
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995AbbGDASw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:18:52 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35340 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755864AbbGDASc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:32 -0400
Received: by iecuq6 with SMTP id uq6so84335876iec.2
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IEPcYr/kzUIU3k5pzEa8qv9we/4CosjxTf+qfDBs6uk=;
        b=TD8t6jp6vh46OLHe5iiDYJbZttd8PojbVwabD0XkeS0Vb3tBmxhFEkX12TXzouJ28q
         QcQJ0TwM7PXottLgNGE7GovHkIiHrsp8OENKpBaMXcQxqr0kqn5iTdi6Ux2mPzMkrr6j
         0REFtbIpaD3nL16NsN1s3UbS/eodVkVLymSVpBB0VHeXc33+Om+HP43aL82WtAOuOsFu
         2wOYOv8vahyQGeOHw1IklgWPybsVbFDA340qeoA4mfm4rX8GPCJ72fqAKDhJSyYvEPMA
         70k1bC76b+9sZ+wZTAh1u7kkrt3UMJdkS5+HF1FN7vzzy3P38OdlZw3RlhNMIFejmMm1
         4b9g==
X-Received: by 10.50.66.167 with SMTP id g7mr25947526igt.22.1435969111884;
        Fri, 03 Jul 2015 17:18:31 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.31
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273320>

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
index 2fdfb3e..410f0b4 100644
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
