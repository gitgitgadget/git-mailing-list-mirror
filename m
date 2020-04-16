Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9915C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C21F20857
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHxB0St4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404043AbgDPQYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729633AbgDPQYW (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 12:24:22 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB934C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:24:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cl8so1607742pjb.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjhCNfTsmnZ0MmUWnNylyxLqPHPURgI5Xphx/glCHAk=;
        b=jHxB0St4NytD3zqmHKlCZu4aHkQvoRH2yrSsSkF7dH5rPClBTVQYmdCUi946IYHENc
         KQk8bz+AoWeUy0nfTAgPQj+BG2bYDq+qIihx2C6IXtUb1p/QRODXGWc9Uvar7MONYQHE
         l53N3yDei3C/bxcizDqtIkBuez1ChtO8BKrjtslaswoTfhZ2KJeRiYZcm8uuYWOHSKC+
         d/oWkGzEwmUqlDJ1Qa5fXxgFjNN7oyyzsMXBJojKq6JdXhs8e3v6UTTTUQFj4vS3Cd6S
         w0Z4zaQfLyMXJEtZXc/DgsWD4KVypi035f4wrnYxoEoW2f8GZM1xboUMmkPeDLz89tsk
         GTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjhCNfTsmnZ0MmUWnNylyxLqPHPURgI5Xphx/glCHAk=;
        b=dU5zWJ3DwD8q8u1b04CRJMgFtvQbFIhY7s+zfsHUb+16om4QPOnH0LqXaINXYduFwV
         S56Xbfs+qPf6jFx/3jzoJlocjq9yV4juzBZPFK6UqRm5DGS+UThMykxuEmAALQytPl9D
         7U/jzXTycy6aRLssyyEXvwrJe0XHY9TsRhjB6DjQtnCfY4R/g0FXxXly9buN8y8Yfn+l
         L0zUf6diz5/iE5RUjizyjAZy4ROOvBFbLnuX6ZS4cNFF7CjUSDljEmEwC8edbzY3FIqz
         FkdnBGcl6jH/OohWWOC/1t5W2tu/cud31fshcDL+ZQzlJgbKkOwjqdjZ0Vcor0yy3ULX
         RLZg==
X-Gm-Message-State: AGi0PuZNSMbhr2wypa5emJ7ZW5xMcGijg0HrCML/mQz33JYT34zsPwh2
        r2bYS6CPp3iA0LE6Yi0QyyE=
X-Google-Smtp-Source: APiQypLa/y7S4gchLOaU7tK9sUxk9Pgh3sDH0LwF91BqgeurJrhJeYYW7p4ZR4d53tdfAuO9KQyXcw==
X-Received: by 2002:a17:902:7286:: with SMTP id d6mr10914440pll.241.1587054262284;
        Thu, 16 Apr 2020 09:24:22 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c125sm17007933pfa.142.2020.04.16.09.24.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 09:24:21 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 1/5] send-pack: fix inconsistent porcelain output
Date:   Thu, 16 Apr 2020 12:24:11 -0400
Message-Id: <20200416162415.5751-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200329143329.13846-1-worldhello.net@gmail.com>
References: <20200329143329.13846-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The porcelain output of a failed `git-push` command is inconsistent for
different protocols.  For example, the following `git-push` command
failed because of the failure of `pre-receive` hook.

    git push --porcelain origin HEAD:refs/heads/master

For SSH protocol, the porcelain output does not end with a "Done"
message:

	To <URL/of/upstream.git>
	!  HEAD:refs/heads/master  [remote rejected] (pre-receive hook declined)

While for HTTP protocol, the porcelain output does end with a "Done"
message;

	To <URL/of/upstream.git>
	!  HEAD:refs/heads/master  [remote rejected] (pre-receive hook declined)
	Done

The following code at the end of function `send_pack()` indicates that
`send_pack()` should not return an error if some references are rejected
in porcelain mode.

    int send_pack(...)
        ... ...

        if (args->porcelain)
            return 0;

        for (ref = remote_refs; ref; ref = ref->next) {
            switch (ref->status) {
            case REF_STATUS_NONE:
            case REF_STATUS_UPTODATE:
            case REF_STATUS_OK:
                break;
            default:
                return -1;
            }
        }
        return 0;
    }

