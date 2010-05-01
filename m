From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Create install target for gitweb in Makefile
Date: Sat, 1 May 2010 22:36:15 +0200
Message-ID: <201005012236.16703.jnareb@gmail.com>
References: <20100429235046.29606.35311.stgit@localhost.localdomain> <7vbpcz4d95.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 01 22:43:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8JX2-0005vj-P8
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 22:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab0EAUgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 16:36:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64021 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab0EAUgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 16:36:24 -0400
Received: by fxm10 with SMTP id 10so1130031fxm.19
        for <git@vger.kernel.org>; Sat, 01 May 2010 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=37eD8isHpwDXYmzO11UzgRIgp8QVjUxx9llGTiaNpfA=;
        b=prY4BnW23lsJaynFc9oJcBvQ05asv2OODK8I0LeDKR9YSy6Yo0oXO+XyjfQQvvs9Q5
         gnpXMWysnwNegdb5LlIpZZ0kcYSdAPSiE1SFjKyl0QCaiqvG21OL2VXdwL5rFLCcxV1T
         sJ5VwRN6ajz8CsdlXjd0Ibcn2yEtU1VnUnNo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=s3Y6X7zonJTkLVj+mOBIIJHtVPJJITiJSvhXW+mFj+99/I04d9TOiTHcRvMqnEWPAw
         I5ySOfiXuH6mqzUbavpBldpZ6CaUp3cx/GMsBHTCvKPheh123962+PJpQI5E8tdD0+lw
         Xyn5iUj2FjWeai1Q6h272b+Aq2YxMhu1tKLwQ=
Received: by 10.103.126.37 with SMTP id d37mr7348878mun.66.1272746182354;
        Sat, 01 May 2010 13:36:22 -0700 (PDT)
Received: from [192.168.1.13] (abvy46.neoplus.adsl.tpnet.pl [83.8.222.46])
        by mx.google.com with ESMTPS id j10sm14245991mue.48.2010.05.01.13.36.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 May 2010 13:36:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vbpcz4d95.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146119>

On Sat, 1 May 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Installing gitweb is now as easy as
> >   # make gitwebdir=/var/www/cgi-bin gitweb-install  ;# as root
> > The gitweb/INSTALL file was updated accordingly.
> 
> Just a style, but I prefer a blank line on both sides of an example
> command line like this.

O.K.

> > There is a question whether to rely on correctly set file permissions
> > during build phase, i.e.
> >
> > 	$(INSTALL) $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
> >
> > or whether to ensure correct file permissions during installl phase
> >
> > 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
> > 	$(INSTALL) -m 644 $(GITWEB_FILES)    '$(DESTDIR_SQ)$(gitwebdir_SQ)'
> >
> > Currently the first option is used.
> 
> Hmm, the reason being?  I do not have a strong preference either way, but
> the primary Makefile seems to use "-m mode".

No reason, just that this was simpler way (gitweb.cgi is created
executable by its rule).

Changed patch below.
 
> > Note that install-* targets, including new install-gitweb, are not
> > marked as .PHONY
> 
> The reason being?
> 
> My preference for the standard targets like "all", "clean", and "install"
> is to make them double-colon rules and mark them as phoneys.

The reason being that only 'all::' is double-colon rule, and in main
Makefile while 'all' and 'install' targets are marked .PHONY, other
install targets: install-doc, install-info, install-man etc. are not.

I was following example of 'install-doc' target with new 'install-gitweb'
target in main Makefile.  This can be fixed, but I think it is a matter
for a separate commit.

-- >8 --
Subject: [PATCHv2] gitweb: Create install target for gitweb in Makefile

Installing gitweb is now as easy as

  # make gitwebdir=/var/www/cgi-bin gitweb-install  ;# as root

The gitweb/INSTALL file was updated accordingly, to make use of this
new target.

