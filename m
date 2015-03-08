From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 1/2] git-compat-util.h: move SHELL_PATH default into header
Date: Sat,  7 Mar 2015 21:07:59 -0800
Message-ID: <38be9195b966a027cb050e5a1b47526@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 06:08:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUTRj-0008Fc-Ei
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 06:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbbCHFIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 00:08:06 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36582 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbbCHFIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 00:08:05 -0500
Received: by pdbnh10 with SMTP id nh10so62612017pdb.3
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 21:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/j8PEJwNMorrU1545H02ndiocRh5jVyS9ST3sPFv2vU=;
        b=L0an9NilUHx3wo61ejnhryVcsaG5IMy2xVt+PgfKDyLU79ej89N78abW0DIqCzpG5A
         DY4EJrqDk5x8uiaDodLwu9gSQMeZu/SSgg23EuoQTq5Lz2+JZkrSKiwHMMvs2LOoivju
         pmikdKyJhIJfWVJeJPMA28wZPvap1tGHmnCtvC8zTHuIEfLbuLn0Spl4QuftvW0Dwo4I
         JGntEevjvV3f2l4yRblyKySFkLqFDuimMW/b50OwhVY1oKBEvBoiU61mr/cVBLgGl7i1
         BfQ2FkG3hhCbsImk8IqGWdNrrIFUQ0OSaHiPq/PCqKrcwGSHeTlZ2c4u9Dg7TIHHwjae
         D9Ng==
X-Received: by 10.68.190.41 with SMTP id gn9mr10431759pbc.11.1425791284757;
        Sat, 07 Mar 2015 21:08:04 -0800 (PST)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id om9sm13762729pbb.34.2015.03.07.21.08.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 07 Mar 2015 21:08:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265028>

If SHELL_PATH is not defined we use "/bin/sh".  However,
run-command.c is not the only file that needs to use
the default value so move it into a common header.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 git-compat-util.h | 4 ++++
 run-command.c     | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a3095be9..fbfd10da 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -876,4 +876,8 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define USE_PARENS_AROUND_GETTEXT_N 1
 #endif
 
+#ifndef SHELL_PATH
+# define SHELL_PATH "/bin/sh"
+#endif
+
 #endif
diff --git a/run-command.c b/run-command.c
index 0b432cc9..3afb124c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -4,10 +4,6 @@
 #include "sigchain.h"
 #include "argv-array.h"
 
-#ifndef SHELL_PATH
-# define SHELL_PATH "/bin/sh"
-#endif
-
 void child_process_init(struct child_process *child)
 {
 	memset(child, 0, sizeof(*child));
---
