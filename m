Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30C5C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 14:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E23206B5
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 14:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozkUXBrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHXOwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgHXOvw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 10:51:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0155C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 07:51:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l2so8997313wrc.7
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BQTAVlcEC9wie9fKbIDRFcKsoJ/YWmmTmk5I93rTChs=;
        b=ozkUXBrhC+Oz7952fagBwZD/JFL/sX4uy/IJvQoggsxKIkkvOeuH/LbYVAtpPJpr/D
         mKrwrw7svP6u2GOq7+/M5jY7afrdelURxFIOKlNUdSjf4WIUwHGQ4nZ+OItDuzenpkvT
         cuJyhvACGyhOVALSVtcU1sSRSnbeAv0uPYCsxp+qXHwMOoExUMaXE623xXeh3VeTQZCd
         P2gjaQxQmzHbgco57dRE3AhVXqOodCf3n+O8myYApwVhb83n2WXsgnq3esXcTdMV+Gzb
         Z2RmOgDfBCnjmhJ3c+zjiRsxg0yC6kHEdahyK9x/ldPfQTcbFSIUQLytbqw5MFa2vVO1
         5vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BQTAVlcEC9wie9fKbIDRFcKsoJ/YWmmTmk5I93rTChs=;
        b=fggC4Y21Y7cipytbW+Z62LgZwvwuTNqaHqSknfa6dmmeaJZFHaVQxNwvGYnN4KC3GN
         QyGP4S7D0ti/DGQkAUTuOsqI4AkjoXlP1Ip8sjdJtx7m/rCzig4TaSa9AGbQROXPnMXQ
         cTZ07sIt+YO9WWWd7ULV5Kv8VfvPzJpJ+NSN40eEXVSkgE6CDogMlEDlo9XH60Vce8gR
         n5pOPiF/VuY+ZN2o3gkuRUcI7cKMXIPUuec9ktbGFW9UIy1Pk9TbdMnGws1DfM55shl7
         +ybHIVDtZ1TnUk6KcLQgBJy1I7fyKiJzRMzGoAUZbEbi/zHR+/Co1f3SWyuD3VKGPNkv
         RH3A==
X-Gm-Message-State: AOAM533tLMp4CNEWkewk0DSgsG4m585TDhEDyKCLrjIOm7C8a4vC4YJS
        rzA35x8gDTor9QMsIwpox/G8dvuiUD0=
X-Google-Smtp-Source: ABdhPJylOrb8ZcZTdJMwk9AMOFbxNfrHxkauosIYqZVnghctBWIaOEE/2xsqM+nxdBX5aGH7KU2zGw==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr6247798wrs.368.1598280710026;
        Mon, 24 Aug 2020 07:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm24107526wrv.50.2020.08.24.07.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 07:51:49 -0700 (PDT)
Message-Id: <f4ea4f6c69edfd5ab67bda9c1024c4aa0df3247e.1598280706.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.708.git.1598280703.gitgitgadget@gmail.com>
References: <pull.708.git.1598280703.gitgitgadget@gmail.com>
From:   "Vadim Sannikov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Aug 2020 14:51:43 +0000
Subject: [PATCH 2/2] Unify `update-index --cacheinfo` usage (tests)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Vadim Sannikov <vsj.vadim@gmail.com>,
        Vadim Sannikov <vsj.vadim@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vadim Sannikov <vsj.vadim@gmail.com>

The old three separate parameters format (`<mode> <object> <path>`)
is replaced with the modern, single-parameter form
(`<mode>,<object>,<path>`).

Different parts of Git code use different syntax, so the commit unifies
it. According to `git-update-index` manual page, the new form is
preferred.

