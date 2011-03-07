From: Michal Rokos <rokos@nextsoft.cz>
Subject: [PATCH] Honor HP C's noreturn attribute
Date: Mon, 7 Mar 2011 13:13:15 +0100
Message-ID: <32EABE0E-2447-4189-A3CE-05B68A5E18EF@nextsoft.cz>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 07 13:13:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZJZ-0002Kh-SB
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab1CGMNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 07:13:25 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:41016 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab1CGMNY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 07:13:24 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 44BBC2AD0; Mon,  7 Mar 2011 13:13:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 0182AB0C
	for <git@vger.kernel.org>; Mon,  7 Mar 2011 13:13:20 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pxn8rmgMuHBQ for <git@vger.kernel.org>;
	Mon,  7 Mar 2011 13:13:19 +0100 (CET)
Received: from [10.20.0.58] (unknown [10.20.0.58])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTPSA id 109F32B6
	for <git@vger.kernel.org>; Mon,  7 Mar 2011 13:13:18 +0100 (CET)
X-Mailer: Apple Mail (2.1082)
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168577>

HP C for Integrity servers (Itanium) gained support for noreturn attrib=
ute sometime in 2006. It was released in Compiler Version A.06.10 and m=
ade available in July 2006.

The __HP_cc define detects the HP C compiler version. Precede the __GNU=
C__ check so it works well when compiling with HP C using -Agcc option =
that enables partial support for the GNU C dialect. The -Agcc defines t=
he __GNUC__ too.

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

diff --git a/git-compat-util.h b/git-compat-util.h
index 9c23622..bf947b1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -214,7 +214,10 @@ extern char *gitbasename(char *);
 #define is_dir_sep(c) ((c) =3D=3D '/')
 #endif
=20
-#ifdef __GNUC__
+#if __HP_cc >=3D 61000
+#define NORETURN __attribute__((noreturn))
+#define NORETURN_PTR
+#elif defined(__GNUC__)
 #define NORETURN __attribute__((__noreturn__))
 #define NORETURN_PTR __attribute__((__noreturn__))
 #elif defined(_MSC_VER)

--

Michal Rokos

NextSoft spol. s r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
Czech Republic
mobile: +420 736 646 591
fax:    +420 267 224 307
e-mail: rokos@nextsoft.cz
