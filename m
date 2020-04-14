Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71CEC2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959D620787
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZkxUxgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501999AbgDNMdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2501988AbgDNMdF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 08:33:05 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1599C061A0F
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t4so4587655plq.12
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FrOWekQy/e8jsVnuGIGducIfKVaTJAQ9x8ruJ7aTIGY=;
        b=SZkxUxgilToM/0Ropgl2gOWk5sO0VvJ3LxD4fIgq1tcau5OpawRTcYdYt7atxa5KkP
         TjQ4/L0RWU+tR7Q19OPuAUw1J73BjO1FOkCpB9/ujyQKDL/wVFfZAf4CV0c0jNejRYEv
         19vzDy9XwuimxNc1FKTZl1soVtaBYsBcRTUdHvLMBSfbXE7psFHLh9pxiYG4JkHig1Nw
         69oBJuZrUsvXAUDfmLgwK/m/q6Izpa4qjJfIfcMVNWVruzbOHMcW7Y9OVSjKhxfpMDcN
         +BSr1B1RFI4DEMet7LcJQHfkuwh6Zc/9pp5TNJHyOcewrVAEcMDOb4VJldo4m03BGq/E
         Ppgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FrOWekQy/e8jsVnuGIGducIfKVaTJAQ9x8ruJ7aTIGY=;
        b=obEMnKwnJiwNwDel3coR2naQFoI7bPbeZHPCHiy3LsWmlWWQ2hf+my3Yw7zq9DXeh/
         4YJH+q4+zfc56eRe/kEeOX9snravtyKIPyVbidQy+AMjT0H12SGaANHWuMD/c1l4/5jp
         QumeAEU55ig/7MsihyUDiyTDz8Rp/r5g5CsGFITT0Jo1JUTb6tpBsxqc8iLSl0pN4NXs
         oj1MEwb5l8J8TECwfHWIo1TFNv2Uk2H3LObtkj2qdTFt/xoEHfrcJMBjp4rjqA+fw7xs
         7uFHkp9UFTNVGy/LSecSxLuR4L1pzBRZxQgzxWRdzXEEoV3nh20fEx4YOjenBp1IKADI
         YOJg==
X-Gm-Message-State: AGi0PuY8yM45RvHpTqxzCMCxYqis64km1IjxXxksx//v8KirddFXrhZb
        zerf5AuLyXDB5w8nc2rBZFI=
X-Google-Smtp-Source: APiQypIGAR5ypx9UfLO8tOWiAQebcpVtsKzTwNazU0xez9q9sfOmRZirY4GFsxlUqZKFSfM2NkYydw==
X-Received: by 2002:a17:902:7b8e:: with SMTP id w14mr543055pll.173.1586867585085;
        Tue, 14 Apr 2020 05:33:05 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c9sm996177pfp.53.2020.04.14.05.33.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:33:04 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v12 1/7] transport: not report a non-head push as a branch
Date:   Tue, 14 Apr 2020 08:32:51 -0400
Message-Id: <20200414123257.27449-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq3697cax0.fsf@gitster.c.googlers.com>
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
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
 t/t5411-proc-receive-hook.sh               | 67 +++++++++++++++++++
 t/t5411/common-functions.sh                | 50 ++++++++++++++
 t/t5411/common-test-cases.sh               | 43 ++++++++++++
 t/t5412-proc-receive-hook-http-protocol.sh | 78 ++++++++++++++++++++++
 t/t5516-fetch-push.sh                      |  2 +-
 transport.c                                |  9 ++-
 6 files changed, 245 insertions(+), 4 deletions(-)
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/common-test-cases.sh
 create mode 100755 t/t5412-proc-receive-hook-http-protocol.sh

diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
new file mode 100755
index 0000000000..3f4bee76d9
--- /dev/null
+++ b/t/t5411-proc-receive-hook.sh
@@ -0,0 +1,67 @@
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
+# we also replace the URL of different protocol for the upstream repository
+# with a fixed pattern.
+make_user_friendly_and_stable_output () {
+	make_user_friendly_and_stable_output_common |
+		sed -e "s#To ../upstream.git#To <URL/of/upstream.git>#"
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
+	write_script upstream.git/hooks/pre-receive <<-\EOF &&
+	exec >&2
+	echo "# pre-receive hook"
+	while read old new ref
+	do
+		echo "pre-receive< $old $new $ref"
+	done
+	EOF
+
+	# setup post-receive hook
+	write_script upstream.git/hooks/post-receive <<-\EOF &&
+	exec >&2
+	echo "# post-receive hook"
+	while read old new ref
+	do
+		echo "post-receive< $old $new $ref"
+	done
+	EOF
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
index 0000000000..4337b10c8c
--- /dev/null
+++ b/t/t5411/common-functions.sh
@@ -0,0 +1,50 @@
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
+# it is boring to prepare unquoted single quotes in expect text.
+make_user_friendly_and_stable_output_common () {
+	sed \
+		-e "s/  *\$//" \
+		-e "s/   */ /g" \
+		-e "s/'/\"/g" \
+		-e "s/$A/<COMMIT-A>/g" \
+		-e "s/$B/<COMMIT-B>/g" \
+		-e "s/$TAG/<TAG-v123>/g" \
+		-e "s/$ZERO_OID/<ZERO-OID>/g" \
+		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
+		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g"
+}
diff --git a/t/t5411/common-test-cases.sh b/t/t5411/common-test-cases.sh
new file mode 100644
index 0000000000..23655846e4
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
+	 + <OID-B>...<OID-A> HEAD -> master (forced update)
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
index 0000000000..d102bc438b
--- /dev/null
+++ b/t/t5412-proc-receive-hook-http-protocol.sh
@@ -0,0 +1,78 @@
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
+# we also replace the URL of different protocol for the upstream repository
+# with a fixed pattern.
+make_user_friendly_and_stable_output () {
+	make_user_friendly_and_stable_output_common |
+		sed -e "s#To http:.*/upstream.git#To <URL/of/upstream.git>#"
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
+	write_script upstream.git/hooks/pre-receive <<-\EOF &&
+	exec >&2
+	echo "# pre-receive hook"
+	while read old new ref
+	do
+		echo "pre-receive< $old $new $ref"
+	done
+	EOF
+
+	# setup post-receive hook
+	write_script upstream.git/hooks/post-receive <<-\EOF &&
+	exec >&2
+	echo "# post-receive hook"
+	while read old new ref
+	do
+		echo "post-receive< $old $new $ref"
+	done
+	EOF
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