So if atomic push failed, must check the porcelain mode before return
an error.  And `receive_status()` should not return an error for a
failed updated reference, because `send_pack()` will check them instead.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 send-pack.c               |   7 +-
 t/t5548-push-porcelain.sh | 301 ++++++++++++++++++++++++++++++++++++++
 transport.c               |  10 +-
 3 files changed, 313 insertions(+), 5 deletions(-)
 create mode 100755 t/t5548-push-porcelain.sh

diff --git a/send-pack.c b/send-pack.c
index 0407841ae8..1835cd5582 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -190,10 +190,8 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 
 		if (reader->line[0] == 'o' && reader->line[1] == 'k')
 			hint->status = REF_STATUS_OK;
-		else {
+		else
 			hint->status = REF_STATUS_REMOTE_REJECT;
-			ret = -1;
-		}
 		hint->remote_status = xstrdup_or_null(msg);
 		/* start our next search from the next ref */
 		hint = hint->next;
@@ -489,7 +487,8 @@ int send_pack(struct send_pack_args *args,
 			if (use_atomic) {
 				strbuf_release(&req_buf);
 				strbuf_release(&cap_buf);
-				return atomic_push_failure(args, remote_refs, ref);
+				atomic_push_failure(args, remote_refs, ref);
+				return args->porcelain ? 0 : -1;
 			}
 			/* else fallthrough */
 		default:
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
new file mode 100755
index 0000000000..8d487b2a7a
--- /dev/null
+++ b/t/t5548-push-porcelain.sh
@@ -0,0 +1,301 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Jiang Xin
+#
+test_description='Test git push porcelain output'
+
+. ./test-lib.sh
+
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
+# of the output.
+make_user_friendly_and_stable_output () {
+	sed \
+		-e "s/  *\$//" \
+		-e "s/   */ /g" \
+		-e "s/	/    /g" \
+		-e "s/$A/<COMMIT-A>/g" \
+		-e "s/$B/<COMMIT-B>/g" \
+		-e "s/$ZERO_OID/<ZERO-OID>/g" \
+		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
+		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
+		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#"
+}
+
+run_git_push_porcelain_output_test() {
+	case $1 in
+	http)
+		PROTOCOL="HTTP protocol"
+		URL_PREFIX="http://.*"
+		;;
+	file)
+		PROTOCOL="builtin protocol"
+		URL_PREFIX="\.\."
+		;;
+	esac
+
+	# Refs of upstream : master(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: master(A)                  baz(A)  next(A)
+	# git-push         : master(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success "porcelain output of successful git-push ($PROTOCOL)" '
+		(
+			cd workbench &&
+			git update-ref refs/heads/master $A &&
+			git update-ref refs/heads/baz $A &&
+			git update-ref refs/heads/next $A &&
+			git push --porcelain --force origin \
+				master \
+				:refs/heads/foo \
+				$B:bar \
+				baz \
+				next
+		) >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		To <URL/of/upstream.git>
+		=    refs/heads/baz:refs/heads/baz    [up to date]
+		     <COMMIT-B>:refs/heads/bar    <OID-A>..<OID-B>
+		-    :refs/heads/foo    [deleted]
+		+    refs/heads/master:refs/heads/master    <OID-B>...<OID-A> (forced update)
+		*    refs/heads/next:refs/heads/next    [new branch]
+		Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/master
+		<COMMIT-A> refs/heads/next
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
+	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
+	# git-push         : master(B)  bar(A)  NULL    next(A)
+	test_expect_success "atomic push failed ($PROTOCOL)" '
+		(
+			cd workbench &&
+			git update-ref refs/heads/master $B &&
+			git update-ref refs/heads/bar $A &&
+			test_must_fail git push --atomic --porcelain origin \
+				master \
+				bar \
+				:baz \
+				next
+		) >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		To <URL/of/upstream.git>
+		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
+		!    (delete):refs/heads/baz    [rejected] (atomic push failed)
+		!    refs/heads/master:refs/heads/master    [rejected] (atomic push failed)
+		!    refs/heads/next:refs/heads/next    [rejected] (atomic push failed)
+		Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/master
+		<COMMIT-A> refs/heads/next
+		EOF
+		test_cmp expect actual
+	'
+
+	test_expect_success "prepare pre-receive hook ($PROTOCOL)" '
+		write_script "$upstream/hooks/pre-receive" <<-EOF
+		exit 1
+		EOF
+	'
+
+	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
+	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
+	# git-push         : master(B)  bar(A)  NULL    next(A)
+	test_expect_success "pre-receive hook declined ($PROTOCOL)" '
+		(
+			cd workbench &&
+			git update-ref refs/heads/master $B &&
+			git update-ref refs/heads/bar $A &&
+			test_must_fail git push --porcelain --force origin \
+				master \
+				bar \
+				:baz \
+				next
+		) >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		To <URL/of/upstream.git>
+		=    refs/heads/next:refs/heads/next    [up to date]
+		!    refs/heads/bar:refs/heads/bar    [remote rejected] (pre-receive hook declined)
+		!    :refs/heads/baz    [remote rejected] (pre-receive hook declined)
+		!    refs/heads/master:refs/heads/master    [remote rejected] (pre-receive hook declined)
+		Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/master
+		<COMMIT-A> refs/heads/next
+		EOF
+		test_cmp expect actual
+	'
+
+	test_expect_success "remove pre-receive hook ($PROTOCOL)" '
+		rm "$upstream/hooks/pre-receive"
+	'
+
+	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
+	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
+	# git-push         : master(B)  bar(A)  NULL    next(A)
+	test_expect_success "non-fastforward push ($PROTOCOL)" '
+		(
+			cd workbench &&
+			test_must_fail git push --porcelain origin \
+				master \
+				bar \
+				:baz \
+				next
+		) >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		To <URL/of/upstream.git>
+		=    refs/heads/next:refs/heads/next    [up to date]
+		-    :refs/heads/baz    [deleted]
+		     refs/heads/master:refs/heads/master    <OID-A>..<OID-B>
+		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
+		Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-B> refs/heads/bar
+		<COMMIT-B> refs/heads/master
+		<COMMIT-A> refs/heads/next
+		EOF
+		test_cmp expect actual
+	'
+
+	# upstream  (before) : master(A)  bar(B)  baz(A)  next(A)
+	# upstream  (after)  : master(B)  bar(A)  baz(A)           foo(A)
+	# workbench (before) : master(B)  bar(A)  baz(A)  next(A)
+	# workbench (after)  : master(A)
+	test_expect_success "cleanup ($PROTOCOL)" '
+		(
+			cd "$upstream" &&
+			git update-ref refs/heads/master $B &&
+			git update-ref refs/heads/foo    $A &&
+			git update-ref refs/heads/bar    $A &&
+			git update-ref refs/heads/baz    $A &&
+			git update-ref -d refs/heads/next
+		) &&
+		(
+			cd "workbench" &&
+			git update-ref refs/heads/master $A &&
+			git update-ref -d refs/heads/bar &&
+			git update-ref -d refs/heads/baz &&
+			git update-ref -d refs/heads/next
+		)
+	'
+}
+
+# Upstream  after setup : master(B)  foo(A)  bar(A)  baz(A)
+# Workbench after setup : master(A)
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
+		git push origin \
+			$B:refs/heads/master \
+			$A:refs/heads/foo \
+			$A:refs/heads/bar \
+			$A:refs/heads/baz
+	) &&
+	git -C "workbench" config advice.pushUpdateRejected false &&
+	upstream=upstream.git
+'
+
+# Run git-push porcelain test on builtin protocol
+run_git_push_porcelain_output_test file
+
+ROOT_PATH="$PWD"
+. "$TEST_DIRECTORY"/lib-gpg.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+start_httpd
+
+test_expect_success "setup for http" '
+	git -C upstream.git config http.receivepack true &&
+	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
+	mv upstream.git "$upstream" &&
+
+	git -C workbench remote set-url origin $HTTPD_URL/smart/upstream.git &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/bar
+	<COMMIT-A> refs/heads/baz
+	<COMMIT-A> refs/heads/foo
+	<COMMIT-B> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+# Run git-push porcelain test on HTTP protocol
+run_git_push_porcelain_output_test http
+
+test_done
diff --git a/transport.c b/transport.c
index 1fdc7dac1a..13d638d5fe 100644
--- a/transport.c
+++ b/transport.c
@@ -715,7 +715,15 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	close(data->fd[1]);
 	close(data->fd[0]);
-	ret |= finish_connect(data->conn);
+	/*
+	 * Atomic push may abort the connection early and close the pipe,
+	 * which may cause an error for `finish_connect()`. Ignore this error
+	 * for atomic git-push.
+	 */
+	if (ret || args.atomic)
+		finish_connect(data->conn);
+	else
+		ret = finish_connect(data->conn);
 	data->conn = NULL;
 	data->got_remote_heads = 0;
 
-- 
2.24.1.15.g448c31058d.agit.4.5

