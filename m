From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 1/6] templates: Fewer subprocesses in pre-commit hook
Date: Mon, 10 Jun 2013 20:36:00 +0200
Message-ID: <1370889365-6239-2-git-send-email-richih.mailinglist@gmail.com>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 20:36:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6xI-0005Gp-7X
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab3FJSgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:36:15 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:41099 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab3FJSgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:36:14 -0400
Received: by mail-ea0-f177.google.com with SMTP id j14so5584683eak.8
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Zq8cDpZYI8VIWd/G23PvNQ/PZVcZJf3SvOntQrNtxbk=;
        b=kTt4yZIjDSc0aAHcngwntY5tOMJ3UiOw07bz91ZZXZSUAQXAM3woR//x3YV0//jtS4
         T/rcJNJxpIegvLpbfBJj9phLbgRHHRz3CwTeIZRvqSjm5wtoL0A5rnzmerRfxYsguOXf
         K5yWvt1WDxT8APWv7Drl/zixw0W0ej2OY7Lr9ymgVhpwHlsLvO5fABbZas6e3dEJV/Zu
         q+UF/S08C3kvm3DucVuEuoHk+XEVfTSBPOdxWbBwWBx4Cxfloycg67MBbPQO6tSxdyuV
         2XhxK62rU3/3K15BlqRoXku07nmT18X+ZAcEl/MNH3vdlhNfFxbiHYXPJhkGzSMGCtId
         j33g==
X-Received: by 10.14.172.194 with SMTP id t42mr2866594eel.78.1370889373376;
        Mon, 10 Jun 2013 11:36:13 -0700 (PDT)
Received: from rockhopper.fritz.box (p54998111.dip0.t-ipconnect.de. [84.153.129.17])
        by mx.google.com with ESMTPSA id ba7sm24960845eeb.0.2013.06.10.11.36.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 11:36:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227352>

Spawning a new subprocess for every line printed is inefficient.
Thus spawn only one instance of `echo`.

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 templates/hooks--pre-commit.sample |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 18c4829..126ae13 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -31,18 +31,18 @@ if [ "$allownonascii" != "true" ] &&
 	test $(git diff --cached --name-only --diff-filter=A -z $against |
 	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
 then
-	echo "Error: Attempt to add a non-ascii file name."
-	echo
-	echo "This can cause problems if you want to work"
-	echo "with people on other platforms."
-	echo
-	echo "To be portable it is advisable to rename the file ..."
-	echo
-	echo "If you know what you are doing you can disable this"
-	echo "check using:"
-	echo
-	echo "  git config hooks.allownonascii true"
-	echo
+	echo 'Error: Attempt to add a non-ascii file name.
+
+This can cause problems if you want to work
+with people on other platforms.
+
+To be portable it is advisable to rename the file.
+
+If you know what you are doing you can disable this
+check using:
+
+  git config hooks.allownonascii true
+'
 	exit 1
 fi
 
-- 
1.7.10.4
