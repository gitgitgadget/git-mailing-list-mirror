From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] autoconf: Add checking for unsetenv function
Date: Fri, 18 Jan 2008 02:03:51 +0100
Message-ID: <1200618231-28675-1-git-send-email-jnareb@gmail.com>
References: <20080117141143.38a88c7a@pc09.procura.nl>
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	"Junio C Hamano" <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 18 01:59:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFfa0-0001C3-Ox
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 01:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723AbYARA7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 19:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754781AbYARA7C
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 19:59:02 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:50451 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbYARA7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 19:59:00 -0500
Received: by ug-out-1314.google.com with SMTP id z38so415752ugc.16
        for <git@vger.kernel.org>; Thu, 17 Jan 2008 16:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5MgmXQmeSIGmHvbdWT3+yMUu612UY0JSWK/9fzGq+C8=;
        b=YRKs4s5NboxbyVgfFNYxBu45e51yuLkwF8j9ho1eunmnMkhs6ZLZ5F7o+EgI4wnlu3EfONu1hNtIH8bhYl0MjtrpgVHOd1nxSq6iOZdFfZswnGf0Sro72qXBo23GxS4o/M3O5N8NHNYob66Sn8xEVYifn1MCYCQvcXSP5ItnLMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LE5p/ySyFYJqpSPPlzwNTlPNBtGuj5Fps7IEmDsx5SELeZxLyvWEatjUyKQj/alhPb73gdjmyvLUvn/RG3xJgOrFV+f1WgiySin68npTj1VXlNFQcj/zzLWavfSe9ipwPj2KEB9zlBjjHL7q13PqxA1DwAfUdwU50mOpYF70smk=
Received: by 10.66.255.7 with SMTP id c7mr416415ugi.43.1200617938731;
        Thu, 17 Jan 2008 16:58:58 -0800 (PST)
Received: from roke.D-201 ( [83.8.209.38])
        by mx.google.com with ESMTPS id k2sm3308613ugf.12.2008.01.17.16.58.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Jan 2008 16:58:57 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0I13qWe028690;
	Fri, 18 Jan 2008 02:03:53 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0I13pBB028689;
	Fri, 18 Jan 2008 02:03:51 +0100
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <20080117141143.38a88c7a@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70943>

Update configure.ac (and config.mak.in) by adding test for unsetenv
(NO_UNSETENV).  Add comment about NO_UNSETENV to Makefile header, as
original commit 731043fd adding compat/unsetenv.c didn't do that.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
> * Failure of the configure/make to handle the lack of unsetenv() in
>   pre-11.31 HP-UX releases. Bizarrely, it does handle the lack of setenv()
>   and also has a compat/unsetenv.c for use by non-unsetenv()-capable OS'es,
>   but then configure and config.mak.in completely fail to use a NO_UNSETENV
>   variable like they should!

I'm sorry for that. When I was checking which tests were missing from
configure.ac I have examined only Makefile header... and there was no
note about NO_UNSETENV there.

But the above comment I think also means that the uname base "guessage"
system in Makefile didn't catch that. You probably would want to modify
Makefile in that direction too; currently "guessage system" sets
NO_UNSETENV for and SunOS 5.8, SunOS 5.9, and you probably would want
to use it also for (older?) HP-UX.

 Makefile      |    2 ++
 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 82e9cd6..f35e269 100644
--- a/Makefile
+++ b/Makefile
@@ -38,6 +38,8 @@ all::
 #
 # Define NO_SETENV if you don't have setenv in the C library.
 #
+# Define NO_UNSETENV if you don't have unsetenv in the C library.
+#
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
 #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
diff --git a/config.mak.in b/config.mak.in
index 15fb26c..40b14d9 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -40,6 +40,7 @@ NO_MEMMEM=@NO_MEMMEM@
 NO_STRLCPY=@NO_STRLCPY@
 NO_STRTOUMAX=@NO_STRTOUMAX@
 NO_SETENV=@NO_SETENV@
+NO_UNSETENV=@NO_UNSETENV@
 NO_MKDTEMP=@NO_MKDTEMP@
 NO_ICONV=@NO_ICONV@
 OLD_ICONV=@OLD_ICONV@
diff --git a/configure.ac b/configure.ac
index 6f641e3..af177fd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -356,6 +356,12 @@ AC_CHECK_FUNC(setenv,
 [NO_SETENV=YesPlease])
 AC_SUBST(NO_SETENV)
 #
+# Define NO_UNSETENV if you don't have unsetenv in the C library.
+AC_CHECK_FUNC(unsetenv,
+[NO_UNSETENV=],
+[NO_UNSETENV=YesPlease])
+AC_SUBST(NO_UNSETENV)
+#
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
 AC_CHECK_FUNC(mkdtemp,
 [NO_MKDTEMP=],
-- 
1.5.3.7
