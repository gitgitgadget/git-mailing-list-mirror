Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD1FC4167E
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJUPOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJUPN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:13:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D722196ED1
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so2174354wmq.4
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1ckwiSuHx+BmDD4kVrquteOnAzUtDVZtmzpP+FfVv4=;
        b=Ev4q1BwebBj9GQpp7AvhrNWFnRlaD4vwdDr6fJeEs4Pib5xqdR8CTn6hU53/NK/8en
         nbt0K7rJFvnimVCH9Pku4rFCJB3dFZJ65ChQcOmEkhPSx0cCPcyn5Gbwo4UT1zNUu8Oj
         feEzEnBSc1W4w5+tV6S85fRuvsrHxgZxwFq0P5HCR9qZh3runxJwZNfHupwU3x9ClRRm
         VFqHJ4Dla4xlfU/Hre7xp0fg+ElrSnptD3Nf3WMcrYs0sk0fKN1j+rULoL0YRBYFbfN0
         EAd2V1eavdZocUUklNRFJymRWYk4cCIS6QV8KAKd1wjC5qszyjeu6VrJLEQMBU6znnjm
         LB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1ckwiSuHx+BmDD4kVrquteOnAzUtDVZtmzpP+FfVv4=;
        b=a3MLQ6Smul/Y7VgUHXCaAZVcUhauZ6SmvBd5OdNyMBt2+/J1ybpCVuD5fOvW1tmnSw
         rQ/kNHf3cm++nLUptMg4hU+ffzZueEcrjjlL2ZbwpTtOtMN1ETL8bmWIIGTdpvKhCRVR
         mNsoAnmZ3DX8tZsQO/Vr4Vy+X+2KlZMQIwbOxQZEpSyxdMhq7k1v9BX/kRXdncY2+cVJ
         ohmVlHDDpIW1dSh7RSb7DOvTdYymkNPlMyAyGkeT3rScyT7T6tkJaaBMs3ztexvo3VaF
         LTwcUdmA9ja/mQ0QgvZuJ145YfV8J50u3v6Z12MXSJXl1Sa4eCRavZtWo1HV7ZoOm4bg
         pAJg==
X-Gm-Message-State: ACrzQf2otqiUzEKl9uQ5vu4GfGe+1CVIUNAuCPuFD5IHvi/bcu8QujhM
        9CxpqjgpFD4ZqXvSljLNHuGMjZhKKis=
X-Google-Smtp-Source: AMsMyM7fSlHu6O7geEgvCFFzcKJ4aRH26svaRZhMM18JYxYherHx/cdS/S6eByM9Q+Qq1/zU5u1bFQ==
X-Received: by 2002:a05:600c:5248:b0:3c6:faf9:3939 with SMTP id fc8-20020a05600c524800b003c6faf93939mr16104933wmb.100.1666365234618;
        Fri, 21 Oct 2022 08:13:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs14-20020a056000070e00b00236545edc91sm1793349wrb.76.2022.10.21.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:13:54 -0700 (PDT)
Message-Id: <86a842d50345f6d4d0b16c78d565474be6f8068a.1666365220.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 15:13:39 +0000
Subject: [PATCH 9/9] subtree: fix split after annotated tag was squashed
 merged
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The previous commit fixed a failure in 'git subtree merge --squash' when
the previous squash-merge merged an annotated tag of the subtree
repository which is missing locally.

The same failure happens in 'git subtree split', either directly or when
called by 'git subtree push', under the same circumstances: 'cmd_split'
invokes 'find_existing_splits', which loops through previous commits and
invokes 'git rev-parse' (via 'process_subtree_split_trailer') on the
value of any 'git subtree-split' trailer it finds. This fails if this
value is the hash of an annotated tag which is missing locally.

Add a new optional argument 'repository' to 'cmd_split' and
'find_existing_splits', and invoke 'cmd_split' with that argument from
'cmd_push'. This allows 'process_subtree_split_trailer' to try to fetch
the missing tag from the 'repository' if it's not available locally,
mirroring the new behaviour of 'git subtree pull' and 'git subtree
merge'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/subtree/git-subtree.sh     | 26 ++++++++++++++++++--------
 contrib/subtree/git-subtree.txt    |  7 ++++++-
 contrib/subtree/t/t7900-subtree.sh | 12 ++++++++++++
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 2c67989fe8a..10c9c87839a 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -453,14 +453,19 @@ find_latest_squash () {
 	done || exit $?
 }
 
