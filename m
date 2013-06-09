From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 29/36] rebase: cherry-pick: automatically commit stage
Date: Sun,  9 Jun 2013 14:24:43 -0500
Message-ID: <1370805890-3453-30-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHl-0003yF-MZ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab3FIT2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:11 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:52376 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab3FIT2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:28:07 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so3541484oag.2
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=S3pzp+eXVTb86XyKLbvdqyBURVQVRgtvJ9o7Hc5HRMw=;
        b=s/Y1/Cg9IHxuTqAx/sJPkvK8C38IY3z1zgM0xW6dJ7j/dpaUDzzyx9N3BLSzKD7TZr
         AELAr/lCxwsNgDsd3E1QZrKcVBjOYmzkLf3NtM7doYQULOqD6TudO7e9jMlmCvLLbFfY
         Aa13E+lSW2js1kQwwiuq5FGWDKn0EjLeFFNaD94wLEm5UvNZYQWIB05a2Qb1Zy7VxMi5
         NcVuwciyZGsC+kyEG8Wc2XGXC88uSBJk8KusuAHm+q8RwIxlbaFDExE6HcuJojsrSqpz
         EydS7ePQm7oQaeMfkT6UyqqDy6tYen+UFnakfCtX53JRyw+JTomLiGi27JoN0P5GuJJG
         gbJg==
X-Received: by 10.60.178.242 with SMTP id db18mr5531784oec.74.1370806087473;
        Sun, 09 Jun 2013 12:28:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ei16sm16247711oeb.7.2013.06.09.12.28.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:28:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227134>

When there's changes in the staging area. Just like the other rebase
modes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index be17ec4..241cda7 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -8,6 +8,12 @@ export GIT_CHERRY_PICK_HELP
 
 case "$action" in
 continue)
+	# do we have anything to commit?
+	if ! git diff-index --cached --quiet HEAD --
+	then
+		git commit --no-verify -e ||
+			die "Could not commit staged changes."
+	fi
 	git cherry-pick --continue &&
 	move_to_original_branch
 	return
-- 
1.8.3.698.g079b096
