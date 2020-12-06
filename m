Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35F0C433FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 13:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F37C2310E
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 13:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgLFNQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 08:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgLFNQn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 08:16:43 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347E4C0613D0
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 05:16:03 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 3so11115181wmg.4
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 05:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YoSp0hbjWHC1vGp6Zmj0pR0p0PHFZtuEY6HXo+U4EPo=;
        b=jRj1hAyD5IjTuj049VyQExqo/ZNSIIjT3ULZnIIsOuvW+Sv+NxFjZW+DpZkc8tB+Qt
         k1RzuCU7aRT83inAmPLqT4+B8lhAQ5WvyUeZj9C6W6lBKnAHSry2rN4OIMZYI5CVK4Je
         UzcOj5jrUrzXFiwMlDWDnXonmEFWx4H8MbBg6sh3758dgEN/8mxH3tmeTOvgtpQYFgQg
         HxqjFs10rKid2csogVCN/JtK/0/XKgv8ktaapl5IL6LGk30k65bBfXSl3zscOz5xMCOX
         vOql7dsF3UAD5sYvcgM+ldu5efYKmfL9RI/4/Gkwglql4pY8Veqez/GOsWUGMUWAJKxV
         KL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YoSp0hbjWHC1vGp6Zmj0pR0p0PHFZtuEY6HXo+U4EPo=;
        b=iHCWW7RF30/y7gd1Oecy0EGhmocsuCm58hR2LHEYdemCXEf0CnIiypL1WurxNDfZ75
         heB9EqI7GXL/yJCJ9S+PkTExv9JkYqVaZQLO5HCP8JyT2Hs2HJuYtivTxvo8PiJNKXjJ
         yqvHCuScKt6YXQfwKkGuh25cYsJCDntk6hF/l75wppS/iwkBe5Rl1rBddDeQGRYKFs7V
         HkXBS6OaJHCtTv9VR+UJS0ePOE9KfHywvEmvtWatH6A2f/DmvZBd7GVEyGP9wS9YpurX
         Yrhh2f1EykGurlF5+VArhcsBA/VVzgXGdsQ5hvmxN5doC3JC63CTyoqPfMmA/01JAgxV
         6Uqw==
X-Gm-Message-State: AOAM530fEriTwdNucYCFC+T1QIC/M8psyM7+ft5Ead6WGIeDQ+KfzJ7m
        0R4xVCZ3S3DYo1LKSuus6Uqtp+bdFiM=
X-Google-Smtp-Source: ABdhPJzIkq7GfjF16aMprpbqM3EFKrM+ytAxwpc0QFRFKZ5hLREGcKacSUbyQsuWOfz+S2pxTRUEdA==
X-Received: by 2002:a1c:b78a:: with SMTP id h132mr13594124wmf.141.1607260561462;
        Sun, 06 Dec 2020 05:16:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm1048518wrn.90.2020.12.06.05.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 05:16:00 -0800 (PST)
Message-Id: <pull.810.git.1607260559712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Dec 2020 13:15:59 +0000
Subject: [PATCH] t6300: avoid using the default name of the initial branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Our test suite currently only passes when `git init` uses the name
`master` for the initial branch. This would stop us from changing the
default branch name.

Let's adjust t6300 so that it does not rely on any specific default
branch name. This trick is done by (force-)renaming the initial branch
to the name `main` in the `setup` and the `:remotename and :remoteref`
test cases, and then replacing all mentions of `master` and `MASTER`
with `main` and `MAIN`, respectively.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t6300: avoid using the default name of the initial branch
    
    This patch targets master (there is one other topic in flight touching
    t6300: dr/push-remoteref-fix, but it does not conflict with this patch).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-810%2Fdscho%2Ft6300-and-the-default-branch-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-810/dscho/t6300-and-the-default-branch-name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/810

 t/t6300-for-each-ref.sh | 178 ++++++++++++++++++++--------------------
 1 file changed, 90 insertions(+), 88 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b3590231899..810cdbb6f88 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -28,12 +28,13 @@ test_expect_success setup '
 	echo "Using $datestamp" > one &&
 	git add one &&
 	git commit -m "Initial" &&
