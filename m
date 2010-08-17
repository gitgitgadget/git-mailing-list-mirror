From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/5 v2] autoconf: don't use platform regex if it lacks
 REG_STARTEND
Date: Tue, 17 Aug 2010 16:47:09 -0500
Message-ID: <20100817214709.GB2221@burratino>
References: <mtranet.20100817145038.1501455151@telekom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: j6t@kdbg.org
X-From: git-owner@vger.kernel.org Tue Aug 17 23:49:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlU1o-0005Ga-UE
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 23:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426Ab0HQVsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 17:48:53 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58849 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0HQVsw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 17:48:52 -0400
Received: by qyk33 with SMTP id 33so1202938qyk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tEmzUxgongENaN6Z+bYpbYPeHLqGFtsRWt1+AmT4QC8=;
        b=J9t1rPKKAaZu5FRzwbG4qlcytkbXl926jDb03HILjZyLIjDX4fi8bygQusMSVuuI0Y
         gX4Lhb30nci5nXFT2L7/4tc9mEezKK8dyUTRVfa7dj0cTh9PhbcyMM9s9mTPTdU3EKKL
         +qpVc7axkgB6RFhgDAg05QWxXCPFa9q/cWyMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IKhxV2Oh9t3uHLTLCIlelAh+ItBvMEEdn2LsqNTL5UcagrA8jxy+tzf5L2mVZVqtIu
         lcQy79xaJuQNVUZaAJrlVIqvpMMtrerCjMA5ybSNoBhnLon7Dwt3FIKWuWVeJkqoncI9
         PgrgGz+IzQ4/ElM9RGanZ7h7HbsQR6MTS+u5s=
Received: by 10.229.10.200 with SMTP id q8mr182393qcq.288.1282081730847;
        Tue, 17 Aug 2010 14:48:50 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q12sm2394853vcf.35.2010.08.17.14.48.48
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 14:48:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <mtranet.20100817145038.1501455151@telekom.at>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153782>

If the platform regex cannot match null bytes, we might as well
use the glibc version instead.

Cc: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
Tested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
j6t@kdbg.org wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason schrieb:
>> +[#ifdef REG_STARTEND
>> +yippeeyeswehaveit
>> +#endif
>> +]),
>> +	[ac_cv_c_excellent_regex=3Dyes],
>> +	[ac_cv_c_excellent_regex=3Dyes])
>> +])
>
> Do you have REG_STARTEND?
>=20
>   o Yes
>   o Yes
>=20
> Choose wisely! :)

Good catch.  Warning: I only tested the following with glibc.
Testing on platforms with missing or ancient regex support would
be very welcome.

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
index 5601e8b..ed0561b 100644
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
+	[ac_cv_c_excellent_regex=3Dno])
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
1.7.2.1.544.ga752d.dirty
