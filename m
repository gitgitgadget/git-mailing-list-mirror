Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0071E20954
	for <e@80x24.org>; Wed, 22 Nov 2017 21:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbdKVVV2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 16:21:28 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41502 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdKVVVG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 16:21:06 -0500
Received: by mail-pl0-f65.google.com with SMTP id u14so1446723plm.8
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 13:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=232RtYE7HK0wMNDzhA1K9T5eTmySaqgg9GLVDVDrZzg=;
        b=ksAOY3NI07DNoGjcQvhYXHUB8dR5NljQQQma9uk7+wsqShhDCPpI6h+vuOv9VNF8EG
         +NetoKxdCssRQT4Ij0M2Vo2I59OuyRYfMxVBLpI2iZWtEMIoZ/+3sJtTAFPxPNhV3ok3
         kLwCNU/SM1D0DIPXoAm/27mdoEtC6llkNG/NmS6XEZAcD2fNReKI9c25201fJ5dYS5Iw
         oNO4VYnRjcTvgs2yQWyvANWHUGr109SY2ZbJ+2Ddy7mgPQp12aMPeMIDMDT/m0WbGcfz
         Q8Js9euaijkybfsXxzxCpETj10FAKU8qb2c91hx/BWNHW+sqjl/VIOTYyXDU04rCvpyt
         ZLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=232RtYE7HK0wMNDzhA1K9T5eTmySaqgg9GLVDVDrZzg=;
        b=a3C2TBbpczfPMCPr7pGg/QdVdktUHaIJt4P0g7L0djl+3VgkjhWQz+kCbh74iPjJhw
         19+xDFLpl6kzzZyZEmWtyJ3tFfpX7wRPxiuhZTHisYWkfIWsps7EgX0P4hGdSvWB+0nR
         cWF1GjzHvINUy28CO0hCB89odB4cHlPBslM1jVE6eAEcL9juHdKjte229Gkj/hNkR8zI
         To79UEJJ1/QbXAak3KF470Vtxzp/EeynFhzQUKim/VoprExJA+j1uuHTg2dqqjiKq4Ni
         pLYJBdERM0YNs2yG0O78L2T/I58D1AI/+X3V9dx6GY/3A5NNF5/ufBIEhH/O3fF3dUuh
         yzyQ==
X-Gm-Message-State: AJaThX6ercjc0uZDlMFkqJ8f9FkLKjJv1B0w1YlUTCipjHns+Mu9qqum
        gNsHV+qeNLoeiBTQ9imCjvGc4Bsq
X-Google-Smtp-Source: AGs4zMZcxAUjEHF7t81prrX+sFXXkg644I0QrdWjghUAgGbOoA16DbxuXpCcf1m7fa/KRgiN1JGP1w==
X-Received: by 10.84.202.12 with SMTP id w12mr13331277pld.107.1511385665292;
        Wed, 22 Nov 2017 13:21:05 -0800 (PST)
Received: from phord-x1.purestorage.com ([64.84.68.252])
        by smtp.gmail.com with ESMTPSA id h192sm14912194pfc.139.2017.11.22.13.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 13:21:03 -0800 (PST)
From:   Phil Hord <phil.hord@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v2] Teach stash to parse -m/--message like commit does
Date:   Wed, 22 Nov 2017 13:20:30 -0800
Message-Id: <20171122212031.5988-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.15.0.471.g17a719cfe.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git stash push -m foo` uses "foo" as the message for the stash. But
`git stash push -m"foo"` does not parse successfully.  Similarly
`git stash push --message="My stash message"` also fails.  The stash
documentation doesn't suggest this syntax should work, but gitcli
does and my fingers have learned this pattern long ago for `commit`.

Teach `git stash` and `git store` to parse -mFoo and --message=Foo
the same as `git commit` would do.  Even though it's an internal
function, add similar support to create_stash() for consistency.

Reviewd-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phil Hord <phil.hord@gmail.com>
---

Added tests for 'stash push' and 'stash store'.
Added a note that create_stash is included but unnecessary.

 git-stash.sh     | 18 +++++++++++
 t/t3903-stash.sh | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index 4b7495144..1114005ce 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -76,6 +76,12 @@ create_stash () {
 			shift
 			stash_msg=${1?"BUG: create_stash () -m requires an argument"}
 			;;
+		-m*)
+			stash_msg=${1#-m}
+			;;
+		--message=*)
+			stash_msg=${1#--message=}
+			;;
 		-u|--include-untracked)
 			shift
 			untracked=${1?"BUG: create_stash () -u requires an argument"}
@@ -193,6 +199,12 @@ store_stash () {
 			shift
 			stash_msg="$1"
 			;;
+		-m*)
+			stash_msg=${1#-m}
+			;;
+		--message=*)
+			stash_msg=${1#--message=}
+			;;
 		-q|--quiet)
 			quiet=t
 			;;
@@ -251,6 +263,12 @@ push_stash () {
 			test -z ${1+x} && usage
 			stash_msg=$1
 			;;
+		-m*)
+			stash_msg=${1#-m}
+			;;
+		--message=*)
+			stash_msg=${1#--message=}
+			;;
 		--help)
 			show_help
 			;;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3b1ac1971..39c7f2ebd 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -804,6 +804,99 @@ test_expect_success 'push -m shows right message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'push -m also works without space' '
+	>foo &&
+	git add foo &&
+	git stash push -m"unspaced test message" &&
+	echo "stash@{0}: On master: unspaced test message" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'store -m foo shows right message' '
+	git stash clear &&
+	git reset --hard &&
+	echo quux >bazzy &&
+	git add bazzy &&
+	STASH_ID=$(git stash create) &&
+	git stash store -m "store m" $STASH_ID &&
+	echo "stash@{0}: store m" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'store -mfoo shows right message' '
+	git stash clear &&
+	git reset --hard &&
+	echo quux >bazzy &&
+	git add bazzy &&
+	STASH_ID=$(git stash create) &&
+	git stash store -m"store mfoo" $STASH_ID &&
+	echo "stash@{0}: store mfoo" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'store --message=foo shows right message' '
+	git stash clear &&
+	git reset --hard &&
+	echo quux >bazzy &&
+	git add bazzy &&
+	STASH_ID=$(git stash create) &&
+	git stash store --message="store message=foo" $STASH_ID &&
+	echo "stash@{0}: store message=foo" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'store --message foo shows right message' '
+	git stash clear &&
+	git reset --hard &&
+	echo quux >bazzy &&
+	git add bazzy &&
+	STASH_ID=$(git stash create) &&
+	git stash store --message "store message foo" $STASH_ID &&
+	echo "stash@{0}: store message foo" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push -mfoo uses right message' '
+	>foo &&
+	git add foo &&
+	git stash push -m"test mfoo" &&
+	echo "stash@{0}: On master: test mfoo" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push --message foo is synonym for -mfoo' '
+	>foo &&
+	git add foo &&
+	git stash push --message "test message foo" &&
+	echo "stash@{0}: On master: test message foo" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push --message=foo is synonym for -mfoo' '
+	>foo &&
+	git add foo &&
+	git stash push --message="test message=foo" &&
+	echo "stash@{0}: On master: test message=foo" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push -m shows right message' '
+	>foo &&
+	git add foo &&
+	git stash push -m "test m foo" &&
+	echo "stash@{0}: On master: test m foo" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'create stores correct message' '
 	>foo &&
 	git add foo &&
-- 
2.15.0.471.g17a719cfe.dirty