Signed-off-by: Vadim Sannikov <vsj.vadim@gmail.com>
---
 t/lib-submodule-update.sh         |  2 +-
 t/t0028-working-tree-encoding.sh  |  4 ++--
 t/t1006-cat-file.sh               |  2 +-
 t/t1010-mktree.sh                 |  2 +-
 t/t1050-large.sh                  |  2 +-
 t/t1450-fsck.sh                   |  4 ++--
 t/t3600-rm.sh                     |  4 ++--
 t/t5520-pull.sh                   |  2 +-
 t/t5526-fetch-submodules.sh       | 18 +++++++++---------
 t/t5531-deep-submodule-push.sh    |  2 +-
 t/t6130-pathspec-noglob.sh        |  2 +-
 t/t6430-merge-recursive.sh        |  2 +-
 t/t7003-filter-branch.sh          |  2 +-
 t/t7011-skip-worktree-reading.sh  |  4 ++--
 t/t7012-skip-worktree-writing.sh  |  4 ++--
 t/t7113-post-index-change-hook.sh |  2 +-
 t/t7406-submodule-update.sh       |  4 ++--
 t/t9350-fast-export.sh            |  8 ++++----
 t/test-lib-functions.sh           |  2 +-
 19 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 87a759149f..75ce28a9c7 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -139,7 +139,7 @@ create_lib_submodule_repo () {
 		git revert HEAD &&
 
 		git checkout -b invalid_sub1 add_sub1 &&
-		git update-index --cacheinfo 160000 $(test_oid numeric) sub1 &&
+		git update-index --cacheinfo 160000,$(test_oid numeric),sub1 &&
 		git commit -m "Invalid sub1 commit" &&
 		git checkout -b valid_sub1 &&
 		git revert HEAD &&
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index bfc4fb9af5..aa4b719da0 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -213,7 +213,7 @@ test_expect_success 'error if encoding round trip is not the same during refresh
 	echo "*.utf16le text working-tree-encoding=utf-16le" >.gitattributes &&
 	echo "hallo" >nonsense.utf16le &&
 	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16le) &&
-	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16le &&
+	git update-index --add --cacheinfo 100644,$TEST_HASH,nonsense.utf16le &&
 	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
 	git update-ref refs/heads/master $COMMIT &&
 
@@ -229,7 +229,7 @@ test_expect_success 'error if encoding garbage is already in Git' '
 	# This simulates a Git version that has no checkoutEncoding support
 	cp nobom.utf16be.raw nonsense.utf16 &&
 	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
-	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
+	git update-index --add --cacheinfo 100644,$TEST_HASH,nonsense.utf16 &&
 	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
 	git update-ref refs/heads/master $COMMIT &&
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 2f501d2dc9..b61b46eab4 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -134,7 +134,7 @@ run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
 
 test_expect_success '--batch-check without %(rest) considers whole line' '
 	echo "$hello_sha1 blob $hello_size" >expect &&
-	git update-index --add --cacheinfo 100644 $hello_sha1 "white space" &&
+	git update-index --add --cacheinfo 100644,$hello_sha1,"white space" &&
 	test_when_finished "git update-index --remove \"white space\"" &&
 	echo ":white space" | git cat-file --batch-check >actual &&
 	test_cmp expect actual
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index b946f87686..558907af58 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -q -m one &&
 	H=$(git rev-parse HEAD) &&
-	git update-index --add --cacheinfo 160000 $H sub &&
+	git update-index --add --cacheinfo 160000,$H,sub &&
 	test_tick &&
 	git commit -q -m two &&
 	git rev-parse HEAD^{tree} >tree.withsub &&
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 61e89a8071..05d35d20d9 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -90,7 +90,7 @@ test_expect_success 'add a large file or two' '
 
 test_expect_success 'checkout a large file' '
 	large1=$(git rev-parse :large1) &&
-	git update-index --add --cacheinfo 100644 $large1 another &&
+	git update-index --add --cacheinfo 100644,$large1,another &&
 	git checkout another &&
 	test_cmp large1 another
 '
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index b17f5c21fb..643af25e3e 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -59,7 +59,7 @@ test_expect_success 'object with bad sha1' '
 	sha="$(dirname $new)$(basename $new)" &&
 	mv .git/objects/$old .git/objects/$new &&
 	test_when_finished "remove_object $sha" &&
-	git update-index --add --cacheinfo 100644 $sha foo &&
+	git update-index --add --cacheinfo 100644,$sha,foo &&
 	test_when_finished "git read-tree -u --reset HEAD" &&
 	tree=$(git write-tree) &&
 	test_when_finished "remove_object $tree" &&
@@ -438,7 +438,7 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
 	sha="$(dirname $new)$(basename $new)" &&
 	mv .git/objects/$old .git/objects/$new &&
 	test_when_finished "remove_object $sha" &&
