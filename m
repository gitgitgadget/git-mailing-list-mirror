From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] t9010-svn-fi: Add tests for svn-fi
Date: Tue,  1 Feb 2011 19:56:42 +0530
Message-ID: <1296570403-9082-3-git-send-email-artagnon@gmail.com>
References: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 01 15:26:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkHBf-0007hB-Ir
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 15:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125Ab1BAO0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 09:26:17 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38874 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab1BAO0P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 09:26:15 -0500
Received: by ywe10 with SMTP id 10so2470463ywe.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=xuX/cB7FM2ukDDCLAmSxg1CGwiLOWhihpt7ondAjhec=;
        b=CqAg7Frt8pjQf4NAifV7kZSzPpsnlIHBUV6OwgwdiE3zx8ThDCKB6mfqQWXgckhONg
         QIvIb6YfCll6Bhibp+6qlfQt0/OC7AAwKQ3ZeE0hpGTXDWE+kP7JS+J3mLz+3fxeDYv+
         Ro4R6BgUfJtH7NfvFC3q4kXSzyz+Zov6jD7CE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b5V8g+c6iA3Zy4ubWhJMpDN38KBL0CktNXCEA23KIUlK6/mPBLCaqIG1OiqAzPMqRj
         IjBl/enrfwlt6AhPDcY1AddCWqdVQn0oSO4yB1WJTusV8KNsRZP5ia0iUxwh822Ds8nN
         deeisq+P80Vf89YiBLMeUEsSrN4vIZMwXOPNU=
Received: by 10.236.95.140 with SMTP id p12mr15961360yhf.38.1296570374272;
        Tue, 01 Feb 2011 06:26:14 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id i36sm1494275yhd.27.2011.02.01.06.26.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 06:26:13 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165808>

Create a test-svn-fi in toplevel directory, add rules to build it, and
add some basic tests.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 .gitignore        |    1 +
 Makefile          |    5 +-
 t/t9010-svn-fi.sh |  303 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 test-svn-fi.c     |   20 ++++
 4 files changed, 328 insertions(+), 1 deletions(-)
 create mode 100644 t/t9010-svn-fi.sh
 create mode 100644 test-svn-fi.c

diff --git a/.gitignore b/.gitignore
index b48d1ee..c8c8a17 100644
--- a/.gitignore
+++ b/.gitignore
@@ -177,6 +177,7 @@
 /test-sigchain
 /test-subprocess
 /test-svn-fe
+/test-svn-fi
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index d9c2442..cb21b78 100644
--- a/Makefile
+++ b/Makefile
@@ -431,6 +431,7 @@ TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
+TEST_PROGRAMS_NEED_X += test-svn-fi
 TEST_PROGRAMS_NEED_X += test-index-version
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
@@ -1838,7 +1839,7 @@ VCSSVN_OBJS = vcs-svn/line_buffer.o vcs-svn/svnload.o vcs-svn/dump_export.o \
 	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/sliding_window.o \
 	vcs-svn/svndiff.o vcs-svn/svndump.o vcs-svn/dir_cache.o
 VCSSVN_TEST_OBJS = test-obj-pool.o \
-	test-line-buffer.o test-treap.o test-svn-fe.o
+	test-line-buffer.o test-treap.o test-svn-fe.o test-svn-fi.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -2129,6 +2130,8 @@ test-parse-options$X: parse-options.o
 
 test-svn-fe$X: vcs-svn/lib.a
 
+test-svn-fi$X: vcs-svn/lib.a
+
 .PRECIOUS: $(TEST_OBJS)
 
 test-%$X: test-%.o $(GITLIBS)
