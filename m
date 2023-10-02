Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9742E784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbjJBCmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjJBCla (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:30 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AABCEC
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:41:06 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-79f909071c3so570339339f.0
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214465; x=1696819265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uc1k82xvBrnb7Z3un/5fTBvAnqrfiI/m0uwTG7KGIlE=;
        b=Uz5FQne7QoTdHcpIwtvavJ19BYp6/h2dD7mwnJs4P2oedmT2smKh1zK5Y2r4HVpPw7
         BdXRc2yWjE7KvwFe2wDZExlIHQ1n8g+SpTV/Np1oZsvfQMpGhVhCJ6ghWLmd8JHIHfsw
         mDONutSnMu24uFIAvq+ZwbiC1hynNs6qIVicmGfffomcaaRFyh/3QScioNmScm5hPz+8
         rLr86A5WOxJWfXxlaIPEcV+ifkHxujKcpTswnSgGJ/qZs79QGkahPz89ogcUytgX7MTU
         r65FPImVG7XTKEo7MNXGkL/XKKj9rhByEqktx/cmtVYjQWGPTjWc4AKV0k8qdn7Qt9f2
         mGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214465; x=1696819265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uc1k82xvBrnb7Z3un/5fTBvAnqrfiI/m0uwTG7KGIlE=;
        b=j2bfecgYlqwh1rG3QJIAINlE4hhNIYjtLUlZ1J/bd3hondULv56fkCNa2LGNLdkAxk
         cTNUXnh+TCJqrM2++b86V9G/aM1qS1q00V99c18cfEosxa7M0ibSrJgyGRG1FHfpqUHo
         /Tthg0Fo2rd0f0BAEp0E3/lHfe36UCLtPkmbdjL9qsTeUADPaqMOx8nk2XH0cysguxA3
         /n8QGw1qmtUTDLJIIpPWKPBzojpey5LdH0g/60T1wS40sJfg14L/tF7MhZEB/O3ZDX4i
         a4rpLamJA0HBCwmbaEYoIQeaBI8cce0PgirfdVwvXrY8E0EyJLpxRWCO2WvjFIrHhrvM
         KREA==
X-Gm-Message-State: AOJu0YxZmyju2rzMwarAeHhNHP5TsE2DCH818EngwjkFJirQ1Ykh+kpJ
        YB78MuGvbGY8D7O1zuD9CZI=
X-Google-Smtp-Source: AGHT+IGJZLtkpDBvveaUJfGfF4mx84Heyrm5ngtpa/40IEpANYrGrM4RKRGfSLSwdGmCgN3fwL+ScQ==
X-Received: by 2002:a6b:4405:0:b0:785:5917:a35f with SMTP id r5-20020a6b4405000000b007855917a35fmr12552355ioa.8.1696214465380;
        Sun, 01 Oct 2023 19:41:05 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:41:04 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 30/30] t1016-compatObjectFormat: add tests to verify the conversion between objects
Date:   Sun,  1 Oct 2023 21:40:34 -0500
Message-Id: <20231002024034.2611-30-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

For now my strategy is simple.  Create two identical repositories one
in each format.  Use fixed timestamps. Verify the dynamically computed
compatibility objects from one repository match the objects stored in
the other repository.

A general limitation of this strategy is that the git when generating
signed tags and commits with compatObjectFormat enabled will generate
a signature for both formats.  To overcome this limitation I have
added "test-tool delete-gpgsig" that when fed an signed commit or tag
with two signatures deletes one of the signatures.

With that in place I can have "git commit" and  "git tag" generate
signed objects, have my tool delete one, and feed the new object
into "git hash-object" to create the kinds of commits and tags
git without compatObjectFormat enabled will generate.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 Makefile                      |   1 +
 t/helper/test-delete-gpgsig.c |  62 ++++++++
 t/helper/test-tool.c          |   1 +
 t/helper/test-tool.h          |   1 +
 t/t1016-compatObjectFormat.sh | 281 ++++++++++++++++++++++++++++++++++
 t/t1016/gpg                   |   2 +
 6 files changed, 348 insertions(+)
 create mode 100644 t/helper/test-delete-gpgsig.c
 create mode 100755 t/t1016-compatObjectFormat.sh
 create mode 100755 t/t1016/gpg

