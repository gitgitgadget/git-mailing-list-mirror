Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F936C19F2B
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 10:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiG2KNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiG2KM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 06:12:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87906747AD
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 23so3665747pgc.8
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BVSgJnmV4HlP6AvjHi9TydCUbUVFa4rIe5DC8F/gyQs=;
        b=DoU3OQYd5r3n3eK+X+Snd6IKVx5uthFr8Hk1V1Q2sLnd2FLH5YpRrWJ1sa+qXv7gpK
         rgtWEyZAmRDpVUqUhMr+ZJp/1ftM/g1oZhKe8dmsZpf8409BbjcVuSNq/mvuCIQt46oU
         eTsUeASvUMCgn4d/9QPiuIvsuZcQ/cb1m0o3Phiox9pjell93m08QkZKnwdtBeTcBsZg
         oP5unf4DJQbXdANfjAAWHyp3EU02SmgP89PlhahINj/WH0CyHOoYh/HXJ3jfZKMJeRyu
         DTFocOXKTUFFH8ch/SpeMF9en2+7tbkPwUiIzIOWmLdcq3xGtZgJJ2GtL0b16QJQ2Tsk
         R/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVSgJnmV4HlP6AvjHi9TydCUbUVFa4rIe5DC8F/gyQs=;
        b=QoICpaGaP3Vxgavc8xRj8Sj2XHl1iZ2AsMuv1t7sHarBhke3+a26nrZ6AtI0QmZPZo
         RPsLgpizld7ySBi4VjpwiVeccF9q6hrB9vzaKWMTEuh3jYFIbne84NsArfP+MkYXMQnX
         TxTMpf0mkK0rbkTAX8ESLlHfYrOUR3I6FWIYOkmSMPYv6ijlShLMLEDxJ8QL7O+2k9RK
         B5PdUo2KNHS391uNGaPC3m6T3eC3aNV/xJe+GumwbT7UmxIGwTiHraDozYoaH3j8vc4T
         18NhfuyFunXaJhqQYHlDcdwEr2RLoU/J1XDv9TASD2439WRknpoaxkRkZ1gxk8kikOGr
         TBmg==
X-Gm-Message-State: AJIora+rFzUSEiiZzJFmt0x1fx2TOANbzXC9zbG1BzGC1B3fl22YBrMr
        NKVUHdGdcbMofhwtHTJa72BryhcVPo3ERQ==
X-Google-Smtp-Source: AGRyM1uO+75BioEc55ULQVqX0n5wAsbJcBN+0Lhs8Hcqov+WLZGmTqhOmxE5079vHLAWIAoIIiJbxw==
X-Received: by 2002:a63:5a1b:0:b0:41a:64d4:9643 with SMTP id o27-20020a635a1b000000b0041a64d49643mr2315585pgb.126.1659089574794;
        Fri, 29 Jul 2022 03:12:54 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0016c4fb6e0b2sm3207797plg.55.2022.07.29.03.12.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:12:54 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 1/9] t1416: more testcases for reference-transaction hook
Date:   Fri, 29 Jul 2022 18:12:37 +0800
Message-Id: <20220729101245.6469-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220729101245.6469-1-worldhello.net@gmail.com>
References: <20220729101245.6469-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Append more testcases in t1416 for various git commands that may trigger
the "reference-transaction" hook.

In order to create a common "reference-transaction" hook, we define the
common hook path using config variable "core.hooksPath", and create the
"reference-transaction" hook in the path.

Some commands trigger the "reference-transaction" hook properly and get
the expected output. E.g.:

 * git branch <new-branch> <oid>		# create new branch
 * git clone
 * git commit [--amend]
 * git fetch
 * git merge
 * git push [--atomic]
 * git reset --hard
 * git tag [-f] <tag> <oid>			# update tag
 * git tag <new-tag> <oid>			# create new tag
 * git update-ref --stdin			# create new refs
 * git update-ref <ref> <oid>			# create new ref

But 16 testcases failed.

Some commands failed because the expected "<old-oid>" became
"<zero-oid>". E.g.:

 * git branch [-f] <ref> <new-oid>		# update branch
 * git cherry-pick <oid>
 * git rebase
 * git tag -d <tag>
 * git update-ref --stdin			# update/delete refs
 * git update-ref -d <ref>
 * git update-ref <ref> <new-oid> [<old-oid>]	# update ref

