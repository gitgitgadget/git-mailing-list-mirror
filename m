From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3/RFC] gitweb: Prepare for splitting gitweb
Date: Thu, 8 Jul 2010 09:20:33 +0200
Message-ID: <201007080920.38724.jnareb@gmail.com>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com> <7v39vustku.fsf@alter.siamese.dyndns.org> <201007080859.33958.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 09:20:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWlPl-0002B7-Ak
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 09:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152Ab0GHHUq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 03:20:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63119 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab0GHHUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 03:20:44 -0400
Received: by bwz1 with SMTP id 1so241168bwz.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 00:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=p8PMfHlOT7Hd1mehs4GEBA8OBaTuraOZz9M+EjDc954=;
        b=fizbEdtGrr6HfsQTfT+DzEzyMOon5gXRmcpHh4OXvjQAuqe34rOuSNcU2/2NFiJyju
         CjkbyIJMLOrtlFN5jwCgS2+GbU1uEg4k2wJCDrlyXVp1qRplMTtB5OzxtyMgoYQA8pTh
         S1fWIUYhVeeEryRG8/WJFxeFDzsBg3NnKI7EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xsnqj4loga8lTc/VEvqE/Faskh8LOv6Vm11jhuVYLB/ROzc0gXHEgx8ru7soIPqd79
         fraNNAAic+u9+tZDX5V7+J+2GxPgonoQZoAwaRv9sOvY0ZcN5dK7xeKjNHnmn5RMbVEK
         2NIPYp0Why7j36SpGY2lQqSsXl+YS7n9yjdgo=
Received: by 10.204.152.8 with SMTP id e8mr5985877bkw.2.1278573643076;
        Thu, 08 Jul 2010 00:20:43 -0700 (PDT)
Received: from [192.168.1.15] (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id bq20sm30996127bkb.4.2010.07.08.00.20.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 00:20:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201007080859.33958.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150544>

Prepare gitweb for having been split into modules that are to be
installed alongside gitweb in 'lib/' subdirectory, by adding

  use lib __DIR__.'/lib';

to gitweb.perl (to main gitweb script), and preparing for putting
modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from v2:
* Fixed issue with quoting value of shell variable, pointed by Junio
* Removed spurious unrelated addition of an empty line, pointed by =20
  =C3=86var

 gitweb/Makefile    |   14 +++++++++++++-
 gitweb/gitweb.perl |    8 ++++++++
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 2fb7c2d..b39d716 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -55,6 +55,7 @@ PERL_PATH  ?=3D /usr/bin/perl
 bindir_SQ =3D $(subst ','\'',$(bindir))#'
 gitwebdir_SQ =3D $(subst ','\'',$(gitwebdir))#'
 gitwebstaticdir_SQ =3D $(subst ','\'',$(gitwebdir)/static)#'
+gitweblibdir_SQ =3D $(subst ','\'',$(gitwebdir)/lib)#'
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))#'
 PERL_PATH_SQ  =3D $(subst ','\'',$(PERL_PATH))#'
 DESTDIR_SQ    =3D $(subst ','\'',$(DESTDIR))#'
@@ -145,12 +146,23 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
=20
 ### Installation rules
=20
-install: all
+install: all install-modules
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)=
'
=20
+install-modules:
+	install_dirs=3D"$(sort $(dir $(GITWEB_MODULES)))" && \
+	for dir in $$install_dirs; do \
+		test -d '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$dir' || \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$dir'; \
+	done
+	gitweb_modules=3D"$(GITWEB_MODULES)" && \
+	for mod in $$gitweb_modules; do \
+		$(INSTALL) -m 644 $$mod '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$(dirname $$m=
od)'; \
+	done
+
 ### Cleaning rules
=20
 clean:
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1f611d2..ec60a4d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -9,6 +9,14 @@
=20
 use strict;
 use warnings;
+
+use File::Spec;
+# __DIR__ is taken from Dir::Self __DIR__ fragment
+sub __DIR__ () {
+	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1])=
;
+}
+use lib __DIR__ . '/lib';
+
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
--=20
1.7.0.1
