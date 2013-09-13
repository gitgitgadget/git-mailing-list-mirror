From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] sequencer: trivial cleanup
Date: Sat, 14 Sep 2013 03:45:06 +0530
Message-ID: <1379110506-21721-1-git-send-email-artagnon@gmail.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 14 00:21:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKbje-000347-8r
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 00:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455Ab3IMWVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 18:21:01 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:45637 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab3IMWVA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 18:21:00 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so3047544pab.39
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KO0Qpk0euPgtm7UWZNwQuLRZpdUL8jGn9uNEeHfRuqQ=;
        b=sCD1KEPNlC0KJYNJ/lNj4xsfWCmlaV35T4XDaWNf+CS/pD/wpdjP/ePLv/mR0zORhj
         E0Ik8fkE6w6C55R0nmx2Y6BOlIeXyiaE6F75+cIkFTOI3SSd7TaBGkjNlmxOt21eLE5N
         KG3wKMsZtxO2s97h9XbDdkk2z+S0Jb79zioypzyGy9lRIfL0UHpzZZzgFFWCBjxYjYo6
         WM/Qrqw4b7cIRIbluszoXMWNBcSIE4iwi27MFdRr1jCUp1z6bF5FiljhZQA2RYezvU6w
         UkhL5xjk0D4qDnbjrmka6yrhvLUQeaOhzoof9hVHijX/LbaEgqjE2A+PSdl6BowauWvG
         aP0w==
X-Received: by 10.66.161.229 with SMTP id xv5mr17876064pab.87.1379110860290;
        Fri, 13 Sep 2013 15:21:00 -0700 (PDT)
Received: from localhost.localdomain ([122.164.41.186])
        by mx.google.com with ESMTPSA id mr3sm14078813pbb.27.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 15:20:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.299.gb3e7d24.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234780>

Consider that the return values of allow_empty() could either be
negative, zero, or one. However, there is no reason to be overtly
conservative about it: we might as well return positive values as well
since the callsite has no problems with it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 351548f..ae25b5b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -463,13 +463,7 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 	if (opts->keep_redundant_commits)
 		return 1;
 
-	empty_commit = is_original_commit_empty(commit);
-	if (empty_commit < 0)
-		return empty_commit;
-	if (!empty_commit)
-		return 0;
-	else
-		return 1;
+	return is_original_commit_empty(commit);
 }
 
 static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
-- 
1.8.4.299.gb3e7d24.dirty