Some commands failed because the "reference-transaction committed"
command was repeated multiple times for the same changes. E.g.:

 * git cherry-pick
 * git rebase
 * git revert
 * git tag -d <tag>
 * git update-ref -d <ref>
 * git update-ref --stdin			# delete refs

Some commands should not trigger the "reference-transaction" hook
because no real changes have occurred to the repository. E.g.:

 * git gc
 * git pack-refs --all

Some commands did not execute the "reference-transaction" hook at all.
E.g.:

 * git branch -c <src> <dest>			# copy branch
 * git branch -m <old> <new>			# rename branch

Some commands ran unexpected command "reference-transaction aborted".
E.g.:

 * git branch -d <branch>			# delete branch
 * git branch -m <old> <new>			# rename branch
 * git cherr-pick <oid>
 * git rebase
 * git revert
 * git tag -d <tag>				# delete tag
 * git update-ref -d <ref> 			# delete ref

We will fix the failed testcases in later commits.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t1416-ref-transaction-hooks.sh | 1068 ++++++++++++++++++++++++++++++
 1 file changed, 1068 insertions(+)

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 27731722a5..a84621516c 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -133,4 +133,1072 @@ test_expect_success 'interleaving hook calls succeed' '
 	test_cmp expect target-repo.git/actual
 '
 
