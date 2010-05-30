From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] Makefile: remove redundant munging of @@INSTLIBDIR@@
Date: Sun, 30 May 2010 17:12:41 +0000
Message-ID: <1275239561-31437-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 19:19:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OImAY-00041E-5Y
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 19:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449Ab0E3RMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 13:12:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56681 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab0E3RMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 13:12:52 -0400
Received: by fxm10 with SMTP id 10so1859804fxm.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ekpd/rH9DY+GTtHOicl1ixj1+sYCeGUv9/MfInyP4vk=;
        b=w08DrWnx3+xBfiyfTq93OjRBqgQKCe8rrVxlR6f3B3jwHDO0GXpaaO4SLpRxTGTwgh
         Cl1Q/g7mYjP/N221BR2ICobQZZwjzBy2pKIMDU1YHv9PxwLHsNM0ro9ZNP3nDvKyXwxQ
         0WUIISQBak5VA9S3Lw2rXfHoDg5xdm2gyBcEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=KhHP3WP2Wo2zHWXJe57tig/YAxjcE5rIkG105PQvr8hNr8P4NQ/sG7ZV9n54sHpaIY
         rBHr89wpcDwxr/LQU6E5oU8gnrjtfHXof/MxB5ATH9Ynj6AY4nzHfIE0ZH/AlR5s71I3
         FGTp7vUXLllBbst+bgq7r3fvZyrvHUCxLw6Pw=
Received: by 10.223.127.196 with SMTP id h4mr4030671fas.56.1275239570462;
        Sun, 30 May 2010 10:12:50 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 7sm31929299far.6.2010.05.30.10.12.48
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 10:12:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.237.gf48e9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148011>

Junio originally added this in f6276fe159 for use in `unshift @INC,
'@@INSTLIBDIR@@'' in git-fmt-merge-msg.perl. That program was since
then rewritten in C in 00449f992b. And since 6fcca938b0 all Perl
programs use `use lib' to set their @INC path.

There's been no @@INSTLIBDIR@@ in any Perl script to replace since
then. So there's no reason to keep it around.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

I saw this when doing Perl/Gettext support. @@INSTLIBDIR@@ hasn't been
used for anything but the 'use lib' line there since mid-2006.

 Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d5d6565..64e30db 100644
--- a/Makefile
+++ b/Makefile
@@ -1562,11 +1562,10 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e '	h' \
-	    -e '	s=3D.*=3Duse lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "=
@@INSTLIBDIR@@"));=3D' \
+	    -e '	s=3D.*=3Duse lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "=
'"$$INSTLIBDIR"'"));=3D' \
 	    -e '	H' \
 	    -e '	x' \
 	    -e '}' \
-	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.perl >$@+ && \
 	chmod +x $@+ && \
--=20
1.7.1.237.gf48e9
