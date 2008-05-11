From: nathan spindel <nathans@gmail.com>
Subject: [PATCH] instaweb: if no httpd is specified and lighttpd doesn't exist, fall back on apache2.
Date: Sat, 10 May 2008 22:26:03 -0700
Message-ID: <1210483565-12415-1-git-send-email-nathans@gmail.com>
Cc: nathan spindel <nathans@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 07:27:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv45K-0006FW-La
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 07:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbYEKF0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 01:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbYEKF0J
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 01:26:09 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:25249 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbYEKF0I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 01:26:08 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1796151wfd.4
        for <git@vger.kernel.org>; Sat, 10 May 2008 22:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=KE7z61KZdf4tiNHQ48HMxv7uwnHy2Htd3GaShcu8o4g=;
        b=S6hsg1DPdA6Gcwek4kTr0FhtAdf2vAq79UOHw6pKjDn26Y5+1sExrratnxgMm28NmFD5ly3RT8RXf6WktOaNaOJJMv0xppqTHq/zSc6UOmJoLAO66sTUXA40hyh89dxn4Y+Speq7PCt7dAM/+Z7ysL7QMcEOCRmz8sLx3LFC/oA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aaRDi4e9CN3A6s1EGTIrev3qT11aKWLeXT7foKo7o9WDus4esvZue1qedgNvxNuChqrCfQB6radHujHQOvb5r8a+LUPufoAlRc5D4cOOSbFiTbufApVMlfiLwqaDEpWJe/U7e0LSVhuxyVaV6kHqBJN0MmxgapNjJQQvZBME1mc=
Received: by 10.142.53.20 with SMTP id b20mr2696504wfa.280.1210483567705;
        Sat, 10 May 2008 22:26:07 -0700 (PDT)
Received: from localhost ( [76.14.71.118])
        by mx.google.com with ESMTPS id 31sm14511160wff.10.2008.05.10.22.26.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 May 2008 22:26:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.179.g2fe4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81735>

Signed-off-by: nathan spindel <nathans@gmail.com>
---
 git-instaweb.sh |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 6f91c8f..b744133 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -31,8 +31,16 @@ conf="$GIT_DIR/gitweb/httpd.conf"
 
 # Defaults:
 
-# if installed, it doesn't need further configuration (module_path)
-test -z "$httpd" && httpd='lighttpd -f'
+# use lighttpd if it exists, otherwise use apache2
+if test -z "$httpd"
+then
+	if type "lighttpd" > /dev/null 2>&1;
+	then
+		httpd="lighttpd -f"
+	else
+		httpd="apache2 -f"
+	fi
+fi
 
 # any untaken local port will do...
 test -z "$port" && port=1234
-- 
1.5.5.1.179.g2fe4.dirty