+	git branch -M main &&
 	setdate_and_increment &&
 	git tag -a -m "Tagging at $datestamp" testtag &&
-	git update-ref refs/remotes/origin/master master &&
+	git update-ref refs/remotes/origin/main main &&
 	git remote add origin nowhere &&
-	git config branch.master.remote origin &&
-	git config branch.master.merge refs/heads/master &&
+	git config branch.main.remote origin &&
+	git config branch.main.merge refs/heads/main &&
 	git remote add myfork elsewhere &&
 	git config remote.pushdefault myfork &&
 	git config push.default current
@@ -41,7 +42,7 @@ test_expect_success setup '
 
 test_atom() {
 	case "$1" in
-		head) ref=refs/heads/master ;;
+		head) ref=refs/heads/main ;;
 		 tag) ref=refs/tags/testtag ;;
 		 sym) ref=refs/heads/sym ;;
 		   *) ref=$1 ;;
@@ -76,49 +77,49 @@ test_atom() {
 hexlen=$(test_oid hexsz)
 disklen=$(test_oid disklen)
 
-test_atom head refname refs/heads/master
-test_atom head refname: refs/heads/master
-test_atom head refname:short master
-test_atom head refname:lstrip=1 heads/master
-test_atom head refname:lstrip=2 master
-test_atom head refname:lstrip=-1 master
-test_atom head refname:lstrip=-2 heads/master
+test_atom head refname refs/heads/main
+test_atom head refname: refs/heads/main
+test_atom head refname:short main
+test_atom head refname:lstrip=1 heads/main
+test_atom head refname:lstrip=2 main
+test_atom head refname:lstrip=-1 main
+test_atom head refname:lstrip=-2 heads/main
 test_atom head refname:rstrip=1 refs/heads
 test_atom head refname:rstrip=2 refs
 test_atom head refname:rstrip=-1 refs
 test_atom head refname:rstrip=-2 refs/heads
-test_atom head refname:strip=1 heads/master
-test_atom head refname:strip=2 master
-test_atom head refname:strip=-1 master
-test_atom head refname:strip=-2 heads/master
-test_atom head upstream refs/remotes/origin/master
-test_atom head upstream:short origin/master
-test_atom head upstream:lstrip=2 origin/master
-test_atom head upstream:lstrip=-2 origin/master
+test_atom head refname:strip=1 heads/main
+test_atom head refname:strip=2 main
+test_atom head refname:strip=-1 main
+test_atom head refname:strip=-2 heads/main
+test_atom head upstream refs/remotes/origin/main
+test_atom head upstream:short origin/main
+test_atom head upstream:lstrip=2 origin/main
+test_atom head upstream:lstrip=-2 origin/main
 test_atom head upstream:rstrip=2 refs/remotes
 test_atom head upstream:rstrip=-2 refs/remotes
-test_atom head upstream:strip=2 origin/master
-test_atom head upstream:strip=-2 origin/master
-test_atom head push refs/remotes/myfork/master
-test_atom head push:short myfork/master
-test_atom head push:lstrip=1 remotes/myfork/master
-test_atom head push:lstrip=-1 master
+test_atom head upstream:strip=2 origin/main
+test_atom head upstream:strip=-2 origin/main
+test_atom head push refs/remotes/myfork/main
+test_atom head push:short myfork/main
+test_atom head push:lstrip=1 remotes/myfork/main
+test_atom head push:lstrip=-1 main
 test_atom head push:rstrip=1 refs/remotes/myfork
 test_atom head push:rstrip=-1 refs
-test_atom head push:strip=1 remotes/myfork/master
-test_atom head push:strip=-1 master
+test_atom head push:strip=1 remotes/myfork/main
+test_atom head push:strip=-1 main
 test_atom head objecttype commit
 test_atom head objectsize $((131 + hexlen))
 test_atom head objectsize:disk $disklen
 test_atom head deltabase $ZERO_OID
-test_atom head objectname $(git rev-parse refs/heads/master)
-test_atom head objectname:short $(git rev-parse --short refs/heads/master)
-test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
-test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
-test_atom head tree $(git rev-parse refs/heads/master^{tree})
-test_atom head tree:short $(git rev-parse --short refs/heads/master^{tree})
-test_atom head tree:short=1 $(git rev-parse --short=1 refs/heads/master^{tree})
-test_atom head tree:short=10 $(git rev-parse --short=10 refs/heads/master^{tree})
+test_atom head objectname $(git rev-parse refs/heads/main)
+test_atom head objectname:short $(git rev-parse --short refs/heads/main)
+test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/main)
+test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/main)
+test_atom head tree $(git rev-parse refs/heads/main^{tree})
+test_atom head tree:short $(git rev-parse --short refs/heads/main^{tree})
+test_atom head tree:short=1 $(git rev-parse --short=1 refs/heads/main^{tree})
+test_atom head tree:short=10 $(git rev-parse --short=10 refs/heads/main^{tree})
 test_atom head parent ''
 test_atom head parent:short ''
 test_atom head parent:short=1 ''
