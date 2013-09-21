From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH/RFC 2/7] ruby: add setup script
Date: Sat, 21 Sep 2013 13:48:10 -0500
Message-ID: <1379789295-18519-3-git-send-email-felipe.contreras@gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 20:53:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSJZ-0000Wi-P0
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 20:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab3IUSxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 14:53:55 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:47300 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab3IUSxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 14:53:54 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so2119781obc.34
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=93+5Zy05P3gDZ26ee5DxZzvcOpmkSlOCpTtV9ALA0fs=;
        b=GyyaJkGFIddQdewxOb9x6QkiHPMxZkTOQeAhQiwAd34icG9+CJrPRg/R/lLREKU8od
         Ad4WIMbec9jTRK6ZxavIZFlmOI+LvT8pBMiSyKBFLIfB4Mx5UbldzB6EVnHGhxMwPr12
         HZyBf2CmF+fsxqVD3zQ9sE5KxoFkVQnUHrAlU/RLow30pRJSfWfFALNrAXYEL4KYQUG9
         Gbs8VV6JKlciXuenA0TRTSJQHEuQxFSb1sEtRyaKJNdPVSQZyun58JNinjyNnUcBPkD9
         rtcoLBpCmy3+v7tz3vGk0TLEjgbmVTIGvbftiqXvVK266EleG+XScQX1l7UG6dflLser
         fQVA==
X-Received: by 10.60.40.67 with SMTP id v3mr11923634oek.16.1379789634013;
        Sat, 21 Sep 2013 11:53:54 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm7813696oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 11:53:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235135>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile        |  8 +++++++-
 git-rb-setup.rb | 11 +++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 git-rb-setup.rb

diff --git a/Makefile b/Makefile
index 7cbcbcb..138f9bf 100644
--- a/Makefile
+++ b/Makefile
@@ -491,6 +491,8 @@ SCRIPT_PERL += git-svn.perl
 SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
+SCRIPT_RUBY += git-rb-setup.rb
+
 NO_INSTALL += git-remote-testgit
 NO_INSTALL += git-remote-testpy
 
@@ -502,6 +504,7 @@ SCRIPT_PYTHON_GEN = $(patsubst %.py,%,$(SCRIPT_PYTHON))
 SCRIPT_SH_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_SH_GEN))
 SCRIPT_PERL_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_PERL_GEN))
 SCRIPT_PYTHON_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_PYTHON_GEN))
+SCRIPT_RUBY_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_RUBY))
 
 # Individual rules to allow e.g.
 # "make -C ../.. SCRIPT_PERL=contrib/foo/bar.perl build-perl-script"
@@ -511,13 +514,15 @@ build-perl-script: $(SCRIPT_PERL_GEN)
 build-sh-script: $(SCRIPT_SH_GEN)
 build-python-script: $(SCRIPT_PYTHON_GEN)
 
-.PHONY: install-perl-script install-sh-script install-python-script
+.PHONY: install-perl-script install-sh-script install-python-script install-ruby-script
 install-sh-script: $(SCRIPT_SH_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 install-perl-script: $(SCRIPT_PERL_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 install-python-script: $(SCRIPT_PYTHON_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+install-ruby-script: $(SCRIPT_RUBY_INS)
+	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
 .PHONY: clean-perl-script clean-sh-script clean-python-script
 clean-sh-script:
@@ -530,6 +535,7 @@ clean-python-script:
 SCRIPTS = $(SCRIPT_SH_INS) \
 	  $(SCRIPT_PERL_INS) \
 	  $(SCRIPT_PYTHON_INS) \
+	  $(SCRIPT_RUBY_INS) \
 	  git-instaweb
 
 ETAGS_TARGET = TAGS
diff --git a/git-rb-setup.rb b/git-rb-setup.rb
new file mode 100644
index 0000000..969278a
--- /dev/null
+++ b/git-rb-setup.rb
@@ -0,0 +1,11 @@
+#!/usr/bin/env ruby
+
+def die(*args)
+  fmt = args.shift
+  $stderr.printf("fatal: %s\n" % fmt, *args)
+  exit 128
+end
+
+def sha1_to_hex(sha1)
+  sha1.unpack('H*').first
+end
-- 
1.8.4-fc
