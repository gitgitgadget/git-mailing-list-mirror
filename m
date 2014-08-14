From: Markus Hitter <mah@jump-ing.de>
Subject: Git on Mac OS X 10.4.10
Date: Thu, 14 Aug 2014 14:13:15 +0200
Message-ID: <53ECA7DB.7060407@jump-ing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 14:20:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHu0h-0006QH-BY
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 14:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbaHNMT7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2014 08:19:59 -0400
Received: from ud03.udmedia.de ([194.117.254.43]:35220 "EHLO
	mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbaHNMT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 08:19:58 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Aug 2014 08:19:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud03.udmedia.de; h=
	message-id:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; s=beta; bh=m1qHpu/9J1pms4m6aD62YOqpw
	ly42ya3wIOEVmJHJE4=; b=CIYOL1P2+QjZMt76+uKotUF6HoxJ0C5YrRigue8QU
	XlyWABF2yJLZ9DChjh8oq2/goVfXtq666vslK+ojy4AUHSRTrnGr/oS+q9kU08hs
	/BK7qCQ8TxcD4YktXKo3fzrwNVdIUc5wd4UhpymDbiDFPNo1kNBfzGjBZOGc8vKo
	kk=
Received: (qmail 30319 invoked from network); 14 Aug 2014 14:13:15 +0200
Received: from unknown (HELO ?10.0.0.102?) (ud03?291p1@134.3.201.241)
  by mail.ud03.udmedia.de with ESMTPSA (DHE-RSA-AES128-SHA encrypted, authenticated); 14 Aug 2014 14:13:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255263>

I'm new to this list, so: Hello everybody!

My backup servers run Mac OS X 10.4.10. Yes, these are old, but very
reliable and easily up to the task. And Mac OS X 10.4 is the latest OS
supported there (PowerPC G3).

Recently I tried to upgrade to v2.0.4 (from 1.7.11.4).

Issue 1: I get many of these warnings:

    LINK [many cases]
/usr/bin/ld: warning multiple definitions of symbol _regcomp
libgit.a(regex.o) definition of _regcomp in section (__TEXT,__text)
/usr/lib/gcc/powerpc-apple-darwin8/4.0.1/../../../libSystem.dylib(regco=
mp.So)
definition of _regcomp
/usr/bin/ld: warning multiple definitions of symbol _regexec
libgit.a(regex.o) definition of _regexec in section (__TEXT,__text)
/usr/lib/gcc/powerpc-apple-darwin8/4.0.1/../../../libSystem.dylib(regex=
ec.So)
definition of _regexec
/usr/bin/ld: warning multiple definitions of symbol _regfree
libgit.a(regex.o) definition of _regfree in section (__TEXT,__text)
/usr/lib/gcc/powerpc-apple-darwin8/4.0.1/../../../libSystem.dylib(regfr=
ee.So)
definition of _regfree

Is this expected?


Issue 2: I need this simple patch ...

--- compat/apple-common-crypto.h.org	2014-07-30 23:19:53.000000000 +020=
0
+++ compat/apple-common-crypto.h	2014-08-14 12:57:37.000000000 +0200
@@ -2,7 +2,7 @@
 #define OPENSSL_NO_MD5
 #define HEADER_HMAC_H
 #define HEADER_SHA_H
-#include <CommonCrypto/CommonHMAC.h>
+//#include <CommonCrypto/CommonHMAC.h>
 #define HMAC_CTX CCHmacContext
 #define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, le=
n)
 #define HMAC_Update CCHmacUpdate

=2E.. and this command sequence ...

make all
touch imap-send.o
touch git-imap-send
make all

=2E.. to get it compiling. All, except git-imap-send, obviously, which =
is
no loss for my purposes.

I tried many releases, the patch requirement started with about v1.9.1,
the git-imap-send failure somewhere between 1.8.1.6 and 1.8.4.3.

Trying to be a good Open Source citizen, how would I proceed?


Thanks,
Markus


P.S.1: error without the patch is:

In file included from git-compat-util.h:330,
                 from cache.h:4,
                 from advice.c:1:
compat/apple-common-crypto.h:5:37: error: CommonCrypto/CommonHMAC.h: No
such file or directory


P.S.2: error without faking git-imap-send is:

    CC imap-send.o
imap-send.c: In function =E2=80=98cram=E2=80=99:
imap-send.c:881: error: =E2=80=98CCHmacContext=E2=80=99 undeclared (fir=
st use in this
function)
imap-send.c:881: error: (Each undeclared identifier is reported only on=
ce
imap-send.c:881: error: for each function it appears in.)
imap-send.c:881: error: parse error before =E2=80=98hmac=E2=80=99
imap-send.c:896: error: =E2=80=98hmac=E2=80=99 undeclared (first use in=
 this function)
imap-send.c:896: error: =E2=80=98kCCHmacAlgMD5=E2=80=99 undeclared (fir=
st use in this
function)
make: *** [imap-send.o] Error 1


--=20
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
