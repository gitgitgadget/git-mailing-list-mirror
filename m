From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH] Get format-patch to show first commit after root commit
Date: Fri,  9 Jan 2009 13:35:25 -0600
Message-ID: <1231529725-19767-1-git-send-email-nathan.panike@gmail.com>
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 20:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLNAD-00043Y-6X
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 20:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbZAITfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 14:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbZAITfi
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 14:35:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:57873 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbZAITfh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 14:35:37 -0500
Received: by ug-out-1314.google.com with SMTP id 39so56832ugf.37
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 11:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=8nlx4r9xXmbpjxqDjz6EVYWclyc+BTCgwAG0/kIYIOk=;
        b=tQxVQzWB1cstu0gzWLe4eb3Mzwi5dHPhuJF1YJnPSAek7a1vPzb3lSHIbBQGTkl1JA
         8jfJQbmQT/W2YwataLHJ1wa7G4RUOliaNqfqzOpvUnbao97Fxf3OdBaFt2o1HNWXqVlr
         3k4qo7vfWkkpvkXY/okQkwByZNeZQCCg6hTDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=waM5gJ4FpJK/9t90+bRI4Gidnf1mh/HK5sngUu48pOJ8QPjWpqFUMnbcGM/PHnS0uW
         Xeo6ZUe+zyDQOauApucEA3Yk0nI6aqt0rj/NE2Djprio7VFI0vAlyFHHaeD/xTRWGvk3
         dZ5KixpGHlKoBd+Zej02yUdRTwm4sl7Fu7ATU=
Received: by 10.67.95.1 with SMTP id x1mr15198757ugl.17.1231529735783;
        Fri, 09 Jan 2009 11:35:35 -0800 (PST)
Received: from localhost (dyn-108-77.uwnet.wisc.edu [72.33.108.77])
        by mx.google.com with ESMTPS id b39sm63517247ugf.38.2009.01.09.11.35.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 11:35:35 -0800 (PST)
X-Mailer: git-send-email 1.6.1.76.gc123b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105033>

Currently, the command

git format-patch -1 e83c5163316f89bfbde

in the git repository creates an empty file.  Instead, one is
forced to do

git format-patch -1 --root e83c5163316f89bfbde

This seems arbitrary.  This patch fixes this case, so that

git format-patch -1 e83c5163316f89bfbde

will produce an actual patch.
---
 builtin-log.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 4a02ee9..5e7b61f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -977,6 +977,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		list[nr - 1] = commit;
 	}
 	total = nr;
+	if (total == 1 && !list[0]->parents)
+		rev.show_root_diff=1;
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;
 	if (numbered)
-- 
1.6.1.76.gc123b.dirty
