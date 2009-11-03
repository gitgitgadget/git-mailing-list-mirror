From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Set Makefile variables from configure
Date: Tue, 3 Nov 2009 15:54:08 -0600
Message-ID: <20091103215408.GA13720@progeny.tock>
References: <1257021695-21260-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1257269082-sup-5056@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:44:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5RBD-0000MY-Na
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 22:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbZKCVo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 16:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755045AbZKCVo3
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 16:44:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:50176 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZKCVo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 16:44:28 -0500
Received: by fg-out-1718.google.com with SMTP id d23so1523089fga.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 13:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=q/m6wrKXOOUvBRo+3NEdh+ypZ2OgjrvX/7AQmLRdjBE=;
        b=GbRXDTRQ1B5ME2J36b1G8e8h254fGED7M44EhuWvYjzcPgvxIe+m78gDxbWofM+s35
         mR61syYPNvimRiElxMvnqui5vl2SYkYqaIzPtTQPjvCV2jgDQo9FwaBoCHaSXw4az5E8
         743WxSkM/9RoMWyn6qdJbj3uboXoHXqJywYLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZyelaGB1HZSoEz7p4mJI6DZhNx+H0yf/jVMWe+lM0pFc10OLqzWChOa7NKpIlHa0nD
         QdtqrsV1OomClvcA6jrfAaTxryLlagiaqDr5LsDRIkwUXMJafMEqFfPpJ1wQZ/nkHo0H
         Xvo0KsFNcOGNGv7g1WV9MYO+r2UwiXDQJSanY=
Received: by 10.87.40.9 with SMTP id s9mr3511512fgj.11.1257284673077;
        Tue, 03 Nov 2009 13:44:33 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id l12sm881113fgb.12.2009.11.03.13.44.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 13:44:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257269082-sup-5056@ntdws12.chass.utoronto.ca>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132001>

Ben Walton wrote:
> Excerpts from Ben Walton's message of Sat Oct 31 16:41:33 -0400 2009:
=20
>> These patches add support for setting the newly created DEFAULT_EDIT=
OR
>> and DEFAULT_PAGER from the configure script.  I also tacked in
>> ETC_GITCONFIG, since I can't currently toggle this without setting a
>> command line value when building, but have need to alter it.
[...]
> Ping?  Is this useful or should I drop it?

I am not sure these patches alone would make the configuration much
easier.  The --help text means one has to check the Makefile to learn
what these options do, anyway:

--with-editor=3DVALUE	provide value for DEFAULT_EDITOR
--with-pager=3DVALUE	provide value for DEFAULT_PAGER

But then, why not just set the value directly in the Makefile, 'make'
command line, or config.mak?

Maybe something like this could help.  The help text is not carefully
written; it=E2=80=99s just a placeholder to show the idea.

 configure.ac |   56 ++++++++++++++++++++++++++++++++++++++++----------=
------
 1 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/configure.ac b/configure.ac
index f8db034..aeef08c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -68,20 +68,25 @@ else \
 	GIT_CONF_APPEND_LINE(${PACKAGE}DIR=3D$withval); \
 fi \
 ])# GIT_PARSE_WITH
+
 dnl
-dnl GIT_WITH_MAKE_VAR(withname, VAR)
-dnl ---------------------
-dnl Set VAR to the value specied by --with-$withname if --with-$withna=
me
-dnl is specified.  This is a direct way to allow setting variables in =
the
-dnl Makefile.
-AC_DEFUN([GIT_WITH_MAKE_VAR],
-[AC_ARG_WITH([$1],
- [AS_HELP_STRING([--with-$1=3DVALUE],
-		 [provide value for $2])],
- if test -n "$withval"; then \
-    AC_MSG_NOTICE([Setting $2 to $withval]); \
-    GIT_CONF_APPEND_LINE($2=3D$withval); \
- fi)])# GIT_WITH_MAKE_VAR
+dnl GIT_PARSE_VALUE(WITHNAME, VAR)
+dnl ------------------------------
+dnl For use in AC_ARG_WITH action-if-found, for tweakable values that
+dnl are not actually enabling or disabling anything.
+dnl  * Set VAR=3DARG for --with-WITHNAME=3DARG
+dnl  * Complain for --without-WITHNAME or --with-WITHNAME without ARG
+AC_DEFUN([GIT_PARSE_VALUE], [
+if test "$withval" =3D "no"; then
+	AC_MSG_ERROR([$1 cannot be disabled])
+fi
+if test "$withval" =3D "yes"; then
+	AC_MSG_WARN([You should provide a value for --with-$1])
+else
+	AC_MSG_NOTICE([Setting $2 to $withval])
+	GIT_CONF_APPEND_LINE($2=3D$withval)
+fi
+])
=20
 dnl
 dnl GIT_CHECK_FUNC(FUNCTION, IFTRUE, IFFALSE)
@@ -242,13 +247,32 @@ GIT_PARSE_WITH(iconv))
=20
 #
 # Allow user to set ETC_GITCONFIG variable
-GIT_WITH_MAKE_VAR(gitconfig, ETC_GITCONFIG)
+AC_ARG_WITH(gitconfig,
+  [AS_HELP_STRING([--with-gitconfig=3DPATH],
+                  [Use PATH instead of /etc/gitconfig.]
+                  [Interpreted by git as a path relative to the comput=
ed]
+                  [prefix at run-time.])],
+  [GIT_PARSE_VALUE(gitconfig, ETC_GITCONFIG)])
+
 #
 # Allow user to set the default pager
-GIT_WITH_MAKE_VAR(pager, DEFAULT_PAGER)
+AC_ARG_WITH(pager,
+  [AS_HELP_STRING([--with-pager=3DCMD],
+                  [Set fall-back pager to CMD instead of less.]
+                  [The fall-back pager will be used by commands such]
+                  [as git log if the user does not specify some]
+                  [preferred pager.])],
+  [GIT_PARSE_VALUE(pager, DEFAULT_PAGER)])
+
 #
 # Allow user to set the default editor
-GIT_WITH_MAKE_VAR(editor, DEFAULT_EDITOR)
+AC_ARG_WITH(editor,
+  [AS_HELP_STRING([--with-editor=3DCMD],
+                  [Set fall-back text editor to CMD instead of vi.]
+                  [The fall-back editor will be used by commands such]
+                  [as git commit if the user does not specify some]
+                  [preferred editor.])],
+  [GIT_PARSE_VALUE(editor, DEFAULT_EDITOR)])
=20
 #
 # Define SHELL_PATH to provide path to shell.
--=20
1.6.5.2
