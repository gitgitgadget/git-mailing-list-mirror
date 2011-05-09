From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 4/6] configure: Check for libpcre
Date: Mon,  9 May 2011 23:52:06 +0200
Message-ID: <1304977928-7142-5-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 23:53:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYO7-0000Ry-P5
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 23:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab1EIVwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 17:52:46 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43749 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085Ab1EIVwo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 17:52:44 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so6215970wwa.1
        for <git@vger.kernel.org>; Mon, 09 May 2011 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=xQCool4IYTodqD0+JRQAJhdpyrXUVXz0og4/2L4y1Y0=;
        b=cZELAu/X60AotAOoqYoP3LGvEelX8sPUfUo9TeN+7Bi4+Aozzv5UtwdxCqjdZAx9ue
         Ndh63/0CzOfUYhGuxRwOLlJ44Hp8sMisFNzrFu75SQvJVHPGs+7DA6Wi8tNC2+9Qlg0o
         00FHx168t7v7jTSCeWmDycDs5tGhpI9VPFUyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wUWT+YinyDJag5s2hHzXj1ytWNxfAmNC/7Q1+2VuqkGbM8dpgpb9YSUb9jqskj9YXW
         7sywiSbDZnDrbmvabMEkQcqyexFN9xutZKtanLDcuK1n6pJEsz5O6RM+VlxNv7zN4AMA
         pOLmc+/3N+20xYfsLTH3oDgIlk/G7L/iEVIOA=
Received: by 10.216.229.149 with SMTP id h21mr3190691weq.67.1304977963838;
        Mon, 09 May 2011 14:52:43 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id ed10sm4016945wbb.49.2011.05.09.14.52.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 14:52:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173258>

This patch adds checks for libpcre to configure. By default libpcre is
disabled, --with-libpcre enables it (if it works).

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 config.mak.in |    1 +
 configure.ac  |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index e378534..f30130b 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -61,6 +61,7 @@ NO_INET_PTON=3D@NO_INET_PTON@
 NO_ICONV=3D@NO_ICONV@
 OLD_ICONV=3D@OLD_ICONV@
 NO_REGEX=3D@NO_REGEX@
+USE_LIBPCRE=3D@USE_LIBPCRE@
 NO_DEFLATE_BOUND=3D@NO_DEFLATE_BOUND@
 INLINE=3D@INLINE@
 SOCKLEN_T=3D@SOCKLEN_T@
diff --git a/configure.ac b/configure.ac
index fafd815..048a1d4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -220,6 +220,27 @@ AS_HELP_STRING([--with-openssl],[use OpenSSL libra=
ry (default is YES)])
 AS_HELP_STRING([],              [ARG can be prefix for openssl library=
 and headers]),\
 GIT_PARSE_WITH(openssl))
 #
+# Define USE_LIBPCRE if you have and want to use libpcre. git-grep wil=
l be
+# able to use Perl-compatible regular expressions.
+#
+# Define LIBPCREDIR=3D/foo/bar if your libpcre header and library file=
s are in
+# /foo/bar/include and /foo/bar/lib directories.
+#
+AC_ARG_WITH(libpcre,
+AS_HELP_STRING([--with-libpcre],[support Perl-compatible regexes (defa=
ult is NO)])
+AS_HELP_STRING([],           [ARG can be also prefix for libpcre libra=
ry and headers]),
+if test "$withval" =3D "no"; then \
+	USE_LIBPCRE=3D; \
+elif test "$withval" =3D "yes"; then \
+	USE_LIBPCRE=3DYesPlease; \
+else
+	USE_LIBPCRE=3DYesPlease; \
+	LIBPCREDIR=3D$withval; \
+	AC_MSG_NOTICE([Setting LIBPCREDIR to $withval]); \
+	GIT_CONF_APPEND_LINE(LIBPCREDIR=3D$withval); \
+fi \
+)
+#
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
@@ -435,6 +456,25 @@ AC_SUBST(NEEDS_SSL_WITH_CRYPTO)
 AC_SUBST(NO_OPENSSL)
=20
 #
+# Define USE_LIBPCRE if you have and want to use libpcre. git-grep wil=
l be
+# able to use Perl-compatible regular expressions.
+#
+
+if test -n "$USE_LIBPCRE"; then
+
+GIT_STASH_FLAGS($LIBPCREDIR)
+
+AC_CHECK_LIB([pcre], [pcre_version],
+[USE_LIBPCRE=3DYesPlease],
+[USE_LIBPCRE=3D])
+
+GIT_UNSTASH_FLAGS($LIBPCREDIR)
+
+AC_SUBST(USE_LIBPCRE)
+
+fi
+
+#
 # Define NO_CURL if you do not have libcurl installed.  git-http-pull =
and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
--=20
1.7.3.4
