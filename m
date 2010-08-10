From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 9/9] Documentation: git stash branch now tolerates non-stash references.
Date: Tue, 10 Aug 2010 10:04:48 +1000
Message-ID: <1281398688-21008-10-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 02:07:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OicN4-0001mQ-Nt
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab0HJAG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:06:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42444 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757383Ab0HJAG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 20:06:59 -0400
Received: by pwj7 with SMTP id 7so1537076pwj.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 17:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=D32g1sCraVicDijGclqAzP/ekZchqmhcxQ6CRolWkeM=;
        b=srR5NhVwfjBwo3q0oLtLGYS2BiHWk8A1UZ4Y7DL+JV5Dsc04fYwcMXeA0PMDIaEwsr
         VW5gU14aZx5MVZPyMDh71hMM9f2dCuqLG6gyj/EMQWs5TFDllWYMr00qlFYGasqv7nNo
         NRGgKVy0wyxiuDE7+tO1jQsC76iuoq5aK2LVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eDWRsMKek9tgBLgSuOijMD3LniPEcgeLVrynmh1Cottd2ef9wcaTC5H3hm3+UnXYyH
         zhOeMcxC7ySU3xZl9+YOpxOitvdfBvxl+76ZuR4/lhikj80oMpOFN5ceiWBlNtqGHsiU
         1bC77SkbyNCG/QbbXidQpk4vJ07L0z5hFLepo=
Received: by 10.142.234.6 with SMTP id g6mr2069101wfh.146.1281398818683;
        Mon, 09 Aug 2010 17:06:58 -0700 (PDT)
Received: from localhost.localdomain ([120.16.203.103])
        by mx.google.com with ESMTPS id x18sm7096974wfd.8.2010.08.09.17.06.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 17:06:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.53.gddb82
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153067>

Update the documentation to indicate that git stash branch only attempts
to drop the specified stash if it looks like stash reference.

Also changed the synopsis to more clearly indicate which commands require
a stash entry reference as opposed to merely a stash-like commit.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-stash.txt |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 473889a..499ac48 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,10 +9,11 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<options>]
-'git stash' show [<stash>]
-'git stash' drop [-q|--quiet] [<stash>]
-'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
-'git stash' branch <branchname> [<stash>]
+'git stash' show [<stash-like>]
+'git stash' drop [-q|--quiet] [<stash-entry>]
+'git stash' pop [--index] [-q|--quiet] [<stash-entry>]
+'git stash' apply [--index] [-q|--quiet] [<stash-like>]
+'git stash' branch <branchname> [<stash-like>]
 'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
 'git stash' clear
 'git stash' create
@@ -80,15 +81,15 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
-show [<stash>]::
+show [<stash-like>]::
 
 	Show the changes recorded in the stash as a diff between the
-	stashed state and its original parent. When no `<stash>` is given,
+	stashed state and its original parent. When no `<stash-like>` is given,
 	shows the latest one. By default, the command shows the diffstat, but
 	it will accept any format known to 'git diff' (e.g., `git stash show
 	-p stash@\{1}` to view the second most recent stash in patch form).
 
-pop [--index] [-q|--quiet] [<stash>]::
+pop [--index] [-q|--quiet] [<stash-entry>]::
 
 	Remove a single stashed state from the stash list and apply it
 	on top of the current working tree state, i.e., do the inverse
@@ -104,19 +105,21 @@ tree's changes, but also the index's ones. However, this can fail, when you
 have conflicts (which are stored in the index, where you therefore can no
 longer apply the changes as they were originally).
 +
-When no `<stash>` is given, `stash@\{0}` is assumed.
+When no `<stash-entry>` is given, `stash@\{0}` is assumed.
 
-apply [--index] [-q|--quiet] [<stash>]::
+apply [--index] [-q|--quiet] [<stash-like>]::
 
-	Like `pop`, but do not remove the state from the stash list.
+	Like `pop`, but do not remove the state from the stash list. Unlike `pop`,
+	the `<stash-like>` argument can be any commit that looks like a stash, for
+	example, a stash created with `create`.
 
-branch <branchname> [<stash>]::
+branch <branchname> [<stash-like>]::
 
 	Creates and checks out a new branch named `<branchname>` starting from
-	the commit at which the `<stash>` was originally created, applies the
-	changes recorded in `<stash>` to the new working tree and index, then
-	drops the `<stash>` if that completes successfully. When no `<stash>`
-	is given, applies the latest one.
+	the commit at which the `<stash-like>` was originally created, applies the
+	changes recorded in `<stash-like>` to the new working tree and index, then
+	drops the `<stash-like>` if that completes successfully and `<stash-like>`
+	is also a stash entry. When no `<stash-like>` is given, applies the latest one.
 +
 This is useful if the branch on which you ran `git stash save` has
 changed enough that `git stash apply` fails due to conflicts. Since
@@ -129,9 +132,9 @@ clear::
 	be subject to pruning, and may be impossible to recover (see
 	'Examples' below for a possible strategy).
 
-drop [-q|--quiet] [<stash>]::
+drop [-q|--quiet] [<stash-entry>]::
 
-	Remove a single stashed state from the stash list. When no `<stash>`
+	Remove a single stashed state from the stash list. When no `<stash-entry>`
 	is given, it removes the latest one. i.e. `stash@\{0}`
 
 create::
-- 
1.6.5.rc3.8.g8ba5e