+HOOK_OUTPUT=hook-output
+
+# Create commits in <repo> and assign each commit's oid to shell variables
+# given in the arguments (A, B, and C). E.g.:
+#
+#     create_commits_in <repo> A B C
+#
+# NOTE: Never calling this function from a subshell since variable
+# assignments will disappear when subshell exits.
+create_commits_in () {
+	repo="$1" && test -d "$repo" ||
+	error "Repository $repo does not exist."
+	shift &&
+	while test $# -gt 0
+	do
+		name=$1 &&
+		shift &&
+		test_commit -C "$repo" --no-tag "$name" &&
+		eval $name=$(git -C "$repo" rev-parse HEAD)
+	done
+}
+
+get_abbrev_oid () {
+	oid=$1 &&
+	suffix=${oid#???????} &&
+	oid=${oid%$suffix} &&
+	if test -n "$oid"
+	then
+		echo "$oid"
+	else
+		echo "undefined-oid"
+	fi
+}
+
+# Format the output of git-push, git-show-ref and other commands to make a
+# user-friendly and stable text.  We can easily prepare the expect text
+# without having to worry about future changes of the commit ID.
+make_user_friendly_and_stable_output () {
+	sed \
+		-e "s/$(get_abbrev_oid $A)[0-9a-f]*/<COMMIT-A>/g" \
+		-e "s/$(get_abbrev_oid $B)[0-9a-f]*/<COMMIT-B>/g" \
+		-e "s/$(get_abbrev_oid $C)[0-9a-f]*/<COMMIT-C>/g" \
+		-e "s/$(get_abbrev_oid $D)[0-9a-f]*/<COMMIT-D>/g" \
+		-e "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" \
+		-e "s/$(get_abbrev_oid $F)[0-9a-f]*/<COMMIT-F>/g" \
+		-e "s/$(get_abbrev_oid $G)[0-9a-f]*/<COMMIT-G>/g" \
+		-e "s/$(get_abbrev_oid $H)[0-9a-f]*/<COMMIT-H>/g" \
+		-e "s/$(get_abbrev_oid $I)[0-9a-f]*/<COMMIT-I>/g" \
+		-e "s/$ZERO_OID/<ZERO-OID>/g"
+}
+
+test_cmp_heads_and_tags () {
+	indir= &&
+	while test $# != 0
+	do
+		case "$1" in
+		-C)
+			indir="$2"
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done &&
+	expect=${1:-expect} &&
+	actual=${2:-actual-heads-and-tags} &&
+	indir=${indir:+"$indir"/} &&
+	test_path_is_file "$expect" &&
+	test_when_finished "rm -f \"$actual\"" &&
+	git ${indir:+ -C "$indir"} show-ref --heads --tags | \
+		make_user_friendly_and_stable_output >"$actual" &&
+	test_cmp "$expect" "$actual"
+}
+
+test_expect_success 'setup git config and common reference-transaction hook' '
+	git config --global \
+		core.hooksPath "$HOME/test-hooks" &&
+	git config --global core.abbrev 7 &&
+	mkdir "test-hooks" &&
+	write_script "test-hooks/reference-transaction" <<-EOF
+		exec >>"$HOME/$HOOK_OUTPUT"
+		printf "## Call hook: reference-transaction %9s ##\n" "\$@"
+		while read -r line
+		do
+		    printf "%s\n" "\$line"
+		done
+	EOF
+'
+
+test_expect_success "setup base repository" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-\EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> HEAD
+		<ZERO-OID> <COMMIT-A> refs/heads/main
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> HEAD
+		<ZERO-OID> <COMMIT-A> refs/heads/main
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <COMMIT-B> HEAD
+		<COMMIT-A> <COMMIT-B> refs/heads/main
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <COMMIT-B> HEAD
+		<COMMIT-A> <COMMIT-B> refs/heads/main
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-B> <COMMIT-C> HEAD
+		<COMMIT-B> <COMMIT-C> refs/heads/main
+		## Call hook: reference-transaction committed ##
+		<COMMIT-B> <COMMIT-C> HEAD
+		<COMMIT-B> <COMMIT-C> refs/heads/main
+	EOF
+
+	git init base &&
+	create_commits_in base A B C &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+	EOF
+	test_cmp_heads_and_tags -C base expect
+'
+
+test_expect_success "update-ref: setup workdir using git-clone" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-\EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/remotes/origin/main
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/remotes/origin/main
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> HEAD
+		<ZERO-OID> <COMMIT-C> refs/heads/main
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> HEAD
+		<ZERO-OID> <COMMIT-C> refs/heads/main
+	EOF
+
+	git clone base workdir &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	<COMMIT-C> refs/heads/main
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_success "update-ref: create new refs" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic1
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic1
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic2
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic2
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic3
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic3
+	EOF
+
+	(
+		cd workdir &&
+		git update-ref refs/heads/topic1 $A &&
+		git update-ref refs/heads/topic2 $A &&
+		git update-ref refs/heads/topic3 $A
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-A> refs/heads/topic1
+		<COMMIT-A> refs/heads/topic2
+		<COMMIT-A> refs/heads/topic3
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "update-ref: update HEAD, a symbolic-ref" '
+	test_when_finished "git switch main; rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <COMMIT-B> HEAD
+		<COMMIT-A> <COMMIT-B> refs/heads/topic1
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <COMMIT-B> HEAD
+		<COMMIT-A> <COMMIT-B> refs/heads/topic1
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> HEAD
+		<COMMIT-B> <COMMIT-A> refs/heads/topic1
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> HEAD
+		<COMMIT-B> <COMMIT-A> refs/heads/topic1
+	EOF
+
+	(
+		cd workdir &&
+		git switch topic1 &&
+		git update-ref HEAD $B $A &&
+		git update-ref HEAD $A &&
+		git switch main
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-A> refs/heads/topic1
+		<COMMIT-A> refs/heads/topic2
+		<COMMIT-A> refs/heads/topic3
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "update-ref: call git-pack-refs to create packed_ref_store" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+	git -C workdir pack-refs --all &&
+	test_path_is_file workdir/.git/packed-refs &&
+	test_path_is_missing $HOOK_OUTPUT
+'
+
+test_expect_failure "update-ref: update refs already packed to .git/packed-refs" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <COMMIT-B> refs/heads/topic2
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <COMMIT-B> refs/heads/topic2
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <COMMIT-C> refs/heads/topic3
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <COMMIT-C> refs/heads/topic3
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic4
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic4
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <COMMIT-C> refs/heads/topic4
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <COMMIT-C> refs/heads/topic4
+	EOF
+
+	(
+		cd workdir &&
+		git update-ref refs/heads/topic2 $B $A &&
+		git update-ref refs/heads/topic3 $C &&
+		git update-ref refs/heads/topic4 $A &&
+		git update-ref refs/heads/topic4 $C
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-A> refs/heads/topic1
+		<COMMIT-B> refs/heads/topic2
+		<COMMIT-C> refs/heads/topic3
+		<COMMIT-C> refs/heads/topic4
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "update-ref: remove refs with mixed ref_stores" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <ZERO-OID> refs/heads/topic1
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <ZERO-OID> refs/heads/topic1
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <ZERO-OID> refs/heads/topic1
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <ZERO-OID> refs/heads/topic2
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-B> <ZERO-OID> refs/heads/topic2
+		## Call hook: reference-transaction committed ##
+		<COMMIT-B> <ZERO-OID> refs/heads/topic2
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <ZERO-OID> refs/heads/topic3
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-C> <ZERO-OID> refs/heads/topic3
+		## Call hook: reference-transaction committed ##
+		<COMMIT-C> <ZERO-OID> refs/heads/topic3
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-C> <ZERO-OID> refs/heads/topic4
+		## Call hook: reference-transaction committed ##
+		<COMMIT-C> <ZERO-OID> refs/heads/topic4
+	EOF
+
+	(
+		cd workdir &&
+		git update-ref -d refs/heads/topic1 $A &&
+		git update-ref -d refs/heads/topic2 $B &&
+		git update-ref -d refs/heads/topic3 &&
+		git update-ref -d refs/heads/topic4
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_success "update-ref --stdin: create new refs" '
+	test_when_finished "git -C workdir pack-refs --all; rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic1
+		<ZERO-OID> <COMMIT-A> refs/heads/topic2
+		<ZERO-OID> <COMMIT-A> refs/heads/topic3
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic1
+		<ZERO-OID> <COMMIT-A> refs/heads/topic2
+		<ZERO-OID> <COMMIT-A> refs/heads/topic3
+	EOF
+
+	(
+		cd workdir &&
+		git update-ref --stdin <<-EOF
+		create refs/heads/topic1 $A
+		create refs/heads/topic2 $A
+		create refs/heads/topic3 $A
+		EOF
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-A> refs/heads/topic1
+		<COMMIT-A> refs/heads/topic2
+		<COMMIT-A> refs/heads/topic3
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "update-ref --stdin: update refs" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <COMMIT-B> refs/heads/topic2
+		<COMMIT-A> <COMMIT-C> refs/heads/topic3
+		<ZERO-OID> <COMMIT-C> refs/heads/topic4
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <COMMIT-B> refs/heads/topic2
+		<COMMIT-A> <COMMIT-C> refs/heads/topic3
+		<ZERO-OID> <COMMIT-C> refs/heads/topic4
+	EOF
+
+	(
+		cd workdir &&
+		git update-ref --stdin <<-EOF
+		start
+		update refs/heads/topic2 $B $A
+		update refs/heads/topic3 $C
+		create refs/heads/topic4 $C
+		prepare
+		commit
+		EOF
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-A> refs/heads/topic1
+		<COMMIT-B> refs/heads/topic2
+		<COMMIT-C> refs/heads/topic3
+		<COMMIT-C> refs/heads/topic4
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "update-ref --stdin: delete refs" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <ZERO-OID> refs/heads/topic1
+		<ZERO-OID> <ZERO-OID> refs/heads/topic2
+		<ZERO-OID> <ZERO-OID> refs/heads/topic3
+		<ZERO-OID> <ZERO-OID> refs/heads/topic4
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <ZERO-OID> refs/heads/topic1
+		<COMMIT-B> <ZERO-OID> refs/heads/topic2
+		<COMMIT-C> <ZERO-OID> refs/heads/topic3
+		<COMMIT-C> <ZERO-OID> refs/heads/topic4
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <ZERO-OID> refs/heads/topic1
+		<COMMIT-B> <ZERO-OID> refs/heads/topic2
+		<COMMIT-C> <ZERO-OID> refs/heads/topic3
+		<COMMIT-C> <ZERO-OID> refs/heads/topic4
+	EOF
+
+	(
+		cd workdir &&
+		git update-ref --stdin <<-EOF
+		start
+		delete refs/heads/topic1
+		delete refs/heads/topic2 $B
+		delete refs/heads/topic3
+		delete refs/heads/topic4
+		prepare
+		commit
+		EOF
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_success "branch: setup workdir using git-fetch" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-\EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/remotes/origin/main
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/remotes/origin/main
+	EOF
+
+	rm -rf workdir &&
+	git init workdir &&
+	git -C workdir remote add origin ../base &&
+	git -C workdir fetch origin &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/heads/main
+		<ZERO-OID> <COMMIT-C> HEAD
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/heads/main
+		<ZERO-OID> <COMMIT-C> HEAD
+	EOF
+
+	rm $HOOK_OUTPUT &&
+	git -C workdir switch -c main origin/main &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	<COMMIT-C> refs/heads/main
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_success "branch: create new branches" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic1
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic1
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic2
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic2
+	EOF
+
+	(
+		cd workdir &&
+		git branch topic1 $A &&
+		git branch topic2 $A
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-A> refs/heads/topic1
+		<COMMIT-A> refs/heads/topic2
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "branch: call git-gc to create packed_ref_store" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+	git -C workdir gc &&
+	test_path_is_file workdir/.git/packed-refs &&
+	test_path_is_missing $HOOK_OUTPUT
+'
+
+test_expect_failure "branch: update refs to create loose refs" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <COMMIT-B> refs/heads/topic2
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <COMMIT-B> refs/heads/topic2
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic3
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic3
+	EOF
+
+	(
+		cd workdir &&
+		git branch -f topic2 $B &&
+		git branch topic3 $C
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-A> refs/heads/topic1
+		<COMMIT-B> refs/heads/topic2
+		<COMMIT-C> refs/heads/topic3
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "branch: copy branches" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-B> refs/heads/topic4
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-B> refs/heads/topic4
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic5
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic5
+	EOF
+
+	(
+		cd workdir &&
+		git branch -c topic2 topic4 &&
+		git branch -c topic3 topic5
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-A> refs/heads/topic1
+		<COMMIT-B> refs/heads/topic2
+		<COMMIT-C> refs/heads/topic3
+		<COMMIT-B> refs/heads/topic4
+		<COMMIT-C> refs/heads/topic5
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "branch: rename branches" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-B> <ZERO-OID> refs/heads/topic4
+		## Call hook: reference-transaction committed ##
+		<COMMIT-B> <ZERO-OID> refs/heads/topic4
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-B> refs/heads/topic6
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-B> refs/heads/topic6
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-C> <ZERO-OID> refs/heads/topic5
+		## Call hook: reference-transaction committed ##
+		<COMMIT-C> <ZERO-OID> refs/heads/topic5
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic7
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic7
+	EOF
+
+	(
+		cd workdir &&
+		git branch -m topic4 topic6 &&
+		git branch -m topic5 topic7
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-A> refs/heads/topic1
+		<COMMIT-B> refs/heads/topic2
+		<COMMIT-C> refs/heads/topic3
+		<COMMIT-B> refs/heads/topic6
+		<COMMIT-C> refs/heads/topic7
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "branch: remove branches" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <ZERO-OID> refs/heads/topic1
+		<ZERO-OID> <ZERO-OID> refs/heads/topic2
+		<ZERO-OID> <ZERO-OID> refs/heads/topic3
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <ZERO-OID> refs/heads/topic1
+		<COMMIT-B> <ZERO-OID> refs/heads/topic2
+		<COMMIT-C> <ZERO-OID> refs/heads/topic3
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <ZERO-OID> refs/heads/topic1
+		<COMMIT-B> <ZERO-OID> refs/heads/topic2
+		<COMMIT-C> <ZERO-OID> refs/heads/topic3
+	EOF
+
+	(
+		cd workdir &&
+		git branch -d topic1 topic2 topic3
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-B> refs/heads/topic6
+		<COMMIT-C> refs/heads/topic7
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_success "tag: setup workdir using git-push" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/heads/main
+		<ZERO-OID> <COMMIT-C> HEAD
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/heads/main
+		<ZERO-OID> <COMMIT-C> HEAD
+	EOF
+
+	rm -rf workdir &&
+	git init workdir &&
+	git -C workdir config receive.denyCurrentBranch ignore &&
+	git -C base push ../workdir "+refs/heads/*:refs/heads/*" &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+	EOF
+	test_cmp_heads_and_tags -C workdir expect &&
+
+	git -C workdir restore --staged -- . &&
+	git -C workdir restore -- .
+'
+
+test_expect_success "tag: create new tags" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> refs/tags/v1
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> refs/tags/v1
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> refs/tags/v2
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> refs/tags/v2
+	EOF
+
+	(
+		cd workdir &&
+		git tag v1 $A &&
+		git tag v2 $A
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-A> refs/tags/v1
+		<COMMIT-A> refs/tags/v2
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "tag: call git-pack-refs to create packed_ref_store" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+	git -C workdir pack-refs --all &&
+	test_path_is_file workdir/.git/packed-refs &&
+	test_path_is_missing $HOOK_OUTPUT
+'
+
+test_expect_success "tag: update refs to create loose refs" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <COMMIT-B> refs/tags/v2
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <COMMIT-B> refs/tags/v2
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/tags/v3
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/tags/v3
+	EOF
+
+	(
+		cd workdir &&
+		git tag -f v2 $B &&
+		git tag v3 $C
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-A> refs/tags/v1
+		<COMMIT-B> refs/tags/v2
+		<COMMIT-C> refs/tags/v3
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "tag: remove tags with mixed ref_stores" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <ZERO-OID> refs/tags/v1
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <ZERO-OID> refs/tags/v1
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <ZERO-OID> refs/tags/v1
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <ZERO-OID> refs/tags/v2
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-B> <ZERO-OID> refs/tags/v2
+		## Call hook: reference-transaction committed ##
+		<COMMIT-B> <ZERO-OID> refs/tags/v2
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-C> <ZERO-OID> refs/tags/v3
+		## Call hook: reference-transaction committed ##
+		<COMMIT-C> <ZERO-OID> refs/tags/v3
+	EOF
+
+	(
+		cd workdir &&
+		git tag -d v1 &&
+		git tag -d v2 &&
+		git tag -d v3
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_success "worktree: setup workdir using push --atomic" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/heads/main
+		<ZERO-OID> <COMMIT-C> HEAD
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/heads/main
+		<ZERO-OID> <COMMIT-C> HEAD
+	EOF
+
+	rm -rf workdir &&
+	git init --bare repo.git &&
+	git -C base push --atomic --mirror ../repo.git &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+	rm $HOOK_OUTPUT &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/remotes/origin/main
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/remotes/origin/main
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> HEAD
+		<ZERO-OID> <COMMIT-C> refs/heads/main
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> HEAD
+		<ZERO-OID> <COMMIT-C> refs/heads/main
+	EOF
+
+	git clone --no-local repo.git workdir &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+		<COMMIT-C> refs/heads/main
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_success "worktree: topic1: commit --amend" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic1
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic1
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-C> <COMMIT-D> HEAD
+		<COMMIT-C> <COMMIT-D> refs/heads/topic1
+		## Call hook: reference-transaction committed ##
+		<COMMIT-C> <COMMIT-D> HEAD
+		<COMMIT-C> <COMMIT-D> refs/heads/topic1
+	EOF
+
+	(
+		cd workdir &&
+		git checkout -b topic1 &&
+		git commit --amend -m "C (amend)"
+	) &&
+	D=$(git -C workdir rev-parse HEAD) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-D> refs/heads/topic1
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_success "worktree: topic2: merge" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic2
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic2
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> ORIG_HEAD
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> ORIG_HEAD
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <COMMIT-E> HEAD
+		<COMMIT-A> <COMMIT-E> refs/heads/topic2
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <COMMIT-E> HEAD
+		<COMMIT-A> <COMMIT-E> refs/heads/topic2
+	EOF
+
+	(
+		cd workdir &&
+		git checkout -b topic2 $A &&
+		git merge --no-ff main &&
+		test_path_is_file B.t &&
+		test_path_is_file C.t
+	) &&
+	E=$(git -C workdir rev-parse HEAD) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-D> refs/heads/topic1
+		<COMMIT-E> refs/heads/topic2
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "worktree: topic3: cherry-pick" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic3
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-A> refs/heads/topic3
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> CHERRY_PICK_HEAD
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> CHERRY_PICK_HEAD
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <COMMIT-F> HEAD
+		<COMMIT-A> <COMMIT-F> refs/heads/topic3
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <COMMIT-F> HEAD
+		<COMMIT-A> <COMMIT-F> refs/heads/topic3
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-C> <ZERO-OID> CHERRY_PICK_HEAD
+		## Call hook: reference-transaction committed ##
+		<COMMIT-C> <ZERO-OID> CHERRY_PICK_HEAD
+	EOF
+
+	(
+		cd workdir &&
+		git checkout -b topic3 $A &&
+		git cherry-pick $C &&
+		test_path_is_file C.t &&
+		test_path_is_missing B.t
+	) &&
+	F=$(git -C workdir rev-parse HEAD) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-D> refs/heads/topic1
+		<COMMIT-E> refs/heads/topic2
+		<COMMIT-F> refs/heads/topic3
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "worktree: topic4: rebase" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-A> <COMMIT-G> ORIG_HEAD
+		## Call hook: reference-transaction committed ##
+		<COMMIT-A> <COMMIT-G> ORIG_HEAD
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-G> <COMMIT-C> HEAD
+		## Call hook: reference-transaction committed ##
+		<COMMIT-G> <COMMIT-C> HEAD
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <ZERO-OID> REBASE_HEAD
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <ZERO-OID> REBASE_HEAD
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-G> CHERRY_PICK_HEAD
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-G> CHERRY_PICK_HEAD
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-C> <COMMIT-H> HEAD
+		## Call hook: reference-transaction committed ##
+		<COMMIT-C> <COMMIT-H> HEAD
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-G> <ZERO-OID> CHERRY_PICK_HEAD
+		## Call hook: reference-transaction committed ##
+		<COMMIT-G> <ZERO-OID> CHERRY_PICK_HEAD
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-G> <COMMIT-H> refs/heads/topic4
+		## Call hook: reference-transaction committed ##
+		<COMMIT-G> <COMMIT-H> refs/heads/topic4
+	EOF
+
+	git -C workdir checkout -b topic4 $A &&
+	create_commits_in workdir G &&
+	rm $HOOK_OUTPUT &&
+	git -C workdir rebase main &&
+	H=$(git -C workdir rev-parse HEAD) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-D> refs/heads/topic1
+		<COMMIT-E> refs/heads/topic2
+		<COMMIT-F> refs/heads/topic3
+		<COMMIT-H> refs/heads/topic4
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_failure "worktree: topic5: revert" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic5
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic5
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-C> <COMMIT-I> HEAD
+		<COMMIT-C> <COMMIT-I> refs/heads/topic5
+		## Call hook: reference-transaction committed ##
+		<COMMIT-C> <COMMIT-I> HEAD
+		<COMMIT-C> <COMMIT-I> refs/heads/topic5
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
+	EOF
+
+	(
+		cd workdir &&
+		git checkout -b topic5 $C &&
+		git revert HEAD &&
+		test_path_is_file B.t &&
+		test_path_is_missing C.t
+	) &&
+	I=$(git -C workdir rev-parse HEAD) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-D> refs/heads/topic1
+		<COMMIT-E> refs/heads/topic2
+		<COMMIT-F> refs/heads/topic3
+		<COMMIT-H> refs/heads/topic4
+		<COMMIT-I> refs/heads/topic5
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
+test_expect_success "worktree: topic6: reset" '
+	test_when_finished "rm -f $HOOK_OUTPUT" &&
+
+	cat >expect <<-EOF &&
+		## Call hook: reference-transaction  prepared ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic6
+		## Call hook: reference-transaction committed ##
+		<ZERO-OID> <COMMIT-C> refs/heads/topic6
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-G> <COMMIT-C> ORIG_HEAD
+		## Call hook: reference-transaction committed ##
+		<COMMIT-G> <COMMIT-C> ORIG_HEAD
+		## Call hook: reference-transaction  prepared ##
+		<COMMIT-C> <COMMIT-B> HEAD
+		<COMMIT-C> <COMMIT-B> refs/heads/topic6
+		## Call hook: reference-transaction committed ##
+		<COMMIT-C> <COMMIT-B> HEAD
+		<COMMIT-C> <COMMIT-B> refs/heads/topic6
+	EOF
+
+	(
+		cd workdir &&
+		git checkout -b topic6 $C &&
+		git reset --hard $B
+	) &&
+	make_user_friendly_and_stable_output <$HOOK_OUTPUT >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-EOF &&
+		<COMMIT-C> refs/heads/main
+		<COMMIT-D> refs/heads/topic1
+		<COMMIT-E> refs/heads/topic2
+		<COMMIT-F> refs/heads/topic3
+		<COMMIT-H> refs/heads/topic4
+		<COMMIT-I> refs/heads/topic5
+		<COMMIT-B> refs/heads/topic6
+	EOF
+	test_cmp_heads_and_tags -C workdir expect
+'
+
 test_done
-- 
2.36.1.25.gc87d5ad63a.dirty

