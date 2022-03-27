Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9A7C433EF
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 13:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiC0NUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiC0NUD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 09:20:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274E913EA2
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 06:18:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r13so16685635wrr.9
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=49/p0Jd7SXM3jMUC6daqniBxl+Tu8aqQUvDc/bECvgw=;
        b=QTr4D2jqYEP9byJFLg7Fpdtpz7CBSAGNLBdx/itWdOHyRhgkDnFupL+w6eMz2yFtCe
         vjvinUGIplx0ud0f3xMCT6aHp9v+/xz8VFOJT8IcL8DKFIVSL7/kCtAHX5hKfPt4sjNO
         36BW0ufXfJJ59NlD+DTZlxjvofloQ1Iqzj1t61T/Z5cPlQV0Y4lTw+fdBg6UCeT9qgU4
         lyLUPnkPrn5R2HShkptiwX9/IYlJfOJ82S7lnn7tESxCBAO/GAXCe8t6LLc2cZbZBv9S
         2Ox/N6Mgp4YNVsGMPRafKx+Rhubflu6dlS09fQmh/SWbXhqcuQGW8t3iM+XfA1N9Y4pN
         dwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=49/p0Jd7SXM3jMUC6daqniBxl+Tu8aqQUvDc/bECvgw=;
        b=6QZqNjPePoVzG1Nyi+CMsJyXly1dzJzArjHDHOFU5TC47RgTar43BvjUmsj4IvAFQN
         5Qr5zxxGx9QBpGroNjGiOAFkKBb+ClnVHhCcJnhI5eMlXHoJ9taG2CmQJmiWMVcathCz
         zZTF+3DnwMIgvYO2m7cF8m7V3z5j64U7+CXo4M9EAiu3IlcezxTfKr4LFjcKzqu2skqh
         6H1wV+lJyyIErXzWOul1FucHPC8N+3etj83Z9X7fq1KSlSCRvnWb1k8duqfG1B0xfiTR
         Y+pIK7Ve8AyVqepiwxkZBLmXSOf3pT/GDZxAVp5KZeeU60nmI/VyiPi7QxpZFKAgwpcU
         fQdA==
X-Gm-Message-State: AOAM530GjoQjvdO6cK+A03L75Gu03WYg53qm0I3CEJIMiRXFE2B28R8+
        736NtnEtuaYP+5U8Q8ah32hnzbuaJSJbuQ==
X-Google-Smtp-Source: ABdhPJwC/xdX2ROahGNppBFigmjLKqzofE70p0g26dVqc3S5UTF0WfU25vu6dXQ7VIVhHHT+XDpv8g==
X-Received: by 2002:a5d:4310:0:b0:1ef:fb60:e1d8 with SMTP id h16-20020a5d4310000000b001effb60e1d8mr17277068wrq.92.1648387102180;
        Sun, 27 Mar 2022 06:18:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000188b00b00204109f7826sm10899518wri.28.2022.03.27.06.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 06:18:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Fernando Ramos <greenfoo@u92.eu>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tests: do roundtrip builtin doc & sanity checking
Date:   Sun, 27 Mar 2022 15:18:20 +0200
Message-Id: <patch-1.1-4a5d219dfe7-20220327T131751Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1535.gc79a163ff4c
In-Reply-To: <xmqq4k3k6xw3.fsf@gitster.g>
References: <xmqq4k3k6xw3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the part of "make check-docs" first added in [1] and the
entirety of "make check-builtins" first added in [2] with checks that
do checking against --list-cmds=main (see [3]) and that our generated
"man" docs instead.

The "check-docs" part of this was mostly broken anyway, in that we
were ignoring the exit code. Since b6d8887d3d6 (documentation: add
documentation for 'git version', 2021-09-14) we started emitting:

	$ make -s check-docs
	removed but documented: git-version

But as noted in [4] the check didn't fail.

By checking that we get the man page when running "git $cmd --help" we
can be sure that we don't miss anything. To do this add a
GIT_TEST_MANPATH, as we don't want to append to the manpath as we'd
pick up the MANPATH on the system.

There is no replacement provided for the "$base is builtin but
$builtin.$sfx still exists" part of the "check-builtins" check being
removed here. Back when it was added various commands were being
migrated to C at a rapid rate, now we have just a few stragglers
in *.sh and *.perl. It's unlikely that we'd forget to remove the old
code.

