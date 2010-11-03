From: martin.von.zweigbergk@gmail.com
Subject: [PATCH 4/5] rebase: remove unused rebase state 'prev_head'
Date: Wed,  3 Nov 2010 22:09:39 +0100
Message-ID: <1288818580-7576-5-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1288818580-7576-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 04 04:10:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDqDt-00024F-SR
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 04:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab0KDDKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 23:10:24 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36692 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab0KDDKO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 23:10:14 -0400
Received: by mail-qw0-f46.google.com with SMTP id 7so831090qwf.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 20:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=X2DBABtpdlYqb7MsH/yRhUQcGU7iwXxyDwEOGLRKTes=;
        b=XChR5n8qdV1tN0qOnOOEq84TJMD4hQM5IpPdqrVrvxmFgr4DNZwFVXbKD7fpDsQOVB
         +sFS2bpDpISZhUV+EasJfM3llZaZJMP+fsZffw5+FF/42tDni2pZpge7xapPXpz1OyDh
         E1anNMRlT6c3pbd1tgENmxrbIQrl5sFZXHEYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LgExAI2CcR+xrahnW95jram6V1a6Ak5WGmXA8T6zm4dJ50TL+q/JrHGya/W+mTLUss
         iIaxCL1LwwzuSpPF8TTGXmbSUzXvhbWQkfjaCvtay3f9tRPt3SmgpffftRzemMP8VUPc
         SXoDZwZrdMoxZGhr5hHB7zciklr0VQwbZwGl0=
Received: by 10.229.232.205 with SMTP id jv13mr111038qcb.68.1288840214455;
        Wed, 03 Nov 2010 20:10:14 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u2sm7746119qcq.31.2010.11.03.20.10.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 20:10:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.4.g5879b6
In-Reply-To: <1288818580-7576-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160685>

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

The rebase state 'prev_head' is not used. Remove it.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2c812b2..a7428ea 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -60,7 +60,6 @@ read_state () {
 	if test -d "$merge_dir"
 	then
 		state_dir="$merge_dir"
-		prev_head=$(cat "$merge_dir"/prev_head) &&
 		onto_name=$(cat "$merge_dir"/onto_name) &&
 		end=$(cat "$merge_dir"/end) &&
 		msgnum=$(cat "$merge_dir"/msgnum)
@@ -74,7 +73,6 @@ read_state () {
 }
 
 continue_merge () {
-	test -n "$prev_head" || die "prev_head must be defined"
 	test -d "$merge_dir" || die "$merge_dir directory does not exist"
 
 	unmerged=$(git ls-files -u)
@@ -108,10 +106,6 @@ continue_merge () {
 	test -z "$GIT_QUIET" &&
 	GIT_PAGER='' git log --format=%s -1 "$cmt"
 
-	prev_head=`git rev-parse HEAD^0`
-	# save the resulting commit so we can read-tree on it later
-	echo "$prev_head" > "$merge_dir/prev_head"
-
 	# onto the next patch:
 	msgnum=$(($msgnum + 1))
 	echo "$msgnum" >"$merge_dir/msgnum"
@@ -574,8 +568,6 @@ fi
 
 mkdir -p "$merge_dir"
 echo "$onto_name" > "$merge_dir/onto_name"
-prev_head=$orig_head
-echo "$prev_head" > "$merge_dir/prev_head"
 echo "$head_name" > "$merge_dir/head-name"
 echo "$onto" > "$merge_dir/onto"
 echo "$orig_head" > "$merge_dir/orig-head"
-- 
1.7.3.rc1.4.g5879b6
