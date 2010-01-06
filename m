From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5] Makefile: consolidate .FORCE-* targets
Date: Wed, 6 Jan 2010 02:06:58 -0600
Message-ID: <20100106080658.GE7298@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
 <20091128113709.GD10059@progeny.tock>
 <20100106080216.GA7298@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:16:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSR4U-0005KD-5l
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 09:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885Ab0AFIPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 03:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607Ab0AFIPU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 03:15:20 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:51366 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab0AFIPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 03:15:20 -0500
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2010 03:15:20 EST
Received: by gxk9 with SMTP id 9so38823535gxk.8
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 00:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+GAD8+pWXp9Ss66akukluQaJn8M85JqSTWZnXZaLkVw=;
        b=f61a7hO7nyi/RvLdAnmCtzSXAasDv4ysswi7A8NBpOfIaIq911VS7TU95qy/FuXgTD
         iP6TY5Sxh3rFuJeRTrD9sD0uf364e11Q1ADQXHMRCykxMv92JibtQnJgJDKebqwiy3g4
         38kpD6e72j8tSq/239FYE4ntTYvdyzvVjHgB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dSuHfGBQxh13Xvp/iaTvYRp/KkGCjKdXD2XHtlvXmLAivgSbmhZGfFEPaY3Dwr1r12
         +MTVWAK8/OywgXlpJiqOQ/AuzrCdT303mK44qriFXDFK23D0bsUm78nb3cZqGh4Gcuxl
         bYUhvYRZzwT8DpVcMT8+ebnxPIHTfDUTTOF0w=
Received: by 10.150.19.4 with SMTP id 4mr165044ybs.216.1262765217009;
        Wed, 06 Jan 2010 00:06:57 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm19386834iwn.9.2010.01.06.00.06.56
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 00:06:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100106080216.GA7298@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136248>

Providing multiple targets to force a rebuild is unnecessary
complication.

Avoid using a name that could conflict with future special
targets in GNU make (a leading period followed by uppercase
letters).

The corresponding change to the git-gui Makefile is left for
another patch.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/Makefile |    4 ++--
 Makefile               |   15 ++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4797b2d..8a8a395 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -204,7 +204,7 @@ install-pdf: pdf
 install-html: html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
-../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
+../GIT-VERSION-FILE: FORCE
 	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
 
 -include ../GIT-VERSION-FILE
@@ -337,4 +337,4 @@ quick-install-man:
 quick-install-html:
 	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htmldir)
 
-.PHONY: .FORCE-GIT-VERSION-FILE
+.PHONY: FORCE
diff --git a/Makefile b/Makefile
index 3d774c6..fd79cd6 100644
--- a/Makefile
+++ b/Makefile
@@ -222,7 +222,7 @@ all::
 #   DEFAULT_EDITOR='$GIT_FALLBACK_EDITOR',
 #   DEFAULT_EDITOR='"C:\Program Files\Vim\gvim.exe" --nofork'
 
-GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
+GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
@@ -1632,7 +1632,7 @@ git.o git.spec \
 
 %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
-%.s: %.c GIT-CFLAGS .FORCE-LISTING
+%.s: %.c GIT-CFLAGS FORCE
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
 %.o: %.S
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
@@ -1723,7 +1723,7 @@ cscope:
 TRACK_CFLAGS = $(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ)
 
-GIT-CFLAGS: .FORCE-GIT-CFLAGS
+GIT-CFLAGS: FORCE
 	@FLAGS='$(TRACK_CFLAGS)'; \
 	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
 		echo 1>&2 "    * new build flags or prefix"; \
@@ -1733,7 +1733,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 # We need to apply sq twice, once to protect from the shell
 # that runs GIT-BUILD-OPTIONS, and then again to protect it
 # and the first level quoting from the shell that runs "echo".
-GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
+GIT-BUILD-OPTIONS: FORCE
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
 	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
@@ -1745,14 +1745,12 @@ GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 ifndef NO_TCLTK
 TRACK_VARS = $(subst ','\'',-DTCLTK_PATH='$(TCLTK_PATH_SQ)')
 
-GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
+GIT-GUI-VARS: FORCE
 	@VARS='$(TRACK_VARS)'; \
 	    if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
 		echo 1>&2 "    * new Tcl/Tk interpreter location"; \
 		echo "$$VARS" >$@; \
             fi
-
-.PHONY: .FORCE-GIT-GUI-VARS
 endif
 
 ### Testing rules
@@ -1972,8 +1970,7 @@ endif
 
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
-.PHONY: .FORCE-GIT-BUILD-OPTIONS .FORCE-LISTING
+.PHONY: FORCE TAGS tags cscope
 
 ### Check documentation
 #
-- 
1.6.6.rc2
