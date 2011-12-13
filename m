From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC 1/2] wrapper: supply xsetenv
Date: Tue, 13 Dec 2011 13:10:26 +0100
Message-ID: <1323778227-1664-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 13:10:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaRC6-0002R8-Nk
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 13:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab1LMMKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 07:10:46 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57068 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029Ab1LMMKp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 07:10:45 -0500
Received: by lagp5 with SMTP id p5so2318290lag.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 04:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        bh=DlLY3LJYJ7pwnmPNMU8MC0R6FztRJ4AQG5pDlIj4Ssc=;
        b=ePrKrXB95uK3nI5G4IkUJohs5cZBwQxe5+6aL5Q+tHVCpmdn6Ebd8ilYtiHYWgyGoh
         /3lkxs/lCKGyXyCAnLMQ++SlZnAc+X0A421SzBthRkHJaCXtJqeyCgALa31OHnCeEifS
         Bbv3Xh8jVw3Bqiyn0FipvPKQhGKadVa+wLFRA=
Received: by 10.152.133.210 with SMTP id pe18mr2264570lab.19.1323778243928;
        Tue, 13 Dec 2011 04:10:43 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id nw10sm19781767lab.4.2011.12.13.04.10.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 04:10:42 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.272.g9e47e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187013>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 git-compat-util.h |    1 +
 wrapper.c         |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 77062ed..551a0be 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -439,6 +439,7 @@ extern int xdup(int fd);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
+extern int xsetenv(const char *name, const char *val, int override);
 extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 extern int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1);
 
diff --git a/wrapper.c b/wrapper.c
index 85f09df..442800b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -381,3 +381,9 @@ int remove_or_warn(unsigned int mode, const char *file)
 {
 	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
 }
+
+int xsetenv(const char *name, const char *val, int overwrite)
+{
+	if (setenv(name, val, overwrite))
+		die_errno("setenv failed");
+}
-- 
1.7.7.1.msysgit.0.272.g9e47e
