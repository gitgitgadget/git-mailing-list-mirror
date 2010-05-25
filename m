From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCHv6 GSoC] gitweb: Move static files into seperate subdirectory
Date: Tue, 25 May 2010 14:54:28 +0530
Message-ID: <1274779468-13975-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue May 25 11:24:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGqNX-0008Ed-Hx
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297Ab0EYJYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:24:46 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50631 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169Ab0EYJYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:24:45 -0400
Received: by pvg3 with SMTP id 3so463465pvg.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BsfxSs1dxUVq1VTHl0FardiaqbZgOlMCEXNyB1erAV8=;
        b=vgUU7abPwtvppf2I1/GWitdc4ojrZYvHUqbYHAcHY0x/O1ajkS9GS00DFEXMBI7w3g
         HWSWd4IrAmIUdNlcywbKhQKANmx4CIyJRTSNk4JANQYZRYfS5Nd0Hqt4MKdiMkelEDfd
         aEh5Bceo1ioCbALE7TsyCzS1VZG3utEtTrvtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TUOPxSw9bJXphV2vERnGR74/dySPh1aOUJOnxwnCvYzYigKtg4PSwbkfmB7NcEXAze
         fgCfRQ2j8pSQsbSdhPE/s9f7yeoNzFYWekCMmMtcuiH/KMhfvhVmtgKhsQZbNHLrKLv7
         e9hHUbWgSx0MvN0bOsd67RFyty9n3nhhOYmsA=
Received: by 10.142.1.22 with SMTP id 22mr4508711wfa.345.1274779484546;
        Tue, 25 May 2010 02:24:44 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id r20sm46181937wam.5.2010.05.25.02.24.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 02:24:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.18.g74211d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147698>

Create a new subdirectory called 'static' in gitweb/, and move
all static files required by gitweb.cgi when running, which means
styles, images and Javascript code. This should make gitweb more
readable and easier to maintain.

Update t/gitweb-lib.sh to reflect this change.The install-gitweb
now also include moving of static files into 'static' subdirectory
in target directory: update Makefile, gitweb's INSTALL, README and
Makefile accordingly.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---

There is a bug in git which doesn't show pure 100% rename of
binary files in patches. This led the previous patch to move
only the js and css files into static dir leaving the image files
in the main gitweb/ directory.

Now I manually added the lines in the diff to move the image files too.

 Makefile                            |   22 +++++++++---------
 gitweb/INSTALL                      |   19 +++++++--------
 gitweb/Makefile                     |   40 ++++++++++++++++++----------------
 gitweb/README                       |   14 +++++++-----
 gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
 gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
 gitweb/{ => static}/gitweb.css      |    0
 gitweb/{ => static}/gitweb.js       |    0
 t/gitweb-lib.sh                     |    6 ++--
 9 files changed, 52 insertions(+), 49 deletions(-)
 rename gitweb/{ => static}/git-favicon.png (100%)
 rename gitweb/{ => static}/git-logo.png (100%)
 rename gitweb/{ => static}/gitweb.css (100%)
 rename gitweb/{ => static}/gitweb.js (100%)

diff --git a/Makefile b/Makefile
index 6eb6289..de7f680 100644
--- a/Makefile
+++ b/Makefile
@@ -1561,32 +1561,32 @@ gitweb:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
 
 ifdef JSMIN
-GITWEB_PROGRAMS += gitweb/gitweb.min.js
-GITWEB_JS = gitweb/gitweb.min.js
+GITWEB_PROGRAMS += gitweb/static/gitweb.min.js
+GITWEB_JS = gitweb/static/gitweb.min.js
 else
-GITWEB_JS = gitweb/gitweb.js
+GITWEB_JS = gitweb/static/gitweb.js
 endif
 ifdef CSSMIN
-GITWEB_PROGRAMS += gitweb/gitweb.min.css
-GITWEB_CSS = gitweb/gitweb.min.css
+GITWEB_PROGRAMS += gitweb/static/gitweb.min.css
+GITWEB_CSS = gitweb/static/gitweb.min.css
 else
-GITWEB_CSS = gitweb/gitweb.css
+GITWEB_CSS = gitweb/static/gitweb.css
 endif
 OTHER_PROGRAMS +=  gitweb/gitweb.cgi  $(GITWEB_PROGRAMS)
 gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
 
 ifdef JSMIN
-gitweb/gitweb.min.js: gitweb/gitweb.js
+gitweb/static/gitweb.min.js: gitweb/static/gitweb.js
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
 endif # JSMIN
 ifdef CSSMIN
