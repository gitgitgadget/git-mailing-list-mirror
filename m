From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 03/17] gitweb: Prepare for splitting gitweb
Date: Mon, 14 Jun 2010 18:08:15 +0200
Message-ID: <1276531710-22945-4-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:10:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCEs-0002Dq-86
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab0FNQIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:08:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44776 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab0FNQIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:41 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649600fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ekDcLxXURWp+8sYQuH6EbuEzQGZ+lhm9WBegY3ask3Y=;
        b=NU7llW+JYxuiVsprqwzfP7beBuVbf/ReGqExencjMG7UpedeVcaEWj4jDcHfKOdxoJ
         D3M7t+SOC2e6Bz8HJhnrDxtnU1+wirK2VsQEEEefJUYMYuqwJu9/0lfcntrxdjLnbS1t
         q4Hx+2JoXmbOY2NXzrRl+O5sTHFKOPa8CzMJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RnVYn62xYJbAetLs1gIdX3JNsGSFhpxt1HAOBhl9YaIin79PKSoIf+UwRhcZZz7FyD
         IB8322cRTpyLH1Q/cZBgmf+5zPaTYobecpXhX4hR8UgnHAgXZdJ/CWx8eOG60Er4I/rZ
         RbzVwMb2kaQjxjJ5GgqMX21jbXF8pFW0INXZ0=
Received: by 10.223.30.130 with SMTP id u2mr5648590fac.70.1276531720852;
        Mon, 14 Jun 2010 09:08:40 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149108>

Prepare gitweb for having been split into modules that are to be
installed alongside gitweb in 'lib/' subdirectory, by adding

  use lib __DIR__.'/lib';

to gitweb.perl (to main gitweb script), and preparing for putting
modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/Makefile    |    3 +++
 gitweb/gitweb.perl |    9 +++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index d2584fe..d2401e1 100644
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
+	$(foreach mod,$(GITWEB_MODULES),$(INSTALL) -m 644 $(mod) '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(mod)';)
 
 ### Cleaning rules
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 74be92b..bb81e14 100755
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
1.7.0.1
