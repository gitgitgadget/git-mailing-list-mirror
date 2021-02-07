Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E76BC433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5DC64E31
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBGSUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBGSUG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:20:06 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65865C06178B
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 10:19:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id t11so5107637pgu.8
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 10:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qa98g+97FQeBkK5gcs/N6WYNQQO0UeoEdnJ8RNAG32M=;
        b=QzNplF28VQd5ZORcM/Qyp3J82nXzdDiKuIyu2Zoh5NfNlbpnYBwkgm9HzyN/ZuV8gN
         WebV60VzXbQSLTPWsh5JhbuC3UWxBeGAuDiQiGwddWuWa/abrFKl3y14fgCxL/DWz8JL
         byWqUlf7wHF7U3A75VyMPfmIXuonxyaIveOJKoxU6x279XDRyKeEFOqesOLnS9I8817T
         Gggr9e0WmJkRmmrDC0nQFW+fude1mcG0m4D2AQ+dYX2xouemFIIkH3qynrZN7/fNNPMJ
         TtYsstwE4gCuUfs0oZekoArj1u5n2lWR7gXZX+4kmNQDm65pK524rh5kjkT/qKH0W9wP
         GV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qa98g+97FQeBkK5gcs/N6WYNQQO0UeoEdnJ8RNAG32M=;
        b=VLOOCCw9vF/qrLp2ENGVbZIVzC2eNb/2c5VqzjQOr0UFPpT/w7bITzNjWXV7ZnUPud
         +mtYW06XJBzqJ4WFeciqsfhqGIlajCZRuvJaOuQ/AcWhQv3DQ1quf7KDuC4MaZkXlSyB
         Ctt0m33Ni/GztDKQgiyPefnkYGC73yppjJwSQM6b4F7gRsWB5oY1IvbLhiWFDQD7YPXq
         zYtRf2jSYm3c0CocxM0/YH0D1OdPJSDcP7/FenDwBI8bbPr8FRd6zYyS6rzHjDnGDZdk
         LGBB4j08V8k2y7K575iKmhGKxkAIjNaPQvp+jAgHkUsfn9XjrizRTTpz6vJ//HSKkRRQ
         QDTQ==
X-Gm-Message-State: AOAM530JJf+d99+lgptqmNR+xvI/0TvqBzdifwzAemO1snNzF1OF3EJS
        t3WVtZIIG5mdtTbCSWmvDzmpzgtpxY200g==
X-Google-Smtp-Source: ABdhPJx2Ec/S7Cr5gqaEw4hxz+BRAiEBYsZAe4hPLTzQmidOJFeAr/lGqI/I/wRhqO5S3yDGQ3st3w==
X-Received: by 2002:a63:fb18:: with SMTP id o24mr3389483pgh.55.1612721965638;
        Sun, 07 Feb 2021 10:19:25 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:4438:7fbe:1d1f:8bc])
        by smtp.googlemail.com with ESMTPSA id n7sm16375194pfn.141.2021.02.07.10.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 10:19:25 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/7] t/t3437: update the tests
Date:   Sun,  7 Feb 2021 23:44:39 +0530
Message-Id: <20210207181439.1178-7-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's do the changes listed below to make tests more easier to follow :

-Remove the dependency of 'expected-message' file from earlier tests to
make it easier to run tests selectively with '--run' or 'GIT_SKIP_TESTS'.

-Add author timestamp to check that the author date of fixed up commit
is unchanged.

-Simplify the test_commit_message() and add comments before the
function.

-Clarify the working of 'fixup -c' with "amend!" in the test-description.

-Remove unnecessary curly braces and use the named commits in the
tests so that they will still refer to the same commit if the setup
gets changed in the future whereas 'branch~2' will change which commit
it points to.

Original-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 82 ++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 3de899f68a..96f3a94831 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -8,8 +8,10 @@ test_description='git rebase interactive fixup options
 This test checks the "fixup [-C|-c]" command of rebase interactive.
 In addition to amending the contents of the commit, "fixup -C"
 replaces the original commit message with the message of the fixup
