From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH RFC] add: Do not open editor if patch is empty
Date: Sun, 26 Apr 2015 23:03:40 +0600
Message-ID: <1430067820-3349-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 26 19:03:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmPyF-00030v-7o
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 19:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbbDZRDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 13:03:50 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:36443 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbDZRDu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 13:03:50 -0400
Received: by lagv1 with SMTP id v1so64990853lag.3
        for <git@vger.kernel.org>; Sun, 26 Apr 2015 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Fs3aqOMxaam8y7Shle73dyy24M2a/KMv86aemdNE2IY=;
        b=B4FayFqjtuRq5mKJ9a8cHlHpaKfF1GdV9+XJZBKFCu1m1saNW/5qJVhULUAila0w5I
         Y/Q7JUevTiowzbIvkiDhPVnnvLz/1DvTZfsH6Aw4Ma61RhkyTcSY+E1iBX4gkwF9q9yU
         m4WbxgaMf67iXzEZDzcXmJz3d9fbSJscQmfZddbRVhsaCXuyUxujdDvM1mPRWUh5XuFO
         BBGhBEPgv14zUaXe3jdHBSt6TKcbGrjQ5Hlks3pI8fLW9NXu2UfdTaejXAgtQlULG7la
         Q2A0nQYFn8ZZVPb0IY01jateZJCVOJt4gE3lURWwO/tEFVW+LOnv/gDBumopc5FFYkbA
         Zkaw==
X-Received: by 10.112.162.167 with SMTP id yb7mr6792119lbb.121.1430067828849;
        Sun, 26 Apr 2015 10:03:48 -0700 (PDT)
Received: from localhost.localdomain ([37.151.34.107])
        by mx.google.com with ESMTPSA id oe1sm4183352lbb.23.2015.04.26.10.03.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Apr 2015 10:03:47 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.611.g09038fc.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267830>

If we'll run 'git add -e <path>' on a path which has no
difference with the current index, empty editor will open. This
patch prevents this behaviour and checks that patch is not empty
before an editor with patch will be opened.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/add.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ee370b0..4fc6b13 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -209,13 +209,13 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	if (run_diff_files(&rev, 0))
 		die(_("Could not write patch"));
 
-	launch_editor(file, NULL, NULL);
-
 	if (stat(file, &st))
 		die_errno(_("Could not stat '%s'"), file);
 	if (!st.st_size)
 		die(_("Empty patch. Aborted."));
 
+	launch_editor(file, NULL, NULL);
+
 	child.git_cmd = 1;
 	child.argv = apply_argv;
 	if (run_command(&child))
-- 
2.3.3.611.g09038fc.dirty
