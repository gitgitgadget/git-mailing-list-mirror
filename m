From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 7/8] rebase: cherry-pick: automatically commit stage
Date: Tue, 28 May 2013 23:16:39 -0500
Message-ID: <1369801000-3705-8-git-send-email-felipe.contreras@gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 06:18:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXqb-0002So-Jx
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 06:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934988Ab3E2ESn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 00:18:43 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:41492 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933908Ab3E2ESm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 00:18:42 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so11041496oag.30
        for <git@vger.kernel.org>; Tue, 28 May 2013 21:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UW3GWPVux5mMH5Q03LDHnyQWqAOH+4COlOnehz4RdAw=;
        b=Bz+ymEYoMxvlTRV5O8wlrRDEAGhRjdR0Jbgpg4GgCxKJT+3MAKzjgphzJXiYNQpY/0
         nvNU6uWEGrb1ZJexS7FuXve/8Vz5H9Q6VwD2BvX0yyLE2VKQsYae06Cm8heqBx1670Z3
         wurpLCaKm+vfAse2okbK1/N+TsTv+Y9x4qHG0w1rN4RgDCraffdpaziaOWQeoE95FEZX
         c1c/DT/94h/2Y8h1DjY55AJigwFa81H8dIK/smJcooaqREUU8vyGVz3AUMgGR1m0oUcO
         D2HDwksgGx8rURTMU1hCzmJyOhPFcYv3RwE58neVO2lkXdlrxMySaEZn3tZbQ/2eQ7Av
         N84Q==
X-Received: by 10.182.111.199 with SMTP id ik7mr543287obb.44.1369801122058;
        Tue, 28 May 2013 21:18:42 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt1sm39324547oeb.5.2013.05.28.21.18.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 21:18:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225731>

When there's changes in the staging area. Just like the other rebase
modes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index ef3224d..0fcf2e1 100644
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
 	move_to_original_branch &&
 	rm -rf "$state_dir"
-- 
1.8.3.rc3.312.g47657de
