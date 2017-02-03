Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62821F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752287AbdBCCyf (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:35 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33303 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbdBCCyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:32 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so1211364wmv.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLMa0quNxjcFLezYdL+6nrMXZphj8TPKXu0uWcY+YYM=;
        b=dU5buGO6f7gC/GOOrjccbHqI/7BweCb8ZwqNqGjIxlHMnStlyqY/QoI2ANBGirqQZN
         RrxbCvbqOVk1g2X7PhrAlvib+RSVEQkhu4tE+Kzt17ZXkcfiFGGUUdr78vzxhYGK91Wr
         CMhMJElNQ3Cypd7rDPECxuaTNCxZ1sAR6h4tB7MA9hO/e6sXMNfGmfMilD7OCIaCPQ5r
         +mqdnBZqvbKxpyaAqR7t87mnuu78ty6MBySMGrf6eRwcdZK2Zt4kD4OZTb6g8wjZt+ay
         J9OzRyaDd36+GDHqXCPuUWu02AQzteXldiNvCfbMQoWv2NYwqSpr0dMs6XNdqkBf05sF
         b+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLMa0quNxjcFLezYdL+6nrMXZphj8TPKXu0uWcY+YYM=;
        b=abCQYJIUMPhIHlC0OHDJiod5gGSNVeX/foWfo08btmlfHz+sjv9jgq88SqJ2+bFqpY
         OGIcJO4xu6amUGMYTAtVvMQVj5pvbjLjUvt66nbwIbNRWtGzFnbNKIMoYpo2Cm2x0aqL
         7NQgoUvv/KK1vU4pIrj8i1ZZk1r+E8SOh4PpgvrddEyzrU1U5RWEfrPfHrh09KqohAEA
         OAkqMhF7/Vrp38hO66XD9D17NJsLEw3vmhemQswlicxrKFpEeT9zoESphDzMndjjY00g
         RL6oXYD7QoYipDPVtnCMJUinT2KbR6tO+3i7yBqg/iTBG0+pUCw/HEeX9QzyDiICiJ7W
         5PyA==
X-Gm-Message-State: AIkVDXI5A6Fm9IxP5wAuncHmFUbEG8iwNm+z3sSizRok/pwkVn2tT8Wk2BEk9VTOwjEiwg==
X-Received: by 10.223.168.87 with SMTP id l81mr12020684wrc.194.1486090470920;
        Thu, 02 Feb 2017 18:54:30 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:30 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 07/12] completion: let 'for-each-ref' and 'ls-remote' filter matching refs
Date:   Fri,  3 Feb 2017 03:54:00 +0100
Message-Id: <20170203025405.8242-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203025405.8242-1-szeder.dev@gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When completing refs, several __git_refs() code paths list all the
refs from the refs/{heads,tags,remotes}/ hierarchy and then
__gitcomp_nl() iterates over those refs in a shell loop to filter out
refs not matching the current word to be completed.  This comes with a
considerable performance penalty when a repository contains a lot of
refs but the current word can be uniquely completed or when only a
handful of refs match the current word.

Specify appropriate globbing patterns to 'git for-each-ref' and 'git
ls-remote' to list only those refs that match the current word to be
completed.  This reduces the number of iterations in __gitcomp_nl()
from the number of refs to the number of matching refs.

This speeds up refs completion considerably when there are a lot of
non-matching refs to be filtered out.  Uniquely completing a branch in
a repository with 100k local branches, all packed, best of five:

  On Linux, before:

    $ time __git_complete_refs --cur=maste

    real    0m0.831s
    user    0m0.808s
    sys     0m0.028s

  After:

    real    0m0.119s
    user    0m0.104s
    sys     0m0.008s

  On Windows, before:

    real    0m1.480s
    user    0m1.031s
    sys     0m0.060s

  After:

    real    0m0.377s
    user    0m0.015s
    sys     0m0.030s

