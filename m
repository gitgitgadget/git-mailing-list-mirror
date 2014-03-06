From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 3/6] merge: fix GIT_EDITOR override for commit hook
Date: Thu,  6 Mar 2014 15:50:21 +0100
Message-ID: <1394117424-29780-4-git-send-email-benoit.pierre@gmail.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 15:50:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLZdE-00058Z-Vo
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 15:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbaCFOuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 09:50:40 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:38554 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaCFOuj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 09:50:39 -0500
Received: by mail-wg0-f49.google.com with SMTP id b13so3293026wgh.32
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=WK6whpM3dSkCWZFpRckAKIn9Z6TkDuQ7vUihtwh6FHM=;
        b=DuM9aoXd8iSImYnZHj4OFm8PJZSnSO4EPyG4XUzjUeriPZbv9mO9hWKMYdPnxuKjvo
         iUZWCBdYiM3luUZ58TxxkSbirNECDLcXYveCbT/V/puNeLnrNCQSlJ5wtC6+VIWKXCxw
         vqC8trmiywQ0j8ItaI1cxHTw+HBcpIP+VIw2P3KFBIuQ/5rh1X+oS3Y5zgU02QcKfpYY
         0XC4db/9BealvtYGVc6aru7H8wN25Olqdb3FY1XKISZUo16N+QMHr9simJo3AfSoPnaY
         6HjHmI8Xh7tpLez8mQ/dAlc2CMODpn6AOgH11Tpi7P7Uw482J7y5hWniXyWZ7Wt5YJgc
         Oncg==
X-Received: by 10.194.250.34 with SMTP id yz2mr10963420wjc.18.1394117438696;
        Thu, 06 Mar 2014 06:50:38 -0800 (PST)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id bm8sm18022011wjc.12.2014.03.06.06.50.37
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2014 06:50:38 -0800 (PST)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243513>

Don't set GIT_EDITOR to ":" when calling prepare-commit-msg hook if the
editor is going to be called (e.g. with "merge -e").

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d2a1bfe..da7cafe 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -821,7 +821,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	if (0 < option_edit)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
 	write_merge_msg(&msg);
-	if (run_commit_hook(1, get_index_file(), "prepare-commit-msg",
+	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
 			    git_path("MERGE_MSG"), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
-- 
1.9.0
