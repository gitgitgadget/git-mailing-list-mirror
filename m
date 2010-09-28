From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] Makefile: implement help target
Date: Tue, 28 Sep 2010 22:38:04 +0200
Message-ID: <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net>
References: <AANLkTikx2tL73gJQnqjG7yp3btcZJprKLf0z9QwcAUC1@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 22:38:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0gwK-0003b7-Js
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 22:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164Ab0I1Uh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 16:37:57 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:36578 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750915Ab0I1Uh4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 16:37:56 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BC1C427C;
	Tue, 28 Sep 2010 16:37:55 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 28 Sep 2010 16:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=8HhGHfGiJBgPRzx2cprc6iariyQ=; b=Gup+KcN6r6f5I/BSr3wmf/yguP1hD2zN4PJI8NcX00RdkTEm7GO2c7nY/jlW8jIeB8iUqmnEhSBUYN6XPdUtp5y6FmBxHr4BfTEW+vreuKnSDt5ZYSQRrpuKOJIPWa2fn9n5Bn/jwBoPqQAr/IYYyCOQv062rYXvpY2pnQfCxMA=
X-Sasl-enc: 8C2zMzIp+T0nqSUSyK0FwNxLtUIxMaAh6Rl8Y+D/YTAt 1285706274
Received: from localhost (p54858FBF.dip0.t-ipconnect.de [84.133.143.191])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 651475E2A8B;
	Tue, 28 Sep 2010 16:37:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.98.g5ad7d
In-Reply-To: <AANLkTikx2tL73gJQnqjG7yp3btcZJprKLf0z9QwcAUC1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157466>

with automatic help text collection from lines starting with "# Help: " and
preceding a make target.

Suggested-by: Stephen Boyd <bebarino@gmail.com>
Helped-by: Andreas Ericsson <andreas.ericsson@op5.se>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Now how's this for portability and such? New output:

Build targets:
    all:                Build the Git suite
    dist:               Build git-$(GIT_VERSION).tar.gz source
    dist-doc:           Build $(manpages).tar.gz and $(htmldocs).tar.gz
    doc:                Build man pages and HTML docs
    html:               Build HTML doc
    info:               Build info docs
    man:                Build man pages
    pdf:                Build PDF docs
    rpm:                Build source and binary RPM packages
Clean targets:
    clean:              Remove generated files but keep the configure script
    distclean:          Remove generated files and the configure script
Develop targets:
    cscope:             Generate cscope index
    tags:               Generate tags using ctags
    TAGS:               Generate tags using etags
Help targets:
    help:               Show help for main make targets
Install targets:
    install-doc:        Install man pages
    install-html:       Install HTML docs
    install-info:       Install info docs
    install:            Install the Git suite
    install-man:        Install man pages
    install-pdf:        Install PDF docs
    quick-install-doc:  Install pregenerated man pages from origin/man
    quick-install-html: Install pregenerated HTML pages from origin/html
    quick-install-man:  Install pregenerated man pages from origin/man
Test targets:
    check-docs:         Check documentation coverage
    coverage:           Check test coverage
    cover_db_html:      Check test coverage and create HTML report
    test:               Check the build by running the test suite

 Makefile |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index db2efd6..497dd92 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,5 @@
 # The default target of this Makefile is...
+# Help: Build: Build the Git suite
 all::
 
 # Define V=1 to have a more verbose compile.
@@ -1952,29 +1953,37 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
 
+# Help: Build: Build man pages and HTML docs
 doc:
 	$(MAKE) -C Documentation all
 
+# Help: Build: Build man pages
 man:
 	$(MAKE) -C Documentation man
 
+# Help: Build: Build HTML doc
 html:
 	$(MAKE) -C Documentation html
 
+# Help: Build: Build info docs
 info:
 	$(MAKE) -C Documentation info
 
+# Help: Build: Build PDF docs
 pdf:
 	$(MAKE) -C Documentation pdf
 
+# Help: Develop: Generate tags using etags
 TAGS:
 	$(RM) TAGS
 	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
 
