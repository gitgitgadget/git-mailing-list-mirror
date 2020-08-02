Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8986EC433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A0020759
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0hTqsCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgHBOaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgHBOae (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 10:30:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273C9C06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 07:30:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so26779596ljj.7
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owZfW9CZ9kyBeV9z1LzYlmL2Y6QLgtgbxFNwaCqTP6c=;
        b=N0hTqsCpwFeCITq95VlEEX6eVcQq+YuL6wb7lkp07hbztnzvwlH+57UU38yJ2QAXqR
         G7KEqIXsTkuu+44mQnhlSOfliZML+g5IEm5QJUetiHCC+uTBdRRtaDPT57hWygLBb0UH
         9Dt8lw38m3ho1bHHwCRBaNaSK5XUSV13+wBFo+DDXv1IWqZzbV38kHxcYhVYvS+CzGvc
         /84a06lNbC+calurg5bZlPuHFn1SL+LjmYa+CjD3ATNAThLSi9Por8OzkHhnltY8aRXW
         MNC8QgGRd+uZLfqgNFYkw2jeh1VzL0jbsx3inDb9VMd8gUvHqB+4eVtxp4qLXtHyYmxo
         NYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owZfW9CZ9kyBeV9z1LzYlmL2Y6QLgtgbxFNwaCqTP6c=;
        b=d5s3YWqio0+U5kzrG7tcmIHMOodxIB5epbBd+puU6T7m/42lsiGhw2Etjd5sfeRNHb
         PLShMbMO/6JSbwDbSnM9p+aVbUVGfYo+NgjwS2Y00dGMCunpz1rd470IOBIUvY291CgB
         39UDwyR2p7lqTKHjy0ZuixGfT7mN31RbvtemUfCpxzOmgruS4WRujF52h7yOSTkwnqFO
         kXLCTgYmEkpAKLppvSoscwBvoBPoNiuUvExmS8Whe9oQwLnxXiwIUIRFNtkb+mH6j1yx
         2q6+9nVh61+i011hjPB1YlpJDaqkh2Lz9n1mDVloiJzM4MCuhY1k0LERXBuBhk7Hj4Nc
         cmkQ==
X-Gm-Message-State: AOAM5321J4yQNz5KA/qu1YajnBfB0cHAW06WheEpbA7pBjQ7I7oIJkF9
        WTiWcWc748BsKniMlTYzic5s6x4X
X-Google-Smtp-Source: ABdhPJyJyWya0SgUaKxSPgxbnwKBmCkjOHTgbN4nbSjmwybkV2GKa1Pte/2PhkZVPV9uOojpy3gO0w==
X-Received: by 2002:a05:651c:153:: with SMTP id c19mr5943238ljd.170.1596378631113;
        Sun, 02 Aug 2020 07:30:31 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id r16sm948819ljd.71.2020.08.02.07.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:30:30 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] t1450: fix quoting of NUL byte when corrupting pack
Date:   Sun,  2 Aug 2020 16:30:18 +0200
Message-Id: <20200802143018.5501-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.81.ge8ab941b67
In-Reply-To: <xmqqmu3d27vs.fsf@gitster.c.googlers.com>
References: <xmqqmu3d27vs.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2 Aug 2020 at 02:45, Junio C Hamano <gitster@pobox.com> wrote:
>
> I wonder if it is an easy way to find similar problems without too
> much hand-parsing of the test scripts.  Inside a modern test_expect_*
> that begins and ends the test body with a single quote, any line
> that has a single quote that is not quoted could be suspect, but
> that would probably give us too many false positive.

I did some very crude hand-parsing and identified a few spots that
looked needlessly complicated and where I could change or drop the
quoting so that the code we see is the code we also execute. Patch
below.

Some of those sites made me go "what is actually going on here?" which
would be an argument for simplifying them. Others are more "maybe we
should avoid those quote marks, but the test is obviously correct
anyway".

So I didn't spot any other bugs (like the 0x30/NUL thing in my original
patch), which is good, but also makes me not very motivated to invest in
more advanced parsing.

Martin

-- >8 --
Subject: [PATCH] t: don't spuriously close & open quotes

If we write something like

test_expect_success 'sed a little' '
  sed -e 's/hi/lo/' in >out
