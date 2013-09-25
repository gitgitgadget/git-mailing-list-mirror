From: Wataru Noguchi <wnoguchi.0727@gmail.com>
Subject: [PATCH] git-compat-util.h: reduce optimization level to 1 on MinGW env.
Date: Thu, 26 Sep 2013 00:45:41 +0900
Message-ID: <1380123941-25941-1-git-send-email-wnoguchi.0727@gmail.com>
Cc: Wataru Noguchi <wnoguchi.0727@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 25 17:46:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOrHv-0003II-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 17:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017Ab3IYPp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 11:45:57 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:45798 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab3IYPp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 11:45:56 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so6181174pdj.8
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6LxXulmZDFWIyhA6l/XNYOfQDoF6wlL9UAskpX4qC/A=;
        b=MgD95n4YDRPE0sIVOd5yAvOX0kxMZFw2Ahbv92Nz+c/ojXudfPMHGKGD0hgueBedXP
         j79jALitSj+5JeVLpwUqnDg0OZQzft1vkO8dLeeVlF+0uadzuWZZFcCvygMcB0IWWdg1
         ffihJshDE2dcy7slNCdHAoKLxHnozjY20duTLH2iRmgIUTGAselTO5HR5dCy1Wa5uYgS
         sSev3vavFnpIkBlZEUDubesHXQM8XMoYcqbVBhsMSwQdsVchcT5ndP/y2xyPSyZAAho3
         93MfF2Ve5D+0GNC0JTRNAKd8Z2iMrxlkwLaLkW8eZYSP3RnQZXNvAeRuUD0IKvgnrK5e
         PQkw==
X-Received: by 10.66.141.199 with SMTP id rq7mr35480407pab.9.1380123956087;
        Wed, 25 Sep 2013 08:45:56 -0700 (PDT)
Received: from localhost.localdomain (p4168-ipbf905akatuka.ibaraki.ocn.ne.jp. [219.114.17.168])
        by mx.google.com with ESMTPSA id hx1sm48435404pbb.35.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 08:45:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235357>

Git for Windows crashes when clone Japanese multibyte repository.
- Japanese Base Encoding is Shift-JIS.
- It happens Japanese multibyte directory name and too-long directory path
- Linux(ex. Ubuntu 13.04 amd64) can clone normally.
- example repository is here:

git clone https://github.com/wnoguchi/mingw-checkout-crash.git

- The reproduce crash repository contains following file only.
  - following directory and file name is encoded for this commit log.
  - actually file name is decoded.]
  %E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%201-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%202-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%203-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%204-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%205-long-long-long-dirname/%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB%E3%81%8A%E8%AA%AD%E3%81%BF%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84.txt
- only one commit.

This commit reduce gcc optimization level from O2 to O1 when MinGW Windows environment.

Signed-off-by: Wataru Noguchi <wnoguchi.0727@gmail.com>
---
 git-compat-util.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index a31127f..394c23b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -90,6 +90,8 @@
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
+/* reduce gcc optimization level to 1 */
+#pragma GCC optimize ("O1")
 #define GIT_WINDOWS_NATIVE
 #endif
 
-- 
1.8.1.2
