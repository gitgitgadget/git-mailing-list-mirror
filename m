From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 19/28] rebase: cherry-pick: automatically commit stage
Date: Fri, 30 Aug 2013 00:56:13 -0500
Message-ID: <1377842182-18724-20-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmL-0007TR-C6
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab3H3GBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:50 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:56941 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3H3GBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:49 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so1774992oag.36
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cq4BKts/VtZM/WgiH+aWmGEIkMRvmCa63kj7GjY0Fs4=;
        b=08dv0JVAY4hJ0Pxb/TsmpmMaqO1RK53gKSBfibPk5+rYRxSqD5MUZb/1dxNBnz1ksX
         p6Rw6IiarUGs7IVIzFOLARTISpUxpXkKdixpyMlih/cmwKWwBF8q1B/itMSpYrKF0yCk
         bvh8I1nqbrTb6/BL1lywrn63+sLQS/dfuUnGJLRwliy+cZTZLM5m4+SMrzj/xAV57VMs
         IuKa7/QjsmAV0p93EQrZTPCOasog58LK8UfuqvTwFTEMbeG5t+BsJH3GOBP5e7wRzfCa
         WQVvBjWLQJ9Bzhm89tzLmM62ESe3MjCNPpNauegCb7D0sPZ4FStcXG4ZH0GPOtao6pxh
         nuag==
X-Received: by 10.182.96.169 with SMTP id dt9mr5428790obb.76.1377842508809;
        Thu, 29 Aug 2013 23:01:48 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm36920559oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233412>

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
1.8.4-fc