-# Usage: find_existing_splits DIR REV
+# Usage: find_existing_splits DIR REV [REPOSITORY]
 find_existing_splits () {
-	assert test $# = 2
+	assert test $# = 2 -o $# = 3
 	debug "Looking for prior splits..."
 	local indent=$(($indent + 1))
 
 	dir="$1"
 	rev="$2"
+	repository=""
+	if test "$#" = 3
+	then
+		repository="$3"
+	fi
 	main=
 	sub=
 	local grep_format="^git-subtree-dir: $dir/*\$"
@@ -480,7 +485,7 @@ find_existing_splits () {
 			main="$b"
 			;;
 		git-subtree-split:)
-			process_subtree_split_trailer "$b" "$sq"
+			process_subtree_split_trailer "$b" "$sq" "$repository"
 			;;
 		END)
 			debug "Main is: '$main'"
@@ -906,17 +911,22 @@ cmd_add_commit () {
 	say >&2 "Added dir '$dir'"
 }
 
-# Usage: cmd_split [REV]
+# Usage: cmd_split [REV] [REPOSITORY]
 cmd_split () {
 	if test $# -eq 0
 	then
 		rev=$(git rev-parse HEAD)
-	elif test $# -eq 1
+	elif test $# -eq 1 -o $# -eq 2
 	then
 		rev=$(git rev-parse -q --verify "$1^{commit}") ||
 			die "fatal: '$1' does not refer to a commit"
 	else
-		die "fatal: you must provide exactly one revision.  Got: '$*'"
+		die "fatal: you must provide exactly one revision, and optionnally a repository.  Got: '$*'"
+	fi
+	repository=""
+	if test "$#" = 2
+	then
+		repository="$2"
 	fi
 
 	if test -n "$arg_split_rejoin"
@@ -940,7 +950,7 @@ cmd_split () {
 		done || exit $?
 	fi
 
-	unrevs="$(find_existing_splits "$dir" "$rev")" || exit $?
+	unrevs="$(find_existing_splits "$dir" "$rev" "$repository")" || exit $?
 
 	# We can't restrict rev-list to only $dir here, because some of our
 	# parents have the $dir contents the root, and those won't match.
@@ -1072,7 +1082,7 @@ cmd_push () {
 			die "fatal: '$localrevname_presplit' does not refer to a commit"
 
 		echo "git push using: " "$repository" "$refspec"
-		localrev=$(cmd_split "$localrev_presplit") || die
+		localrev=$(cmd_split "$localrev_presplit" "$repository") || die
 		git push "$repository" "$localrev":"refs/heads/$remoteref"
 	else
 		die "fatal: '$dir' must already exist. Try 'git subtree add'."
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 0e7524d7864..004abf415b8 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -94,7 +94,7 @@ annotated tag of the subtree repository, that tag needs to be available locally.
 If <repository> is given, a missing tag will automatically be fetched from that
 repository.
 
-split [<local-commit>]::
+split [<local-commit>] [<repository>]::
 	Extract a new, synthetic project history from the
 	history of the <prefix> subtree of <local-commit>, or of
 	HEAD if no <local-commit> is given.  The new history
@@ -114,6 +114,11 @@ settings passed to 'split' (such as '--annotate') are the same.
 Because of this, if you add new commits and then re-split, the new
 commits will be attached as commits on top of the history you
 generated last time, so 'git merge' and friends will work as expected.
++
+When a previous merge with '--squash' merged an annotated tag of the
+subtree repository, that tag needs to be available locally.
+If <repository> is given, a missing tag will automatically be fetched from that
+repository.
 
 pull <repository> <remote-ref>::
 	Exactly like 'merge', but parallels 'git pull' in that
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index d0671676c7a..341c169eca7 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -582,6 +582,12 @@ test_expect_success 'split "sub dir"/ with --branch for an incompatible branch'
 	)
 '
 
+test_expect_success 'split after annotated tag was added/merged with --squash pre-v2.32.0' '
+	test_create_pre2_32_repo "$test_count" &&
+	test_must_fail git -C "$test_count-clone" subtree split --prefix="sub" HEAD &&
+	git -C "$test_count-clone" subtree split --prefix="sub" HEAD "../$test_count-sub"
+'
+
 #
 # Tests for 'git subtree pull'
 #
@@ -989,6 +995,12 @@ test_expect_success 'push "sub dir"/ with a local rev' '
 	)
 '
 
+test_expect_success 'push after annotated tag was added/merged with --squash pre-v2.32.0' '
+	test_create_pre2_32_repo "$test_count" &&
+	test_create_commit "$test_count-clone" sub/main-sub1 &&
+	git -C "$test_count-clone" subtree push --prefix="sub" "../$test_count-sub" from-mainline
+'
+
 #
 # Validity checking
 #
-- 
gitgitgadget