-commit. "fixup -c" also replaces the original message, but opens the
-editor to allow the user to edit the message before committing.
+commit and similar to "fixup" command that works with "fixup!", "fixup -C"
+works with "amend!" upon --autosquash. "fixup -c" also replaces the original
+message, but opens the editor to allow the user to edit the message before
+committing.
 '

 . ./test-lib.sh
@@ -18,36 +20,34 @@ editor to allow the user to edit the message before committing.

 EMPTY=""

+# test_commit_message <rev> -m <msg>
+# test_commit_message <rev> <path>
+# Verify that the commit message of <rev> matches
+# <msg> or the content of <path>.
 test_commit_message () {
-	rev="$1" && # commit or tag we want to test
-	file="$2" && # test against the content of a file
-	git show --no-patch --pretty=format:%B "$rev" >actual-message &&
-	if test "$2" = -m
-	then
-		str="$3" && # test against a string
-		printf "%s\n" "$str" >tmp-expected-message &&
-		file="tmp-expected-message"
-	fi
-	test_cmp "$file" actual-message
+	git show --no-patch --pretty=format:%B "$1" >actual &&
+    case "$2" in
+    -m) echo "$3" >expect &&
+	    test_cmp expect actual ;;
+    *) test_cmp "$2" actual ;;
+    esac
 }

 get_author () {
 	rev="$1" &&
-	git log -1 --pretty=format:"%an %ae" "$rev"
+	git log -1 --pretty=format:"%an %ae %at" "$rev"
 }

 test_expect_success 'setup' '
 	cat >message <<-EOF &&
 	amend! B
-	${EMPTY}
+	$EMPTY
 	new subject
-	${EMPTY}
+	$EMPTY
 	new
 	body
 	EOF

-	sed "1,2d" message >expected-message &&
-
 	test_commit A A &&
 	test_commit B B &&
 	get_author HEAD >expected-author &&
@@ -68,40 +68,43 @@ test_expect_success 'setup' '
 	echo B1 >B &&
 	test_tick &&
 	git commit --fixup=HEAD -a &&
+	git tag B1 &&
 	test_tick &&
 	git commit --allow-empty -F - <<-EOF &&
 	amend! B
-	${EMPTY}
+	$EMPTY
 	B
-	${EMPTY}
+	$EMPTY
 	edited 1
 	EOF
 	test_tick &&
 	git commit --allow-empty -F - <<-EOF &&
 	amend! amend! B
-	${EMPTY}
+	$EMPTY
 	B
-	${EMPTY}
+	$EMPTY
 	edited 1
-	${EMPTY}
+	$EMPTY
 	edited 2
 	EOF
 	echo B2 >B &&
 	test_tick &&
 	FAKE_COMMIT_AMEND="edited squash" git commit --squash=HEAD -a &&
+	git tag B2 &&
 	echo B3 >B &&
 	test_tick &&
 	git commit -a -F - <<-EOF &&
 	amend! amend! amend! B
-	${EMPTY}
+	$EMPTY
 	B
-	${EMPTY}
+	$EMPTY
 	edited 1
-	${EMPTY}
+	$EMPTY
 	edited 2
-	${EMPTY}
+	$EMPTY
 	edited 3
 	EOF
+	git tag B3 &&

 	GIT_AUTHOR_NAME="Rebase Author" &&
 	GIT_AUTHOR_EMAIL="rebase.author@example.com" &&
@@ -134,6 +137,7 @@ test_expect_success 'simple fixup -c works' '
 test_expect_success 'fixup -C removes amend! from message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A1 &&
+	git log -1 --pretty=format:%b >expected-message &&
 	FAKE_LINES="1 fixup-C 2" git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
 	test_cmp_rev HEAD^{tree} A1^{tree} &&
@@ -145,13 +149,14 @@ test_expect_success 'fixup -C removes amend! from message' '
 test_expect_success 'fixup -C with conflicts gives correct message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A1 &&
