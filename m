From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 04/31] rebase: remove unused rebase state 'prev_head'
Date: Sun,  6 Feb 2011 13:43:33 -0500
Message-ID: <1297017841-20678-5-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:46:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9ce-0004j0-DR
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab1BFSpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:45:53 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58927 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab1BFSpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:45:51 -0500
Received: by qyk12 with SMTP id 12so3422584qyk.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=qk7iBLC4h+cZR/yChQikYvtBvgVvolvHonVhlWCV5Fo=;
        b=lt02pThsnHq9/7PxRN5ix8/7HnR9oWMJ3zwKj97//v1xtjkdreQQ39TdbhYOyEzrnd
         D7OvyVFFanAmDj10mhXhmgjTFy1R2YKpz+aO7Pqjps5FBSXLHnUwZfpjsUkM3y/urPJT
         qX5MyyQXXO+OWdR6rYBVAM9j2e747Qbmsr1Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mrKIIeiTwRbFjibZKoJC7E9CD07ti1kmFO4jy/JQMipa2Dwk/NEB1jUO06f7L8HRY2
         z96nNpbtnwjHTiXgKZ86yHqKwriHwdMtx4mM0xVRNzqwq6XWinXSB2w2D3Jq7xquLhWn
         h4KDNqi+Xj8KXZZvcVanRBBAEKfslBcCnWdT0=
Received: by 10.224.19.130 with SMTP id a2mr13347194qab.33.1297017950876;
        Sun, 06 Feb 2011 10:45:50 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.45.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:45:50 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166164>

The state stored in $GIT_DIR/rebase-merge/prev_head was introduced in
58634db (rebase: Allow merge strategies to be used when rebasing,
2006-06-21), but it was never used and should therefore be removed.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 70948bc..8c1c4ed 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -61,7 +61,6 @@ read_state () {
 	if test -d "$merge_dir"
 	then
 		state_dir="$merge_dir"
-		prev_head=$(cat "$merge_dir"/prev_head) &&
 		onto_name=$(cat "$merge_dir"/onto_name) &&
 		end=$(cat "$merge_dir"/end) &&
 		msgnum=$(cat "$merge_dir"/msgnum)
@@ -75,7 +74,6 @@ read_state () {
 }
 
 continue_merge () {
-	test -n "$prev_head" || die "prev_head must be defined"
 	test -d "$merge_dir" || die "$merge_dir directory does not exist"
 
 	unmerged=$(git ls-files -u)
@@ -109,10 +107,6 @@ continue_merge () {
 	test -z "$GIT_QUIET" &&
 	GIT_PAGER='' git log --format=%s -1 "$cmt"
 
-	prev_head=`git rev-parse HEAD^0`
-	# save the resulting commit so we can read-tree on it later
-	echo "$prev_head" > "$merge_dir/prev_head"
-
 	# onto the next patch:
 	msgnum=$(($msgnum + 1))
 	echo "$msgnum" >"$merge_dir/msgnum"
@@ -568,8 +562,6 @@ fi
 
 mkdir -p "$merge_dir"
 echo "$onto_name" > "$merge_dir/onto_name"
-prev_head=$orig_head
-echo "$prev_head" > "$merge_dir/prev_head"
 echo "$head_name" > "$merge_dir/head-name"
 echo "$onto" > "$merge_dir/onto"
 echo "$orig_head" > "$merge_dir/orig-head"
-- 
1.7.4.rc2.33.g8a14f
