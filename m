Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760E32BF4B
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874246; cv=none; b=kTebF+skosDjIRLSov+lf0jH2ysvu0nI0e/u+0iAu/mo1yxlIk4C2drVXsSgSdPGKKn14bWc0g6l++mGWRR/J7G9mRUgAzogW31QhanF4AmqZscbdYPBodGxQm5G94JhhiBRJ4EYJO6xjLc6ob3440TiJAYybNVBn4xlrDrHoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874246; c=relaxed/simple;
	bh=lMQ18cvRHLfKcT59UyMgjmlh6IXlWerX1NRTo+BsQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f31goiHo6vUCz+HewESWeVREGen1WTMGgXEOCmrukL/b3MadvciIl6dcAqPHTghirqHBUGriRXyNXZCWHMzNNK9dtLfYE0EFjIg1uRnS9/WfpQfZOLz6Gu3G7oiBGcLPyiNsawccf6C7mODVqhRJnnzeCXYYqwFKGll1Bh9YF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hWJ4t5f7tzKryP;
	Fri, 28 Aug 2026 01:43:58 +0200 (CEST)
From: Wesley Schwengle <wesleys@opperschaap.net>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: [PATCH v2 2/2] Makefile: add NO_GIT_SVN knob to skip building/installing git-svn
Date: Thu, 27 Aug 2026 19:43:45 -0400
Message-ID: <20260827234345.1037130-3-wesleys@opperschaap.net>
In-Reply-To: <20260827234345.1037130-1-wesleys@opperschaap.net>
References: <xmqqy0dr8npo.fsf@gitster.g>
 <20260827234345.1037130-1-wesleys@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option also implies that NO_SVN_TESTS is enabled.

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index d4b775953d..e4b2f5fa0b 100644
--- a/Makefile
+++ b/Makefile
@@ -81,20 +81,23 @@ include shared.mak
 #
 # Define NO_SYS_SELECT_H if you don't have sys/select.h.
 #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
 #
 # Define NO_SVN_TESTS if you want to skip time-consuming SVN interoperability
 # tests.  These tests take up a significant amount of the total test time
 # but are not needed unless you plan to talk to SVN repos.
 #
+# Define NO_GIT_SVN if you don't want git-svn built or installed at all.
+# Implies NO_SVN_TESTS.
+#
 # Define NO_FINK if you are building on Darwin/Mac OS X, have Fink
 # installed in /sw, but don't want GIT to link against any libraries
 # installed there.  If defined you may specify your own (or Fink's)
 # include directories and library directories by defining CFLAGS
 # and LDFLAGS appropriately.
 #
 # Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
 # have DarwinPorts (which is an old name for MacPorts) installed
 # in /opt/local, but don't want GIT to
 # link against any libraries installed there.  If defined you may
@@ -741,21 +744,23 @@ SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-sh-i18n
 SCRIPT_LIB += git-sh-setup
 
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
 SCRIPT_PERL += git-cvsimport.perl
 SCRIPT_PERL += git-cvsserver.perl
 SCRIPT_PERL += git-send-email.perl
+ifndef NO_GIT_SVN
 SCRIPT_PERL += git-svn.perl
+endif
 
 SCRIPT_PYTHON += git-p4.py
 
 # Generated files for scripts
 SCRIPT_SH_GEN = $(patsubst %.sh,%,$(SCRIPT_SH))
 SCRIPT_PERL_GEN = $(patsubst %.perl,%,$(SCRIPT_PERL))
 SCRIPT_PYTHON_GEN = $(patsubst %.py,%,$(SCRIPT_PYTHON))
 
 # Individual rules to allow e.g.
 # "make -C ../.. SCRIPT_PERL=contrib/foo/bar.perl build-perl-script"
@@ -3408,20 +3413,23 @@ $(test_bindir_programs): bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
 	     -e 's|@GITPERLLIB@|$(shell pwd)/perl/build/lib|' \
 	     -e 's|@MERGE_TOOLS_DIR@|$(shell pwd)/mergetools|' \
 	     -e 's|@TEMPLATE_DIR@|$(shell pwd)/templates/blt|' \
 	     -e 's|@PROG@|$(shell pwd)/$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
 	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
 # However, the environment gets quite big, and some programs have problems
 # with that.
 
+ifdef NO_GIT_SVN
+NO_SVN_TESTS = YesPlease
+endif
 export NO_SVN_TESTS
 export TEST_NO_MALLOC_CHECK
 
 ### Testing rules
 
 test: all
 	$(MAKE) -C t/ all
 ifdef TEST_CONTRIB_TOO
 	$(MAKE) -C contrib/ test
 endif
-- 
2.55.0.975.g5fa7c85aff