+	git log -1 --pretty=format:%b >expected-message &&
+	test_write_lines "" "edited" >>expected-message &&
 	test_must_fail env FAKE_LINES="1 fixup-C 2" git rebase -i conflicts &&
 	git checkout --theirs -- A &&
 	git add A &&
 	FAKE_COMMIT_AMEND=edited git rebase --continue &&
 	test_cmp_rev HEAD^ conflicts &&
 	test_cmp_rev HEAD^{tree} A1^{tree} &&
-	test_write_lines "" edited >>expected-message &&
 	test_commit_message HEAD expected-message &&
 	get_author HEAD >actual-author &&
 	test_cmp expected-author actual-author
@@ -167,12 +172,12 @@ test_expect_success 'skipping fixup -C after fixup gives correct message' '
 '

 test_expect_success 'sequence of fixup, fixup -C & squash --signoff works' '
-	git checkout --detach branch &&
+	git checkout --detach B3 &&
 	FAKE_LINES="1 fixup 2 fixup-C 3 fixup-C 4 squash 5 fixup-C 6" \
 		FAKE_COMMIT_AMEND=squashed \
 		FAKE_MESSAGE_COPY=actual-squash-message \
 		git -c commit.status=false rebase -ik --signoff A &&
-	git diff-tree --exit-code --patch HEAD branch -- &&
+	git diff-tree --exit-code --patch HEAD B3 -- &&
 	test_cmp_rev HEAD^ A &&
 	test_i18ncmp "$TEST_DIRECTORY/t3437/expected-squash-message" \
 		actual-squash-message
@@ -180,7 +185,7 @@ test_expect_success 'sequence of fixup, fixup -C & squash --signoff works' '

 test_expect_success 'first fixup -C commented out in sequence fixup fixup -C fixup -C' '
 	test_when_finished "test_might_fail git rebase --abort" &&
-	git checkout branch && git checkout --detach branch~2 &&
+	git checkout --detach B2~ &&
 	git log -1 --pretty=format:%b >expected-message &&
 	FAKE_LINES="1 fixup 2 fixup-C 3 fixup-C 4" git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
@@ -190,13 +195,16 @@ test_expect_success 'first fixup -C commented out in sequence fixup fixup -C fix
 test_expect_success 'multiple fixup -c opens editor once' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A3 &&
-	base=$(git rev-parse HEAD~4) &&
-	FAKE_COMMIT_MESSAGE="Modified-A3" \
+	git log -1 --pretty=format:%B >expected-message &&
+	test_write_lines "" "Modified-A3" >>expected-message &&
+	FAKE_COMMIT_AMEND="Modified-A3" \
 		FAKE_LINES="1 fixup-C 2 fixup-c 3 fixup-c 4" \
 		EXPECT_HEADER_COUNT=4 \
-		git rebase -i $base &&
-	test_cmp_rev $base HEAD^ &&
-	test 1 = $(git show | grep Modified-A3 | wc -l)
+		git rebase -i A &&
+	test_cmp_rev HEAD^ A &&
+	get_author HEAD >actual-author &&
+	test_cmp expected-author actual-author &&
+	test_commit_message HEAD expected-message
 '

 test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
@@ -211,12 +219,12 @@ test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
 '

 test_expect_success 'fixup -C works upon --autosquash with amend!' '
-	git checkout --detach branch &&
+	git checkout --detach B3 &&
 	FAKE_COMMIT_AMEND=squashed \
 		FAKE_MESSAGE_COPY=actual-squash-message \
 		git -c commit.status=false rebase -ik --autosquash \
 						--signoff A &&
-	git diff-tree --exit-code --patch HEAD branch -- &&
+	git diff-tree --exit-code --patch HEAD B3 -- &&
 	test_cmp_rev HEAD^ A &&
 	test_i18ncmp "$TEST_DIRECTORY/t3437/expected-squash-message" \
 		actual-squash-message
--
2.29.0.rc1

