Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0577AC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA62660231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhEaRlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhEaRky (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED297C00874D
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z8so6422219wrp.12
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=6mfwQ1ZQ3qCeJT++Ml9TRrZ4/YAQ1E39joQqjbMQfbg=;
        b=vCaKG/EOIIa3DJnakX97VmCxqkP86V4N+DvQGcNA6q+cqpgTZsPiqNT6/egnJWHXtj
         c7sPH/qFM4L7rDGiM9HnriZYVJYa+fXxx8uxVwxozcu4nU0GodWOjh1usDI8Wc/ppNJj
         LwbE2JR8VXMdsIDmFTS7fchf3s+Djq/5S+PQy+XJgDYtwZVrdrN6iMcrFLEFPDM7ta+q
         mTN/K6y0C2OrE+ak96gDBbPBSQNvhvuKnx8Br5b0m+dbxid3ept7zUammymNADNGD6uw
         KhX009qLBeNKebGV+2i65FfSMNNHYb8RzVSLwJOPZN+J1rfrpz197kLbt9Pn4mCrD79u
         SBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=6mfwQ1ZQ3qCeJT++Ml9TRrZ4/YAQ1E39joQqjbMQfbg=;
        b=UpHmecENsaEO7uF9dgMt0+j+rYtF1uFZzR4RYMqeZsC8sk4eJDuKg3Ti6A4eobA0jE
         L4BCLjE/Cf0tqnUxVpq6vh5wKcL5/VSZKTrRJ7C2fqKyZoEuXL8myQ50G4G1I+d4uyon
         NiAUI+bD53vu8Ngehihf25iamLC1mLL16DY1trfMZcj62VR2FTGv9k2/Ju+2OacEvwzT
         pg54VS4JBcvtDwcBcaGYBlC6xARagXJv5c0aDVsZYnoDMPZbhWznojBSZzWVLYtj+jcR
         PpWPCf22rc7Xc89DGMzJQUdVUSYNBC2SWdAP/0ziavka3FLGvtyLreAWtb3DgXG/Uiam
         qJvg==
X-Gm-Message-State: AOAM530v366iZL4L9qwE/y+3cFm3zMJLBDedRleIv05KS+qPUl7zJMbD
        P7IMDTgL7jXQCTBHef6RgBMvY19vc4E=
X-Google-Smtp-Source: ABdhPJw84y1eM22owdU/ebZ0JiGEj4zAbJEXZcppjfHhueMnbRADXoT4/2qlytktQMmGe7vxa9oDTA==
X-Received: by 2002:a5d:4890:: with SMTP id g16mr23282250wrq.353.1622480205607;
        Mon, 31 May 2021 09:56:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a123sm43340wmd.2.2021.05.31.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:45 -0700 (PDT)
Message-Id: <c12406ac9655d45a6eb3f408805d2a5db1c63bfa.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:27 +0000
Subject: [PATCH v3 12/22] t5304: restyle: trim empty lines, drop ':' before >
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5304-prune.sh | 74 +++++++++++++-----------------------------------
 1 file changed, 20 insertions(+), 54 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 3475b06aeb26..15d56d3d8791 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -22,30 +22,25 @@ add_blob() {
 }
 
 test_expect_success setup '
-
-	: > file &&
+	>file &&
 	git add file &&
 	test_tick &&
 	git commit -m initial &&
 	git gc
-
 '
 
 test_expect_success 'prune stale packs' '
-
 	orig_pack=$(echo .git/objects/pack/*.pack) &&
-	: > .git/objects/tmp_1.pack &&
-	: > .git/objects/tmp_2.pack &&
+	>.git/objects/tmp_1.pack &&
+	>.git/objects/tmp_2.pack &&
 	test-tool chmtime =-86501 .git/objects/tmp_1.pack &&
 	git prune --expire 1.day &&
 	test_path_is_file $orig_pack &&
 	test_path_is_file .git/objects/tmp_2.pack &&
 	test_path_is_missing .git/objects/tmp_1.pack
-
 '
 
 test_expect_success 'prune --expire' '
-
 	add_blob &&
 	git prune --expire=1.hour.ago &&
 	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
@@ -54,11 +49,9 @@ test_expect_success 'prune --expire' '
 	git prune --expire 1.day &&
 	verbose test $before = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
-
 '
 
 test_expect_success 'gc: implicit prune --expire' '
-
 	add_blob &&
 	test-tool chmtime =-$((2*$week-30)) $BLOB_FILE &&
 	git gc &&
@@ -68,33 +61,25 @@ test_expect_success 'gc: implicit prune --expire' '
 	git gc &&
 	verbose test $before = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
-
 '
 
 test_expect_success 'gc: refuse to start with invalid gc.pruneExpire' '
-
 	git config gc.pruneExpire invalid &&
 	test_must_fail git gc
-
 '
 
 test_expect_success 'gc: start with ok gc.pruneExpire' '
-
 	git config gc.pruneExpire 2.days.ago &&
 	git gc
-
 '
 
 test_expect_success 'prune: prune nonsense parameters' '
-
 	test_must_fail git prune garbage &&
 	test_must_fail git prune --- &&
 	test_must_fail git prune --no-such-option
-
 '
 
 test_expect_success 'prune: prune unreachable heads' '
-
 	git config core.logAllRefUpdates false &&
 	mv .git/logs .git/logs.old &&
 	: > file2 &&
@@ -104,11 +89,9 @@ test_expect_success 'prune: prune unreachable heads' '
 	git reset HEAD^ &&
 	git prune &&
 	test_must_fail git reset $tmp_head --
-
 '
 
 test_expect_success 'prune: do not prune detached HEAD with no reflog' '
-
 	git checkout --detach --quiet &&
 	git commit --allow-empty -m "detached commit" &&
 	# verify that there is no reflogs
@@ -116,75 +99,61 @@ test_expect_success 'prune: do not prune detached HEAD with no reflog' '
 	test_path_is_missing .git/logs &&
 	git prune -n >prune_actual &&
 	test_must_be_empty prune_actual
-
 '
 
 test_expect_success 'prune: prune former HEAD after checking out branch' '
-
 	head_oid=$(git rev-parse HEAD) &&
 	git checkout --quiet main &&
 	git prune -v >prune_actual &&
 	grep "$head_oid" prune_actual
-
 '
 
 test_expect_success 'prune: do not prune heads listed as an argument' '
-
-	: > file2 &&
+	>file2 &&
 	git add file2 &&
 	git commit -m temporary &&
 	tmp_head=$(git rev-list -1 HEAD) &&
 	git reset HEAD^ &&
 	git prune -- $tmp_head &&
 	git reset $tmp_head --
-
 '
 
 test_expect_success 'gc --no-prune' '
-
 	add_blob &&
 	test-tool chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git config gc.pruneExpire 2.days.ago &&
 	git gc --no-prune &&
 	verbose test 1 = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE
-
 '
 
 test_expect_success 'gc respects gc.pruneExpire' '
-
 	git config gc.pruneExpire 5002.days.ago &&
 	git gc &&
 	test_path_is_file $BLOB_FILE &&
 	git config gc.pruneExpire 5000.days.ago &&
 	git gc &&
 	test_path_is_missing $BLOB_FILE
-
 '
 
 test_expect_success 'gc --prune=<date>' '
-
 	add_blob &&
 	test-tool chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git gc --prune=5002.days.ago &&
 	test_path_is_file $BLOB_FILE &&
 	git gc --prune=5000.days.ago &&
 	test_path_is_missing $BLOB_FILE
-
 '
 
 test_expect_success 'gc --prune=never' '
-
 	add_blob &&
 	git gc --prune=never &&
 	test_path_is_file $BLOB_FILE &&
 	git gc --prune=now &&
 	test_path_is_missing $BLOB_FILE
-
 '
 
 test_expect_success 'gc respects gc.pruneExpire=never' '
-
 	git config gc.pruneExpire never &&
 	add_blob &&
 	git gc &&
@@ -192,17 +161,14 @@ test_expect_success 'gc respects gc.pruneExpire=never' '
 	git config gc.pruneExpire now &&
 	git gc &&
 	test_path_is_missing $BLOB_FILE
-
 '
 
 test_expect_success 'prune --expire=never' '
-
 	add_blob &&
 	git prune --expire=never &&
 	test_path_is_file $BLOB_FILE &&
 	git prune &&
 	test_path_is_missing $BLOB_FILE
-
 '
 
 test_expect_success 'gc: prune old objects after local clone' '
@@ -222,16 +188,16 @@ test_expect_success 'gc: prune old objects after local clone' '
 test_expect_success 'garbage report in count-objects -v' '
 	test_when_finished "rm -f .git/objects/pack/fake*" &&
 	test_when_finished "rm -f .git/objects/pack/foo*" &&
-	: >.git/objects/pack/foo &&
-	: >.git/objects/pack/foo.bar &&
-	: >.git/objects/pack/foo.keep &&
-	: >.git/objects/pack/foo.pack &&
-	: >.git/objects/pack/fake.bar &&
-	: >.git/objects/pack/fake.keep &&
-	: >.git/objects/pack/fake.pack &&
-	: >.git/objects/pack/fake.idx &&
-	: >.git/objects/pack/fake2.keep &&
-	: >.git/objects/pack/fake3.idx &&
+	>.git/objects/pack/foo &&
+	>.git/objects/pack/foo.bar &&
+	>.git/objects/pack/foo.keep &&
+	>.git/objects/pack/foo.pack &&
+	>.git/objects/pack/fake.bar &&
+	>.git/objects/pack/fake.keep &&
+	>.git/objects/pack/fake.pack &&
+	>.git/objects/pack/fake.idx &&
+	>.git/objects/pack/fake2.keep &&
+	>.git/objects/pack/fake3.idx &&
 	git count-objects -v 2>stderr &&
 	grep "index file .git/objects/pack/fake.idx is too small" stderr &&
 	grep "^warning:" stderr | sort >actual &&
@@ -250,12 +216,12 @@ EOF
 test_expect_success 'clean pack garbage with gc' '
 	test_when_finished "rm -f .git/objects/pack/fake*" &&
 	test_when_finished "rm -f .git/objects/pack/foo*" &&
-	: >.git/objects/pack/foo.keep &&
-	: >.git/objects/pack/foo.pack &&
-	: >.git/objects/pack/fake.idx &&
-	: >.git/objects/pack/fake2.keep &&
-	: >.git/objects/pack/fake2.idx &&
-	: >.git/objects/pack/fake3.keep &&
+	>.git/objects/pack/foo.keep &&
+	>.git/objects/pack/foo.pack &&
+	>.git/objects/pack/fake.idx &&
+	>.git/objects/pack/fake2.keep &&
+	>.git/objects/pack/fake2.idx &&
+	>.git/objects/pack/fake3.keep &&
 	git gc &&
 	git count-objects -v 2>stderr &&
 	grep "^warning:" stderr | sort >actual &&
-- 
gitgitgadget