diff --git a/Makefile b/Makefile
index 3c18664def9a..3e4444fb9ab2 100644
--- a/Makefile
+++ b/Makefile
@@ -790,6 +790,7 @@ TEST_BUILTINS_OBJS += test-crontab.o
 TEST_BUILTINS_OBJS += test-csprng.o
 TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
+TEST_BUILTINS_OBJS += test-delete-gpgsig.o
 TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-dir-iterator.o
 TEST_BUILTINS_OBJS += test-drop-caches.o
diff --git a/t/helper/test-delete-gpgsig.c b/t/helper/test-delete-gpgsig.c
new file mode 100644
index 000000000000..e36831af03f6
--- /dev/null
+++ b/t/helper/test-delete-gpgsig.c
@@ -0,0 +1,62 @@
+#include "test-tool.h"
+#include "gpg-interface.h"
+#include "strbuf.h"
+
+
+int cmd__delete_gpgsig(int argc, const char **argv)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *pattern = "gpgsig";
+	const char *bufptr, *tail, *eol;
+	int deleting = 0;
+	size_t plen;
+
+	if (argc >= 2) {
+		pattern = argv[1];
+		argv++;
+		argc--;
+	}
+
+	plen = strlen(pattern);
+	strbuf_read(&buf, 0, 0);
+
+	if (!strcmp(pattern, "trailer")) {
+		size_t payload_size = parse_signed_buffer(buf.buf, buf.len);
+		fwrite(buf.buf, 1, payload_size, stdout);
+		fflush(stdout);
+		return 0;
+	}
+
+	bufptr = buf.buf;
+	tail = bufptr + buf.len;
+
+	while (bufptr < tail) {
+		/* Find the end of the line */
+		eol = memchr(bufptr, '\n', tail - bufptr);
+		if (!eol)
+			eol = tail;
+
+		/* Drop continuation lines */
+		if (deleting && (bufptr < eol) && (bufptr[0] == ' ')) {
+			bufptr = eol + 1;
+			continue;
+		}
+		deleting = 0;
+
+		/* Does the line match the prefix? */
+		if (((bufptr + plen) < eol) &&
+		    !memcmp(bufptr, pattern, plen) &&
+		    (bufptr[plen] == ' ')) {
+			deleting = 1;
+			bufptr = eol + 1;
+			continue;
+		}
+
+		/* Print all other lines */
+		fwrite(bufptr, 1, (eol - bufptr) + 1, stdout);
+		bufptr = eol + 1;
+	}
+	fflush(stdout);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index abe8a785eb65..8b6c84f202d6 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -21,6 +21,7 @@ static struct test_cmd cmds[] = {
 	{ "csprng", cmd__csprng },
 	{ "ctype", cmd__ctype },
 	{ "date", cmd__date },
+	{ "delete-gpgsig", cmd__delete_gpgsig },
 	{ "delta", cmd__delta },
 	{ "dir-iterator", cmd__dir_iterator },
 	{ "drop-caches", cmd__drop_caches },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ea2672436c9a..76baaece35b9 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -15,6 +15,7 @@ int cmd__csprng(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
+int cmd__delete_gpgsig(int argc, const char **argv);
 int cmd__dir_iterator(int argc, const char **argv);
 int cmd__drop_caches(int argc, const char **argv);
 int cmd__dump_cache_tree(int argc, const char **argv);
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
new file mode 100755
index 000000000000..8132cd37b8c8
--- /dev/null
+++ b/t/t1016-compatObjectFormat.sh
@@ -0,0 +1,281 @@
+#!/bin/sh
+#
+# Copyright (c) 2023 Eric Biederman
+#
+
+test_description='Test how well compatObjectFormat works'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
+
+# All of the follow variables must be defined in the environment:
+# GIT_AUTHOR_NAME
+# GIT_AUTHOR_EMAIL
+# GIT_AUTHOR_DATE
+# GIT_COMMITTER_NAME
+# GIT_COMMITTER_EMAIL
+# GIT_COMMITTER_DATE
+#
+# The test relies on these variables being set so that the two
+# different commits in two different repositories encoded with two
+# different hash functions result in the same content in the commits.
+# This means that when the commit is translated between hash functions
+# the commit is identical to the commit in the other repository.
+
+compat_hash () {
+    case "$1" in
+    "sha1")
+	echo "sha256"
+	;;
+    "sha256")
+	echo "sha1"
+	;;
+    esac
+}
+
+hello_oid () {
+    case "$1" in
+    "sha1")
+	echo "$hello_sha1_oid"
+	;;
+    "sha256")
+	echo "$hello_sha256_oid"
+	;;
+    esac
+}
+
+tree_oid () {
+    case "$1" in
+    "sha1")
+	echo "$tree_sha1_oid"
+	;;
+    "sha256")
+	echo "$tree_sha256_oid"
+	;;
+    esac
+}
+
+commit_oid () {
+    case "$1" in
+    "sha1")
+	echo "$commit_sha1_oid"
+	;;
+    "sha256")
+	echo "$commit_sha256_oid"
+	;;
+    esac
+}
+
+commit2_oid () {
+    case "$1" in
+    "sha1")
+	echo "$commit2_sha1_oid"
+	;;
+    "sha256")
+	echo "$commit2_sha256_oid"
+	;;
+    esac
+}
+
+del_sigcommit () {
+    local delete=$1
+
+    if test "$delete" = "sha256" ; then
+	local pattern="gpgsig-sha256"
+    else
+	local pattern="gpgsig"
+    fi
+    test-tool delete-gpgsig "$pattern"
+}
+
+
+del_sigtag () {
+    local storage=$1
+    local delete=$2
+
+    if test "$storage" = "$delete" ; then
+	local pattern="trailer"
+    elif test "$storage" = "sha256" ; then
+	local pattern="gpgsig"
+    else
+	local pattern="gpgsig-sha256"
+    fi
+    test-tool delete-gpgsig "$pattern"
+}
+
+base=$(pwd)
+for hash in sha1 sha256
+do
+	cd "$base"
+	mkdir -p repo-$hash
+	cd repo-$hash
+
+	test_expect_success "setup $hash repository" '
+		git init --object-format=$hash &&
+		git config core.repositoryformatversion 1 &&
+		git config extensions.objectformat $hash &&
+		git config extensions.compatobjectformat $(compat_hash $hash) &&
+		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
+		echo "Hellow World!" > hello &&
+		eval hello_${hash}_oid=$(git hash-object hello) &&
+		git update-index --add hello &&
+		git commit -m "Initial commit" &&
+		eval commit_${hash}_oid=$(git rev-parse HEAD) &&
+		eval tree_${hash}_oid=$(git rev-parse HEAD^{tree})
+	'
+	test_expect_success "create a $hash  tagged blob" '
+		git tag --no-sign -m "This is a tag" hellotag $(hello_oid $hash) &&
+		eval hellotag_${hash}_oid=$(git rev-parse hellotag)
+	'
+	test_expect_success "create a $hash tagged tree" '
+		git tag --no-sign -m "This is a tag" treetag $(tree_oid $hash) &&
+		eval treetag_${hash}_oid=$(git rev-parse treetag)
+	'
+	test_expect_success "create a $hash tagged commit" '
+		git tag --no-sign -m "This is a tag" committag $(commit_oid $hash) &&
+		eval committag_${hash}_oid=$(git rev-parse committag)
+	'
+	test_expect_success GPG2 "create a $hash signed commit" '
+		git commit --gpg-sign --allow-empty -m "This is a signed commit" &&
+		eval signedcommit_${hash}_oid=$(git rev-parse HEAD)
+	'
+	test_expect_success GPG2 "create a $hash signed tag" '
+		git tag -s -m "This is a signed tag" signedtag HEAD &&
+		eval signedtag_${hash}_oid=$(git rev-parse signedtag)
+	'
+	test_expect_success "create a $hash branch" '
+		git checkout -b branch $(commit_oid $hash) &&
+		echo "More more more give me more!" > more &&
+		eval more_${hash}_oid=$(git hash-object more) &&
+		echo "Another and another and another" > another &&
+		eval another_${hash}_oid=$(git hash-object another) &&
+		git update-index --add more another &&
+		git commit -m "Add more files!" &&
+		eval commit2_${hash}_oid=$(git rev-parse HEAD) &&
+		eval tree2_${hash}_oid=$(git rev-parse HEAD^{tree})
+	'
+	test_expect_success GPG2 "create another $hash signed tag" '
+		git tag -s -m "This is another signed tag" signedtag2 $(commit2_oid $hash) &&
+		eval signedtag2_${hash}_oid=$(git rev-parse signedtag2)
+	'
+	test_expect_success GPG2 "merge the $hash branches together" '
+		git merge -S -m "merge some signed tags together" signedtag signedtag2 &&
+		eval signedcommit2_${hash}_oid=$(git rev-parse HEAD)
+	'
+	test_expect_success GPG2 "create additional $hash signed commits" '
+		git commit --gpg-sign --allow-empty -m "This is an additional signed commit" &&
+		git cat-file commit HEAD | del_sigcommit sha256 > "../${hash}_signedcommit3" &&
+		git cat-file commit HEAD | del_sigcommit sha1 > "../${hash}_signedcommit4" &&
+		eval signedcommit3_${hash}_oid=$(git hash-object -t commit -w ../${hash}_signedcommit3) &&
+		eval signedcommit4_${hash}_oid=$(git hash-object -t commit -w ../${hash}_signedcommit4)
+	'
+	test_expect_success GPG2 "create additional $hash signed tags" '
+		git tag -s -m "This is an additional signed tag" signedtag34 HEAD &&
+		git cat-file tag signedtag34 | del_sigtag "${hash}" sha256 > ../${hash}_signedtag3 &&
+		git cat-file tag signedtag34 | del_sigtag "${hash}" sha1 > ../${hash}_signedtag4 &&
+		eval signedtag3_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag3) &&
+		eval signedtag4_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag4)
+	'
+done
+cd "$base"
+
+compare_oids () {
+    test "$#" = 5 && { local PREREQ=$1; shift; } || PREREQ=
+    local type="$1"
+    local name="$2"
+    local sha1_oid="$3"
+    local sha256_oid="$4"
+
+    echo ${sha1_oid} > ${name}_sha1_expected
+    echo ${sha256_oid} > ${name}_sha256_expected
+    echo ${type} > ${name}_type_expected
+
+    git --git-dir=repo-sha1/.git rev-parse --output-object-format=sha256 ${sha1_oid} > ${name}_sha1_sha256_found
+    git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha256_sha1_found
+    local sha1_sha256_oid=$(cat ${name}_sha1_sha256_found)
+    local sha256_sha1_oid=$(cat ${name}_sha256_sha1_found)
+
+    test_expect_success $PREREQ "Verify ${type} ${name}'s sha1 oid" '
+	git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
+	test_cmp ${name}_sha1 ${name}_sha1_expected
+'
+
+    test_expect_success $PREREQ "Verify ${type} ${name}'s sha256 oid" '
+	git --git-dir=repo-sha1/.git rev-parse --output-object-format=sha256 ${sha1_oid} > ${name}_sha256 &&
+	test_cmp ${name}_sha256 ${name}_sha256_expected
+'
+
+    test_expect_success $PREREQ "Verify ${name}'s sha1 type" '
+	git --git-dir=repo-sha1/.git cat-file -t ${sha1_oid} > ${name}_type1 &&
+	git --git-dir=repo-sha256/.git cat-file -t ${sha256_sha1_oid} > ${name}_type2 &&
+	test_cmp ${name}_type1 ${name}_type2 &&
+	test_cmp ${name}_type1 ${name}_type_expected
+'
+
+    test_expect_success $PREREQ "Verify ${name}'s sha256 type" '
+	git --git-dir=repo-sha256/.git cat-file -t ${sha256_oid} > ${name}_type3 &&
+	git --git-dir=repo-sha1/.git cat-file -t ${sha1_sha256_oid} > ${name}_type4 &&
+	test_cmp ${name}_type3 ${name}_type4 &&
+	test_cmp ${name}_type3 ${name}_type_expected
+'
+
+    test_expect_success $PREREQ "Verify ${name}'s sha1 size" '
+	git --git-dir=repo-sha1/.git cat-file -s ${sha1_oid} > ${name}_size1 &&
+	git --git-dir=repo-sha256/.git cat-file -s ${sha256_sha1_oid} > ${name}_size2 &&
+	test_cmp ${name}_size1 ${name}_size2
+'
+
+    test_expect_success $PREREQ "Verify ${name}'s sha256 size" '
+	git --git-dir=repo-sha256/.git cat-file -s ${sha256_oid} > ${name}_size3 &&
+	git --git-dir=repo-sha1/.git cat-file -s ${sha1_sha256_oid} > ${name}_size4 &&
+	test_cmp ${name}_size3 ${name}_size4
+'
+
+    test_expect_success $PREREQ "Verify ${name}'s sha1 pretty content" '
+	git --git-dir=repo-sha1/.git cat-file -p ${sha1_oid} > ${name}_content1 &&
+	git --git-dir=repo-sha256/.git cat-file -p ${sha256_sha1_oid} > ${name}_content2 &&
+	test_cmp ${name}_content1 ${name}_content2
+'
+
+    test_expect_success $PREREQ "Verify ${name}'s sha256 pretty content" '
+	git --git-dir=repo-sha256/.git cat-file -p ${sha256_oid} > ${name}_content3 &&
+	git --git-dir=repo-sha1/.git cat-file -p ${sha1_sha256_oid} > ${name}_content4 &&
+	test_cmp ${name}_content3 ${name}_content4
+'
+
+    test_expect_success $PREREQ "Verify ${name}'s sha1 content" '
+	git --git-dir=repo-sha1/.git cat-file ${type} ${sha1_oid} > ${name}_content5 &&
+	git --git-dir=repo-sha256/.git cat-file ${type} ${sha256_sha1_oid} > ${name}_content6 &&
+	test_cmp ${name}_content5 ${name}_content6
+'
+
+    test_expect_success $PREREQ "Verify ${name}'s sha256 content" '
+	git --git-dir=repo-sha256/.git cat-file ${type} ${sha256_oid} > ${name}_content7 &&
+	git --git-dir=repo-sha1/.git cat-file ${type} ${sha1_sha256_oid} > ${name}_content8 &&
+	test_cmp ${name}_content7 ${name}_content8
+'
+
+}
+
+compare_oids 'blob' hello "$hello_sha1_oid" "$hello_sha256_oid"
+compare_oids 'tree' tree "$tree_sha1_oid" "$tree_sha256_oid"
+compare_oids 'commit' commit "$commit_sha1_oid" "$commit_sha256_oid"
+compare_oids GPG2 'commit' signedcommit "$signedcommit_sha1_oid" "$signedcommit_sha256_oid"
+compare_oids 'tag' hellotag "$hellotag_sha1_oid" "$hellotag_sha256_oid"
+compare_oids 'tag' treetag "$treetag_sha1_oid" "$treetag_sha256_oid"
+compare_oids 'tag' committag "$committag_sha1_oid" "$committag_sha256_oid"
+compare_oids GPG2 'tag' signedtag "$signedtag_sha1_oid" "$signedtag_sha256_oid"
+
+compare_oids 'blob' more "$more_sha1_oid" "$more_sha256_oid"
+compare_oids 'blob' another "$another_sha1_oid" "$another_sha256_oid"
+compare_oids 'tree' tree2 "$tree2_sha1_oid" "$tree2_sha256_oid"
+compare_oids 'commit' commit2 "$commit2_sha1_oid" "$commit2_sha256_oid"
+compare_oids GPG2 'tag' signedtag2 "$signedtag2_sha1_oid" "$signedtag2_sha256_oid"
+compare_oids GPG2 'commit' signedcommit2 "$signedcommit2_sha1_oid" "$signedcommit2_sha256_oid"
+compare_oids GPG2 'commit' signedcommit3 "$signedcommit3_sha1_oid" "$signedcommit3_sha256_oid"
+compare_oids GPG2 'commit' signedcommit4 "$signedcommit4_sha1_oid" "$signedcommit4_sha256_oid"
+compare_oids GPG2 'tag' signedtag3 "$signedtag3_sha1_oid" "$signedtag3_sha256_oid"
+compare_oids GPG2 'tag' signedtag4 "$signedtag4_sha1_oid" "$signedtag4_sha256_oid"
+
+test_done
diff --git a/t/t1016/gpg b/t/t1016/gpg
new file mode 100755
index 000000000000..2601cb18a5b3
--- /dev/null
+++ b/t/t1016/gpg
@@ -0,0 +1,2 @@
+#!/bin/sh
+exec gpg --faked-system-time "20230918T154812" "$@"
-- 
2.41.0