@@ -171,8 +172,8 @@ test_atom tag deltabase $ZERO_OID
 test_atom tag '*deltabase' $ZERO_OID
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
 test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
-test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
-test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
+test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/main)
+test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/main)
 test_atom tag tree ''
 test_atom tag tree:short ''
 test_atom tag tree:short=1 ''
@@ -253,7 +254,7 @@ test_date () {
 	author_date=$3 &&
 	tagger_date=$4 &&
 	cat >expected <<-EOF &&
-	'refs/heads/master' '$committer_date' '$author_date'
+	'refs/heads/main' '$committer_date' '$author_date'
 	'refs/tags/testtag' '$tagger_date'
 	EOF
 	(
@@ -375,8 +376,8 @@ test_expect_success 'exercise strftime with odd fields' '
 '
 
 cat >expected <<\EOF
-refs/heads/master
-refs/remotes/origin/master
+refs/heads/main
+refs/remotes/origin/main
 refs/tags/testtag
 EOF
 
@@ -388,8 +389,8 @@ test_expect_success 'Verify ascending sort' '
 
 cat >expected <<\EOF
 refs/tags/testtag
-refs/remotes/origin/master
-refs/heads/master
+refs/remotes/origin/main
+refs/heads/main
 EOF
 
 test_expect_success 'Verify descending sort' '
@@ -424,8 +425,8 @@ test_expect_success 'exercise glob patterns with prefixes' '
 '
 
 cat >expected <<\EOF
-'refs/heads/master'
-'refs/remotes/origin/master'
+'refs/heads/main'
+'refs/remotes/origin/main'
 'refs/tags/testtag'
 EOF
 
@@ -445,8 +446,8 @@ test_expect_success 'Quoting style: python' '
 '
 
 cat >expected <<\EOF
-"refs/heads/master"
-"refs/remotes/origin/master"
+"refs/heads/main"
+"refs/remotes/origin/main"
 "refs/tags/testtag"
 EOF
 
@@ -473,8 +474,8 @@ test_atom head upstream:nobracket,track 'ahead 1'
 
 test_expect_success 'setup for push:track[short]' '
 	test_commit third &&
-	git update-ref refs/remotes/myfork/master master &&
-	git reset master~1
+	git update-ref refs/remotes/myfork/main main &&
+	git reset main~1
 '
 
 test_atom head push:track '[behind 1]'
@@ -490,8 +491,8 @@ test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	[gone]
 
 	EOF
-	test_when_finished "git config branch.master.merge refs/heads/master" &&
-	git config branch.master.merge refs/heads/does-not-exist &&
+	test_when_finished "git config branch.main.merge refs/heads/main" &&
+	git config branch.main.merge refs/heads/does-not-exist &&
 	git for-each-ref \
 		--format="%(upstream:track)$LF%(upstream:trackshort)" \
 		refs/heads >actual &&
@@ -504,9 +505,9 @@ test_expect_success 'Check for invalid refname format' '
 
 test_expect_success 'set up color tests' '
 	cat >expected.color <<-EOF &&
-	$(git rev-parse --short refs/heads/master) <GREEN>master<RESET>
-	$(git rev-parse --short refs/remotes/myfork/master) <GREEN>myfork/master<RESET>
-	$(git rev-parse --short refs/remotes/origin/master) <GREEN>origin/master<RESET>
+	$(git rev-parse --short refs/heads/main) <GREEN>main<RESET>
+	$(git rev-parse --short refs/remotes/myfork/main) <GREEN>myfork/main<RESET>
+	$(git rev-parse --short refs/remotes/origin/main) <GREEN>origin/main<RESET>
 	$(git rev-parse --short refs/tags/testtag) <GREEN>testtag<RESET>
 	$(git rev-parse --short refs/tags/third) <GREEN>third<RESET>
 	$(git rev-parse --short refs/tags/two) <GREEN>two<RESET>
@@ -538,8 +539,8 @@ test_expect_success 'color.ui=always does not override tty check' '
 '
 
 cat >expected <<\EOF
-heads/master
-tags/master
+heads/main
+tags/main
 EOF
 
 test_expect_success 'Check ambiguous head and tag refs (strict)' '
@@ -549,19 +550,19 @@ test_expect_success 'Check ambiguous head and tag refs (strict)' '
 	git add one &&
 	git commit -m "Branch" &&
 	setdate_and_increment &&
-	git tag -m "Tagging at $datestamp" master &&
-	git for-each-ref --format "%(refname:short)" refs/heads/master refs/tags/master >actual &&
+	git tag -m "Tagging at $datestamp" main &&
+	git for-each-ref --format "%(refname:short)" refs/heads/main refs/tags/main >actual &&
 	test_cmp expected actual
 '
 
 cat >expected <<\EOF
-heads/master
-master
+heads/main
+main
 EOF
 
 test_expect_success 'Check ambiguous head and tag refs (loose)' '
 	git config --bool core.warnambiguousrefs false &&
-	git for-each-ref --format "%(refname:short)" refs/heads/master refs/tags/master >actual &&
+	git for-each-ref --format "%(refname:short)" refs/heads/main refs/tags/main >actual &&
 	test_cmp expected actual
 '
 
@@ -571,7 +572,7 @@ ambiguous
 EOF
 
 test_expect_success 'Check ambiguous head and tag refs II (loose)' '
-	git checkout master &&
+	git checkout main &&
 	git tag ambiguous testtag^0 &&
 	git branch ambiguous testtag^0 &&
 	git for-each-ref --format "%(refname:short)" refs/heads/ambiguous refs/tags/ambiguous >actual &&
@@ -705,8 +706,8 @@ body contents
 $sig"
 
 test_expect_success 'set up refs pointing to tree and blob' '
-	git update-ref refs/mytrees/first refs/heads/master^{tree} &&
-	git update-ref refs/myblobs/first refs/heads/master:one
+	git update-ref refs/mytrees/first refs/heads/main^{tree} &&
+	git update-ref refs/myblobs/first refs/heads/main:one
 '
 
 test_atom refs/mytrees/first subject ""
@@ -778,7 +779,7 @@ test_expect_success 'equivalent sorts fall back on refname' '
 '
 
 test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
 	sed -e "s/^\* /  /" actual >expect &&
 	git checkout --orphan orphaned-branch &&
@@ -815,9 +816,9 @@ test_expect_success '%(trailers:unfold) unfolds trailers' '
 		unfold <trailers
 		echo
 	} >expect &&
-	git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
+	git for-each-ref --format="%(trailers:unfold)" refs/heads/main >actual &&
 	test_cmp expect actual &&
-	git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/master >actual &&
+	git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -826,9 +827,9 @@ test_expect_success '%(trailers:only) shows only "key: value" trailers' '
 		grep -v patch.description <trailers &&
 		echo
 	} >expect &&
