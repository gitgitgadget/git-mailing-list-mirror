From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] rebase: replace antiquated sed invocation
Date: Sun, 24 Jan 2010 23:06:31 -0800
Message-ID: <1264403191-11523-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 08:06:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZJ1y-0005fy-Sl
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 08:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab0AYHGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 02:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525Ab0AYHGf
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 02:06:35 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:57448 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab0AYHGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 02:06:34 -0500
Received: by yxe17 with SMTP id 17so2538573yxe.33
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 23:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3i71SZ58YQihHxyBtX/4+Zn03hTQu0eaQEQtCFCxaRc=;
        b=LH0/PeqdrNDJOm5Ga015LKgKEre7Ypw34mOy3wCr9PkzjPv4ytUVu1K+g3RfFwBX9J
         FGzbJm2lk/WYyvjH8ri6+/W7TXZgmoZf3MAZ3IBrmafdpZK1+u28IycW55F4d+ULcCGu
         l0otDCWwvTciCiKFyoFuDLycKMj/UMrrlmC9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Th3Mx52GNjTb3ld38U2v+iW+m6MtHCeG0zn8FZxMy8hrSlHxBjl+SfGPSW0sjIk3iQ
         95J/s3MVmEwfrjIJiG0qopyH+1orQ9sshl5/y06exlrtOPudCZzOrrq64sXCV58Nti3Q
         iXBDfsDb3xtcHCGVneCPieNY+vWMXfctEOiD0=
Received: by 10.101.121.16 with SMTP id y16mr7352873anm.95.1264403194256;
        Sun, 24 Jan 2010 23:06:34 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm1549170yxe.57.2010.01.24.23.06.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 23:06:33 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137939>

Use the modern form of printing a commit subject instead of piping
the output of rev-list to sed.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 git-rebase.sh |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index eddc028..b5d9178 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -85,10 +85,8 @@ continue_merge () {
 			printf "Already applied: %0${prec}d " $msgnum
 		fi
 	fi
-	if test -z "$GIT_QUIET"
-	then
-		git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'
-	fi
+	test -z "$GIT_QUIET" &&
+	git log --format=%s -1 "$cmt"
 
 	prev_head=`git rev-parse HEAD^0`
 	# save the resulting commit so we can read-tree on it later
-- 
1.6.6.1.436.gaba7d
