From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 17/31] rebase: remove $branch as synonym for $orig_head
Date: Sun,  6 Feb 2011 13:43:46 -0500
Message-ID: <1297017841-20678-18-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eC-0005ZO-1G
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab1BFSqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:23 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab1BFSqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:17 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=M49yvrWzrV2S4ZmZZdx7CoCwmllN4y1GvV5FkeIWN5U=;
        b=frsdH+V5hPupzp2sd3z3ijIW/kfmtXKaEx2eYeNScdAdrIsT2C9S2SR0taOJYeM31E
         CCR0RRciCgVz0me36pJ85ey7CNr0JxWZWyxLIB8ogkWlvmR6rOtC8pK0FNIPJJXOmvBJ
         lLSBQyfkf6s4sgMess3BdqiyoTxRnTPS7gseI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xaG+YosRXeCNk8A8mRsFQk8kIVawpKJ7CoYdwEGNT7bs7gCIIAaGH0vLq+p+NNeOjo
         6YymhU6+5mhaKqD7tEwGPha8LicfAgczyTpW88s/3Z7oV06tf9P4TNqtl00aNJkJxT5C
         PZih8olxxcQI1wK+4dTpv1bUIFugKFYoosf/A=
Received: by 10.224.60.205 with SMTP id q13mr13792991qah.60.1297017976663;
        Sun, 06 Feb 2011 10:46:16 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:15 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166177>

The variables $branch and $orig_head were used as synonyms. To avoid
confusion, remove $branch. The name 'orig_head' seems more suitable,
since that is the name used when the variable is persisted.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index c8a7e4e..ed34906 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -485,10 +485,10 @@ case "$#" in
 	switch_to="$1"
 
 	if git show-ref --verify --quiet -- "refs/heads/$1" &&
-	   branch=$(git rev-parse -q --verify "refs/heads/$1")
+	   orig_head=$(git rev-parse -q --verify "refs/heads/$1")
 	then
 		head_name="refs/heads/$1"
-	elif branch=$(git rev-parse -q --verify "$1")
+	elif orig_head=$(git rev-parse -q --verify "$1")
 	then
 		head_name="detached HEAD"
 	else
@@ -506,24 +506,23 @@ case "$#" in
 		head_name="detached HEAD"
 		branch_name=HEAD ;# detached
 	fi
-	branch=$(git rev-parse --verify "${branch_name}^0") || exit
+	orig_head=$(git rev-parse --verify "${branch_name}^0") || exit
 	;;
 esac
-orig_head=$branch
 
 require_clean_work_tree "rebase" "Please commit or stash them."
 
-# Now we are rebasing commits $upstream..$branch (or with --root,
-# everything leading up to $branch) on top of $onto
+# Now we are rebasing commits $upstream..$orig_head (or with --root,
+# everything leading up to $orig_head) on top of $onto
 
 # Check if we are already based on $onto with linear history,
 # but this should be done only when upstream and onto are the same
 # and if this is not an interactive rebase.
-mb=$(git merge-base "$onto" "$branch")
+mb=$(git merge-base "$onto" "$orig_head")
 if test "$type" != interactive && test "$upstream" = "$onto" &&
 	test "$mb" = "$onto" &&
 	# linear history?
-	! (git rev-list --parents "$onto".."$branch" | sane_grep " .* ") > /dev/null
+	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
 then
 	if test -z "$force_rebase"
 	then
@@ -554,11 +553,11 @@ test "$type" = interactive && run_interactive_rebase
 # Detach HEAD and reset the tree
 say "First, rewinding head to replay your work on top of it..."
 git checkout -q "$onto^0" || die "could not detach HEAD"
-git update-ref ORIG_HEAD $branch
+git update-ref ORIG_HEAD $orig_head
 
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast-forwarded.
-if test "$mb" = "$branch"
+if test "$mb" = "$orig_head"
 then
 	say "Fast-forwarded $branch_name to $onto_name."
 	move_to_original_branch
-- 
1.7.4.rc2.33.g8a14f
