From: Angus Hammond <angusgh@gmail.com>
Subject: [PATCH 1/2] Change error messages in ident.c Make error messages caused by failed reads of the /etc/passwd file easier to understand. Signed-off-by: Angus Hammond <angusgh@gmail.com>
Date: Thu, 10 May 2012 20:06:09 +0100
Message-ID: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
Cc: Angus Hammond <angusgh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 21:06:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSYh7-00024W-NJ
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 21:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758731Ab2EJTG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 15:06:29 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62938 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab2EJTG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 15:06:28 -0400
Received: by wibhr2 with SMTP id hr2so958705wib.1
        for <git@vger.kernel.org>; Thu, 10 May 2012 12:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yuTN05vC/P2oAMniPYtF6u1n0UCaYaecgWXCP71ToqE=;
        b=p+J5Z7ZnYdA1KXE3n2poz7/fd0HvrHPSeyoE6SRqQPII7J+h8r9qQbM7dGZO7NentM
         3JXbXk8mSjxBychPNfY2YLbUwHTU0viaxDeJ8BwYttDySuqfN2AeTFRrUlIt0g8Jk3sL
         R07m0BaF4jeRrYqfEkUdtKv7n/bwJZPo5MJxtrFAVUbPtDgWSgtxRkQv74XYQellnqu6
         RJjF4AD8k/B5ON11/3CpHru73Y23I5D1aoz/3Us47v8tf19Uh4ggKAps+yofG8wKg6UF
         GmlmPwQgPVCWMAOSiv5ddD33zp799+k0dRBHLNatCgB4azoACVetAG02hpUsG2B6+wlM
         BqVg==
Received: by 10.180.93.38 with SMTP id cr6mr301116wib.16.1336676783700;
        Thu, 10 May 2012 12:06:23 -0700 (PDT)
Received: from angus-laptop.lan (levelgrove.demon.co.uk. [62.49.19.234])
        by mx.google.com with ESMTPS id o9sm8065149wia.3.2012.05.10.12.06.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 12:06:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197616>

---
 ident.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ident.c b/ident.c
index 87c697c..51a7a73 100644
--- a/ident.c
+++ b/ident.c
@@ -46,7 +46,7 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 	if (len < sz)
 		name[len] = 0;
 	else
-		die("Your parents must have hated you!");
+		die("Your GECOS field is too long.");
 
 }
 
@@ -106,7 +106,7 @@ static void copy_email(const struct passwd *pw)
 	 */
 	size_t len = strlen(pw->pw_name);
 	if (len > sizeof(git_default_email)/2)
-		die("Your sysadmin must hate you!");
+		die("Your name field in is too long.");
 	memcpy(git_default_email, pw->pw_name, len);
 	git_default_email[len++] = '@';
 
@@ -125,7 +125,7 @@ static void setup_ident(const char **name, const char **emailp)
 	if (!*name && !git_default_name[0]) {
 		pw = getpwuid(getuid());
 		if (!pw)
-			die("You don't exist. Go away!");
+			die("Could not read your GECOS field.");
 		copy_gecos(pw, git_default_name, sizeof(git_default_name));
 	}
 	if (!*name)
@@ -142,7 +142,7 @@ static void setup_ident(const char **name, const char **emailp)
 			if (!pw)
 				pw = getpwuid(getuid());
 			if (!pw)
-				die("You don't exist. Go away!");
+				die("Could not read your GECOS field.");
 			copy_email(pw);
 		}
 	}
@@ -325,7 +325,7 @@ const char *fmt_ident(const char *name, const char *email,
 			die("empty ident %s <%s> not allowed", name, email);
 		pw = getpwuid(getuid());
 		if (!pw)
-			die("You don't exist. Go away!");
+			die("Could not read your GECOS field.");
 		strlcpy(git_default_name, pw->pw_name,
 			sizeof(git_default_name));
 		name = git_default_name;
-- 
1.7.9.5
