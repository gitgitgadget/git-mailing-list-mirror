From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCHv2 GSOC 02/11] gitweb: Prepare for splitting gitweb
Date: Thu, 15 Jul 2010 12:59:02 +0530
Message-ID: <1279178951-23712-3-git-send-email-pavan.sss1991@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Thu Jul 15 09:29:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZIt2-00035s-VV
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 09:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab0GOH33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 03:29:29 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57044 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab0GOH32 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 03:29:28 -0400
Received: by pwi5 with SMTP id 5so155754pwi.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 00:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PQ2tzbczqeQ4IrRBr4XV6/IQqqKrt1xXzdEmFzPUMls=;
        b=ft+IcRXZgbg3XPocwr+aimTr5Ka+Y5ZS89s0v4VDIZAkG/53jbSBPICxpW2WhHDAma
         EsS5UGEStbbgyvIzT03wiu4BX6s8ya9zwCr4e7m9mvdI9NSq4vwO+BjjyQHLp/13uFMu
         5H0jK0vU2LgE+qF07Bvau9AQqqKpRDTbIA86k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QignFC0DIPZO4oPHEcS4uGRWLBSJMsk+x71ObxLXSf8MeUuSyFRwENUrZyyUfw+CO4
         4JG6T3CfziOauSeSQdzRqy+rs6IUfXVR9Re19wIVy5CfFrX4x2zH1yQstEjufOIg0jYr
         s5m+mXSxUipxCm0ZjAcBrLX5kBGWRc5pdy1zA=
Received: by 10.142.180.20 with SMTP id c20mr4985384wff.134.1279178967598;
        Thu, 15 Jul 2010 00:29:27 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id l29sm8484428rvb.7.2010.07.15.00.29.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 00:29:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.455.g8f441
In-Reply-To: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151049>

Prepare gitweb for having been split into modules that are to be
installed alongside gitweb in 'lib/' subdirectory, by adding

  use lib __DIR__.'/lib';

to gitweb.perl (to main gitweb script), and preparing for putting
modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile    |    3 +++
 gitweb/gitweb.perl |    9 +++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index d2584fe..c7610b3 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -55,6 +55,7 @@ PERL_PATH  ?= /usr/bin/perl
 bindir_SQ = $(subst ','\'',$(bindir))#'
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
 gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
+gitweblibdir_SQ = $(subst ','\'',$(gitwebdir)/lib)#'
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
 PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
 DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
@@ -150,6 +151,8 @@ install: all
 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
+	$(foreach dir,$(sort $(dir $(GITWEB_MODULES))),test -d '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(dir)' || $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(dir)';)
+	$(foreach mod,$(GITWEB_MODULES),$(INSTALL) -m 644 $(mod) '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(dir $(mod))';)
 
 ### Cleaning rules
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 518328f..bda7da3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -9,6 +9,14 @@
 
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
@@ -16,6 +24,7 @@ use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
+
 binmode STDOUT, ':utf8';
 
 our $t0;
-- 
1.7.1.455.g8f441
