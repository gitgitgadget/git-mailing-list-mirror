From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH 02/11 GSoC] gitweb: Prepare for splitting gitweb
Date: Tue, 22 Jun 2010 03:30:38 +0530
Message-ID: <1277157648-6029-3-git-send-email-pavan.sss1991@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Jun 22 00:01:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQp3r-0006vS-0P
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796Ab0FUWBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:01:42 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61837 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318Ab0FUWBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:01:41 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so528092pwj.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bS/lCEot5qGQJeRi0G2GpP1A2tjqqmM61w6/wiQs3XI=;
        b=ViNAmg4Uge4zGebcTVQO+01Ce7oTGANQFYT2FgSLJrihUqE+ahtNBuC0LpNmir0iuY
         vW+65eUEfLWo0WhXt4jnPPjkajUShaqvK3hFn9mtB2UcjhDO3qjVir0ag/wEILAEufD+
         6DR0zfzTf8+NPdY69+4ZpeED9XOmU2mg9ABpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z/kNS0mf95HMbyT9LHN78BUwIilHsDhViZwJTVari7tHkrLi5wEkcE6SvrohhTym9S
         pYDVio/jAYYTPrUeeVffSr+S78wfKY9xizfqE5S6yOnxA5UaJRxSprPPeZ+1+n6JLf0g
         fWg7HcumvRC4yhi7ZOO/h+YPKA0tultHzo9kk=
Received: by 10.143.169.8 with SMTP id w8mr4047261wfo.296.1277157701008;
        Mon, 21 Jun 2010 15:01:41 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id y27sm525703wfi.17.2010.06.21.15.01.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 15:01:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.g6bbe9.dirty
In-Reply-To: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149445>

From: Jakub Narebski <jnareb@gmail.com>

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
index d2584fe..a8464a9 100644
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
1.7.1.454.g276eb9.dirty