Fix shell quoting, i.e. setting bindir_SQ etc., in gitweb/Makefile.
Those variables were not used previously.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Here is the interdiff:

 diff --git a/gitweb/Makefile b/gitweb/Makefile
 index 729cf50..935d2d2 100644
 --- a/gitweb/Makefile
 +++ b/gitweb/Makefile
 @@ -85,7 +85,7 @@ endif
  
  all:: gitweb.cgi
  
 -GITWEB_FILES = gitweb.cgi
 +GITWEB_PROGRAMS = gitweb.cgi
  
  ifdef JSMIN
  GITWEB_FILES += gitweb.min.js
 @@ -146,7 +146,8 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
  
  install: all
  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 -	$(INSTALL) $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 +	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 +	$(INSTALL) -m 644 $(GITWEB_FILES)    '$(DESTDIR_SQ)$(gitwebdir_SQ)'
  
  ### Cleaning rules
  

 

 Makefile        |    3 +++
 gitweb/INSTALL  |   11 ++++-------
 gitweb/Makefile |   32 ++++++++++++++++++++++++++++----
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 910f471..dab5a14 100644
--- a/Makefile
+++ b/Makefile
@@ -2004,6 +2004,9 @@ endif
 	  done; } && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
+install-gitweb:
+	$(MAKE) -C gitweb install
+
 install-doc:
 	$(MAKE) -C Documentation install
 
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 1bfd9aa..4447e26 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -6,10 +6,8 @@ First you have to generate gitweb.cgi from gitweb.perl using
 gitweb.css, git-logo.png and git-favicon.png) to their destination.
 For example if git was (or is) installed with /usr prefix, you can do
 
-	$ make prefix=/usr gitweb             ;# as yourself
-	# cp gitweb/*.cgi gitweb/*.css \
-	     gitweb/*.js  gitweb/*.png \
-	     /var/www/cgi-bin/                ;# as root
+	$ make prefix=/usr gitweb                            ;# as yourself
+	# make gitwebdir=/var/www/cgi-bin install-gitweb     ;# as root
 
 Alternatively you can use autoconf generated ./configure script to
 set up path to git binaries (via config.mak.autogen), so you can write
@@ -18,9 +16,8 @@ instead
 	$ make configure                     ;# as yourself
 	$ ./configure --prefix=/usr          ;# as yourself
 	$ make gitweb                        ;# as yourself
-	# cp gitweb/*.cgi gitweb/*.css \
-	     gitweb/*.js  gitweb/*.png \
-	     /var/www/cgi-bin/               ;# as root
+	# make gitwebdir=/var/www/cgi-bin \
+	       install-gitweb                ;# as root
 
 The above example assumes that your web server is configured to run
 [executable] files in /var/www/cgi-bin/ as server scripts (as CGI
diff --git a/gitweb/Makefile b/gitweb/Makefile
index f2e1d92..935d2d2 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -12,7 +12,10 @@ all::
 
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
+gitwebdir ?= /var/www/cgi-bin
+
 RM ?= rm -f
+INSTALL ?= install
 
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
@@ -49,9 +52,11 @@ SHELL_PATH ?= $(SHELL)
 PERL_PATH  ?= /usr/bin/perl
 
 # Shell quote;
-bindir_SQ = $(subst ','\'',$(bindir))         #'
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH)) #'
-PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))  #'
+bindir_SQ = $(subst ','\'',$(bindir))#'
+gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
+PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
+DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
 
 # Quiet generation (unless V=1)
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
@@ -80,20 +85,30 @@ endif
 
 all:: gitweb.cgi
 
+GITWEB_PROGRAMS = gitweb.cgi
+
 ifdef JSMIN
+GITWEB_FILES += gitweb.min.js
 GITWEB_JS = gitweb.min.js
 all:: gitweb.min.js
 gitweb.min.js: gitweb.js GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(JSMIN) <$< >$@
+else
+GITWEB_FILES += gitweb.js
 endif
 
 ifdef CSSMIN
+GITWEB_FILES += gitweb.min.css
 GITWEB_CSS = gitweb.min.css
 all:: gitweb.min.css
 gitweb.min.css: gitweb.css GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(CSSMIN) <$ >$@
+else
+GITWEB_FILES += gitweb.css
 endif
 
+GITWEB_FILES += git-logo.png git-favicon.png
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
@@ -127,8 +142,17 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
 	chmod +x $@+ && \
 	mv $@+ $@
 
+### Installation rules
+
+install: all
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
+	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
+	$(INSTALL) -m 644 $(GITWEB_FILES)    '$(DESTDIR_SQ)$(gitwebdir_SQ)'
+
+### Cleaning rules
+
 clean:
 	$(RM) gitweb.cgi gitweb.min.js gitweb.min.css GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean .FORCE-GIT-VERSION-FILE FORCE
+.PHONY: all clean install .FORCE-GIT-VERSION-FILE FORCE
 
-- 
1.7.0.1
