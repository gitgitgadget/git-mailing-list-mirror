From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 5/5] autoconf: don't use platform regex if it lacks REG_STARTEND
Date: Tue, 17 Aug 2010 09:24:42 +0000
Message-ID: <1282037082-12996-6-git-send-email-avarab@gmail.com>
References: <20100817080322.GA28476@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 11:26:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlIRO-0001Ud-S9
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 11:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757404Ab0HQJ0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 05:26:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62919 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341Ab0HQJ0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 05:26:17 -0400
Received: by mail-ww0-f44.google.com with SMTP id 17so844005wwi.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=x/sLXKEMuADeQ3jyKmxtJ530zabvz4zWoMUXEKKm7Pc=;
        b=MHsZUD34P+yWVwNMnmofa61LekPe5y1b2EH+U0ZL0wOBvBYibVSU6VFaKgPBBhANQP
         H7FwsHfWT8kkAnyliKP1TA+sBx6ew0TvnBT7qfyXNSKHi91JUuuH+fqENyKPRQnI8ZKa
         5IauQc7qoh1H3xX6KlwucebQPmBIX7lJzgF9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DG+mrweniJfVYk3ov7bqGy10u6U5hRvLDlmYhL741KnyCM8CYccCLDx3SXAWnTBBxC
         fECqDBtArRKarbQsuPu3w86BfXEttPpuEHI1YoAa1QH0CPOuEu15Q15OZhhuVRLjjnO1
         usE3wL9pZu3B8DJs5X1zg3gW2MeY+04GU7STI=
Received: by 10.227.146.139 with SMTP id h11mr5377701wbv.197.1282037176428;
        Tue, 17 Aug 2010 02:26:16 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm3916254weq.33.2010.08.17.02.26.13
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 02:26:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.389.gc3d0b
In-Reply-To: <20100817080322.GA28476@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153741>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

If the platform regex cannot match null bytes, we might as well
use the glibc version instead.

Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Cc: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Tested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 config.mak.in |    1 +
 configure.ac  |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index b4e65c3..67dbd3b 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -58,6 +58,7 @@ NO_INET_NTOP=3D@NO_INET_NTOP@
 NO_INET_PTON=3D@NO_INET_PTON@
 NO_ICONV=3D@NO_ICONV@
 OLD_ICONV=3D@OLD_ICONV@
+NO_REGEX=3D@NO_REGEX@
 NO_DEFLATE_BOUND=3D@NO_DEFLATE_BOUND@
 INLINE=3D@INLINE@
 SOCKLEN_T=3D@SOCKLEN_T@
diff --git a/configure.ac b/configure.ac
index 5601e8b..71ac89f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -706,6 +706,27 @@ else
 fi
 AC_SUBST(NO_C99_FORMAT)
 #
+# Define NO_REGEX if you have no or inferior regex support in your C l=
ibrary.
+AC_CACHE_CHECK([whether the platform regex can handle null bytes],
+ [ac_cv_c_excellent_regex], [
+AC_EGREP_CPP(yippeeyeswehaveit,
+	AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT
+#include <regex.h>
+],
+[#ifdef REG_STARTEND
+yippeeyeswehaveit
+#endif
+]),
+	[ac_cv_c_excellent_regex=3Dyes],
+	[ac_cv_c_excellent_regex=3Dyes])
+])
+if test $ac_cv_c_excellent_regex =3D yes; then
+	NO_REGEX=3D
+else
+	NO_REGEX=3DYesPlease
+fi
+AC_SUBST(NO_REGEX)
+#
 # Define FREAD_READS_DIRECTORIES if your are on a system which succeed=
s
 # when attempting to read from an fopen'ed directory.
 AC_CACHE_CHECK([whether system succeeds to read fopen'ed directory],
--=20
1.7.2.1.389.gc3d0b
