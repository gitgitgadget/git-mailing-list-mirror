From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 07/14] stash: add --stage to pop and apply
Date: Fri, 25 Apr 2014 13:12:40 -0500
Message-ID: <1398449567-16314-8-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:24:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdknB-00079k-FC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbaDYSXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:23:46 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:51451 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbaDYSXp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:23:45 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so4543136oag.7
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uEKqHJOTl5ig12kQUnOZQMFW2G7t62BFVzDyqgoY0Ws=;
        b=Kvhld8tbm/wA2hGIVst158P8IEqZzGj2Bm3o0ayRWbJR26NaLdLvPmaFY4x7+OFdBB
         Rt4h+7RS6J505wHzSJAz7HYvFOrI7ZMojgnAJnDmLCXbSVtWVXfYLuav/c4pd88F2aM/
         Klr1Fu7nHj6PxcGGR40JYWNnoPMXCE4WvQy9wrOAyxX0OoJ14FGBAL/9JiVhA1k06+rr
         piVLNFgUktPqE2BU0rmNmGiGIAPi1tnDD2BgAAHiZfI5mp1wDERbzwdF8T9Lfr5LiuMp
         upTucy6fawKA1QbOwM4ndgWIUUm2UIXy6LRbgmOblynHfouX70+YpmDlNg7A0YhqJFkt
         zpQQ==
X-Received: by 10.60.159.74 with SMTP id xa10mr1859632oeb.78.1398450224890;
        Fri, 25 Apr 2014 11:23:44 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm34688233oeb.13.2014.04.25.11.23.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247080>

Synonym of --index.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stash.txt | 8 ++++----
 git-stash.sh                | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 21a01c2..5fdaa35 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git stash' list [<options>]
 'git stash' show [<stash>]
 'git stash' drop [-q|--quiet] [<stash>]
-'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
+'git stash' ( pop | apply ) [--index|--stage] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index|--[no-]stage] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
@@ -96,7 +96,7 @@ show [<stash>]::
 	it will accept any format known to 'git diff' (e.g., `git stash show
 	-p stash@{1}` to view the second most recent stash in patch form).
 
-pop [--index] [-q|--quiet] [<stash>]::
+pop [--index|--stage] [-q|--quiet] [<stash>]::
 
 	Remove a single stashed state from the stash list and apply it
 	on top of the current working tree state, i.e., do the inverse
@@ -110,12 +110,12 @@ and call `git stash drop` manually afterwards.
 If the `--index` option is used, then tries to reinstate not only the working
 tree's changes, but also the index's ones. However, this can fail, when you
 have conflicts (which are stored in the index, where you therefore can no
-longer apply the changes as they were originally).
+longer apply the changes as they were originally). `--stage` is a synonym.
 +
 When no `<stash>` is given, `stash@{0}` is assumed, otherwise `<stash>` must
 be a reference of the form `stash@{<revision>}`.
 
-apply [--index] [-q|--quiet] [<stash>]::
+apply [--index|--stage] [-q|--quiet] [<stash>]::
 
 	Like `pop`, but do not remove the state from the stash list. Unlike `pop`,
 	`<stash>` may be any commit that looks like a commit created by
diff --git a/git-stash.sh b/git-stash.sh
index bff4ecc..0f764fe 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -5,7 +5,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="list [<options>]
    or: $dashless show [<stash>]
    or: $dashless drop [-q|--quiet] [<stash>]
-   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
+   or: $dashless ( pop | apply ) [--index|--stage] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [--patch] [-k|--[no-]keep-index|--[no-]stage] [-q|--quiet]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
@@ -373,7 +373,7 @@ parse_flags_and_rev()
 			-q|--quiet)
 				GIT_QUIET=-t
 			;;
-			--index)
+			--index|--stage)
 				INDEX_OPTION=--index
 			;;
 			-*)
-- 
1.9.2+fc1.2.gfbaae8c
