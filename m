From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/7] rebase --merge: return control to caller, for housekeeping
Date: Sun, 12 May 2013 17:26:40 +0530
Message-ID: <1368359801-28121-7-git-send-email-artagnon@gmail.com>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 12 13:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbUtG-0002DN-Pn
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 13:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab3ELL4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 07:56:23 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:48516 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab3ELL4V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 07:56:21 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so3765360pbc.9
        for <git@vger.kernel.org>; Sun, 12 May 2013 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SbkooANyH8pwXj34uoX+tXVhA9r+qv+0ZE/o7etUrVE=;
        b=xXyKf8WSk649akc1NW+jeXdPtZnwwqaDm/o0kAwinQcDbDBfuj/LAttzjDtHdg/537
         1kd0MmFYqdNDTC2PbgC7ruDImJjCXioG8hUb1MfVJs2Czsr73F8HOq/8uV5mDHHDWr+t
         vPFL6WWBm4EgNAeytTYBmDJEqpB/huRXVsJS9LogUxHPh13PIygM6g5BUagNLctVswLO
         ofWzwKAr3Tx9vMsV/iN1M3CZOhh3A88UmUrPZJftCmKzexUAgBafC+DVZFnAtUTlrVHd
         B3JCGW3Avq+LDaO3fML4pFQTZc+6gQJ+wXfEClEjRSpqR+aYKToiz/qJiFGkUrXmGPVa
         Uihg==
X-Received: by 10.68.108.196 with SMTP id hm4mr25050383pbb.88.1368359780856;
        Sun, 12 May 2013 04:56:20 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.41])
        by mx.google.com with ESMTPSA id iy2sm9911078pbb.31.2013.05.12.04.56.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 May 2013 04:56:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.51.gd7a04de
In-Reply-To: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224040>

Return control to the caller git-rebase.sh to get these two tasks

    rm -fr "$dotest"
    git gc --auto

done by it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase--merge.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index b10f2cf..16d1817 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -96,7 +96,6 @@ finish_rb_merge () {
 			"$GIT_DIR"/hooks/post-rewrite rebase <"$state_dir"/rewritten
 		fi
 	fi
-	rm -r "$state_dir"
 	say All done.
 }
 
@@ -110,7 +109,7 @@ continue)
 		continue_merge
 	done
 	finish_rb_merge
-	exit
+	return
 	;;
 skip)
 	read_state
@@ -122,7 +121,7 @@ skip)
 		continue_merge
 	done
 	finish_rb_merge
-	exit
+	return
 	;;
 esac
 
-- 
1.8.3.rc1.51.gd7a04de
