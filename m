From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [Patch 001/GSoC] Move static files into subdir
Date: Mon, 10 May 2010 17:14:36 +0530
Message-ID: <AANLkTim2rIFDBRChBxTiWZCNmd8ozwKQzM3RZOEr3mgp@mail.gmail.com>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com>
	 <m3bpcoenci.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 13:45:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBRQ8-0003qp-IE
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 13:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907Ab0EJLpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 07:45:06 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:34977 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab0EJLpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 07:45:05 -0400
Received: by ywh36 with SMTP id 36so1844523ywh.4
        for <git@vger.kernel.org>; Mon, 10 May 2010 04:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ausfxitsoofWcOKjNQKaHyM0UtRUI6QP4/SojmTDQBA=;
        b=Zj85Ff2+s1JrmR5U/pl0T8YsWzrpVDR6WUNNayjxcEJa+2zN7bdlLSbi7/rYH28th4
         QiH6GfjUKlBrh2zIqcKzS8qBmP93Zdul3bOFrNK9juFb/F2qj5etU4tYlYQDJBvgQ/eB
         8Qb0RVJfx75U+xO1UpvCLCVAazexeOOabxnEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CwbVHREfSjwFDqEcTH05r/YJdNjRefMC2qlHQCZ7rpdS9So3n3GlprdWYNxggNAiXC
         n9Vo3uXHmDOzC440NVC2dV0iL1mGgiNFnqPjhFE5B7xXdBlCqfgjlrLHC0HTEA2EZHK7
         Hez8qjMP7KC1IhS3Bt3aVWbWrDRD7c3v28Yi0=
Received: by 10.90.62.22 with SMTP id k22mr2286534aga.72.1273491876817; Mon, 
	10 May 2010 04:44:36 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Mon, 10 May 2010 04:44:36 -0700 (PDT)
In-Reply-To: <m3bpcoenci.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146803>

Gitweb: Move static files into seperate subdirectory

Create a new subdirectory called 'static' in gitweb/, and move
all static files required by gitweb.cgi when running, which means
styles, images and Javascript code. This should make gitweb more
readable and easier to maintain.

Update t/gitweb-lib.sh to reflect this change.  The default is
now to install static files also in 'static' subdirectory in target
directory: update Makefile, gitweb's INSTALL, README and Makefile
accordingly.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 Makefile                            |   20 ++++++++++----------
 gitweb/INSTALL                      |   20 ++++++++++----------
 gitweb/Makefile                     |   20 ++++++++++----------
 gitweb/README                       |   13 +++++++------
 gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
 gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
 gitweb/{ => static}/gitweb.css      |    0
 gitweb/{ => static}/gitweb.js       |    0
 t/gitweb-lib.sh                     |    6 +++---
 9 files changed, 40 insertions(+), 39 deletions(-)
 rename gitweb/{ => static}/git-favicon.png (100%)
 rename gitweb/{ => static}/git-logo.png (100%)
 rename gitweb/{ => static}/gitweb.css (100%)
 rename gitweb/{ => static}/gitweb.js (100%)

diff --git a/Makefile b/Makefile
index 910f471..fe34c22 100644
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


-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
gitweb/gitweb.js
+git-instaweb: git-instaweb.sh gitweb/gitweb.cgi
gitweb/static/gitweb.css gitweb/static/gitweb.js
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
@@ -2098,7 +2098,7 @@ clean:
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
-	$(RM) gitweb/gitweb.cgi gitweb/gitweb.min.*
+	$(RM) gitweb/gitweb.cgi gitweb/static/gitweb.min.*
 	$(MAKE) -C perl clean
 endif
 ifndef NO_PYTHON
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index cbdc136..0b4693f 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -7,7 +7,8 @@ gitweb.css, git-logo.png and git-favicon.png) to their
destination.
 For example if git was (or is) installed with /usr prefix, you can do

 	$ make prefix=/usr gitweb             ;# as yourself
