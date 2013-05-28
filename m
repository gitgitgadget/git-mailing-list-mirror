From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/5] rebase: fix sequence continuation
Date: Tue, 28 May 2013 08:29:15 -0500
Message-ID: <1369747757-10192-4-git-send-email-felipe.contreras@gmail.com>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 15:31:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJzz-0007qu-NO
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934188Ab3E1NbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 09:31:24 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:53270 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934127Ab3E1NbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 09:31:09 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so10032564oag.9
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=X1QuIWPCp04/aCNohYJG51gjZrvcaB/JSEmMvuow6kQ=;
        b=RHrwmERVp9IBBQGQKWJ43wYNBN8HNHYX4YVWyF8QqQofU7+aBnANsidGr7voJ0K46N
         kQO/AdrCrgr2+Kp+laJ6SkHpiqOLG8Myr8Yp8K0qsbhWa1IwUAk+/l9jGsu8QwDMWPdK
         MMcJ5UeDQ9Ze8hpqL17osLn3R+tGzko6PfKp3c1Cf9bDbXhHyKxrz9/YC4SvS0Of5zVM
         7HOdstzrjSiDUIlUKaLcHvWK8/IFBZ1ArNJa4v+cqPfDtsOexpGufJje0CtI7FH/UX8r
         0tGDaxs57at3XHSp2o5WPlH0JBQPNUp4p9vgblN0zNAprsEvUDRroEz/bd9iQjB63gtj
         gGZg==
X-Received: by 10.60.125.201 with SMTP id ms9mr20671042oeb.65.1369747868865;
        Tue, 28 May 2013 06:31:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm34546422obb.14.2013.05.28.06.31.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 06:31:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225651>

We are not in am mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherry.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
index ab1f8b7..ca78b1b 100644
--- a/git-rebase--cherry.sh
+++ b/git-rebase--cherry.sh
@@ -5,13 +5,15 @@
 
 case "$action" in
 continue)
-	git am --resolved --resolvemsg="$resolvemsg" &&
-	move_to_original_branch
+	git cherry-pick --continue &&
+	move_to_original_branch &&
+	rm -rf "$state_dir"
 	exit
 	;;
 skip)
-	git am --skip --resolvemsg="$resolvemsg" &&
-	move_to_original_branch
+	git cherry-pick --skip &&
+	move_to_original_branch &&
+	rm -rf "$state_dir"
 	exit
 	;;
 esac
-- 
1.8.3.rc3.312.g47657de
