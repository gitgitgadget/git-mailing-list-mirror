From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv1/RFC 5/5] gitweb: Minify gitweb.js if JSMIN is defined
Date: Tue,  1 Sep 2009 13:39:20 +0200
Message-ID: <1251805160-5303-6-git-send-email-jnareb@gmail.com>
References: <1251805160-5303-1-git-send-email-jnareb@gmail.com>
 <1251805160-5303-2-git-send-email-jnareb@gmail.com>
 <1251805160-5303-3-git-send-email-jnareb@gmail.com>
 <1251805160-5303-4-git-send-email-jnareb@gmail.com>
 <1251805160-5303-5-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 13:32:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiRbN-0001Kk-Eh
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 13:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbZIALcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 07:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbZIALcH
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 07:32:07 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:50510 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbZIALcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 07:32:04 -0400
Received: by fxm17 with SMTP id 17so3435951fxm.37
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bGFvpaMS0gKXEpTb11mzOWipJmMu6OXzk8K7Lod7I+s=;
        b=b7e37tDXgAyoN0LiRt9cpsSemQ0SYx9bMkSEWLhXxRHlHzKm8nynlsGQJpdVnecOwy
         kMRQ7oCaYLpspzFQCwnWydbwiBk6OrmjBvyA9XPwzsRhMn0N+/WaqHNJEI8c3GPpEvv3
         etN+Z7UVBl+UAfQMej0eSM70yLbkOp71ecpVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F5Z1M77yVVUPJcl4VB/5FiJpKgP7gdU/4NzUuSquQGGdgmYaYdNB/RZ4gmX8lH04Rg
         tNKn4pmM4KwbwUF6YColxBryu93/zhem8sinVASGWCNJ3TUf56JdF0W9D9yTGEgH2yih
         HbiVTUIwPe0nlOKgDQ28Vj5ODycFZ5vOHchmM=
Received: by 10.103.125.35 with SMTP id c35mr2833005mun.30.1251804725804;
        Tue, 01 Sep 2009 04:32:05 -0700 (PDT)
Received: from localhost.localdomain (abwl209.neoplus.adsl.tpnet.pl [83.8.235.209])
        by mx.google.com with ESMTPS id j10sm4029665mue.45.2009.09.01.04.32.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 04:32:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n81BdYFh005354;
	Tue, 1 Sep 2009 13:39:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n81BdYeT005352;
	Tue, 1 Sep 2009 13:39:34 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1251805160-5303-5-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127532>

It requires that $JSMIN command can function as a filter.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is new in series.  Comments welcome.

I have not tested it extensively, but JSMIN=cat seems to work
correctly.

 Makefile |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 407b35c..f149a36 100644
--- a/Makefile
+++ b/Makefile
@@ -194,6 +194,9 @@ all::
 # memory allocators with the nedmalloc allocator written by Niall Douglas.
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
+#
+# Define JSMIN to point to JavaScript minifier that functions as
+# a filter to have gitweb.js minified.
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -246,6 +249,9 @@ lib = lib
 # DESTDIR=
 pathsep = :
 
+# JavaScript minifier invocation that can function as filter
+JSMIN =
+
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
 GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
@@ -261,7 +267,11 @@ GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
+ifdef JSMIN
+GITWEB_JS = gitweb.min.js
+else
 GITWEB_JS = gitweb.js
+endif
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -1374,8 +1384,13 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	chmod +x $@+ && \
 	mv $@+ $@
 
+ifdef JSMIN
+OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
+gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
+else
 OTHER_PROGRAMS += gitweb/gitweb.cgi
 gitweb/gitweb.cgi: gitweb/gitweb.perl
+endif
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
@@ -1426,6 +1441,11 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 	mv $@+ $@
 endif # NO_PERL
 
+ifdef JSMIN
+gitweb/gitweb.min.js: gitweb/gitweb.js
+	$(QUIET_GEN)$(JSMIN) <$< >$@
+endif # JSMIN
+
 configure: configure.ac
 	$(QUIET_GEN)$(RM) $@ $<+ && \
 	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-- 
1.6.3.3