+# Help: Develop: Generate tags using ctags
 tags:
 	$(RM) tags
 	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
 
+# Help: Develop: Generate cscope index
 cscope:
 	$(RM) cscope*
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
@@ -2040,6 +2049,7 @@ export NO_SVN_TESTS
 
 ### Testing rules
 
+# Help: Test: Check the build by running the test suite
 test: all
 	$(MAKE) -C t/ all
 
@@ -2099,6 +2109,7 @@ export gitexec_instdir
 
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
 
+# Help: Install: Install the Git suite
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
@@ -2155,27 +2166,35 @@ endif
 install-gitweb:
 	$(MAKE) -C gitweb install
 
+# Help: Install: Install man pages
 install-doc:
 	$(MAKE) -C Documentation install
 
+# Help: Install: Install man pages
 install-man:
 	$(MAKE) -C Documentation install-man
 
+# Help: Install: Install HTML docs
 install-html:
 	$(MAKE) -C Documentation install-html
 
+# Help: Install: Install info docs
 install-info:
 	$(MAKE) -C Documentation install-info
 
+# Help: Install: Install PDF docs
 install-pdf:
 	$(MAKE) -C Documentation install-pdf
 
+# Help: Install: Install pregenerated man pages from origin/man
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
+# Help: Install: Install pregenerated man pages from origin/man
 quick-install-man:
 	$(MAKE) -C Documentation quick-install-man
 
+# Help: Install: Install pregenerated HTML pages from origin/html
 quick-install-html:
 	$(MAKE) -C Documentation quick-install-html
 
@@ -2188,6 +2207,7 @@ git.spec: git.spec.in
 	mv $@+ $@
 
 GIT_TARNAME=git-$(GIT_VERSION)
+# Help: Build: Build git-$(GIT_VERSION).tar.gz source
 dist: git.spec git-archive$(X) configure
 	./git-archive --format=tar \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
@@ -2203,6 +2223,7 @@ dist: git.spec git-archive$(X) configure
 	@$(RM) -r $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
 
+# Help: Build: Build source and binary RPM packages
 rpm: dist
 	$(RPMBUILD) \
 		--define "_source_filedigest_algorithm md5" \
@@ -2211,6 +2232,8 @@ rpm: dist
 
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
+
+# Help: Build: Build $(manpages).tar.gz and $(htmldocs).tar.gz
 dist-doc:
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
@@ -2230,10 +2253,11 @@ dist-doc:
 	$(RM) -r .doc-tmp-dir
 
 ### Cleaning rules
-
+# Help: Clean: Remove generated files and the configure script
 distclean: clean
 	$(RM) configure
 
+# Help: Clean: Remove generated files but keep the configure script
 clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
 		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
@@ -2268,7 +2292,7 @@ endif
 .PHONY: FORCE TAGS tags cscope
 
 ### Check documentation
-#
+# Help: Test: Check documentation coverage
 check-docs::
 	@(for v in $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk; \
 	do \
@@ -2335,6 +2359,7 @@ check-builtins::
 #
 .PHONY: coverage coverage-clean coverage-build coverage-report
 
+# Help: Test: Check test coverage
 coverage:
 	$(MAKE) coverage-build
 	$(MAKE) coverage-report
@@ -2370,5 +2395,19 @@ coverage-untested-functions: coverage-report
 cover_db: coverage-report
 	gcov2perl -db cover_db *.gcov
 
+# Help: Test: Check test coverage and create HTML report
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
+
+# Help: Help: Show help for main make targets
+help:
+	@awk '/^# Help:/ { l=substr($$0,8); \
+		getline; \
+		j=index(l,":"); \
+		print substr(l,1,j-1), substr($$0,1,index($$0,":")), substr(l,j+2); \
+		}' <Makefile | sort | while read category target text; \
+	do \
+		test "$$category" = "$$currcat" || printf "$$category targets:\n"; \
+		currcat="$$category"; \
+		printf "    %-20s%s\n" "$$target" "$$text"; \
+	done
-- 
1.7.3.98.g5ad7d