-gitweb/gitweb.min.css: gitweb/gitweb.css
+gitweb/static/gitweb.min.css: gitweb/static/gitweb.css
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
 endif # CSSMIN
 
 
-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.js
+git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index d484d76..8230531 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -2,9 +2,10 @@ GIT web Interface (gitweb) Installation
 =======================================
 
 First you have to generate gitweb.cgi from gitweb.perl using
-"make gitweb", then copy appropriate files (gitweb.cgi, gitweb.js,
-gitweb.css, git-logo.png and git-favicon.png) to their destination.
-For example if git was (or is) installed with /usr prefix, you can do
+"make gitweb", then "make install-gitweb" appropriate files
+(gitweb.cgi, gitweb.js, gitweb.css, git-logo.png and git-favicon.png)
+to their destination. For example if git was (or is) installed with
+/usr prefix and gitwebdir is /var/www/cgi-bin, you can do
 
 	$ make prefix=/usr gitweb                            ;# as yourself
 	# make gitwebdir=/var/www/cgi-bin install-gitweb     ;# as root
@@ -81,16 +82,14 @@ Build example
   minifiers, you can do
 
 	make GITWEB_PROJECTROOT="/home/local/scm" \
-	     GITWEB_JS="/gitweb/gitweb.js" \
-	     GITWEB_CSS="/gitweb/gitweb.css" \
-	     GITWEB_LOGO="/gitweb/git-logo.png" \
-	     GITWEB_FAVICON="/gitweb/git-favicon.png" \
+	     GITWEB_JS="gitweb/static/gitweb.js" \
+	     GITWEB_CSS="gitweb/static/gitweb.css" \
+	     GITWEB_LOGO="gitweb/static/git-logo.png" \
+	     GITWEB_FAVICON="gitweb/static/git-favicon.png" \
 	     bindir=/usr/local/bin \
 	     gitweb
 
-	cp -fv gitweb/gitweb.{cgi,js,css} \
-	       gitweb/git-{favicon,logo}.png \
-	     /var/www/cgi-bin/gitweb/
+	make gitwebdir=/var/www/cgi-bin/gitweb install-gitweb
 
 
 Gitweb config file
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 935d2d2..d2584fe 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -4,10 +4,10 @@ all::
 # Define V=1 to have a more verbose compile.
 #
 # Define JSMIN to point to JavaScript minifier that functions as
-# a filter to have gitweb.js minified.
+# a filter to have static/gitweb.js minified.
 #
 # Define CSSMIN to point to a CSS minifier in order to generate a minified
-# version of gitweb.css
+# version of static/gitweb.css
 #
 
 prefix ?= $(HOME)
@@ -29,10 +29,10 @@ GITWEB_STRICT_EXPORT =
 GITWEB_BASE_URL =
 GITWEB_LIST =
 GITWEB_HOMETEXT = indextext.html
-GITWEB_CSS = gitweb.css
-GITWEB_LOGO = git-logo.png
-GITWEB_FAVICON = git-favicon.png
-GITWEB_JS = gitweb.js
+GITWEB_CSS = static/gitweb.css
+GITWEB_LOGO = static/git-logo.png
+GITWEB_FAVICON = static/git-favicon.png
+GITWEB_JS = static/gitweb.js
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -54,6 +54,7 @@ PERL_PATH  ?= /usr/bin/perl
 # Shell quote;
 bindir_SQ = $(subst ','\'',$(bindir))#'
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
+gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
 PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
 DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
@@ -88,26 +89,26 @@ all:: gitweb.cgi
 GITWEB_PROGRAMS = gitweb.cgi
 
 ifdef JSMIN
-GITWEB_FILES += gitweb.min.js
-GITWEB_JS = gitweb.min.js
-all:: gitweb.min.js
-gitweb.min.js: gitweb.js GITWEB-BUILD-OPTIONS
+GITWEB_FILES += static/gitweb.min.js
+GITWEB_JS = static/gitweb.min.js
+all:: static/gitweb.min.js
+static/gitweb.min.js: static/gitweb.js GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(JSMIN) <$< >$@
 else
-GITWEB_FILES += gitweb.js
+GITWEB_FILES += static/gitweb.js
 endif
 
 ifdef CSSMIN
-GITWEB_FILES += gitweb.min.css
-GITWEB_CSS = gitweb.min.css
-all:: gitweb.min.css
-gitweb.min.css: gitweb.css GITWEB-BUILD-OPTIONS
+GITWEB_FILES += static/gitweb.min.css
+GITWEB_CSS = static/gitweb.min.css
+all:: static/gitweb.min.css
+static/gitweb.min.css: static/gitweb.css GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(CSSMIN) <$ >$@
 else