'

the human readers do not see what the shell eventually sees:

  sed -e s/hi/lo/ in >out

In this example, this makes no real difference. But this can be confusing
and can make the reader wonder whether we actually rely on that whole
"close the quote, do some stuff, then start quoting again" and what is
actually going on. It could potentially also be a bug in the test.

Change several such single quotes to use double quotes instead or, in a
few cases, drop them altogether. These were identified using some crude
grepping. We're not fixing any test bugs here, but we're hopefully
making these tests slightly easier to grok and to maintain.

(There are legitimate use cases for closing a quote and opening a new
one, e.g., both '\'' and '"'"' can be used to produce a literal single
quote. I'm not touching any of those here.)

In t9401, tuck the redirecting ">" to the filename while we're touching
those lines.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t1400-update-ref.sh           |  2 +-
 t/t3501-revert-cherry-pick.sh   |  4 ++--
 t/t3507-cherry-pick-conflict.sh |  4 ++--
 t/t4005-diff-rename-2.sh        |  4 ++--
 t/t4034-diff-words.sh           |  2 +-
 t/t4104-apply-boundary.sh       | 24 ++++++++++++------------
 t/t4150-am.sh                   |  8 ++++----
 t/t4200-rerere.sh               |  2 +-
 t/t5302-pack-index.sh           |  2 +-
 t/t5510-fetch.sh                |  4 ++--
 t/t5553-set-upstream.sh         |  6 +++---
 t/t6026-merge-attr.sh           |  4 ++--
 t/t7001-mv.sh                   |  2 +-
 t/t7600-merge.sh                |  6 +++---
 t/t9001-send-email.sh           | 10 +++++-----
 t/t9100-git-svn-basic.sh        |  2 +-
 t/t9401-git-cvsserver-crlf.sh   |  8 ++++----
 t/t9402-git-cvsserver-refs.sh   |  2 +-
 18 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 27171f8261..d0d36750bc 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -324,7 +324,7 @@ test_expect_success "create $m (logged by config)" '
 test_expect_success "update $m (logged by config)" '
 	test_config core.logAllRefUpdates true &&
 	GIT_COMMITTER_DATE="2005-05-26 23:33" \
-	git update-ref HEAD'" $B $A "'-m "Switch" &&
+	git update-ref HEAD $B $A -m "Switch" &&
 	test $B = $(git show-ref -s --verify $m)
 '
 test_expect_success "set $m (logged by config)" '
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 7c1da21df1..3669dfb1be 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -47,7 +47,7 @@ test_expect_success 'cherry-pick --nonsense' '
 	git diff --exit-code HEAD &&
 	test_must_fail git cherry-pick --nonsense 2>msg &&
 	git diff --exit-code HEAD "$pos" &&
-	test_i18ngrep '[Uu]sage:' msg
+	test_i18ngrep "[Uu]sage:" msg
 '
 
 test_expect_success 'revert --nonsense' '
@@ -56,7 +56,7 @@ test_expect_success 'revert --nonsense' '
 	git diff --exit-code HEAD &&
 	test_must_fail git revert --nonsense 2>msg &&
 	git diff --exit-code HEAD "$pos" &&
-	test_i18ngrep '[Uu]sage:' msg
+	test_i18ngrep "[Uu]sage:" msg
 '
 
 test_expect_success 'cherry-pick after renaming branch' '
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 752bc43487..f107622a9e 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -512,7 +512,7 @@ test_expect_success 'commit after failed cherry-pick adds -s at the right place'
 	Signed-off-by: C O Mitter <committer@example.com>
 	# Conflicts:
 	EOF
-	grep -e "^# Conflicts:" -e '^Signed-off-by' .git/COMMIT_EDITMSG >actual &&
+	grep -e "^# Conflicts:" -e "^Signed-off-by" .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual &&
 
 	cat <<-\EOF >expected &&
@@ -541,7 +541,7 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
 	Signed-off-by: C O Mitter <committer@example.com>
 	Conflicts:
 	EOF
-	grep -e "^Conflicts:" -e '^Signed-off-by' .git/COMMIT_EDITMSG >actual &&
+	grep -e "^Conflicts:" -e "^Signed-off-by" .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index f542d2929d..d18a80493c 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -14,8 +14,8 @@ test_expect_success 'setup reference tree' '
 	git update-index --add COPYING rezrov &&
 	tree=$(git write-tree) &&
 	echo $tree &&
-	sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
-	sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
+	sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
+	sed -e "s/GPL/G.P.L/g" <COPYING >COPYING.2 &&
 	origoid=$(git hash-object COPYING) &&
 	oid1=$(git hash-object COPYING.1) &&
 	oid2=$(git hash-object COPYING.2)
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index fb145aa173..0c8fb39ced 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -102,7 +102,7 @@ test_expect_success 'word diff with runs of whitespace' '
 '
 
 test_expect_success '--word-diff=porcelain' '
-	sed 's/#.*$//' >expect <<-EOF &&
+	sed "s/#.*$//" >expect <<-EOF &&
 		diff --git a/pre b/post
 		index $pre..$post 100644
 		--- a/pre
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index 32e3b0ee0b..19f08d9ccd 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -11,7 +11,7 @@ test_description='git apply boundary tests
 L="c d e f g h i j k l m n o p q r s t u v w x"
 
 test_expect_success setup '
-	for i in b '"$L"' y
+	for i in b $L y
 	do
 		echo $i
 	done >victim &&
@@ -19,7 +19,7 @@ test_expect_success setup '
 	git update-index --add victim &&
 
 	# add to the head
-	for i in a b '"$L"' y
+	for i in a b $L y
 	do
 		echo $i
 	done >victim &&
@@ -28,7 +28,7 @@ test_expect_success setup '
 	git diff --unified=0 >add-a-patch.without &&
 
 	# insert at line two
-	for i in b a '"$L"' y
+	for i in b a $L y
 	do
 		echo $i
 	done >victim &&
@@ -37,7 +37,7 @@ test_expect_success setup '
 	git diff --unified=0 >insert-a-patch.without &&
 
 	# modify at the head
-	for i in a '"$L"' y
+	for i in a $L y
 	do
 		echo $i
 	done >victim &&
@@ -46,7 +46,7 @@ test_expect_success setup '
 	git diff --unified=0 >mod-a-patch.without &&
 
 	# remove from the head
-	for i in '"$L"' y
+	for i in $L y
 	do
 		echo $i
 	done >victim &&
@@ -55,7 +55,7 @@ test_expect_success setup '
 	git diff --unified=0 >del-a-patch.without &&
 
 	# add to the tail
-	for i in b '"$L"' y z
+	for i in b $L y z
 	do
 		echo $i
 	done >victim &&
@@ -64,7 +64,7 @@ test_expect_success setup '
 	git diff --unified=0 >add-z-patch.without &&
 
 	# modify at the tail
-	for i in b '"$L"' z
+	for i in b $L z
 	do
 		echo $i
 	done >victim &&
@@ -73,7 +73,7 @@ test_expect_success setup '
 	git diff --unified=0 >mod-z-patch.without &&
 
 	# remove from the tail
-	for i in b '"$L"'
+	for i in b $L
 	do
 		echo $i
 	done >victim &&
@@ -95,8 +95,8 @@ do
 		test_expect_success "apply $kind-patch $with context" '
 			cat original >victim &&
 			git update-index victim &&
-			git apply --index '"$u$kind-patch.$with"' &&
-			test_cmp '"$kind"'-expect victim
+			git apply --index $u$kind-patch.$with &&
+			test_cmp $kind-expect victim
 		'
 	done
 done
@@ -110,8 +110,8 @@ do
 	test_expect_success "apply non-git $kind-patch without context" '
 		cat original >victim &&
 		git update-index victim &&
-		git apply --unidiff-zero --index '"$kind-ng.without"' &&
-		test_cmp '"$kind"'-expect victim
+		git apply --unidiff-zero --index $kind-ng.without &&
+		test_cmp $kind-expect victim
 	'
 done
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index bda4586a79..855ed11b32 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -989,7 +989,7 @@ test_expect_success 'am -s unexpected trailer block' '
 	Signed-off-by: J C H <j@c.h>
 	EOF
 	git commit -F msg &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >original &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >original &&
 	git format-patch --stdout -1 >patch &&
 
 	git reset --hard HEAD^ &&
@@ -998,7 +998,7 @@ test_expect_success 'am -s unexpected trailer block' '
 		cat original &&
 		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 	) >expect &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
 	test_cmp expect actual &&
 
 	cat >msg <<-\EOF &&