-	git update-index --add --cacheinfo 100644 $sha foo &&
+	git update-index --add --cacheinfo 100644,$sha,foo &&
 	test_when_finished "git read-tree -u --reset HEAD" &&
 	tree=$(git write-tree) &&
 	test_when_finished "remove_object $tree" &&
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index efec8d13b6..a78a6b161b 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -305,7 +305,7 @@ EOF
 test_expect_success 'rm removes empty submodules from work tree' '
 	mkdir submod &&
 	hash=$(git rev-parse HEAD) &&
-	git update-index --add --cacheinfo 160000 "$hash" submod &&
+	git update-index --add --cacheinfo 160000,"$hash",submod &&
 	git config -f .gitmodules submodule.sub.url ./. &&
 	git config -f .gitmodules submodule.sub.path submod &&
 	git submodule init &&
@@ -632,7 +632,7 @@ test_expect_success 'setup subsubmodule' '
 	(
 		cd submod &&
 		hash=$(git rev-parse HEAD) &&
-		git update-index --add --cacheinfo 160000 "$hash" subsubmod &&
+		git update-index --add --cacheinfo 160000,"$hash",subsubmod &&
 		git config -f .gitmodules submodule.sub.url ../. &&
 		git config -f .gitmodules submodule.sub.path subsubmod &&
 		git submodule init &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9fae07cdfa..3be5b64030 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -350,7 +350,7 @@ test_expect_success 'failed --rebase shows advice' '
 	git checkout -b diverging &&
 	test_commit attributes .gitattributes "* text=auto" attrs &&
 	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
-	git update-index --cacheinfo 0644 $sha1 file &&
+	git update-index --cacheinfo 0644,$sha1,file &&
 	git commit -m v1-with-cr &&
 	# force checkout because `git reset --hard` will not leave clean `file`
 	git checkout -f -b fails-to-rebase HEAD^ &&
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 63205dfdf9..470f470b3e 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -614,12 +614,12 @@ test_expect_success "fetch new submodule commits on-demand outside standard refs
 
 	C=$(git -C submodule commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
 	git -C submodule update-ref refs/changes/1 $C &&
-	git update-index --cacheinfo 160000 $C submodule &&
+	git update-index --cacheinfo 160000,$C,submodule &&
 	test_tick &&
 
 	D=$(git -C sub1 commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
 	git -C sub1 update-ref refs/changes/2 $D &&
-	git update-index --cacheinfo 160000 $D sub1 &&
+	git update-index --cacheinfo 160000,$D,sub1 &&
 
 	git commit -m "updated submodules outside of refs/heads" &&
 	E=$(git rev-parse HEAD) &&
@@ -638,12 +638,12 @@ test_expect_success 'fetch new submodule commit on-demand in FETCH_HEAD' '
 
 	C=$(git -C submodule commit-tree -m "another change outside refs/heads" HEAD^{tree}) &&
 	git -C submodule update-ref refs/changes/4 $C &&
-	git update-index --cacheinfo 160000 $C submodule &&
+	git update-index --cacheinfo 160000,$C,submodule &&
 	test_tick &&
 
 	D=$(git -C sub1 commit-tree -m "another change outside refs/heads" HEAD^{tree}) &&
 	git -C sub1 update-ref refs/changes/5 $D &&
-	git update-index --cacheinfo 160000 $D sub1 &&
+	git update-index --cacheinfo 160000,$D,sub1 &&
 
 	git commit -m "updated submodules outside of refs/heads" &&
 	E=$(git rev-parse HEAD) &&
@@ -669,12 +669,12 @@ test_expect_success 'fetch new submodule commits on-demand without .gitmodules e
 
 	C=$(git -C submodule commit-tree -m "yet another change outside refs/heads" HEAD^{tree}) &&
 	git -C submodule update-ref refs/changes/7 $C &&
-	git update-index --cacheinfo 160000 $C submodule &&
+	git update-index --cacheinfo 160000,$C,submodule &&
 	test_tick &&
 
 	D=$(git -C sub1 commit-tree -m "yet another change outside refs/heads" HEAD^{tree}) &&
 	git -C sub1 update-ref refs/changes/8 $D &&
-	git update-index --cacheinfo 160000 $D sub1 &&
+	git update-index --cacheinfo 160000,$D,sub1 &&
 
 	git commit -m "updated submodules outside of refs/heads" &&
 	E=$(git rev-parse HEAD) &&
@@ -696,15 +696,15 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
 	F=$(git -C sub1 commit-tree -m "change 12 outside refs/heads" HEAD^{tree}) &&
 
 	git -C sub1 update-ref refs/changes/10 $D &&
-	git update-index --cacheinfo 160000 $D sub1 &&
+	git update-index --cacheinfo 160000,$D,sub1 &&
 	git commit -m "updated submodules outside of refs/heads" &&
 
 	git -C sub1 update-ref refs/changes/11 $E &&
-	git update-index --cacheinfo 160000 $E sub1 &&
+	git update-index --cacheinfo 160000,$E,sub1 &&
 	git commit -m "updated submodules outside of refs/heads" &&
 
 	git -C sub1 update-ref refs/changes/12 $F &&
-	git update-index --cacheinfo 160000 $F sub1 &&
+	git update-index --cacheinfo 160000,$F,sub1 &&
 	git commit -m "updated submodules outside of refs/heads" &&
 
 	G=$(git rev-parse HEAD) &&
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 4ad059e6be..7b5dc2df00 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -301,7 +301,7 @@ test_expect_success 'push succeeds if submodule commit disabling recursion from
 test_expect_success 'submodule entry pointing at a tag is error' '
 	git -C work/gar/bage tag -a test1 -m "tag" &&
 	tag=$(git -C work/gar/bage rev-parse test1^{tag}) &&
-	git -C work update-index --cacheinfo 160000 "$tag" gar/bage &&
+	git -C work update-index --cacheinfo 160000,"$tag",gar/bage &&
 	git -C work commit -m "bad commit" &&
 	test_when_finished "git -C work reset --hard HEAD^" &&
 	test_must_fail git -C work push --recurse-submodules=on-demand ../pub.git master 2>err &&
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index ba7902c9cd..bd9cb80feb 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -11,7 +11,7 @@ test_expect_success 'create commits with glob characters' '
 	# on Windows (the tests below do not depend on the presence
 	# of the file in the worktree)
 	git config core.protectNTFS false &&
-	git update-index --add --cacheinfo 100644 "$(git rev-parse HEAD:foo)" "f*" &&
+	git update-index --add --cacheinfo 100644,"$(git rev-parse HEAD:foo)","f*" &&
 	test_tick &&
 	git commit -m star &&
 	test_commit bracket "f[o][o]"
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index d48d211a95..c7766deb3a 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -246,7 +246,7 @@ test_expect_success 'setup 7' '
 	git rm d/e &&
 	test_tick &&
 	git commit -m "remove d/e" &&
-	git update-index --add --cacheinfo 160000 $c1 d &&
+	git update-index --add --cacheinfo 160000,$c1,d &&
 	test_tick &&
 	git commit -m "make d/ a submodule"
 '
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 36477cb1f4..49c7fff29e 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -467,7 +467,7 @@ test_expect_success 'replace submodule revision' '
 	git reset --hard original &&
 	git filter-branch -f --tree-filter \
 	    "if git ls-files --error-unmatch -- submod > /dev/null 2>&1
-	     then git update-index --cacheinfo 160000 $invalid submod
+	     then git update-index --cacheinfo 160000,$invalid,submod
 	     fi" HEAD &&
 	test $orig_head != $(git show-ref --hash --head HEAD)
 '
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 37525cae3a..97f4cbedf5 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -26,7 +26,7 @@ EOF
 setup_absent() {
 	test -f 1 && rm 1
 	git update-index --remove 1 &&
-	git update-index --add --cacheinfo 100644 $EMPTY_BLOB 1 &&
+	git update-index --add --cacheinfo 100644,$EMPTY_BLOB,1 &&
 	git update-index --skip-worktree 1
 }
 
@@ -40,7 +40,7 @@ test_absent() {
 setup_dirty() {
 	git update-index --force-remove 1 &&
 	echo dirty > 1 &&
-	git update-index --add --cacheinfo 100644 $EMPTY_BLOB 1 &&
+	git update-index --add --cacheinfo 100644,$EMPTY_BLOB,1 &&
 	git update-index --skip-worktree 1
 }
 
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index 7476781979..1ad17d3606 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -56,7 +56,7 @@ test_expect_success 'read-tree removes worktree, dirty case' '
 setup_absent() {
 	test -f 1 && rm 1
 	git update-index --remove 1 &&
-	git update-index --add --cacheinfo 100644 $EMPTY_BLOB 1 &&
+	git update-index --add --cacheinfo 100644,$EMPTY_BLOB,1 &&
 	git update-index --skip-worktree 1
 }
 
@@ -70,7 +70,7 @@ test_absent() {
 setup_dirty() {
 	git update-index --force-remove 1 &&
 	echo dirty > 1 &&
-	git update-index --add --cacheinfo 100644 $EMPTY_BLOB 1 &&
+	git update-index --add --cacheinfo 100644,$EMPTY_BLOB,1 &&
 	git update-index --skip-worktree 1
 }
 
diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
index f011ad7eec..4272f542ca 100755
--- a/t/t7113-post-index-change-hook.sh
+++ b/t/t7113-post-index-change-hook.sh
@@ -132,7 +132,7 @@ test_expect_success 'test reset --mixed and update-index triggers the hook' '
 	test_path_is_file testsuccess && rm -f testsuccess &&
 	test_path_is_missing testfailure &&
 	git hash-object -w --stdin <dir1/file2.txt >expect &&
-	git update-index --cacheinfo 100644 "$(cat expect)" dir1/file1.txt &&
+	git update-index --cacheinfo 100644,"$(cat expect)",dir1/file1.txt &&
 	test_path_is_file testsuccess && rm -f testsuccess &&
 	test_path_is_missing testfailure &&
 	git update-index --skip-worktree dir1/file2.txt &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index aa19ff3a2e..404353d411 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -517,7 +517,7 @@ test_expect_success 'submodule init does not copy command into .git/config' '
 	 git ls-files -s submodule >out &&
 	 H=$(cut -d" " -f2 out) &&
 	 mkdir submodule1 &&
-	 git update-index --add --cacheinfo 160000 $H submodule1 &&
+	 git update-index --add --cacheinfo 160000,$H,submodule1 &&
 	 git config -f .gitmodules submodule.submodule1.path submodule1 &&
 	 git config -f .gitmodules submodule.submodule1.url ../submodule &&
 	 git config -f .gitmodules submodule.submodule1.update !false &&
@@ -928,7 +928,7 @@ test_expect_success 'submodule update properly revives a moved submodule' '
 	 git rm --cached submodule2 &&
 	 rm -rf submodule2 &&
 	 mkdir -p "moved/sub module" &&
-	 git update-index --add --cacheinfo 160000 $H "moved/sub module" &&
+	 git update-index --add --cacheinfo 160000,$H,"moved/sub module" &&
 	 git config -f .gitmodules submodule.submodule2.path "moved/sub module" &&
 	 git commit -am "post move" &&
 	 git submodule update &&
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 1372842559..9135b75e2e 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -604,10 +604,10 @@ test_expect_success 'fast-export quotes pathnames' '
 	(cd crazy-paths &&
 	 blob=$(echo foo | git hash-object -w --stdin) &&
 	 git -c core.protectNTFS=false update-index --add \
-		--cacheinfo 100644 $blob "$(printf "path with\\nnewline")" \
-		--cacheinfo 100644 $blob "path with \"quote\"" \
-		--cacheinfo 100644 $blob "path with \\backslash" \
-		--cacheinfo 100644 $blob "path with space" &&
+		--cacheinfo 100644,$blob,"$(printf "path with\\nnewline")" \
+		--cacheinfo 100644,$blob,"path with \"quote\"" \
+		--cacheinfo 100644,$blob,"path with \\backslash" \
+		--cacheinfo 100644,$blob,"path with space" &&
 	 git commit -m addition &&
 	 git ls-files -z -s | perl -0pe "s{\\t}{$&subdir/}" >index &&
 	 git read-tree --empty &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6a8e194a99..dc5e9af6c6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1230,7 +1230,7 @@ test_ln_s_add () {
 	else
 		printf '%s' "$1" >"$2" &&
 		ln_s_obj=$(git hash-object -w "$2") &&
-		git update-index --add --cacheinfo 120000 $ln_s_obj "$2" &&
+		git update-index --add --cacheinfo 120000,$ln_s_obj,"$2" &&
 		# pick up stat info from the file
 		git update-index "$2"
 	fi
-- 
gitgitgadget
