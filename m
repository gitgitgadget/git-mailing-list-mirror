From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 04/31] rebase: remove unused rebase state 'prev_head'
Date: Tue, 28 Dec 2010 10:30:21 +0100
Message-ID: <1293528648-21873-5-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:32:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbXS-0004xT-K9
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179Ab0L1Pcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:32:31 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab0L1Pc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:29 -0500
Received: by qwa26 with SMTP id 26so9391760qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=00ygq7kwHIRW5nlNpHYV7F8gbz3x8L275+1ENiXumVQ=;
        b=OqjaJPSGl2weUEFIConkus8sT3geLd9TEZfC2JpeTknImc2Bz1lfFySZDIXfQ8Nseb
         nBEwdmBj2v2RDB5HRX3AsVjm/350zGATsov8KNP8yilZNUQiM/fKK4RRwbSNlTkqnNJx
         UgFgD0vQW2SCBaYg5pYHC5IrQOQLwmqUw/Pf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=yHOyjp14DJs+WfnMi/Tk+4QMoZDzFdcf1DLBb4iZyhE+m7zsY5WgB6+k5sEOkbcxzI
         GRkj7A8WgjwVJtwULopg0lVSAu2n+wEaYW0MBtZwjaZ/Sx6U+jo3PmgLCzgZ54Nl7EM7
         a1Jetml1yjWZz6X2/J0Hk2R5fuoCqLK0WTXDo=
Received: by 10.229.184.13 with SMTP id ci13mr11832500qcb.134.1293550348780;
        Tue, 28 Dec 2010 07:32:28 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:28 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164243>

The state stored in $GIT_DIR/rebase-merge/prev_head was introduced in
58634db (rebase: Allow merge strategies to be used when rebasing,
2006-06-21), but it was never used and should therefore be removed.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9be831e..af9bd14 100755
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
@@ -567,8 +561,6 @@ fi
 
 mkdir -p "$merge_dir"
 echo "$onto_name" > "$merge_dir/onto_name"
-prev_head=$orig_head
-echo "$prev_head" > "$merge_dir/prev_head"
 echo "$head_name" > "$merge_dir/head-name"
 echo "$onto" > "$merge_dir/onto"
 echo "$orig_head" > "$merge_dir/orig-head"
-- 
1.7.3.2.864.gbbb96