@@ -1009,7 +1009,7 @@ test_expect_success 'am -s unexpected trailer block' '
 	EOF
 	git reset HEAD^ &&
 	git commit -F msg file &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >original &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >original &&
 	git format-patch --stdout -1 >patch &&
 
 	git reset --hard HEAD^ &&
@@ -1020,7 +1020,7 @@ test_expect_success 'am -s unexpected trailer block' '
 		echo &&
 		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 	) >expect &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 831d424c47..f99385c191 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -364,7 +364,7 @@ test_expect_success 'set up an unresolved merge' '
 	git reset --hard &&
 	git checkout version2 &&
 	fifth=$(git rev-parse fifth) &&
-	echo "$fifth		branch 'fifth' of ." |
+	echo "$fifth		branch fifth of ." |
 	git fmt-merge-msg >msg &&
 	ancestor=$(git merge-base version2 fifth) &&
 	test_must_fail git merge-recursive "$ancestor" -- HEAD fifth &&
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 8981c9b90e..d1a6a3c37a 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup' '
 	i=1 &&
 	while test $i -le 100
 	do
-		iii=$(printf '%03i' $i)
+		iii=$(printf "%03i" $i)
 		test-tool genrandom "bar" 200 > wide_delta_$iii &&
 		test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
 		test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 7456c567cd..6a6a760f5f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -213,7 +213,7 @@ test_expect_success 'fetch tags when there is no tags' '
 test_expect_success 'fetch following tags' '
 
 	cd "$D" &&
