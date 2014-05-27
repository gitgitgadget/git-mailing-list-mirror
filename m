From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] config: respect '~' and '~user' in mailmap.file
Date: Tue, 27 May 2014 10:45:58 +0200
Message-ID: <1401180358-27281-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 10:46:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpD1V-0007zG-1V
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 10:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaE0IqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2014 04:46:12 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:63231 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbaE0IqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 04:46:11 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so1215682wib.11
        for <git@vger.kernel.org>; Tue, 27 May 2014 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=hIidoWkqIu4e/4gRKW5+PHsjEofbSaxEqMI6uqTq82g=;
        b=04GwAdpSk9WWBhfoaXCF9lP/ACzfzw/MLwzZJtoazWx4yyHn0W0JFSN2pCGQmb+KVB
         Z8a6ShGiVygSHFIEYpgvOncpyDgTl77SbOwRRz2oDViNL5GAFM1NAs0BRVcC0Nt8bJ8c
         pdZZLEGAKNHWbrYWTQ0jUpIeloFQtuk1jo5jmMm4XDlbvRZisN2O8fIeCDuPft8dIzzY
         swfyuQJXZES0DTxsZ5XzspinA5kR+so8k4tPSydML8G0wILn4wG3sfTRb7T7vXa0EMKy
         jJSpXXaCaXWBqPLHLxmnY7ISxCn0Nsa49ZUcaLjsOKWxtCdv4I8RqgNbYJrCQ0GcsUzZ
         Tatw==
X-Received: by 10.180.185.100 with SMTP id fb4mr36034497wic.11.1401180366775;
        Tue, 27 May 2014 01:46:06 -0700 (PDT)
Received: from localhost.localdomain (80.156.189.109.customer.cdi.no. [109.189.156.80])
        by mx.google.com with ESMTPSA id s9sm6545565wix.13.2014.05.27.01.46.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 May 2014 01:46:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250158>

git_config_string() does not handle '~' and '~user' as part of the
value. Using git_config_pathname() fixes this.

Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 314d8ee..ec7af5f 100644
--- a/config.c
+++ b/config.c
@@ -963,7 +963,7 @@ static int git_default_push_config(const char *var,=
 const char *value)
 static int git_default_mailmap_config(const char *var, const char *val=
ue)
 {
 	if (!strcmp(var, "mailmap.file"))
-		return git_config_string(&git_mailmap_file, var, value);
+		return git_config_pathname(&git_mailmap_file, var, value);
 	if (!strcmp(var, "mailmap.blob"))
 		return git_config_string(&git_mailmap_blob, var, value);
=20
--=20
2.0.0.rc4
