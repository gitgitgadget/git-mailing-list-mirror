From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 29/45] rebase: cherry-pick: automatically commit stage
Date: Sun,  9 Jun 2013 11:40:41 -0500
Message-ID: <1370796057-25312-30-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlijA-0007CV-A8
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250Ab3FIQoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:15 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47945 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab3FIQoN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:13 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so8924626obb.19
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=S3pzp+eXVTb86XyKLbvdqyBURVQVRgtvJ9o7Hc5HRMw=;
        b=pL3jvnm7MT/9fn2k0utjiY6Tr+Uqj7YDOWZCm0GIj3MYzILz7pbD3DGxXmUhD6r6BB
         Fb89JBafQpNrp4Ojfye+KiXknjpTqzFrTOl1TNaQnmrhP2SwALzGNkdhLgsFeKFM2OOr
         OpP1cF24YFfVJoPXbKfJ9svi9OmJnpjiB0ps06ImKZdmV7wHnfAkB+oMXckD8VQBoTJt
         Dym0XXqERez2wAcNx//1tAFLZRJNpDts7NqUTqZJgD/uXxmWJaGFKLatDI2Czgy8G/Km
         z5n6hrYmqUjIG/Xv8WPaHMXXdFedRHrCpVn51O6Y3wSyQA42NuRxvkZ2xuzCnJZuaSzL
         EY3A==
X-Received: by 10.60.37.233 with SMTP id b9mr5435849oek.27.1370796253118;
        Sun, 09 Jun 2013 09:44:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id z5sm14938959obw.4.2013.06.09.09.44.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226998>

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