Strictly speaking this is a fundamental behavior change in
__git_refs(), a helper function that is likely used in users' custom
completion scriptlets.  However, arguably this change should be
harmless, because:

  - __git_refs() was only ever intended to feed refs to Bash's
    completion machinery, for which non-matching refs have to be
    filtered out anyway.

  - There were already code paths that list only matching refs
    (listing unique remote branches for 'git checkout's tracking
    DWIMery and listing full remote refs via 'git ls-remote').

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash |  14 +++--
 t/t9902-completion.sh                  | 102 +++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d55eadfd1..615292f8b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -394,7 +394,7 @@ __git_refs ()
 		case "$cur_" in
 		refs|refs/*)
 			format="refname"
-			refs="${cur_%/*}"
+			refs=("$cur_*" "$cur_*/**")
 			track=""
 			;;
 		*)
@@ -402,11 +402,13 @@ __git_refs ()
 				if [ -e "$dir/$i" ]; then echo $pfx$i; fi
 			done
 			format="refname:strip=2"
-			refs="refs/tags refs/heads refs/remotes"
+			refs=("refs/tags/$cur_*" "refs/tags/$cur_*/**"
+				"refs/heads/$cur_*" "refs/heads/$cur_*/**"
+				"refs/remotes/$cur_*" "refs/remotes/$cur_*/**")
 			;;
 		esac
 		__git_dir="$dir" __git for-each-ref --format="$pfx%($format)" \
-			$refs
+			"${refs[@]}"
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
@@ -438,10 +440,12 @@ __git_refs ()
 		if [ "$list_refs_from" = remote ]; then
 			echo "HEAD"
 			__git for-each-ref --format="%(refname:strip=2)" \
-				"refs/remotes/$remote/" | sed -e "s#^$remote/##"
+				"refs/remotes/$remote/$cur_*" \
+				"refs/remotes/$remote/$cur_*/**" | sed -e "s#^$remote/##"
 		else
 			__git ls-remote "$remote" HEAD \
-				"refs/tags/*" "refs/heads/*" "refs/remotes/*" |
+				"refs/tags/$cur_*" "refs/heads/$cur_*" \
+				"refs/remotes/$cur_*" |
 			while read -r hash i; do
 				case "$i" in
 				*^{})	;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7b42a686c..499be5879 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -837,6 +837,108 @@ test_expect_success '__git refs - exluding full refs' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'setup for filtering matching refs' '
+	git branch matching/branch &&
+	git tag matching/tag &&
+	git -C otherrepo branch matching/branch-in-other &&
+	git fetch --no-tags other &&
+	rm -f .git/FETCH_HEAD
+'
+
+test_expect_success '__git_refs - only matching refs' '
+	cat >expected <<-EOF &&
+	HEAD
+	matching-branch
+	matching/branch
+	matching-tag
+	matching/tag
+	EOF
+	(
+		cur=mat &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - only matching refs - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/matching-branch
+	refs/heads/matching/branch
+	EOF
+	(
+		cur=refs/heads/mat &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - only matching refs - remote on local file system' '
+	cat >expected <<-EOF &&
+	HEAD
+	master-in-other
+	matching/branch-in-other
+	EOF
+	(
+		cur=ma &&
+		__git_refs otherrepo >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - only matching refs - configured remote' '
+	cat >expected <<-EOF &&
+	HEAD
+	master-in-other
+	matching/branch-in-other
+	EOF
+	(
+		cur=ma &&
+		__git_refs other >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - only matching refs - remote - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/master-in-other
+	refs/heads/matching/branch-in-other
+	EOF
+	(
+		cur=refs/heads/ma &&
+		__git_refs other >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - only matching refs - checkout DWIMery' '
+	cat >expected <<-EOF &&
+	HEAD
+	matching-branch
+	matching/branch
+	matching-tag
+	matching/tag
+	matching/branch-in-other
+	EOF
+	for remote_ref in refs/remotes/other/ambiguous \
+		refs/remotes/remote/ambiguous \
+		refs/remotes/remote/branch-in-remote
+	do
+		git update-ref $remote_ref master &&
+		test_when_finished "git update-ref -d $remote_ref"
+	done &&
+	(
+		cur=mat &&
+		__git_refs "" 1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'teardown after filtering matching refs' '
+	git branch -d matching/branch &&
+	git tag -d matching/tag &&
+	git update-ref -d refs/remotes/other/matching/branch-in-other
+'
+
 test_expect_success '__git_complete_refs - simple' '
 	sed -e "s/Z$//g" >expected <<-EOF &&
 	HEAD Z
-- 
2.11.0.555.g967c1bcb3

