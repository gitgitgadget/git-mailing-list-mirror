From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 2/5] gitweb: Prepare for splitting gitweb
Date: Sat,  3 Mar 2012 18:57:00 +0100
Message-ID: <1330797423-22926-3-git-send-email-jnareb@gmail.com>
References: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 18:57:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3tCx-00031I-Fd
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 18:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab2CCR5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 12:57:15 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49491 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab2CCR5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 12:57:13 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so945738eaa.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 09:57:12 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.113.205 as permitted sender) client-ip=10.213.113.205;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.113.205 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.113.205])
        by 10.213.113.205 with SMTP id b13mr1933396ebq.114.1330797432843 (num_hops = 1);
        Sat, 03 Mar 2012 09:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TBBEqNKGaZKfqxhuGW9wHB+SPxmZpoTQJO1HjSd6Ung=;
        b=RxWW6YfiouJMXi3V5Uf40kUqNt4OcUO5PIFAYf2OB5GMOgaZSr/hOztvZtVwU5lip7
         ot35+P1fW29tSfH79fzkLv90y0RCpF3QQGHziVSInMxDSADuEYtLHqCkKzgZPTRpwamy
         FVeBjfrBHY4WpZjca/a1Tne64Ep+PG0s8s45q7vYzejixxMEHXuN7AW5bEc+uSY2Lxfy
         tjZtcTan0ZMy09aaSS/i+Qn+AT95ujFF53xY6ZvZ9cEDuSM2ThVEH1xxp2qWYviLYjND
         ZxSta0S6YWF/QZRHskZjSmgIa4O2Ac8svvS0bLEvIucK/JvZbovzDGqafV73t0KgA2cF
         5yPg==
Received: by 10.213.113.205 with SMTP id b13mr1485198ebq.114.1330797432731;
        Sat, 03 Mar 2012 09:57:12 -0800 (PST)
Received: from localhost.localdomain (abwo91.neoplus.adsl.tpnet.pl. [83.8.238.91])
        by mx.google.com with ESMTPS id s48sm36973616eem.0.2012.03.03.09.57.10
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 09:57:11 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192121>

Prepare gitweb for having been split into modules that are to be
installed alongside gitweb in 'lib/' subdirectory, by adding

  use lib __DIR__.'/lib';

to gitweb.perl (to main gitweb script), and preparing for putting
modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is the beginning of splitting gitweb (with its 8000+
lines, and more than 240kB) into modules, and is useful independently
of being in this patch series.

Sidenote: it is needed for __DIR__ only here.

 gitweb/Makefile    |   14 +++++++++++++-
 gitweb/gitweb.perl |    8 ++++++++
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index cd194d0..549e7dc 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -59,6 +59,7 @@ PERL_PATH  ?= /usr/bin/perl
 bindir_SQ = $(subst ','\'',$(bindir))#'
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
 gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
+gitweblibdir_SQ = $(subst ','\'',$(gitwebdir)/lib)#'
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
 PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
 DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
@@ -178,12 +179,23 @@ test-installed:
 
 ### Installation rules
 
-install: all
+install: all install-modules
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 
+install-modules:
+	install_dirs="$(sort $(dir $(GITWEB_MODULES)))" && \
+	for dir in $$install_dirs; do \
+		test -d '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$dir' || \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$dir'; \
+	done
+	gitweb_modules="$(GITWEB_MODULES)" && \
+	for mod in $$gitweb_modules; do \
+		$(INSTALL) -m 644 $$mod '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$(dirname $$mod)'; \
+	done
+
 ### Cleaning rules
 
 clean:
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2cca2cd..22efec2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -10,6 +10,14 @@
 use 5.008;
 use strict;
 use warnings;
+
+use File::Spec;
+# __DIR__ is taken from Dir::Self __DIR__ fragment
+sub __DIR__ () {
+	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
+}
+use lib __DIR__ . '/lib';
+
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
-- 
1.7.9
