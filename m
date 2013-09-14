From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/3] build: fix rpm versioning
Date: Sat, 14 Sep 2013 01:28:48 -0500
Message-ID: <1379140128-12397-4-git-send-email-felipe.contreras@gmail.com>
References: <1379140128-12397-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 08:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKjQu-0008M6-U4
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112Ab3INGeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:34:12 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:32950 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab3INGeI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:34:08 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so2023275oag.10
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 23:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IB68oUKZxhtj0IWAtApbf6a42asmrdfEmpg9tIeaXjc=;
        b=aZsT7VxKGviRNaJPgJnffuFdV3oRo7D+Lw4xZdyP1i3IzRcnFIoqaCOzPi1OUygRvA
         lBgsZY5ewwGO8DLW/ooJnG9L39ODqGvYHKT3A3zct48Id+U2nKi2bSxtE12ajceMwIhA
         FtxoWzzY6IjBgKt8HAarbWtd06cv33vlWdhghiIaJk1wKcofkQTsEbdJI4P8/k2GbCZR
         BeekWhEC1TRhaV/ZQ01qYO6oXT5hYUHSgw92iKGcZJ21AidMNvnhBWVjRqSIuuptO8jT
         WAuuMolBrHe+C9Rh9/9uEUVqMSkEv3eFJJU2oxXbQ4+6s5Ql/c5hIHLodvfGduU/sryB
         F7+g==
X-Received: by 10.182.181.34 with SMTP id dt2mr15660949obc.30.1379140448192;
        Fri, 13 Sep 2013 23:34:08 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xx9sm20288279obc.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 23:34:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379140128-12397-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234794>

The current versioning scheme doesn't work properly:

  git-1.8.4 < git-1.8.4.rc1
  git-1.8.4 < git-1.8.4-rc1
  git-1.8.4 > git-1.8.4~rc1

Since v1.8.4 final is obviously greater than v1.8.4-rc1, we need to use
a tilde so RPM detects it properly as a greater version number.

This works in rpm-4.10, in older versions, a tilde would work as bad as
anything else.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 3588ca1..7a8bee7 100644
--- a/Makefile
+++ b/Makefile
@@ -2426,7 +2426,7 @@ quick-install-html:
 ### Maintainer's dist rules
 
 git.spec: git.spec.in GIT-VERSION-FILE
-	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@+
+	sed -e 's/@@VERSION@@/$(subst -,~,$(GIT_VERSION))/g' < $< > $@+
 	mv $@+ $@
 
 GIT_TARNAME = git-$(GIT_VERSION)
-- 
1.8.4-fc
