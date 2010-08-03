From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] perl/Makefile: Unset INSTALL_BASE when making perl.mak
Date: Tue,  3 Aug 2010 10:30:11 +0000
Message-ID: <1280831411-4511-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 12:30:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgElO-0008AZ-HA
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 12:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab0HCKaV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 06:30:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33133 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253Ab0HCKaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 06:30:20 -0400
Received: by wyb39 with SMTP id 39so4218814wyb.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ssvkMubRJbCnNfkEAytft4JRLrcM3EH3ds97S+dgf5g=;
        b=R9SchPMatpTIJrocgEYVraXd00nlEJTGTHnlRx209OMqIV2bTsL2VatBZEKGJ6Xn2d
         kz/g57HYXJ8l2V3TuGKk+WahQsXLKuyj9yPejuSr8pKdTEW7f/kROqIZqZzsOlGNxjck
         WW7sn94gXe1I3rH5zkdcBJO3QW3bhe47qMsy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=RCRIYGGAg8Y63BMLM+odSHhSj0NmLtjkXXIOp/EtcsOYyBKOkJ4TYnhM5lucqj5nBa
         y/Ojt22Csr7gbYlwLzaAHvTxlXmLtwZU6SvBja/6amOXoyz5A8dxYGNNbYQ4kef82mLo
         /qHoSUB0rux7qs8cC0yZIWf3XDfXaea/l83k0=
Received: by 10.227.134.85 with SMTP id i21mr6089497wbt.127.1280831419624;
        Tue, 03 Aug 2010 03:30:19 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm5928514wbe.23.2010.08.03.03.30.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 03:30:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152499>

PREFIX and INSTALL_BASE are mutually exclusive. If both are supplied
by INSTALL_BASE being set in PERL_MM_OPT ExtUtils::MakeMaker will
produce an error:

    $ echo $PERL_MM_OPT
    INSTALL_BASE=3D/home/avar/perl5
    $ make -C perl  PERL_PATH=3D'/usr/bin/perl' prefix=3D'/home/avar' p=
erl.mak
    make: Entering directory `/home/avar/g/git/perl'
    /usr/bin/perl Makefile.PL PREFIX=3D'/home/avar'
    Only one of PREFIX or INSTALL_BASE can be given.  Not both.
    make: *** [perl.mak] Error 255
    make: Leaving directory `/home/avar/g/git/perl'

Change the perl Makefile to work around this by explicitly unsetting
INSTALL_BASE.

INSTALL_BASE is set in PERL_MM_OPT by e.g. the popular local::lib
package, from its documentation:

    eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib 2>/dev/null)

Many other environments might also have set PERL_MM_OPT before
building Git. This change enables us to build in these environments.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 perl/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index 4ab21d6..a2ffb64 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -38,7 +38,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo '	echo $(instdir_SQ)' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
-	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)'
+	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)' INSTALL_BASE=3D''
 endif
=20
 # this is just added comfort for calling make directly in perl dir
--=20
1.7.1
