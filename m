From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv2] gitweb: Prepare for splitting gitweb
Date: Sun, 13 Jun 2010 00:54:33 +0200
Message-ID: <20100612225047.19225.81022.stgit@localhost.localdomain>
References: <1276251959-7948-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 13 00:55:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONZbf-0001JY-Uc
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 00:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab0FLWzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 18:55:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48339 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab0FLWzG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 18:55:06 -0400
Received: by fxm8 with SMTP id 8so1683732fxm.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 15:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=shT/vt4gMnW8d7GAKmf1eWI2oK/jleC8XmPH8aDPUqs=;
        b=x2Me9UA4b011UoRScTo926b7xsI8xPCpSSrDSPSQQ8pedNRvHPC1JrkPN68DBDyO3F
         P8Mjv5v1BlfDnxY05/rAAhdnldbODFwmR/luCHhYSewPlKH/SQMzSjRB7ukY/c6Lf3SQ
         k65c+X9feNWIBWqf/qNiflPxjEz3Mj8M9VJuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=d2wdT4lf/+xKk3JcpMPB5Ve8aMVVFgiVZweGQyi/uFtBRx1PDXkhoj4rbenNdl5DOE
         3w6PuPXWty+uYqsogQjSVnzKrBuVfaPafXdqlNWAhzA6QnbNR5C+/leobHhZHkDqYAUe
         m+2Ht4qTQQGw/S3SYhle4rgg5TTOa2+tIQIgE=
Received: by 10.86.124.35 with SMTP id w35mr6187977fgc.49.1276383304676;
        Sat, 12 Jun 2010 15:55:04 -0700 (PDT)
Received: from localhost.localdomain (abve213.neoplus.adsl.tpnet.pl [83.8.202.213])
        by mx.google.com with ESMTPS id e3sm6220260fga.4.2010.06.12.15.55.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 15:55:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5CMsXPu019296;
	Sun, 13 Jun 2010 00:54:38 +0200
In-Reply-To: <1276251959-7948-1-git-send-email-jnareb@gmail.com>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149033>

Prepare gitweb for having been split into modules that are to be
installed alongside gitweb in 'lib/' subdirectory, by adding

  use lib __DIR__.'/lib';

to gitweb.perl (to main gitweb script), and preparing for putting
modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This one actually works: tested with gitweb caching series, with
gitweb caching support split into modules.

The generated command is not very elegant, but perhaps it doesn't
matter:

  install -d -m 755 '/home/local/gitweb'
  install -m 755 gitweb.cgi '/home/local/gitweb'
  install -d -m 755 '/home/local/gitweb/static'
  install -m 644 static/gitweb.js static/gitweb.css static/git-logo.png static/git-favicon.png '/home/local/gitweb/static'
  test -d '/home/local/gitweb/lib/GitwebCache/' || install -d -m 755 '/home/local/gitweb/lib/GitwebCache/'; test -d '/home/local/gitweb/lib/GitwebCache/Capture/' || install -d -m 755 '/home/local/gitweb/lib/GitwebCache/Capture/';
  install -m 644 lib/GitwebCache/CacheOutput.pm '/home/local/gitweb/lib/GitwebCache/CacheOutput.pm'; install -m 644 lib/GitwebCache/SimpleFileCache.pm '/home/local/gitweb/lib/GitwebCache/SimpleFileCache.pm'; install -m 644 lib/GitwebCache/Capture.pm '/home/local/gitweb/lib/GitwebCache/Capture.pm'; install -m 644 lib/GitwebCache/Capture/SelectFH.pm '/home/local/gitweb/lib/GitwebCache/Capture/SelectFH.pm';

This patch is based on commit c0cb4ed (git-instaweb: Configure it to
work with new gitweb structure, 2010-05-28), which is top commit of
'ps/gitweb-soc' branch merged into next on 2010-06-03 (as commit
5db4adf).

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
index e108bbc..dd65943 100755
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
