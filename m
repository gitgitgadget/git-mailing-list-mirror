From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Makefile: implement help target
Date: Tue, 28 Sep 2010 16:44:20 +0200
Message-ID: <c16e8df7c8e9b562ce0e6cd6e543a83779cd2b25.1285684868.git.git@drmicha.warpmail.net>
References: <4CA1E10F.4080906@op5.se>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 16:44:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0bPq-0003l6-1l
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 16:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667Ab0I1OoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 10:44:15 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:33939 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755657Ab0I1OoO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 10:44:14 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C265ECDB;
	Tue, 28 Sep 2010 10:44:13 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 28 Sep 2010 10:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=fpH9U/Bu1MwAPypIDITiJkkbOLc=; b=o6OyispJaWQQPxDZ3eOKp/+qvKngPfFLaZo/V86Y+HD94bid5YqYRZlBTG5oMFaq56rknwKdp5IYs/qJcPmn5sBeNfRWtQl/9fWdOgf5B5npzmnXPCwV9T66QbzD0UucBHVQ61HFcb/RHQRqR1e6QIuu+K3nneRzkb29Kz5VpVc=
X-Sasl-enc: fF6oeAy1nPjegpRNXG1dNeu7d9DHF2a4Ibcc1dJcmxko 1285685053
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 25EF24057D4;
	Tue, 28 Sep 2010 10:44:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.98.g5ad7d
In-Reply-To: <4CA1E10F.4080906@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157428>

with automatic help text collection from lines starting with "#H# " and
preceding a make target.

Suggested-by: Stephen Boyd <bebarino@gmail.com>
Helped-by: Andreas Ericsson <andreas.ericsson@op5.se>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
How's this for a version without maintenance issues?
We could sort differently, of course, or at a category key (build, doc, etc.)
but let's not go too far. Currently, the output of make help is:

GIT_VERSION = 1.7.3.99.gc16e8
dist                : Build git-$(GIT_VERSION).tar.gz source
html                : Build HTML doc
info                : Build info docs
man                 : Build man pages
doc                 : Build man pages and HTML docs
dist-doc            : Build $(manpages).tar.gz and $(htmldocs).tar.gz
pdf                 : Build PDF docs
rpm                 : Build source and binary RPM packages
check-docs          : Check documentation coverage
coverage            : Check test coverage
cover_db_html       : Check test coverage and create HTMl report
test                : Check the build by running the test suite
cscope              : Generate cscope index
tags                : Generate tags using ctags
install-html        : Install HTML docs
install-info        : Install info docs
install-doc         : Install man pages
install-man         : Install man pages
install-pdf         : Install PDF docs
quick-install-html  : Install pregenerated HTML pages from origin/html
quick-install-doc   : Install pregenerated man pages from origin/man
quick-install-man   : Install pregenerated man pages from origin/man
install             : Install the git suite
distclean           : Remove generated files and the configure script
clean               : Remove generated files but keep the configure script
help                : Show help for main make targets

 Makefile |   38 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index db2efd6..187a8a2 100644
--- a/Makefile
+++ b/Makefile
@@ -1952,29 +1952,37 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
 
+#H# Build man pages and HTML docs
 doc:
 	$(MAKE) -C Documentation all
 
+#H# Build man pages
 man:
 	$(MAKE) -C Documentation man
 
+#H# Build HTML doc
 html:
 	$(MAKE) -C Documentation html
 
+#H# Build info docs
 info:
 	$(MAKE) -C Documentation info
 
+#H# Build PDF docs
 pdf:
 	$(MAKE) -C Documentation pdf
 
+#H# Generate tags using etags
 TAGS:
 	$(RM) TAGS
 	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
 
+#H# Generate tags using ctags
 tags:
 	$(RM) tags
 	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
 
+#H# Generate cscope index
 cscope:
 	$(RM) cscope*
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
@@ -2040,6 +2048,7 @@ export NO_SVN_TESTS
 
 ### Testing rules
 
+#H# Check the build by running the test suite
 test: all
 	$(MAKE) -C t/ all
 
@@ -2099,6 +2108,7 @@ export gitexec_instdir
 
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
 
+#H# Install the git suite
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
@@ -2155,27 +2165,35 @@ endif
 install-gitweb:
 	$(MAKE) -C gitweb install
 
+#H# Install man pages
 install-doc:
 	$(MAKE) -C Documentation install
 
+#H# Install man pages
 install-man:
 	$(MAKE) -C Documentation install-man
 
+#H# Install HTML docs
 install-html:
 	$(MAKE) -C Documentation install-html
 
+#H# Install info docs
 install-info:
 	$(MAKE) -C Documentation install-info
 
+#H# Install PDF docs
 install-pdf:
 	$(MAKE) -C Documentation install-pdf
 
+#H# Install pregenerated man pages from origin/man
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
+#H# Install pregenerated man pages from origin/man
 quick-install-man:
 	$(MAKE) -C Documentation quick-install-man
 
+#H# Install pregenerated HTML pages from origin/html
 quick-install-html:
 	$(MAKE) -C Documentation quick-install-html
 
@@ -2188,6 +2206,7 @@ git.spec: git.spec.in
 	mv $@+ $@
 
 GIT_TARNAME=git-$(GIT_VERSION)
+#H# Build git-$(GIT_VERSION).tar.gz source
 dist: git.spec git-archive$(X) configure
 	./git-archive --format=tar \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
@@ -2203,6 +2222,7 @@ dist: git.spec git-archive$(X) configure
 	@$(RM) -r $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
 
+#H# Build source and binary RPM packages
 rpm: dist
 	$(RPMBUILD) \
 		--define "_source_filedigest_algorithm md5" \
@@ -2211,6 +2231,8 @@ rpm: dist
 
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
+
+#H# Build $(manpages).tar.gz and $(htmldocs).tar.gz
 dist-doc:
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
@@ -2230,10 +2252,11 @@ dist-doc:
 	$(RM) -r .doc-tmp-dir
 
 ### Cleaning rules
-
+#H# Remove generated files and the configure script
 distclean: clean
 	$(RM) configure
 
+#H# Remove generated files but keep the configure script
 clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
 		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
@@ -2268,7 +2291,7 @@ endif
 .PHONY: FORCE TAGS tags cscope
 
 ### Check documentation
-#
+#H# Check documentation coverage
 check-docs::
 	@(for v in $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk; \
 	do \
@@ -2335,6 +2358,7 @@ check-builtins::
 #
 .PHONY: coverage coverage-clean coverage-build coverage-report
 
+#H# Check test coverage
 coverage:
 	$(MAKE) coverage-build
 	$(MAKE) coverage-report
@@ -2370,5 +2394,15 @@ coverage-untested-functions: coverage-report
 cover_db: coverage-report
 	gcov2perl -db cover_db *.gcov
 
+#H# Check test coverage and create HTMl report
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
+
+#H# Show help for main make targets
+help:
+	@sed -n  -e '/^#H#/ {N'\
+		-e 's/^#H# \(.*\)\n\([a-z0-9_-]*\):.*/\2 \1/p'\
+		-e '}' <Makefile | sort --key=2 | while read target txt;\
+	do \
+		printf "%-20s: %s\n" "$$target" "$$txt"; \
+	done
-- 
1.7.3.98.g5ad7d
