From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] Setup.c: PATH_MAX is the length including the Nil
Date: Wed,  5 Mar 2014 00:29:10 +0800
Message-ID: <1393950550-9668-1-git-send-email-sunheehnus@gmail.com>
Cc: Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 17:30:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKsF1-0007TG-0S
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 17:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbaCDQaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 11:30:46 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:54509 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbaCDQaq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 11:30:46 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so5359600pde.10
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 08:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xcBTYS8h/tJxAdevP2WON5orHDJCpu6c3QFkx3K6KZ8=;
        b=x+gG7UfiMQfmHppOtCz/cdEd77muOdwJ+re07zN3M78JHD5RS/7UitkZQx94BqeG2h
         81haCN34ikfGnznBelTskT/Gg9S1S7VJ6AIumg17TQybrRtQho0oj/woF6eiTjbH06qX
         lOX8/2uikmxyZ2M0uaU8aFMqNZg1sxzYLlbswzDvIvvUt8g2vsFkp2x7R0kAohFdj2wp
         jJX0Oj4Vcr0tYBXpfpfxeHBIzfszmxoDC13CQVSvR8TQ01aUPpZc3pooTMLSENOIolVX
         ErOSTpT1JmVFc3dXielIcgzf9JysE3ouoAx7yt7y8DTYe6VLMP9+41jetp/e1okBqFTg
         Ilrw==
X-Received: by 10.66.233.74 with SMTP id tu10mr511082pac.144.1393950645518;
        Tue, 04 Mar 2014 08:30:45 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id j3sm49581313pbh.38.2014.03.04.08.30.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Mar 2014 08:30:44 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243355>

Signed-off-by: Sun He <sunheehnus@gmail.com>
---

Check the limit.h of linux and find out that the MACRO
#define PATH_MAX        4096	/* # chars in a path name including nul */
So if the magic number 40 is just the size it should be. (e.g. hash code)
It may bring bugs with the length(4056) of long name(gitdirenv).
As gitdirenv could be set by GIT_DIR_ENVIRONMENT.
If it is a bug, it will almost never occur.
But I need your help to know if there is the PATH_MAX of git is the mirror of the
PATH_MAX of linux and if this fix is right?
If it was, there may be many places like "PATH_MAX + 1" could be replaced by
just "PATH_MAX". And there may be many places like this.

Cheers,
He Sun

 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index cffb6d6..1511612 100644
--- a/setup.c
+++ b/setup.c
@@ -395,7 +395,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	char *gitfile;
 	int offset;
 
-	if (PATH_MAX - 40 < strlen(gitdirenv))
+	if (PATH_MAX - 41 < strlen(gitdirenv))
 		die("'$%s' too big", GIT_DIR_ENVIRONMENT);
 
 	gitfile = (char*)read_gitfile(gitdirenv);
-- 
1.9.0.138.g2de3478.dirty
