From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] make the name of the library directory a config option
Date: Wed, 1 Aug 2007 06:30:35 +0200
Message-ID: <20070801043035.GH29424@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 06:30:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG5rL-0003z5-Cv
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 06:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbXHAEal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 00:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbXHAEal
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 00:30:41 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:62207 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbXHAEaj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 00:30:39 -0400
Received: by mu-out-0910.google.com with SMTP id i10so123328mue
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 21:30:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=FZ8/MWUudMYpgIcOWeo+d8Q2cCyaWIUT3sG6SSQFu2SGIvgrbyLS2Ci4hSLxHG6MpmDMjVDKRbhwIUjmfzHn2r+lFWI5SMiO0y3WhVyg5q7i6KulQT6970eEgCms/fJvhaTHMaarKLGRFGKe7484MKgxFHmJYsYbY7LoyD8a0/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=o83pHB4Do8ZaBAUnwRPx3YeWBlMiMDbQBAcjlgXYlx7F56WcaNpiztB105/8LYYV+bIx1VBN8EM+1ZDJstdDu5lLSweGVg9YPzFoP/1ZMljZ+DWtSFIAgBMaXRhDVj7062pkb4/jjUiwguqvD/Q1F3F0CFRYJK1gXGjPKhPlVjA=
Received: by 10.86.54.3 with SMTP id c3mr236572fga.1185942638091;
        Tue, 31 Jul 2007 21:30:38 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.100.172])
        by mx.google.com with ESMTPS id w5sm856811mue.2007.07.31.21.30.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2007 21:30:37 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id CA3FBC0DB70; Wed,  1 Aug 2007 06:30:35 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54406>

Introduce new makefile variable lib to hold the name of the lib
directory ("lib" by default).  Also introduce a switch for configure
to specify this name with --with-lib=ARG.  This is useful for systems
that use a different name than "lib" (like "lib64" on some 64 bit
Linux architectures).

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
You can also fetch this patch as e58a07b30a879228b9090a0c8ac6c690d77fcde8 from
git://schiele.dyndns.org/git

It requires that my zlib patch was applied before.

 Makefile     |   11 ++++++-----
 configure.ac |   11 +++++++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index ca1247d..ff5fc5f 100644
--- a/Makefile
+++ b/Makefile
@@ -151,6 +151,7 @@ sysconfdir = /etc
 else
 sysconfdir = $(prefix)/etc
 endif
+lib = lib
 ETC_GITCONFIG = $(sysconfdir)/gitconfig
 # DESTDIR=
 
@@ -500,9 +501,9 @@ endif
 
 ifndef NO_CURL
 	ifdef CURLDIR
-		# Try "-Wl,-rpath=$(CURLDIR)/lib" in such a case.
+		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
 		BASIC_CFLAGS += -I$(CURLDIR)/include
-		CURL_LIBCURL = -L$(CURLDIR)/lib $(CC_LD_DYNPATH)$(CURLDIR)/lib -lcurl
+		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
 	else
 		CURL_LIBCURL = -lcurl
 	endif
@@ -520,7 +521,7 @@ endif
 
 ifdef ZLIB_PATH
 	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
-	EXTLIBS += -L$(ZLIB_PATH)/lib $(CC_LD_DYNPATH)$(ZLIB_PATH)/lib
+	EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
 endif
 EXTLIBS += -lz
 
@@ -528,7 +529,7 @@ ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
 		BASIC_CFLAGS += -I$(OPENSSLDIR)/include
-		OPENSSL_LINK = -L$(OPENSSLDIR)/lib $(CC_LD_DYNPATH)$(OPENSSLDIR)/lib
+		OPENSSL_LINK = -L$(OPENSSLDIR)/$(lib) $(CC_LD_DYNPATH)$(OPENSSLDIR)/$(lib)
 	else
 		OPENSSL_LINK =
 	endif
@@ -545,7 +546,7 @@ endif
 ifdef NEEDS_LIBICONV
 	ifdef ICONVDIR
 		BASIC_CFLAGS += -I$(ICONVDIR)/include
-		ICONV_LINK = -L$(ICONVDIR)/lib $(CC_LD_DYNPATH)$(ICONVDIR)/lib
+		ICONV_LINK = -L$(ICONVDIR)/$(lib) $(CC_LD_DYNPATH)$(ICONVDIR)/$(lib)
 	else
 		ICONV_LINK =
 	endif
diff --git a/configure.ac b/configure.ac
index b2f1965..84fd7f1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -69,6 +69,17 @@ fi \
 ## Site configuration related to programs (before tests)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
 #
+# Set lib to alternative name of lib directory (e.g. lib64)
+AC_ARG_WITH([lib],
+ [AS_HELP_STRING([--with-lib=ARG],
+                 [ARG specifies alternative name for lib directory])],
+ [if test "$withval" = "no" -o "$withval" = "yes"; then \
+	AC_MSG_WARN([You should provide name for --with-lib=ARG]); \
+else \
+	GIT_CONF_APPEND_LINE(lib=$withval); \
+fi; \
+],[])
+#
 # Define SHELL_PATH to provide path to shell.
 GIT_ARG_SET_PATH(shell)
 #
-- 
1.5.2.3