-	git tag -a -m 'annotated' anno HEAD &&
+	git tag -a -m "annotated" anno HEAD &&
 	git tag light HEAD &&
 
 	mkdir four &&
@@ -331,7 +331,7 @@ test_expect_success 'bundle does not prerequisite objects' '
 test_expect_success 'bundle should be able to create a full history' '
 
 	cd "$D" &&
-	git tag -a -m '1.0' v1.0 master &&
+	git tag -a -m "1.0" v1.0 master &&
 	git bundle create bundle4 v1.0
 
 '
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 81975ad8f9..7622981cbf 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -81,7 +81,7 @@ test_expect_success 'fetch --set-upstream http://nosuchdomain.example.com fails
 
 test_expect_success 'fetch --set-upstream with valid URL sets upstream to URL' '
 	clear_config other other2 &&
-	url="file://'"$PWD"'" &&
+	url="file://$PWD" &&
 	git fetch --set-upstream "$url" &&
 	check_config master "$url" HEAD &&
 	check_config_missing other &&
@@ -158,7 +158,7 @@ test_expect_success 'pull --set-upstream upstream with more than one branch does
 test_expect_success 'pull --set-upstream with valid URL sets upstream to URL' '
 	clear_config master other other2 &&
 	git checkout master &&
-	url="file://'"$PWD"'" &&
+	url="file://$PWD" &&
 	git pull --set-upstream "$url" &&
 	check_config master "$url" HEAD &&
 	check_config_missing other &&
@@ -168,7 +168,7 @@ test_expect_success 'pull --set-upstream with valid URL sets upstream to URL' '
 test_expect_success 'pull --set-upstream with valid URL and branch sets branch' '
 	clear_config master other other2 &&
 	git checkout master &&
-	url="file://'"$PWD"'" &&
+	url="file://$PWD" &&
 	git pull --set-upstream "$url" master &&
 	check_config master "$url" refs/heads/master &&
 	check_config_missing other &&
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 5900358ce9..76a55f838c 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -122,7 +122,7 @@ test_expect_success 'custom merge backend' '
 	o=$(git unpack-file master^:text) &&
 	a=$(git unpack-file side^:text) &&
 	b=$(git unpack-file master:text) &&
-	sh -c "./custom-merge $o $a $b 0 'text'" &&
+	sh -c "./custom-merge $o $a $b 0 text" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
 	rm -f $o $a $b
