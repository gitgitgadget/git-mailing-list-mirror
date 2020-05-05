Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D0FC47257
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8044D206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8VvsBmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgEEOlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 10:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729095AbgEEOln (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 10:41:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5EDC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 07:41:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id a4so1171528pgc.0
        for <git@vger.kernel.org>; Tue, 05 May 2020 07:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZKy1iA3gqefjPC0uG0fesIAcPKjaDiosWJX+x1+h+E=;
        b=s8VvsBmMEZKtNulgxBXIkmWVNUl63bduO6Dm3UBHeoMERZyNplz5+NNRgFLMDxzSaZ
         0BgBbzRD3ZlcieAg+9vtbQj1kPZwlpjPhaQn1qFIWB/lf6jO6yc68NAHz3nFpNxivBnP
         IrVCiJeV59iHGmFfTqYYaAVS1WmkPowU+LDZ5ukzQeeVEtHlRX7e9Lc6yUEE3d2qsheZ
         Z6K/gxjMee1J7FSGiatZoawhZU1/m5DElNnaUnJ+2TM/AtlGoCJAlUd4y2gDYNjE33IH
         Zxp3U4o4r7r2L9WThbYTTOaxKHdzo5MKneXyryfJm5X63nZfa0ZFaJ/T1e2IDxln0Dew
         v2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZKy1iA3gqefjPC0uG0fesIAcPKjaDiosWJX+x1+h+E=;
        b=o79P98GwPiWmqLH5xkCzlCxodfeB8kPQWIrKtC27eMCb9sU3xr/ehUA7tfwzX0jZGE
         9lSEzmr72Wx6+1WJrXqk+Oas2WpZfT0MYTShSxuRhDo2V+fCZQtf3/bZ+4Ir/X+VyD5G
         KKzysQSSpObZPdN8yMc9lLcFpEnCr+yiWCe3DenL8RoXBko/KZIOJ7jqsKhnBp0JUN+P
         /Q4PxEEkK8T8g0b/RraTJdWgPKRkK1D/Yl2HO2KJ6oSijMqpYiIVKFH8e/zNiJdByx0M
         dfuTYMP1LM6FURNfVVCZ011JCsAqenrvJqWgKJrzJgbjjZmD8aoamKzeHzWw9gzBxWNz
         EYQg==
X-Gm-Message-State: AGi0PuZexH4mehmqkaqvvhNX/yQmQohRHV1iQZJffutdMV2HSF45s33N
        I0ZcPXP7JmT1Fbt57M2kDAY=
X-Google-Smtp-Source: APiQypLE80lBWUkwEi4nFL6yFPVPsT6RoQPbDeTz7qVtAiFt49uUaw8ZXScrMLDM02I6LCRg7iI1Lw==
X-Received: by 2002:a63:1806:: with SMTP id y6mr3044465pgl.407.1588689700977;
        Tue, 05 May 2020 07:41:40 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f99sm2431012pjg.22.2020.05.05.07.41.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 07:41:40 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 1/7] transport: not report a non-head push as a branch
Date:   Tue,  5 May 2020 10:41:25 -0400
Message-Id: <20200505144131.30048-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
References: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
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
 t/t5411-proc-receive-hook.sh                  | 106 ++++++++++++++++++
 t/t5411/common-functions.sh                   |  56 +++++++++
 t/t5411/test-0000-standard-git-push.sh        |  84 ++++++++++++++
 .../test-0001-standard-git-push--porcelain.sh |  86 ++++++++++++++
 t/t5411/test-0002-pre-receive-declined.sh     |  33 ++++++
 ...st-0003-pre-receive-declined--porcelain.sh |  34 ++++++
 t/t5516-fetch-push.sh                         |   2 +-
 transport.c                                   |   9 +-
 8 files changed, 406 insertions(+), 4 deletions(-)
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/test-0000-standard-git-push.sh
 create mode 100644 t/t5411/test-0001-standard-git-push--porcelain.sh
 create mode 100644 t/t5411/test-0002-pre-receive-declined.sh
 create mode 100644 t/t5411/test-0003-pre-receive-declined--porcelain.sh

diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
new file mode 100755
index 0000000000..67492db940
--- /dev/null
+++ b/t/t5411-proc-receive-hook.sh
@@ -0,0 +1,106 @@
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
+			git remote add origin ../upstream.git &&
+			git update-ref refs/heads/master $A &&
+			git tag -m "v123" v123 $A &&
+			git push origin $A:refs/heads/master
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
+	file | local)
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
+	set_askpass user@host pass@host &&
+	git -C workbench remote set-url origin $HTTPD_URL/smart/upstream.git
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
index 0000000000..52160aebf7
--- /dev/null
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -0,0 +1,84 @@
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
+# git-push -f      : master(A)  NULL     tags/v123  refs/review/master/topic(A)  a/b/c(A)
+test_expect_success "git-push -f ($PROTOCOL)" '
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
index 0000000000..4077015b17
--- /dev/null
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -0,0 +1,86 @@
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
+# git-push -f      : master(A)  NULL     tags/v123  refs/review/master/topic(A)  a/b/c(A)
+test_expect_success "git-push -f ($PROTOCOL/porcelain)" '
+	git -C workbench push --porcelain -f origin \
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
+	+    HEAD:refs/heads/master    <OID-B>...<OID-A> (forced update)
+	-    :refs/heads/next    [deleted]
+	*    refs/tags/v123:refs/tags/v123    [new tag]
+	*    HEAD:refs/review/master/topic    [new reference]
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
+test_expect_success "cleanup ($PROTOCOL)" '
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
index 0000000000..510cd3b333
--- /dev/null
+++ b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
@@ -0,0 +1,34 @@
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
+test_expect_success "cleanup ($PROTOCOL)" '
+	mv "$upstream/hooks/pre-receive.ok" "$upstream/hooks/pre-receive"
+'
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9c6218f568..77938db77f 100755
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
index 15f5ba4e8f..26fefd13c1 100644
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
2.26.1.120.g98702cf3e9