1. 8c989ec5288 (Makefile: $(MAKE) check-docs, 2006-04-13)
2. c74390e4a1d (cherry is built-in, do not ship git-cherry.sh,
   2006-11-05)
3. 6bb2dc0b947 (completion: implement and use --list-cmds=main,others,
   2018-05-20)
4. https://lore.kernel.org/git/87o88i2keu.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile     |  3 --
 Makefile                   | 39 +----------------
 builtin/help.c             | 12 +++++-
 check-builtins.sh          | 34 ---------------
 ci/install-dependencies.sh |  3 ++
 t/t0012-help.sh            | 86 +++++++++++++++++++++++++++++++++++++-
 6 files changed, 101 insertions(+), 76 deletions(-)
 delete mode 100755 check-builtins.sh

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1eb9192dae8..a2c6ef479e0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -431,9 +431,6 @@ require-htmlrepo::
 quick-install-html: require-htmlrepo
 	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(htmldir) $(GIT_MAN_REF)
 
-print-man1:
-	@for i in $(MAN1_TXT); do echo $$i; done
-
 ## Lint: gitlink
 LINT_DOCS_GITLINK = $(patsubst %.txt,.build/lint-docs/gitlink/%.ok,$(HOWTO_TXT) $(DOC_DEP_TXT))
 $(LINT_DOCS_GITLINK): lint-gitlink.perl
diff --git a/Makefile b/Makefile
index e8aba291d7f..c5b83f80a3a 100644
--- a/Makefile
+++ b/Makefile
@@ -3331,46 +3331,11 @@ ALL_COMMANDS += gitweb
 .PHONY: check-docs
 check-docs::
 	$(MAKE) -C Documentation lint-docs
-	@(for v in $(patsubst %$X,%,$(ALL_COMMANDS)); \
-	do \
-		case "$$v" in \
-		git-merge-octopus | git-merge-ours | git-merge-recursive | \
-		git-merge-resolve | git-merge-subtree | \
-		git-fsck-objects | git-init-db | \
-		git-remote-* | git-stage | git-legacy-* | \
-		git-?*--?* ) continue ;; \
-		esac ; \
-		test -f "Documentation/$$v.txt" || \
-		echo "no doc: $$v"; \
-		sed -e '1,/^### command list/d' -e '/^#/d' command-list.txt | \
-		grep -q "^$$v[ 	]" || \
-		case "$$v" in \
-		git) ;; \
-		*) echo "no link: $$v";; \
-		esac ; \
-	done; \
-	( \
-		sed -e '1,/^### command list/d' \
-		    -e '/^#/d' \
-		    -e '/guide$$/d' \
-		    -e 's/[ 	].*//' \
-		    -e 's/^/listed /' command-list.txt; \
-		$(MAKE) -C Documentation print-man1 | \
-		grep '\.txt$$' | \
-		sed -e 's|^|documented |' \
-		    -e 's/\.txt//'; \
-	) | while read how cmd; \
-	do \
-		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS)) " in \
-		*" $$cmd "*)	;; \
-		*) echo "removed but $$how: $$cmd" ;; \
-		esac; \
-	done ) | sort
 
 ### Make sure built-ins do not have dups and listed in git.c
 #
-check-builtins::
-	./check-builtins.sh
+check-builtins:: all man
+	$(MAKE) -C t T=t0012-help.sh
 
 ### Test suite coverage testing
 #
diff --git a/builtin/help.c b/builtin/help.c
index 222f994f863..775eee76c05 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -434,7 +434,7 @@ static const char *cmd_to_page(const char *git_cmd)
 		return xstrfmt("git%s", git_cmd);
 }
 
-static void setup_man_path(void)
+static void setup_real_man_path(void)
 {
 	struct strbuf new_path = STRBUF_INIT;
 	const char *old_path = getenv("MANPATH");
@@ -455,6 +455,16 @@ static void setup_man_path(void)
 	strbuf_release(&new_path);
 }
 
