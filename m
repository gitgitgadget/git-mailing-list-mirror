From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/8] rebase --merge: return control to caller, for housekeeping
Date: Fri, 10 May 2013 19:56:44 +0530
Message-ID: <1368196005-5354-8-git-send-email-artagnon@gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:25:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoGY-0007V1-G6
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407Ab3EJOZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:25:31 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:38940 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab3EJOZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:25:25 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so2821669pde.18
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=WIDiPceMSgpgOrd3zzTc1hvAItUVNxv9W0WGF5bM3rg=;
        b=Xb5eu5qtHjZPLoeUX3yIAxmN19diJSR795nJKm/NdyeZzmBTPf/m93TQKNv5wu3CqN
         VJKHdo3iB4ZG0AFApBe9fB4oMJ3ensjGpqWvVCFO2mcpU6JNvxYL4JNhlOyFxxL/dSUa
         asRsXL2Rjq3SHTnwKLk73Q6I+BpbhVzOCMRMsJk4FA/AM8Ydc+jxNtdPnBt6fok6Y4K+
         /v3BiX00qLGFX4n8xHLTIfAxhGur3k6RC91jX7JXKlY6xOrM9wjEm4hsp4l9Ql/K3bLk
         8DnVeQWJbVSjXHv3A+QEY30UgK5SBGeOB5ai2SWFyuT/OaD8Fc0AVs775PuPfX3d9I9F
         7EKw==
X-Received: by 10.68.213.101 with SMTP id nr5mr17449147pbc.22.1368195925099;
        Fri, 10 May 2013 07:25:25 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id nt2sm2915928pbc.17.2013.05.10.07.25.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:25:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223845>

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
1.8.3.rc1.52.gc14258d
