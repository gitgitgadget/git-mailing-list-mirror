From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Makefile: promote wildmatch to be the default fnmatch implementation
Date: Thu, 30 May 2013 08:34:44 +0700
Message-ID: <1369877684-5050-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 03:35:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhrm0-0001Si-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 03:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994Ab3E3BfD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 21:35:03 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:45403 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759768Ab3E3BfA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 21:35:00 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so10130033pbb.20
        for <git@vger.kernel.org>; Wed, 29 May 2013 18:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=RB/rQbLVebwymbsympTZqPZ/8llMZBnHldxmY/Vcnn0=;
        b=Krr9UxNszd5p5On3CH34Vf1h1dL320XCB/FducpWQq9AlVm/klHftw050g3ta+1lDP
         k+9oGH9M2yaGRjZ3VfgQ7effsnlesmev/jQIRiXjNhcLPZJDeg1N3GKOxw8Rd2IPuKT3
         7vaMCFkrDfZB5yTq3+ydqGUxSbRz1s0QnqgTJqzfwL9q9pQNieaWSBlyJ0iwCIUztYkU
         w/41+AM/Vyn6Wwx+AQ/YEtKLXXodcWq6i9WQLuZLn7i3de5wRpLyfS+byHF3dLvkE8HC
         DLtdhJSKrjunT5YQ7QQZAA8LJWwAjw3Pl1gksu0IWII8l+nYJRbFgMGoCTSbmz88xGB3
         C0IQ==
X-Received: by 10.68.245.70 with SMTP id xm6mr5533815pbc.76.1369877700173;
        Wed, 29 May 2013 18:35:00 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id un15sm40485047pab.7.2013.05.29.18.34.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 29 May 2013 18:34:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 30 May 2013 08:34:53 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225907>

This makes git use wildmatch by default for all fnmatch() calls. Users
who want to use system fnmatch (or compat fnmatch) need to set
NO_WILDMATCH flag.

wildmatch is a drop-in fnmatch replacement with more features. Using
wildmatch gives us a consistent behavior across platforms. The
tentative plan is make it default with an opt-out for about 2 cycles,
then remove NO_WILDMATCH and compat/fnmatch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 0f931a2..efc8439 100644
--- a/Makefile
+++ b/Makefile
@@ -106,7 +106,7 @@ all::
 # Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
 # FNM_CASEFOLD GNU extension.
 #
-# Define USE_WILDMATCH if you want to use Git's wildmatch
+# Define NO_WILDMATCH if you do not want to use Git's wildmatch
 # implementation as fnmatch
 #
 # Define NO_GECOS_IN_PWENT if you don't have pw_gecos in struct passwd
@@ -1261,7 +1261,7 @@ ifdef NO_FNMATCH_CASEFOLD
 	COMPAT_OBJS +=3D compat/fnmatch/fnmatch.o
 endif
 endif
-ifdef USE_WILDMATCH
+ifndef NO_WILDMATCH
 	COMPAT_CFLAGS +=3D -DUSE_WILDMATCH
 endif
 ifdef NO_SETENV
--=20
1.8.2.82.gc24b958