-	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
+	git for-each-ref --format="%(trailers:only)" refs/heads/main >actual &&
 	test_cmp expect actual &&
-	git for-each-ref --format="%(contents:trailers:only)" refs/heads/master >actual &&
+	git for-each-ref --format="%(contents:trailers:only)" refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -837,13 +838,13 @@ test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
 		grep -v patch.description <trailers | unfold &&
 		echo
 	} >expect &&
-	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
+	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/main >actual &&
 	test_cmp expect actual &&
-	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >actual &&
+	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/main >actual &&
 	test_cmp actual actual &&
-	git for-each-ref --format="%(contents:trailers:only,unfold)" refs/heads/master >actual &&
+	git for-each-ref --format="%(contents:trailers:only,unfold)" refs/heads/main >actual &&
 	test_cmp expect actual &&
-	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/master >actual &&
+	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/main >actual &&
 	test_cmp actual actual
 '
 
@@ -867,7 +868,7 @@ test_expect_success 'if arguments, %(contents:trailers) shows error if colon is
 '
 
 test_expect_success 'basic atom: head contents:trailers' '
-	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
+	git for-each-ref --format="%(contents:trailers)" refs/heads/main >actual &&
 	sanitize_pgp <actual >actual.clean &&
 	# git for-each-ref ends with a blank line
 	cat >expect <<-EOF &&