@@ -149,7 +149,7 @@ test_expect_success 'custom merge backend' '
 	o=$(git unpack-file master^:text) &&
 	a=$(git unpack-file anchor:text) &&
 	b=$(git unpack-file master:text) &&
-	sh -c "./custom-merge $o $a $b 0 'text'" &&
+	sh -c "./custom-merge $o $a $b 0 text" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
 	sed -e 1,3d -e 4q $a >check-3 &&
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index c978b6dee4..63d5f41a12 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -177,7 +177,7 @@ test_expect_success "Sergey Vlasov's test case" '
 	date >ab.c &&
 	date >ab/d &&
 	git add ab.c ab &&
-	git commit -m 'initial' &&
+	git commit -m "initial" &&
 	git mv ab a
 '
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 1d45f9a4ed..dffcf053db 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -246,7 +246,7 @@ test_expect_success 'merge --squash c3 with c7' '
 	#	file
 	EOF
 	git cat-file commit HEAD >raw &&
-	sed -e '1,/^$/d' raw >actual &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp expect actual
 '
 
@@ -268,7 +268,7 @@ test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
 	#	file
 	EOF
 	git cat-file commit HEAD >raw &&
-	sed -e '1,/^$/d' raw >actual &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_i18ncmp expect actual
 '
 
@@ -292,7 +292,7 @@ test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
 	#	file
 	EOF
 	git cat-file commit HEAD >raw &&
-	sed -e '1,/^$/d' raw >actual &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_i18ncmp expect actual
 '
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ec261085ec..3d68570450 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1551,7 +1551,7 @@ test_expect_success $PREREQ '8-bit and sendemail.transferencoding=quoted-printab
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-8bit \
 		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
+	sed "1,/^$/d" msgtxt1 >actual &&
 	test_cmp expected actual
 '
 
@@ -1568,7 +1568,7 @@ test_expect_success $PREREQ '8-bit and sendemail.transferencoding=base64' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-8bit \
 		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
+	sed "1,/^$/d" msgtxt1 >actual &&
 	test_cmp expected actual
 '
 
@@ -1594,7 +1594,7 @@ test_expect_success $PREREQ 'convert from quoted-printable to base64' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-qp \
 		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
+	sed "1,/^$/d" msgtxt1 >actual &&
 	test_cmp expected actual
 '
 
@@ -1624,7 +1624,7 @@ test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=quoted-printabl
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-crlf \
 		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
+	sed "1,/^$/d" msgtxt1 >actual &&
 	test_cmp expected actual
 '
 
@@ -1641,7 +1641,7 @@ test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=base64' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-crlf \
 		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
+	sed "1,/^$/d" msgtxt1 >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 3055943a22..30172664ac 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -69,7 +69,7 @@ test_expect_success "$name" "
 	mv dir/new_file dir/file &&
 	git update-index --remove dir/file &&
 	git update-index --add dir/file/file &&
-	git commit -m '$name' &&
+	git commit -m "$name" &&
 	test_must_fail git svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch
 "
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 84787eee9a..c7a0dd84a4 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -167,10 +167,10 @@ test_expect_success 'adding files' '
 
 test_expect_success 'updating' '
     git pull gitcvs.git &&
-    echo 'hi' > subdir/newfile.bin &&
-    echo 'junk' > subdir/file.h &&
-    echo 'hi' > subdir/newfile.c &&
-    echo 'hello' >> binfile.bin &&
+    echo "hi" >subdir/newfile.bin &&
+    echo "junk" >subdir/file.h &&
+    echo "hi" >subdir/newfile.c &&
+    echo "hello" >>binfile.bin &&
     git add subdir/newfile.bin subdir/file.h subdir/newfile.c binfile.bin &&
     git commit -q -m "Add and change some files" &&
     git push gitcvs.git >/dev/null &&
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index cf31ace667..6436c91a3c 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -178,7 +178,7 @@ test_expect_success 'setup v1.2 on b1' '
 	mkdir cdir &&
 	echo "cdir/cfile" >cdir/cfile &&
 	git add -A cdir adir t3 t2 &&
-	git commit -q -m 'v1.2' &&
+	git commit -q -m "v1.2" &&
 	git tag v1.2 &&
 	git push --tags gitcvs.git b1:b1
 '
-- 
2.28.0.81.ge8ab941b67

