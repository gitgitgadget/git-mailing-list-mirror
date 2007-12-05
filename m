From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed,  5 Dec 2007 16:45:26 +0100
Message-ID: <1196869526-2197-1-git-send-email-jnareb@gmail.com>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 16:46:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzwRp-0003hf-6N
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 16:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbXLEPpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 10:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbXLEPpk
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 10:45:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:60977 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbXLEPpi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 10:45:38 -0500
Received: by nf-out-0910.google.com with SMTP id g13so3163382nfb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 07:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/0SaBQzIfLKRC6WK+MVizU0lAzyOADrgLVOUJecZDt4=;
        b=LAxRJzQwS5aTGaM8f+FDE1CFIGzUogBF2GzoGJ1KKErcpkMfKgviuE9Z2zjpFYXYkXsGELlgFiJnar94flzFuSJZBDezLcYRGuGUhUAFh9Boni1NXt3Kzvti6LaWJqYZ6Rb2Jq12HUXkhvP4e8yTKSOQsmWQHWOwTcQ62VKxhzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I/TxKS+FG3WHA1JBJsD/MopLwX3XaLe396MCXQLhXOrYW2aP0Rg6VcusqrphhoVsBwzWm6EbaXI/Ds6ZEZgqyzpJLQByDxhUWKciKSlSXbp1bF/oCkQMPW7H7Dl+acnsmLzojujLMoEZ1TFcfjidx8uKs5KPKvTHkBMQLS4z27I=
Received: by 10.86.51.2 with SMTP id y2mr606521fgy.1196869536961;
        Wed, 05 Dec 2007 07:45:36 -0800 (PST)
Received: from roke.D-201 ( [83.8.215.161])
        by mx.google.com with ESMTPS id d4sm5921205fga.2007.12.05.07.45.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 07:45:35 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB5FjUft002212;
	Wed, 5 Dec 2007 16:45:31 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB5FjRLo002211;
	Wed, 5 Dec 2007 16:45:27 +0100
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67162>

Update configure.ac (and config.mak.in) to keep up with git
development by adding [compile] test whether your library has
an old iconv(), where the second (input buffer pointer) parameter
is declared with type (const char **) (OLD_ICONV).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch needs checking if it correctly sets OLD_ICONV
when needed.  I have checked only that it is not set when
with new iconv() declaration.  Could people using Cygwin
(and other with OLD_ICONV: Darwin) test it?

I should probably used AC_LANG_PROGRAM like for NO_C99_FORMAT instead
of generating whole programlet^W test program by hand (I hope that for
example I haven't missed some header file which needs to be included);
I have followed example for NO_ICONV / NEEDS_LIBICONV and
NO_DEFLATE_BOUND test.  I'm also not sure if I have put this test in
the correct autoconf section, but that is probably matter of taste.

P.S. Is there any convention on where to use YesPlease, and where
UnfortunatelyYes when setting Makefile build configuration variables?

 config.mak.in |    1 +
 configure.ac  |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 11d256e..7d5df9b 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -41,4 +41,5 @@ NO_STRTOUMAX=@NO_STRTOUMAX@
 NO_SETENV=@NO_SETENV@
 NO_MKDTEMP=@NO_MKDTEMP@
 NO_ICONV=@NO_ICONV@
+OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
diff --git a/configure.ac b/configure.ac
index 5f8a15b..5d2936e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -212,6 +212,27 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
 
 
 ## Checks for header files.
+AC_MSG_NOTICE([CHECKS for header files])
+#
+# Define OLD_ICONV if your library has an old iconv(), where the second
+# (input buffer pointer) parameter is declared with type (const char **).
+AC_DEFUN([OLDICONVTEST_SRC], [[
+#include <iconv.h>
+
+int main(void)
+{
+	iconv_t cd;
+	char *ibp, *obp;
+	size_t insz, outsz;
+	iconv(cd, &ibp, &insz, &obp, &outsz);
+}
+]])
+AC_MSG_CHECKING([for old iconv()])
+AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
+	[AC_MSG_RESULT([no])],
+	[AC_MSG_RESULT([yes])
+	OLD_ICONV=YesPlease])
+AC_SUBST(OLD_ICONV)
 
 
 ## Checks for typedefs, structures, and compiler characteristics.
-- 
1.5.3.6
