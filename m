From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 17/31] rebase: remove $branch as synonym for $orig_head
Date: Tue, 28 Dec 2010 10:30:34 +0100
Message-ID: <1293528648-21873-18-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYp-0005Wr-8G
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab0L1PdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:14 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48315 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab0L1Pcx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:53 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so10443701qyk.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=P72e2ytPxDQ6op5aLUjNJ5pJdKfDYIU9PVrY0xf0R+8=;
        b=RYPSI+x+MzAsrebkoCJ/rV0bO23iDvboBHm92lf+dER750TpnJUFle3JsJoHkLXVTU
         Ta6ZJypnPF3hE7dVibAcLZ3EUI9+vWIGtI0fBZRQXuBfPgEN4lLNDPSYZfjT2EZAxXDe
         NrSBqOHfXp9UNddIbtLeqUo+IXHbYwN+COJ0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QoHw5seAU7FEhSuRmzUPodVf6+xnQyDgs9xAG/79EAcp+oaRLUGygEhm0NmVv3+EKg
         FpQunXC5u9F6JEybzUKpo+cQ6fvcftuUMBTB5y1lBDJSTwae8cXqflgnJOwsWQKxCoZG
         NkAljZaig5ZXiveHtTg+/tpHoHUs2abiolRZg=
Received: by 10.229.83.198 with SMTP id g6mr12290104qcl.157.1293550372847;
        Tue, 28 Dec 2010 07:32:52 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:52 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164256>

The variables $branch and $orig_head were used as synonyms. To avoid
confusion, remove $branch. The name 'orig_head' seems more suitable,
since that is the name used when the variable is persisted.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 0fc580a..eae2f7a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -487,10 +487,10 @@ case "$#" in
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
@@ -507,24 +507,23 @@ case "$#" in
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
@@ -555,11 +554,11 @@ test "$type" = interactive && run_interactive_rebase
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
1.7.3.2.864.gbbb96
