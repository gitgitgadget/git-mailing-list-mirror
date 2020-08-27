Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D748C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312CB2177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzuV80bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgH0PqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgH0Pp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:45:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79948C061232
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:45:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g1so3636127pgm.9
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/D+2QzptwYd7DSbmiLqkSrhdv4AvdvV74eO72WXStbI=;
        b=kzuV80bfsILX2IPGxXkBlyAFGz2ORoeYhTud4rc2Yv5ED8QWEY1sDE6PuyaUSazn1m
         jv6XMaW5lNVFKRLGCYDgTOYRJ9a23H4jmgQ5FwIbT0ZEZ/avhS71O17YCVE9NYZHklZ1
         8wDiEq+S8qiEoi4SsHV5kycek6V5Sx0ns+B2eRhe0+7j+PwmTDSwBnShx5T+YEf0qyFq
         WAh12Wd/yPIoLoycI9W4mD0g/R0UmZ92Yewy8r3F/YvQ7028undlY5gG8X8UzLcpVdot
         Zg+vSV7KGQ8UxY3oniJwACk0RuDxKFzNdtzfGWOWPMXYrjkcOf4N0aQqlwBy5eAKMTck
         qEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/D+2QzptwYd7DSbmiLqkSrhdv4AvdvV74eO72WXStbI=;
        b=fJywZkxXr5MO/+7aic/fLhGXvGOhIe1kw7+TVYqD7H4Otnzop5NKBeR8TI/Q7Qo2Hp
         juwZoPWDoyu9AZErjAI/H0HcZLuealoqRRyVWI1XCE3Gek9mhzsk/O1dYHuogy/j+VHi
         jwb5bLW00ovANrLpgdobN4zCrn1Oq1/hR7bGOToOGY4KpFDeQNUvd9xD4/b6NUV57pcP
         JCYz12oORSbHoMjPZP+wd++Fi6/y+Fo39SInc32gpUefz72SeL84Nc8Hc6ZDIQQEyETb
         lI7JhD0hwsrFrX7F/mSc0bCQpS0981Si1KArT2TZEj4lY30/P3v6otVpkUQi+uWhaQ8x
         2PDw==
X-Gm-Message-State: AOAM531TlZmI1ewSny90lYGZCPheM7GyzcTDXet5meNSph5krh1FUz/g
        f1r317yV3yEK1skQZ0IwLBw=
X-Google-Smtp-Source: ABdhPJzrTZNwgRksGV0MaqhtU6bVvBU1xMEMAirTdAjMGay94I6VsZ5F4WPVJ6ZKbJhmIttW8bz8nA==
X-Received: by 2002:a62:1d05:: with SMTP id d5mr13510809pfd.63.1598543157766;
        Thu, 27 Aug 2020 08:45:57 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x5sm3129218pfj.1.2020.08.27.08.45.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 08:45:57 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v19 02/10] t5411: add basic test cases for proc-receive hook
Date:   Thu, 27 Aug 2020 11:45:43 -0400
Message-Id: <20200827154551.5966-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200824174202.11710-1-worldhello.net@gmail.com>
References: <20200824174202.11710-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Topic "proc-receive-hook" will change the workflow and output of
git-push. Add some basic test cases in t5411 before introducing the new
topic.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411-proc-receive-hook.sh                  | 108 +++++++++++++
 t/t5411/common-functions.sh                   |  56 +++++++
 t/t5411/test-0000-standard-git-push.sh        | 143 +++++++++++++++++
 .../test-0001-standard-git-push--porcelain.sh | 147 ++++++++++++++++++
 t/t5411/test-0002-pre-receive-declined.sh     |  33 ++++
 ...st-0003-pre-receive-declined--porcelain.sh |  34 ++++
 6 files changed, 521 insertions(+)
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/test-0000-standard-git-push.sh
 create mode 100644 t/t5411/test-0001-standard-git-push--porcelain.sh
 create mode 100644 t/t5411/test-0002-pre-receive-declined.sh
 create mode 100644 t/t5411/test-0003-pre-receive-declined--porcelain.sh

diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
new file mode 100755
index 0000000000..3a684353a8
--- /dev/null
+++ b/t/t5411-proc-receive-hook.sh
@@ -0,0 +1,108 @@
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
+setup_upstream_and_workbench () {
+	# Refs of upstream : master(A)
+	# Refs of workbench: master(A)  tags/v123
+	test_expect_success "setup upstream and workbench" '
+		rm -rf upstream.git &&
+		rm -rf workbench &&
+		git init --bare upstream.git &&
+		git init workbench &&
+		create_commits_in workbench A B &&
+		(
+			cd workbench &&
+			# Try to make a stable fixed width for abbreviated commit ID,
+			# this fixed-width oid will be replaced with "<OID>".
+			git config core.abbrev 7 &&
+			git tag -m "v123" v123 $A &&
+			git remote add origin ../upstream.git &&
+			git push origin master &&
+			git update-ref refs/heads/master $A $B &&
+			git -C ../upstream.git update-ref \
+				refs/heads/master $A $B
+		) &&
+		TAG=$(git -C workbench rev-parse v123) &&
+
+		# setup pre-receive hook
+		write_script upstream.git/hooks/pre-receive <<-\EOF &&
+		exec >&2
+		echo "# pre-receive hook"
+		while read old new ref
+		do
+			echo "pre-receive< $old $new $ref"
+		done
+		EOF
+
+		# setup post-receive hook
+		write_script upstream.git/hooks/post-receive <<-\EOF &&
+		exec >&2
+		echo "# post-receive hook"
+		while read old new ref
+		do
+			echo "post-receive< $old $new $ref"
+		done
+		EOF
+
+		upstream=upstream.git
+	'
+}
+
+run_proc_receive_hook_test() {
+	case $1 in
+	http)
+		PROTOCOL="HTTP protocol"
+		URL_PREFIX="http://.*"
+		;;
+	local)
+		PROTOCOL="builtin protocol"
+		URL_PREFIX="\.\."
+		;;
+	esac
+
+	# Include test cases for both file and HTTP protocol
+	for t in  "$TEST_DIRECTORY"/t5411/test-*.sh
+	do
+		. "$t"
+	done
+}
+
+# Initialize the upstream repository and local workbench.
+setup_upstream_and_workbench
+
+# Run test cases for 'proc-receive' hook on local file protocol.
+run_proc_receive_hook_test local
+
+ROOT_PATH="$PWD"
+. "$TEST_DIRECTORY"/lib-gpg.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+start_httpd
+
+# Re-initialize the upstream repository and local workbench.
+setup_upstream_and_workbench
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "setup for HTTP protocol" '
+	git -C upstream.git config http.receivepack true &&
+	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
+	mv upstream.git "$upstream" &&
+	git -C workbench remote set-url origin "$HTTPD_URL/auth-push/smart/upstream.git" &&
+	set_askpass user@host pass@host
+'
+
+setup_askpass_helper
+
+# Run test cases for 'proc-receive' hook on HTTP protocol.
+run_proc_receive_hook_test http
+
+test_done
diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
new file mode 100644
index 0000000000..6580bebd8e
--- /dev/null
+++ b/t/t5411/common-functions.sh
@@ -0,0 +1,56 @@
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
+# of the output.  Single quotes are replaced with double quotes, because
+# it is boring to prepare unquoted single quotes in expect text.  We also
+# remove some locale error messages, which break test if we turn on
+# `GIT_TEST_GETTEXT_POISON=true` in order to test unintentional translations
+# on plumbing commands.
+make_user_friendly_and_stable_output () {
+	sed \
+		-e "s/  *\$//" \
+		-e "s/   */ /g" \
+		-e "s/'/\"/g" \
+		-e "s/	/    /g" \
+		-e "s/$A/<COMMIT-A>/g" \
+		-e "s/$B/<COMMIT-B>/g" \
+		-e "s/$TAG/<TAG-v123>/g" \
+		-e "s/$ZERO_OID/<ZERO-OID>/g" \
+		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
+		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
+		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#" \
+		-e "/^error: / d"
+}
diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
new file mode 100644
index 0000000000..e206587348
--- /dev/null
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -0,0 +1,143 @@
+# Refs of upstream : master(A)  
+# Refs of workbench: master(A)  tags/v123
+# git-push         : master(B)             next(A)
+test_expect_success "git-push ($PROTOCOL)" '
+	git -C workbench push origin \
+		$B:refs/heads/master \
+		HEAD:refs/heads/next \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	To <URL/of/upstream.git>
+	 <OID-A>..<OID-B> <COMMIT-B> -> master
+	 * [new branch] HEAD -> next
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/heads/master
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(B)  next(A)
+# Refs of workbench: master(A)           tags/v123
+# git-push --atomic: master(A)  next(B)
+test_expect_success "git-push --atomic ($PROTOCOL)" '
+	test_must_fail git -C workbench push --atomic origin \
+		master \
+		$B:refs/heads/next \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out |
+		sed -n \
+			-e "/^To / { s/   */ /g; p; }" \
+			-e "/^ ! / { s/   */ /g; p; }" \
+			>actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	 ! [rejected] master -> master (non-fast-forward)
+	 ! [rejected] <COMMIT-B> -> next (atomic push failed)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/heads/master
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(B)  next(A)
+# Refs of workbench: master(A)           tags/v123
+# git-push         : master(A)  next(B)
+test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
+	test_must_fail git \
+		-C workbench \
+		-c advice.pushUpdateRejected=false \
+		push origin \
+		master \
+		$B:refs/heads/next \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
+	To <URL/of/upstream.git>
+	 <OID-A>..<OID-B> <COMMIT-B> -> next
+	 ! [rejected] master -> master (non-fast-forward)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(B)  next(B)
+# Refs of workbench: master(A)           tags/v123
+# git-push -f      : master(A)  NULL     tags/v123  refs/review/master/topic(A)  a/b/c(A)
+test_expect_success "git-push -f ($PROTOCOL)" '
+	git -C workbench push -f origin \
+		refs/tags/v123 \
+		:refs/heads/next \
+		master \
+		master:refs/review/master/topic \
+		HEAD:refs/heads/a/b/c \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: pre-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
+	remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
+	To <URL/of/upstream.git>
+	 + <OID-B>...<OID-A> master -> master (forced update)
+	 - [deleted] next
+	 * [new tag] v123 -> v123
+	 * [new reference] master -> refs/review/master/topic
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
+
+# Refs of upstream : master(A)  tags/v123  refs/review/master/topic(A)  a/b/c(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL)" '
+	(
+		cd "$upstream" &&
+		git update-ref -d refs/review/master/topic &&
+		git update-ref -d refs/tags/v123 &&
+		git update-ref -d refs/heads/a/b/c
+	)
+'
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
new file mode 100644
index 0000000000..48f6fcc846
--- /dev/null
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -0,0 +1,147 @@
+# Refs of upstream : master(A)  
+# Refs of workbench: master(A)  tags/v123
+# git-push         : master(B)             next(A)
+test_expect_success "git-push ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain origin \
+		$B:refs/heads/master \
+		HEAD:refs/heads/next \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	To <URL/of/upstream.git>
+	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
+	*    HEAD:refs/heads/next    [new branch]
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/heads/master
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(B)  next(A)
+# Refs of workbench: master(A)           tags/v123
+# git-push --atomic: master(A)  next(B)
+test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --atomic --porcelain origin \
+		master \
+		$B:refs/heads/next \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out |
+		sed -n \
+			-e "s/^# GETTEXT POISON #//" \
+			-e "/^To / { s/   */ /g; p; }" \
+			-e "/^! / { s/   */ /g; p; }" \
+			>actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	! refs/heads/master:refs/heads/master [rejected] (non-fast-forward)
+	! <COMMIT-B>:refs/heads/next [rejected] (atomic push failed)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/heads/master
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(B)  next(A)
+# Refs of workbench: master(A)           tags/v123
+# git-push         : master(A)  next(B)
+test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
+	test_must_fail git \
+		-C workbench \
+		-c advice.pushUpdateRejected=false \
+		push --porcelain origin \
+		master \
+		$B:refs/heads/next \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
+	To <URL/of/upstream.git>
+	     <COMMIT-B>:refs/heads/next    <OID-A>..<OID-B>
+	!    refs/heads/master:refs/heads/master    [rejected] (non-fast-forward)
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-B> refs/heads/master
+	<COMMIT-B> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(B)  next(B)
+# Refs of workbench: master(A)           tags/v123
+# git-push -f      : master(A)  NULL     tags/v123  refs/review/master/topic(A)  a/b/c(A)
+test_expect_success "git-push -f ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain -f origin \
+		refs/tags/v123 \
+		:refs/heads/next \
+		master \
+		master:refs/review/master/topic \
+		HEAD:refs/heads/a/b/c \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: pre-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-B> <ZERO-OID> refs/heads/next
+	remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
+	To <URL/of/upstream.git>
+	+    refs/heads/master:refs/heads/master    <OID-B>...<OID-A> (forced update)
+	-    :refs/heads/next    [deleted]
+	*    refs/tags/v123:refs/tags/v123    [new tag]
+	*    refs/heads/master:refs/review/master/topic    [new reference]
+	*    HEAD:refs/heads/a/b/c    [new branch]
+	Done
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
+
+# Refs of upstream : master(A)  tags/v123  refs/review/master/topic(A)  a/b/c(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL/porcelain)" '
+	(
+		cd "$upstream" &&
+		git update-ref -d refs/review/master/topic &&
+		git update-ref -d refs/tags/v123 &&
+		git update-ref -d refs/heads/a/b/c
+	)
+'
diff --git a/t/t5411/test-0002-pre-receive-declined.sh b/t/t5411/test-0002-pre-receive-declined.sh
new file mode 100644
index 0000000000..c246f7e68e
--- /dev/null
+++ b/t/t5411/test-0002-pre-receive-declined.sh
@@ -0,0 +1,33 @@
+test_expect_success "setup pre-receive hook ($PROTOCOL)" '
+	mv "$upstream/hooks/pre-receive" "$upstream/hooks/pre-receive.ok" &&
+	write_script "$upstream/hooks/pre-receive" <<-EOF
+	exit 1
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git-push         : master(B)             next(A)
+test_expect_success "git-push is declined ($PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		$B:refs/heads/master \
+		HEAD:refs/heads/next \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	 ! [remote rejected] <COMMIT-B> -> master (pre-receive hook declined)
+	 ! [remote rejected] HEAD -> next (pre-receive hook declined)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "cleanup ($PROTOCOL)" '
+	mv "$upstream/hooks/pre-receive.ok" "$upstream/hooks/pre-receive"
+'
diff --git a/t/t5411/test-0003-pre-receive-declined--porcelain.sh b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
new file mode 100644
index 0000000000..b14894de81
--- /dev/null
+++ b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
@@ -0,0 +1,34 @@
+test_expect_success "setup pre-receive hook ($PROTOCOL/porcelain)" '
+	mv "$upstream/hooks/pre-receive" "$upstream/hooks/pre-receive.ok" &&
+	write_script "$upstream/hooks/pre-receive" <<-EOF
+	exit 1
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git-push         : master(B)             next(A)
+test_expect_success "git-push is declined ($PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		$B:refs/heads/master \
+		HEAD:refs/heads/next \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	!    <COMMIT-B>:refs/heads/master    [remote rejected] (pre-receive hook declined)
+	!    HEAD:refs/heads/next    [remote rejected] (pre-receive hook declined)
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "cleanup ($PROTOCOL/porcelain)" '
+	mv "$upstream/hooks/pre-receive.ok" "$upstream/hooks/pre-receive"
+'
-- 
2.26.2.543.g44b58e439b