+static void setup_man_path(void)
+{
+	const char *test_manpath = getenv("GIT_TEST_MANPATH");
+
+	if (test_manpath)
+		xsetenv("MANPATH", test_manpath, 1);
+	else
+		setup_real_man_path();
+}
+
 static void exec_viewer(const char *name, const char *page)
 {
 	const char *info = get_man_viewer_info(name);
diff --git a/check-builtins.sh b/check-builtins.sh
deleted file mode 100755
index a0aaf3a3473..00000000000
--- a/check-builtins.sh
+++ /dev/null
@@ -1,34 +0,0 @@
-#!/bin/sh
-
-{
-	cat <<\EOF
-sayIt:
-	$(foreach b,$(BUILT_INS),echo XXX $(b:$X=) YYY;)
-EOF
-	cat Makefile
-} |
-make -f - sayIt 2>/dev/null |
-sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p' |
-sort |
-{
-    bad=0
-    while read builtin
-    do
-	base=$(expr "$builtin" : 'git-\(.*\)')
-	x=$(sed -ne 's/.*{ "'$base'", \(cmd_[^, ]*\).*/'$base'	\1/p' git.c)
-	if test -z "$x"
-	then
-		echo "$base is builtin but not listed in git.c command list"
-		bad=1
-	fi
-	for sfx in sh perl py
-	do
-		if test -f "$builtin.$sfx"
-		then
-			echo "$base is builtin but $builtin.$sfx still exists"
-			bad=1
-		fi
-	done
-    done
-    exit $bad
-}
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dbcebad2fb2..1df7c908db0 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -71,6 +71,9 @@ Documentation)
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
+
+	sudo apt-get -q -y install libcurl4-openssl-dev libssl-dev \
+		libexpat-dev gettext make
 	;;
 linux-gcc-default)
 	sudo apt-get -q update
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 6c3e1f7159d..522eb1b492d 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -234,7 +234,9 @@ test_expect_success "'git help -g' section spacing" '
 
 test_expect_success 'generate builtin list' '
 	mkdir -p sub &&
-	git --list-cmds=builtins >builtins
+	git --list-cmds=builtins >builtins &&
+	uniq builtins >builtins.uniq &&
+	test_cmp builtins builtins.uniq
 '
 
 while read builtin
@@ -249,4 +251,86 @@ do
 	'
 done <builtins
 
+
+symlink_test_manpath () {
+	local doc="$GIT_BUILD_DIR"/Documentation &&
+	test_path_exists "$doc"/git-add.1 &&
+	test_when_finished "rm -f man1" &&
+	ln -s "$doc" man1
+}
+
+# Use "git-add" as a guinea pig, and check the basic sanity of the
+# output.
+test_lazy_prereq HAVE_BUILT_DOCS '
+	symlink_test_manpath &&
+	test_when_finished "rm -f man.txt" &&
+	GIT_TEST_MANPATH="$PWD" git add --help >man.txt &&
+	grep GIT-ADD man.txt &&
+	grep ^SYNOPSIS man.txt
+'
+
+is_documented () {
+	cat >undocumented <<-\EOF
+	add--interactive
+	bisect--helper
+	checkout--worker
+	difftool--helper
+	env--helper
+	merge-octopus
+	merge-ours
+	merge-recursive
+	merge-recursive-ours
+	merge-recursive-theirs
+	merge-resolve
+	merge-subtree
+	pickaxe
+	remote-ftp
+	remote-ftps
+	remote-http
+	remote-https
+	submodule--helper
+	upload-archive--writer
+	EOF
+	! grep -q "^$1$" undocumented
+}
+
+test_undocumented () {
+	cmd=$1 &&
+	test_expect_success HAVE_BUILT_DOCS "$cmd does not have --help documentation" '
+		symlink_test_manpath &&
+		test_when_finished "rm -f man.txt" &&
+		test_must_fail env GIT_TEST_MANPATH="$PWD" git $cmd --help >man.txt
+	'
+}
+
+test_documented () {
+	cmd=$1 &&
+	test_expect_success HAVE_BUILT_DOCS "$cmd can handle --help" '
+		symlink_test_manpath &&
+		test_when_finished "rm -f man.txt" &&
+		GIT_TEST_MANPATH="$PWD" git $cmd --help >man.txt &&
+		grep "git-$cmd" man.txt
+	'
+}
+
+test_expect_success 'generate main list' '
+	mkdir -p sub &&
+	git --list-cmds=main >main
+'
+
+while read cmd
+do
+	case "$cmd" in
+	*.sh|*.perl|*.py)
+		    continue
+		    ;;
+	esac &&
+	if is_documented "$cmd"
+	then
+		test_documented "$cmd"
+	else
+		test_undocumented "$cmd"
+	fi
+done <main
+
 test_done
-- 
2.35.1.1535.gc79a163ff4c

