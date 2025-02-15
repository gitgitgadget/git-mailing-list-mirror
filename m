Received: from dalaran.tastycake.net (dalaran.tastycake.net [185.73.44.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01D1F4180
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.73.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739654371; cv=none; b=inT7oOK2X6bP0LF1RThU+WAKIwAwGkFXwQthNyqmrcZrwUd8PMxxv0E4FrffXywixqnW2Aq2chVvYQqtPyf2xyLNx0eMLlcC5H5o1XwbeOvFYpXMZt4jdhdHS96D/HKInHN/eUHnkgjFX73uo1qkv3uFncAWxVCmRmgO5bs6kfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739654371; c=relaxed/simple;
	bh=HvVqPs6V+IN8v11qRCeilb7+lc5FYv+TY2MtEMqHvzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLZy5Mr4mtBSIjdnesSdQZpTBuV5zo7zSeYSUzvRUZeVsMPJrRNXRz8dIhyg5CSOd7W5CcffWOwbn/JRGtEUp0IyYfXqNI+fTwfCrVa2NGdzwyrvGim6pgfJVHXp8/HJIghXsjgqJvjfzsG3zeWs4P4DVkPYVi6nYYAJnTr0HPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org; spf=pass smtp.mailfrom=dinwoodie.org; arc=none smtp.client-ip=185.73.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dinwoodie.org
Received: from e.0.b.e.8.e.6.5.2.3.5.6.f.7.8.6.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:de15:20ad:687f:6532:56e8:eb0e] helo=hex.dinwoodie.org)
	by dalaran.tastycake.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <adam@dinwoodie.org>)
	id 1tjPZG-005G57-Rl;
	Sat, 15 Feb 2025 21:19:18 +0000
Received: by hex.dinwoodie.org (Postfix, from userid 1000)
	id B5C50A6163B; Sat, 15 Feb 2025 21:19:15 +0000 (GMT)
From: Adam Dinwoodie <adam@dinwoodie.org>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] Makefile: set default goals in makefiles
Date: Sat, 15 Feb 2025 21:19:03 +0000
Message-ID: <20250215211904.41883-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <xmqqy0y8ywc7.fsf@gitster.g>
References: <xmqqy0y8ywc7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly set the default goal at the very top of various makefiles.
This is already present in some makefiles, but not all of them.

In particular, this corrects a regression introduced in a38edab7c8
(Makefile: generate doc versions via GIT-VERSION-GEN, 2024-12-06).  That
commit added some config files as build targets for the Documentation
directory, and put the target configuration in a sensible place.
Unfortunately, that sensible place was above any other build target
definitions, meaning the default goal changed to being those
configuration files only, rather than the HTML and man page
documentation.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile                  | 5 ++++-
 contrib/credential/libsecret/Makefile   | 3 +++
 contrib/credential/osxkeychain/Makefile | 1 +
 contrib/credential/wincred/Makefile     | 3 ++-
 contrib/diff-highlight/Makefile         | 3 ++-
 contrib/diff-highlight/t/Makefile       | 5 ++++-
 contrib/mw-to-git/Makefile              | 5 ++++-
 contrib/mw-to-git/t/Makefile            | 3 ++-
 contrib/persistent-https/Makefile       | 5 ++++-
 contrib/subtree/t/Makefile              | 5 ++++-
 git-gui/Makefile                        | 1 +
 git-gui/po/glossary/Makefile            | 3 +++
 t/interop/Makefile                      | 5 ++++-
 t/perf/Makefile                         | 5 ++++-
 templates/Makefile                      | 5 ++++-
 15 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index aedfe99d1d..ddf3aa8fac 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,3 +1,6 @@
+# The default target of this Makefile is...
+all::
+
 # Import tree-wide shared Makefile behavior and libraries
 include ../shared.mak
 
@@ -238,7 +241,7 @@ DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
 ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
 endif
 
-all: html man
+all:: html man
 
 html: $(DOC_HTML)
 
diff --git a/contrib/credential/libsecret/Makefile b/contrib/credential/libsecret/Makefile
index 3e67552cc5..97ce9c92fb 100644
--- a/contrib/credential/libsecret/Makefile
+++ b/contrib/credential/libsecret/Makefile
@@ -1,3 +1,6 @@
+# The default target of this Makefile is...
+all::
+
 MAIN:=git-credential-libsecret
 all:: $(MAIN)
 
diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index 238f5f8c36..0948297e20 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -1,3 +1,4 @@
+# The default target of this Makefile is...
 all:: git-credential-osxkeychain
 
 CC = gcc
diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
index 6e992c0866..5b795fc9fe 100644
--- a/contrib/credential/wincred/Makefile
+++ b/contrib/credential/wincred/Makefile
@@ -1,4 +1,5 @@
-all: git-credential-wincred.exe
+# The default target of this Makefile is...
+all:: git-credential-wincred.exe
 
 -include ../../../config.mak.autogen
 -include ../../../config.mak
diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
index f2be7cc924..33c2ccc9f7 100644
--- a/contrib/diff-highlight/Makefile
+++ b/contrib/diff-highlight/Makefile
@@ -1,4 +1,5 @@
-all: diff-highlight
+# The default target of this Makefile is...
+all:: diff-highlight
 
 PERL_PATH = /usr/bin/perl
 -include ../../config.mak
