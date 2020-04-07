Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331A9C2BB54
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 12:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE40F206F7
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 12:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6GztpSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgDGMIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:08:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42159 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgDGMIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 08:08:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id g6so1636045pgs.9
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 05:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IiqVaz5cJTMB/ny13GrqAqDdURHqAkS4rB+M3+MvmuU=;
        b=R6GztpSvvA8bIxmPsnz8hwQRgjpOr8ptbnB0ucL94qy3SW0dCPsEq5dz3QIRG+FKr4
         jIoz6x2s6lRHVaamPnVUHRy07B0yJrQZRfE6Ow6jY4mBqiM5jZHXYD8lpPsPhxlu2EuI
         Pfpff/JxXBropH4SlE4psrBmDh27FYSTJbFW+1rTl4vzYLut9Urw31pdEho82ZkBL+T6
         vwZI9YzvDzq5kMlLz8zmBbsew8+oxsnWOR/kW7C8y478NZPSwtNIdWOzehW4/NGLq1Eq
         pQ8zWOMSh4fAky6eiq0R3jbIToiWZlXCG7zh2fEJ6Tq0A9ZCI366xv8bZcWXF8hR2pQr
         AoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IiqVaz5cJTMB/ny13GrqAqDdURHqAkS4rB+M3+MvmuU=;
        b=VEM7oXHg2gYm+EwMpaRZ59DoLLNUl07CVxXALKt5YgY+CPR0oMDQAl9g+KuatVXyOf
         /nZUM+slxJgySH1RcrR9wp/E661jmCWPoUfh5VJ5B6+c0byGqC0io8aAWFlf4gQ1Vjov
         AQgxf+cGKv8sI4r449BOhK52oDzBT+/8RAPimILhBFNv1BlLZsS3zR5r5C2RdpYMx2mI
         ZxeQV+7TIefoUr4fMSDLju6BWTs1NtS21gdk6vWesplO3vl5M7uXp3HckB4dSUfDusEC
         WMpY6v8zCIB256SzYY18YmHs6/A3ka8wGfqBe1nJWuGv9aAHNzV3x4xQf082Z53eJxhx
         sR8w==
X-Gm-Message-State: AGi0PuYQ7tmrT3reIhruKyLRM/lUh7sHkFIWB+Eg340NH4YB5lzLqpU1
        63Bdeve5Qk/aVfGQDF9huZ4VHmp5n0E=
X-Google-Smtp-Source: APiQypJp2ZfHlfnWvt/HJ2nZJnE8+P1jsaLfcRrwZDG/cNIx3x5eOApahd3pa26XGbkXdl+QZ8jkkQ==
X-Received: by 2002:a62:e315:: with SMTP id g21mr2291550pfh.302.1586261299325;
        Tue, 07 Apr 2020 05:08:19 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e26sm14061833pfj.61.2020.04.07.05.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 05:08:18 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v9 1/6] transport: not report a non-head push as a branch
Date:   Tue,  7 Apr 2020 08:08:08 -0400
Message-Id: <20200407120813.25025-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200404134345.10655-1-worldhello.net@gmail.com>
References: <20200404134345.10655-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When pushing a new reference (not a head or tag), report it as a new
reference instead of a new branch.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411-proc-receive-hook.sh               | 75 +++++++++++++++++++
 t/t5411/common-functions.sh                | 49 ++++++++++++
 t/t5411/common-test-cases.sh               | 43 +++++++++++
 t/t5412-proc-receive-hook-http-protocol.sh | 86 ++++++++++++++++++++++
 t/t5516-fetch-push.sh                      |  2 +-
 transport.c                                |  9 ++-
 6 files changed, 260 insertions(+), 4 deletions(-)
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/common-test-cases.sh
 create mode 100755 t/t5412-proc-receive-hook-http-protocol.sh

diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
new file mode 100755
index 0000000000..09d516cf1b
--- /dev/null
+++ b/t/t5411-proc-receive-hook.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Jiang Xin
+#
+
+test_description='Test proc-receive hook'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/t5411/common-functions.sh
+
+# Format the output of git-push, git-show-ref and other commands to make a
+# user-friendly and stable text.  In addition to the common format method,
+# we also replace URL of different protocol for the upstream repository to
+# a fixed pattern.
+make_user_friendly_and_stable_output () {
+	make_user_friendly_and_stable_output_common | sed \
+		-e "s#To ../upstream.git#To <URL/of/upstream.git>#"
+}
+
+# Refs of upstream : master(B)  next(A)
+# Refs of workbench: master(A)           tags/v123
+test_expect_success "setup" '
+	git init --bare upstream.git &&
+	git init workbench &&
+	create_commits_in workbench A B &&
+	(
+		cd workbench &&
+		# Try to make a stable fixed width for abbreviated commit ID,
+		# this fixed-width oid will be replaced with "<OID>".
+		git config core.abbrev 7 &&
+		git remote add origin ../upstream.git &&
+		git update-ref refs/heads/master $A &&
+		git tag -m "v123" v123 $A &&
+		git push origin \
+			$B:refs/heads/master \
+			$A:refs/heads/next
+	) &&
+	TAG=$(git -C workbench rev-parse v123) &&
+
+	# setup pre-receive hook
+	cat >upstream.git/hooks/pre-receive <<-\EOF &&
+	#!/bin/sh
+
+	echo >&2 "# pre-receive hook"
+
+	while read old new ref
+	do
+		echo >&2 "pre-receive< $old $new $ref"
+	done
+	EOF
+
+	# setup post-receive hook
+	cat >upstream.git/hooks/post-receive <<-\EOF &&
+	#!/bin/sh
+
+	echo >&2 "# post-receive hook"
+
+	while read old new ref
+	do
+		echo >&2 "post-receive< $old $new $ref"
+	done
+	EOF
+
+	chmod a+x \
+		upstream.git/hooks/pre-receive \
+		upstream.git/hooks/post-receive &&
+
+	upstream=upstream.git
+'
+
+# Include test cases for both file and HTTP protocol
+. "$TEST_DIRECTORY"/t5411/common-test-cases.sh
+
+test_done
diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
new file mode 100644
index 0000000000..e46884f74d
--- /dev/null
+++ b/t/t5411/common-functions.sh
@@ -0,0 +1,49 @@
+# Create commits in <repo> and assign each commit's oid to shell variables
+# given in the arguments (A, B, and C). E.g.:
+#
+#     create_commits_in <repo> A B C
+#
+# NOTE: Never calling this function from a subshell since variable
+# assignments will disappear when subshell exits.
+create_commits_in () {
+	repo="$1" &&
+	if ! parent=$(git -C "$repo" rev-parse HEAD^{} --)
+	then
+		parent=
+	fi &&
+	T=$(git -C "$repo" write-tree) &&
+	shift &&
+	while test $# -gt 0
+	do
+		name=$1 &&
+		test_tick &&
+		if test -z "$parent"
+		then
+			oid=$(echo $name | git -C "$repo" commit-tree $T)
+		else
+			oid=$(echo $name | git -C "$repo" commit-tree -p $parent $T)
+		fi &&
+		eval $name=$oid &&
+		parent=$oid &&
+		shift ||
+		return 1
+	done &&
+	git -C "$repo" update-ref refs/heads/master $oid
+}
+
+# Format the output of git-push, git-show-ref and other commands to make a
+# user-friendly and stable text.  We can easily prepare the expect text
+# without having to worry about future changes of the commit ID and spaces
+# of the output.  We also replce single quotes with double quotes, because
+# it is boring to prepare unquoted single quotes in expect txt.
+make_user_friendly_and_stable_output_common () {
+	sed \
+		-e "s/  *\$//" \
+		-e "s/   */ /g" \
+		-e "s/'/\"/g" \
+		-e "s/$A/<COMMIT-A>/g" \
+		-e "s/$B/<COMMIT-B>/g" \
+		-e "s/$TAG/<TAG-v123>/g" \
+		-e "s/$ZERO_OID/<ZERO-OID>/g" \
+		-e "s/[0-9a-f]\{7,\}/<OID>/g"
+}
diff --git a/t/t5411/common-test-cases.sh b/t/t5411/common-test-cases.sh
new file mode 100644
index 0000000000..33b8541f28
--- /dev/null
+++ b/t/t5411/common-test-cases.sh
@@ -0,0 +1,43 @@
+# Refs of upstream : master(B)  next(A)
+# Refs of workbench: master(A)           tags/v123
+# git-push -f      : master(A)  NULL     tags/v123  refs/review/master/topic(A)  a/b/c(A)
+test_expect_success "normal git-push command" '
+	git -C workbench push -f origin \
+		refs/tags/v123 \
+		:refs/heads/next \
+		HEAD:refs/heads/master \
+		HEAD:refs/review/master/topic \
+		HEAD:refs/heads/a/b/c \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/next
+	remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
+	To <URL/of/upstream.git>
+	 + <OID>...<OID> HEAD -> master (forced update)
+	 - [deleted] next
+	 * [new tag] v123 -> v123
+	 * [new reference] HEAD -> refs/review/master/topic
+	 * [new branch] HEAD -> a/b/c
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/a/b/c
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/review/master/topic
+	<TAG-v123> refs/tags/v123
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t5412-proc-receive-hook-http-protocol.sh b/t/t5412-proc-receive-hook-http-protocol.sh
new file mode 100755
index 0000000000..4883e69299
--- /dev/null
+++ b/t/t5412-proc-receive-hook-http-protocol.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Jiang Xin
+#
+
+test_description='Test proc-receive hook for HTTP protocol'
+
+. ./test-lib.sh
+
+ROOT_PATH="$PWD"
+. "$TEST_DIRECTORY"/lib-gpg.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+start_httpd
+
+. "$TEST_DIRECTORY"/t5411/common-functions.sh
+
+# Format the output of git-push, git-show-ref and other commands to make a
+# user-friendly and stable text.  In addition to the common format method,
+# we also replace URL of different protocol for the upstream repository to
+# a fixed pattern.
+make_user_friendly_and_stable_output () {
+	make_user_friendly_and_stable_output_common | sed \
+		-e "s#To http:.*/upstream.git#To <URL/of/upstream.git>#"
+}
+
+# Refs of upstream : master(B)  next(A)
+# Refs of workbench: master(A)           tags/v123
+test_expect_success "setup" '
+	git init --bare upstream.git &&
+	git -C upstream.git config http.receivepack true &&
+	git init workbench &&
+	create_commits_in workbench A B &&
+	(
+		cd workbench &&
+		# Try to make a stable fixed width for abbreviated commit ID,
+		# this fixed-width oid will be replaced with "<OID>".
+		git config core.abbrev 7 &&
+		git remote add origin ../upstream.git &&
+		git update-ref refs/heads/master $A &&
+		git tag -m "v123" v123 $A &&
+		git push origin \
+			$B:refs/heads/master \
+			$A:refs/heads/next
+	) &&
+	TAG=$(git -C workbench rev-parse v123) &&
+
+	# setup pre-receive hook
+	cat >upstream.git/hooks/pre-receive <<-\EOF &&
+	#!/bin/sh
+
+	echo >&2 "# pre-receive hook"
+
+	while read old new ref
+	do
+		echo >&2 "pre-receive< $old $new $ref"
+	done
+	EOF
+
+	# setup post-receive hook
+	cat >upstream.git/hooks/post-receive <<-\EOF &&
+	#!/bin/sh
+
+	echo >&2 "# post-receive hook"
+
+	while read old new ref
+	do
+		echo >&2 "post-receive< $old $new $ref"
+	done
+	EOF
+
+	chmod a+x \
+		upstream.git/hooks/pre-receive \
+		upstream.git/hooks/post-receive &&
+
+	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
+	mv upstream.git "$upstream" &&
+	git -C workbench remote set-url origin $HTTPD_URL/smart/upstream.git
+'
+
+setup_askpass_helper
+
+# Include test cases for both file and HTTP protocol
+. "$TEST_DIRECTORY"/t5411/common-test-cases.sh
+
+test_done
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9ff041a093..9e4b9313b5 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1039,7 +1039,7 @@ test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
-	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
+	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new reference]"  &&
 	echo >>.git/foo "Done" &&
 	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
diff --git a/transport.c b/transport.c
index 1fdc7dac1a..272c0f4046 100644
--- a/transport.c
+++ b/transport.c
@@ -500,9 +500,12 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 				 porcelain, summary_width);
 	else if (is_null_oid(&ref->old_oid))
 		print_ref_status('*',
-			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
-			"[new branch]"),
-			ref, ref->peer_ref, NULL, porcelain, summary_width);
+				 (starts_with(ref->name, "refs/tags/")
+				  ? "[new tag]"
+				  : (starts_with(ref->name, "refs/heads/")
+				     ? "[new branch]"
+				     : "[new reference]")),
+				 ref, ref->peer_ref, NULL, porcelain, summary_width);
 	else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
-- 
2.24.1.15.g448c31058d.agit.4.5