@@ -896,16 +897,16 @@ test_expect_success 'trailer parsing not fooled by --- line' '
 		echo "trailer: right" &&
 		echo
 	} >expect &&
-	git for-each-ref --format="%(trailers)" refs/heads/master >actual &&
+	git for-each-ref --format="%(trailers)" refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'Add symbolic ref for the following tests' '
-	git symbolic-ref refs/heads/sym refs/heads/master
+	git symbolic-ref refs/heads/sym refs/heads/main
 '
 
 cat >expected <<EOF
-refs/heads/master
+refs/heads/main
 EOF
 
 test_expect_success 'Verify usage of %(symref) atom' '
@@ -914,7 +915,7 @@ test_expect_success 'Verify usage of %(symref) atom' '
 '
 
 cat >expected <<EOF
-heads/master
+heads/main
 EOF
 
 test_expect_success 'Verify usage of %(symref:short) atom' '
@@ -923,8 +924,8 @@ test_expect_success 'Verify usage of %(symref:short) atom' '
 '
 
 cat >expected <<EOF
-master
-heads/master
+main
+heads/main
 EOF
 
 test_expect_success 'Verify usage of %(symref:lstrip) atom' '
@@ -953,22 +954,23 @@ test_expect_success ':remotename and :remoteref' '
 	(
 		cd remote-tests &&
 		test_commit initial &&
+		git branch -M main &&
 		git remote add from fifth.coffee:blub &&
-		git config branch.master.remote from &&
-		git config branch.master.merge refs/heads/stable &&
+		git config branch.main.remote from &&
+		git config branch.main.merge refs/heads/stable &&
 		git remote add to southridge.audio:repo &&
 		git config remote.to.push "refs/heads/*:refs/heads/pushed/*" &&
-		git config branch.master.pushRemote to &&
+		git config branch.main.pushRemote to &&
 		for pair in "%(upstream)=refs/remotes/from/stable" \
 			"%(upstream:remotename)=from" \
 			"%(upstream:remoteref)=refs/heads/stable" \
-			"%(push)=refs/remotes/to/pushed/master" \
+			"%(push)=refs/remotes/to/pushed/main" \
 			"%(push:remotename)=to" \
-			"%(push:remoteref)=refs/heads/pushed/master"
+			"%(push:remoteref)=refs/heads/pushed/main"
 		do
 			echo "${pair#*=}" >expect &&
 			git for-each-ref --format="${pair%=*}" \
-				refs/heads/master >actual &&
+				refs/heads/main >actual &&
 			test_cmp expect actual
 		done &&
 		git branch push-simple &&
@@ -981,12 +983,12 @@ test_expect_success ':remotename and :remoteref' '
 '
 
 test_expect_success 'for-each-ref --ignore-case ignores case' '
-	git for-each-ref --format="%(refname)" refs/heads/MASTER >actual &&
+	git for-each-ref --format="%(refname)" refs/heads/MAIN >actual &&
 	test_must_be_empty actual &&
 
-	echo refs/heads/master >expect &&
+	echo refs/heads/main >expect &&
 	git for-each-ref --format="%(refname)" --ignore-case \
-		refs/heads/MASTER >actual &&
+		refs/heads/MAIN >actual &&
 	test_cmp expect actual
 '
 

base-commit: 3a0b884caba2752da0af626fb2de7d597c844e8b
-- 
gitgitgadget