-GITWEB_FILES += gitweb.css
+GITWEB_FILES += static/gitweb.css
 endif
 
-GITWEB_FILES += git-logo.png git-favicon.png
+GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
@@ -147,12 +148,13 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
-	$(INSTALL) -m 644 $(GITWEB_FILES)    '$(DESTDIR_SQ)$(gitwebdir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
+	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 
 ### Cleaning rules
 
 clean:
-	$(RM) gitweb.cgi gitweb.min.js gitweb.min.css GITWEB-BUILD-OPTIONS
+	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
 
 .PHONY: all clean install .FORCE-GIT-VERSION-FILE FORCE
 
diff --git a/gitweb/README b/gitweb/README
index 71742b3..0e19be8 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -80,24 +80,26 @@ You can specify the following configuration variables when building GIT:
    Points to the location where you put gitweb.css on your web server
    (or to be more generic, the URI of gitweb stylesheet).  Relative to the
    base URI of gitweb.  Note that you can setup multiple stylesheets from
-   the gitweb config file.  [Default: gitweb.css (or gitweb.min.css if the
-   CSSMIN variable is defined / CSS minifier is used)]
+   the gitweb config file.  [Default: static/gitweb.css (or
+   static/gitweb.min.css if the CSSMIN variable is defined / CSS minifier
+   is used)]
  * GITWEB_LOGO
    Points to the location where you put git-logo.png on your web server
    (or to be more generic URI of logo, 72x27 size, displayed in top right
    corner of each gitweb page, and used as logo for Atom feed).  Relative
-   to base URI of gitweb.  [Default: git-logo.png]
+   to base URI of gitweb.  [Default: static/git-logo.png]
  * GITWEB_FAVICON
    Points to the location where you put git-favicon.png on your web server
    (or to be more generic URI of favicon, assumed to be image/png type;
    web browsers that support favicons (website icons) may display them
    in the browser's URL bar and next to site name in bookmarks).  Relative
-   to base URI of gitweb.  [Default: git-favicon.png]
+   to base URI of gitweb.  [Default: static/git-favicon.png]
  * GITWEB_JS
    Points to the localtion where you put gitweb.js on your web server
    (or to be more generic URI of JavaScript code used by gitweb).
-   Relative to base URI of gitweb.  [Default: gitweb.js (or gitweb.min.js
-   if JSMIN build variable is defined / JavaScript minifier is used)]
+   Relative to base URI of gitweb.  [Default: static/gitweb.js (or
+   static/gitweb.min.js if JSMIN build variable is defined / JavaScript
+   minifier is used)]
  * GITWEB_CONFIG
    This Perl file will be loaded using 'do' and can be used to override any
    of the options above as well as some other options -- see the "Runtime
diff --git a/gitweb/gitweb.css b/gitweb/static/gitweb.css
similarity index 100%
rename from gitweb/gitweb.css
rename to gitweb/static/gitweb.css
diff --git a/gitweb/gitweb.js b/gitweb/static/gitweb.js
similarity index 100%
rename from gitweb/gitweb.js
rename to gitweb/static/gitweb.js
diff --git a/gitweb/git-logo.png b/gitweb/static/git-logo.png
similarity index 100%
rename from gitweb/git-logo.png
rename to gitweb/static/git-logo.png
diff --git a/gitweb/git-favicon.png b/gitweb/static/git-favicon.png
similarity index 100%
rename from gitweb/git-favicon.png
rename to gitweb/static/git-favicon.png
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 5a734b1..b70b891 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -19,9 +19,9 @@ our \$site_name = '[localhost]';
 our \$site_header = '';
 our \$site_footer = '';
 our \$home_text = 'indextext.html';
-our @stylesheets = ('file:///$TEST_DIRECTORY/../gitweb/gitweb.css');
-our \$logo = 'file:///$TEST_DIRECTORY/../gitweb/git-logo.png';
-our \$favicon = 'file:///$TEST_DIRECTORY/../gitweb/git-favicon.png';
+our @stylesheets = ('file:///$TEST_DIRECTORY/../gitweb/static/gitweb.css');
+our \$logo = 'file:///$TEST_DIRECTORY/../gitweb/static/git-logo.png';
+our \$favicon = 'file:///$TEST_DIRECTORY/../gitweb/static/git-favicon.png';
 our \$projects_list = '';
 our \$export_ok = '';
 our \$strict_export = '';
-- 
1.7.1.18.g74211d.dirty