-	# cp gitweb/git* /var/www/cgi-bin/    ;# as root
+	# cp gitweb/gitweb.cgi /var/www/cgi-bin/   ;# as root
+	# cp -r gitweb/static /var/www/cgi-bin/    ;# as root

 Alternatively you can use autoconf generated ./configure script to
 set up path to git binaries (via config.mak.autogen), so you can write
@@ -16,7 +17,8 @@ instead
 	$ make configure                     ;# as yourself
 	$ ./configure --prefix=/usr          ;# as yourself
 	$ make gitweb                        ;# as yourself
-	# cp gitweb/git* /var/www/cgi-bin/   ;# as root
+	# cp gitweb/gitweb.cgi /var/www/cgi-bin/   ;# as root
+	# cp -r gitweb/static /var/www/cgi-bin/    ;# as root

 The above example assumes that your web server is configured to run
 [executable] files in /var/www/cgi-bin/ as server scripts (as CGI
@@ -79,17 +81,15 @@ Build example
   we want to display are under /home/local/scm, you can do

 	make GITWEB_PROJECTROOT="/home/local/scm" \
-	     GITWEB_JS="/gitweb/gitweb.js" \
-	     GITWEB_CSS="/gitweb/gitweb.css" \
-	     GITWEB_LOGO="/gitweb/git-logo.png" \
-	     GITWEB_FAVICON="/gitweb/git-favicon.png" \
+	     GITWEB_JS="/gitweb/static/gitweb.js" \
+	     GITWEB_CSS="/gitweb/static/gitweb.css" \
+	     GITWEB_LOGO="/gitweb/static/git-logo.png" \
+	     GITWEB_FAVICON="/gitweb/static/git-favicon.png" \
 	     bindir=/usr/local/bin \
 	     gitweb

-	cp -fv ~/git/gitweb/gitweb.{cgi,js,css} \
-	       ~/git/gitweb/git-{favicon,logo}.png \
-	     /var/www/cgi-bin/gitweb/
-
+	cp -fv ~/git/gitweb/gitweb.cgi /var/www/cgi-bin/gitweb/
+	cp -r ~/git/gitweb/static /var/www/cgi-bin/gitweb/

 Gitweb config file
 ------------------
diff --git a/gitweb/Makefile b/gitweb/Makefile
index f2e1d92..c0d5da3 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -26,10 +26,10 @@ GITWEB_STRICT_EXPORT =
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

@@ -81,16 +81,16 @@ endif
 all:: gitweb.cgi

 ifdef JSMIN
-GITWEB_JS = gitweb.min.js
-all:: gitweb.min.js
-gitweb.min.js: gitweb.js GITWEB-BUILD-OPTIONS
+GITWEB_JS = static/gitweb.min.js
+all:: static/gitweb.min.js
+static/gitweb.min.js: static/gitweb.js GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(JSMIN) <$< >$@
 endif

 ifdef CSSMIN
-GITWEB_CSS = gitweb.min.css
-all:: gitweb.min.css
-gitweb.min.css: gitweb.css GITWEB-BUILD-OPTIONS
+GITWEB_CSS = static/gitweb.min.css
+all:: static/gitweb.min.css
+static/gitweb.min.css: static/gitweb.css GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(CSSMIN) <$ >$@
 endif

diff --git a/gitweb/README b/gitweb/README
index 71742b3..8e063c0 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -80,24 +80,25 @@ You can specify the following configuration
variables when building GIT:
    Points to the location where you put gitweb.css on your web server
    (or to be more generic, the URI of gitweb stylesheet).  Relative to the
    base URI of gitweb.  Note that you can setup multiple stylesheets from
-   the gitweb config file.  [Default: gitweb.css (or gitweb.min.css if the
-   CSSMIN variable is defined / CSS minifier is used)]
+   the gitweb config file.  [Default: static/gitweb.css (or
static/gitweb.min.css
+   if the CSSMIN variable is defined / CSS minifier is used)]
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
1.7.0.4

This is the new patch which includes the changes suggested by Jakub.

Regarding wordwrap, all the mailing ports in my university are closed
which leaves me only the gmail web cient which don't have any option
to disable wordwrap. I will try to find a workaround for this. Please
bear with my wordwrap until then.

Thanks
-Pavan
