From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 3/4] wrapper: supply xsetenv and xputenv
Date: Wed, 14 Dec 2011 15:07:10 +0100
Message-ID: <1323871631-2872-4-git-send-email-kusmabite@gmail.com>
References: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, gitster@pobox.com, schwab@linux-m68k.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 15:07:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RapUm-0001jv-KR
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323Ab1LNOHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 09:07:31 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58893 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757264Ab1LNOH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 09:07:28 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id p5so326742lag.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=okqovpQ2eWCw7RSnntxVjiJdWirHPUQ/jiDId40e3h0=;
        b=lbX8kEOay6KpQkEE274RqO3BwwrjtgnPO/g1nSbwtmq4Su+ntZq2cscaXmb5xbfkTJ
         +mmlVUSEA8plGNq+JDVi6o5/3Wa0WBvrjo+dG5tZoug71xjd3zfU8qK9QPj3ZNR0zr1m
         zu39D0oZ23I7RvTeArTh7z3QM0erZaB/sHGFw=
Received: by 10.152.135.195 with SMTP id pu3mr2465514lab.17.1323871647954;
        Wed, 14 Dec 2011 06:07:27 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id pc8sm2327657lab.8.2011.12.14.06.07.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 06:07:26 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.272.g9e47e
In-Reply-To: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187114>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 git-compat-util.h |    2 ++
 wrapper.c         |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 77062ed..ab17d53 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -439,6 +439,8 @@ extern int xdup(int fd);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
+extern int xsetenv(const char *name, const char *val, int override);
+extern int xputenv(const char *string);
 extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 extern int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1);
 
diff --git a/wrapper.c b/wrapper.c
index 85f09df..8d172ac 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -381,3 +381,17 @@ int remove_or_warn(unsigned int mode, const char *file)
 {
 	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
 }
+
+int xsetenv(const char *name, const char *val, int overwrite)
+{
+	if (setenv(name, val, overwrite))
+		die_errno("setenv failed to set '%s' to '%s'", name, val);
+	return 0;
+}
+
+int xputenv(const char *string)
+{
+	if (putenv(string))
+		die_errno("putenv failed to set '%s' ", string);
+	return 0;
+}
-- 
1.7.7.1.msysgit.0.272.g9e47e