diff --git a/t/t9010-svn-fi.sh b/t/t9010-svn-fi.sh
new file mode 100644
index 0000000..676c7fc
--- /dev/null
+++ b/t/t9010-svn-fi.sh
@@ -0,0 +1,303 @@
+#!/bin/sh
+
+test_description='check svn dumpfile exporter'
+
+. ./test-lib.sh
+
+if ! svnadmin -h >/dev/null 2>&1
+then
+	skip_all='skipping svn-fi tests, svn not available'
+	test_done
+fi
+
+svnrepo="testsvn"
+
+reinit_svn () {
+	rm -rf "$svnrepo" &&
+	rm -f stream &&
+	svnadmin create "$svnrepo" &&
+	printf "#!/bin/sh" > "$svnrepo"/hooks/pre-revprop-change &&
+	chmod +x "$svnrepo"/hooks/pre-revprop-change &&
+	mkfifo stream
+}
+
+svn_look () {
+	subcommand=$1 &&
+	shift &&
+	svnlook "$subcommand" "$svnrepo" "$@"
+}
+
+try_load () {
+	input=$1 &&
+	maybe_fail=${2:+test_$2} &&
+
+	{
+		$maybe_fail test-svn-fi "$input" >stream &
+	} &&
+	svnadmin load "$svnrepo" <stream &&
+	wait $!
+}
+
+test_expect_success 'normal empty files' '
+	reinit_svn &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 foo
+	 bar
+	EOF
+	cat >input <<-\EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author nobody <nobody@localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 0
+	M 100644 inline foo
+	data 0
+	M 644 inline bar
+	data 0
+
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	test_cmp expect.tree actual.tree
+'
+
+# TODO: How to test date? Need to convert from local timestamp
+test_expect_success 'svn:author and svn:log' '
+	reinit_svn &&
+	echo "nothing" >expect.log &&
+	echo "nobody" >expect.author &&
+	cat >input <<-\EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author nobody <nobody@localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 7
+	nothing
+	M 100644 inline foo
+	data 0
+
+	EOF
+	try_load input &&
+	svn_look log >actual.log &&
+	svn_look author >actual.author &&
+	test_cmp expect.log actual.log &&
+	test_cmp expect.author actual.author
+'
+
+test_expect_success 'missing author line' '
+	reinit_svn &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 foo
+	EOF
+	cat >input <<-\EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 0
+	M 100644 inline foo
+	data 0
+
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	test_cmp expect.tree actual.tree
+'
+
+test_expect_success 'blob marks unsupported' '
+	reinit_svn &&
+	cat >input <<-\EOF &&
+	blob
+	mark :1
+	data 0
+
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :2
+	author nobody <nobody@localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 0
+	M 100644 :1 foo
+
+	EOF
+	try_load input must_fail
+'
+
+test_expect_success 'malformed fast-import stream: filemodify' '
+	reinit_svn &&
+	cat >input <<-\EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author nobody <nobody@localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 0
+	M 100644 inline
+
+	EOF
+	try_load input must_fail
+'
+
+test_expect_success 'malformed fast-import stream: author' '
+	reinit_svn &&
+	cat >input <<-\EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author 2d3%*s&f#k|
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 0
+	M 100644 inline foo
+	data 0
+
+	EOF
+	try_load input must_fail
+'
+
+test_expect_success 'malformed fast-import stream: author 2' '
+	reinit_svn &&
+	cat >input <<-\EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author nobody <localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 0
+	M 100644 inline foo
+	data 0
+
+	EOF
+	try_load input must_fail
+'
+
+test_expect_success 'malformed fast-import stream: data length' '
+	reinit_svn &&
+	cat >input <<-\EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author nobody <nobody@localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 0
+	M 100644 inline foo
+	data 14238
+
+	EOF
+	test_must_fail try_load input
+'
+
+test_expect_success 'recursive directory creation' '
+	reinit_svn &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 alpha/
+	  beta/
+	   gamma
+	EOF
+	cat >input <<-\EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author nobody <nobody@localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 7
+	nothing
+	M 100644 inline alpha/beta/gamma
+	data 12
+	some content
+
+	EOF
+	try_load input &&
+	svn_look tree >actual.tree &&
+	test_cmp expect.tree actual.tree
+'
+
+test_expect_success 'svn:special and svn:executable' '
+	reinit_svn &&
+	cat >input <<-\EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author nobody <nobody@localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 7
+	nothing
+	M 100755 inline foo
+	data 0
+	M 755 inline moo
+	data 0
+	M 120000 inline bar
+	data 0
+
+	EOF
+	try_load input &&
+	svn_look propget svn:executable foo &&
+	svn_look propget svn:executable moo &&
+	svn_look propget svn:special bar
+'
+
+test_expect_success 'replace symlink with normal file' '
+	reinit_svn &&
+	cat >expect.tree <<-\EOF &&
+	/
+	 alpha/
+	  beta/
+	   gamma
+	EOF
+	cat >input <<-\EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author nobody <nobody@localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 7
+	nothing
+	M 120000 inline alpha/beta/gamma
+	data 0
+	commit refs/heads/master
+	mark :1
+	author nobody <nobody@localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 7
+	nothing
+	M 100644 inline alpha/beta/gamma
+	data 0
+
+	EOF
+	try_load input &&
+	svn_look tree -r1 >actual.tree1 &&
+	svn_look tree -r2 >actual.tree2 &&
+	test_cmp expect.tree actual.tree1 &&
+	test_cmp expect.tree actual.tree2
+'
+
+test_expect_success 'path includes symlink' '
+	reinit_svn &&
+	cat >input <<-\EOF &&
+	reset refs/heads/master
+	commit refs/heads/master
+	mark :1
+	author nobody <nobody@localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 7
+	nothing
+	M 120000 inline alpha/beta/gamma
+	data 0
+	commit refs/heads/master
+	mark :1
+	author nobody <nobody@localhost> 1170199019 +0100
+	committer nobody <nobody@localhost> 1170199019 +0100
+	data 7
+	nothing
+	M 100644 inline alpha/beta/gamma/bar
+	data 0
+
+	EOF
+	test_must_fail try_load input
+'
+
+test_done
diff --git a/test-svn-fi.c b/test-svn-fi.c
new file mode 100644
index 0000000..b0605fe
--- /dev/null
+++ b/test-svn-fi.c
@@ -0,0 +1,20 @@
+/*
+ * test-svn-fe: Code to exercise the svn import lib
+ */
+
+#include "git-compat-util.h"
+#include "vcs-svn/svnload.h"
+
+int main(int argc, char *argv[])
+{
+	static const char test_svnfe_usage[] =
+		"test-svn-fe (<dumpfile>";
+	if (argc == 2) {
+		if (svnload_init(argv[1]))
+			return 1;
+		svnload_read();
+		svnload_deinit();
+		return 0;
+	}
+	usage(test_svnfe_usage);
+}
-- 
1.7.4.rc1.7.g2cf08.dirty