diff --git a/contrib/diff-highlight/t/Makefile b/contrib/diff-highlight/t/Makefile
index 5ff5275496..2a98541477 100644
--- a/contrib/diff-highlight/t/Makefile
+++ b/contrib/diff-highlight/t/Makefile
@@ -1,12 +1,15 @@
+# The default target of this Makefile is...
+all::
+
 -include ../../../config.mak.autogen
 -include ../../../config.mak
 
 # copied from ../../t/Makefile
 SHELL_PATH ?= $(SHELL)
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 
-all: test
+all:: test
 test: $(T)
 
 .PHONY: help clean all test $(T)
diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index 4e603512a3..497ac434d6 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -12,6 +12,9 @@
 #
 #   make install
 
+# The default target of this Makefile is...
+all::
+
 GIT_MEDIAWIKI_PM=Git/Mediawiki.pm
 SCRIPT_PERL=git-remote-mediawiki.perl
 SCRIPT_PERL+=git-mw.perl
@@ -27,7 +30,7 @@ INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/ \
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 INSTLIBDIR_SQ = $(subst ','\'',$(INSTLIBDIR))
 
-all: build
+all:: build
 
 test: all
 	$(MAKE) -C t
diff --git a/contrib/mw-to-git/t/Makefile b/contrib/mw-to-git/t/Makefile
index f422203fa0..6c9f377caa 100644
--- a/contrib/mw-to-git/t/Makefile
+++ b/contrib/mw-to-git/t/Makefile
@@ -8,7 +8,8 @@
 #
 ## Test git-remote-mediawiki
 
-all: test
+# The default target of this Makefile is...
+all:: test
 
 -include ../../../config.mak.autogen
 -include ../../../config.mak
diff --git a/contrib/persistent-https/Makefile b/contrib/persistent-https/Makefile
index 52b84ba3d4..691737e76b 100644
--- a/contrib/persistent-https/Makefile
+++ b/contrib/persistent-https/Makefile
@@ -12,10 +12,13 @@
 # See the License for the specific language governing permissions and
 # limitations under the License.
 
+# The default target of this Makefile is...
+all::
+
 BUILD_LABEL=$(shell cut -d" " -f3 ../../GIT-VERSION-FILE)
 TAR_OUT=$(shell go env GOOS)_$(shell go env GOARCH).tar.gz
 
-all: git-remote-persistent-https git-remote-persistent-https--proxy \
+all:: git-remote-persistent-https git-remote-persistent-https--proxy \
 	git-remote-persistent-http
 
 git-remote-persistent-https--proxy: git-remote-persistent-https
diff --git a/contrib/subtree/t/Makefile b/contrib/subtree/t/Makefile
index 093399c788..2a85f5ee84 100644
--- a/contrib/subtree/t/Makefile
+++ b/contrib/subtree/t/Makefile
@@ -3,6 +3,9 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
+# The default target of this Makefile is...
+all::
+
 -include ../../../config.mak.autogen
 -include ../../../config.mak
 
@@ -31,7 +34,7 @@ TSVN = $(sort $(wildcard t91[0-9][0-9]-*.sh))
 TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
 THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
 
-all: $(DEFAULT_TEST_TARGET)
+all:: $(DEFAULT_TEST_TARGET)
 
 test: pre-clean $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
diff --git a/git-gui/Makefile b/git-gui/Makefile
index 667c39ed56..6c5a12bc32 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -1,3 +1,4 @@
+# The default target of this Makefile is...
 all::
 
 # Define V=1 to have a more verbose compile.
diff --git a/git-gui/po/glossary/Makefile b/git-gui/po/glossary/Makefile
index 749aa2e7ec..e656b0d2b0 100644
--- a/git-gui/po/glossary/Makefile
+++ b/git-gui/po/glossary/Makefile
@@ -1,3 +1,6 @@
+# The default target of this Makefile is...
+update-po::
+
 PO_TEMPLATE = git-gui-glossary.pot
 
 ALL_POFILES = $(wildcard *.po)
diff --git a/t/interop/Makefile b/t/interop/Makefile
index 6911c2915a..4ff4ed0616 100644
--- a/t/interop/Makefile
+++ b/t/interop/Makefile
@@ -1,14 +1,17 @@
+# The default target of this Makefile is...
+all::
+
 # Import tree-wide shared Makefile behavior and libraries
 include ../../shared.mak
 
 -include ../../config.mak
 export GIT_TEST_OPTIONS
 
 SHELL_PATH ?= $(SHELL)
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 T = $(sort $(wildcard i[0-9][0-9][0-9][0-9]-*.sh))
 
-all: $(T)
+all:: $(T)
 
 $(T):
 	@echo "*** $@ ***"; '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
diff --git a/t/perf/Makefile b/t/perf/Makefile
index e4808aebed..9b3090c4ed 100644
--- a/t/perf/Makefile
+++ b/t/perf/Makefile
@@ -1,10 +1,13 @@
+# The default target of this Makefile is...
+all::
+
 # Import tree-wide shared Makefile behavior and libraries
 include ../../shared.mak
 
 -include ../../config.mak
 export GIT_TEST_OPTIONS
 
-all: test-lint perf
+all:: test-lint perf
 
 perf: pre-clean
 	./run
diff --git a/templates/Makefile b/templates/Makefile
index bd1e9e30c1..722755338d 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -1,3 +1,6 @@
+# The default target of this Makefile is...
+all::
+
 # Import tree-wide shared Makefile behavior and libraries
 include ../shared.mak
 
@@ -23,7 +26,7 @@ PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 template_instdir_SQ = $(subst ','\'',$(template_instdir))
 
-all: boilerplates.made custom
+all:: boilerplates.made custom
 
 # Put templates that can be copied straight from the source
 # in a file direc--tory--file in the source.  They will be
-- 
2.47.0

