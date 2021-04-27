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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A95C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA8D6115C
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhD0Kjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbhD0KjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE91C061756
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l2so6600677wrm.9
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=panOOwwGkkzyCTTovUlDWm2m9ZHmKPk+jlfgRntLo3E=;
        b=mhSAW7JWEeEYrWlLVKiLAoPScJ3mUI48El3xjyJIxUi7Pr/MRJEuqAq0EgtF/JDpmu
         jhmVf4rX0p1/3Mr6r3suv/wGQreuhll0+kSb5JjIGR3eojzNkw7ggiHr/cX62NL5kxwh
         W6YVBnzEQOy5DWgoi2Kmfhw08AWowl+nA94hkymIDRf4gYlD5MHcUPpZTzVRbBgs3Xo1
         zO25Xzfz1JG8EbQyWR/zVxacSNvwHClQ2nd1c28yOCaPxC13PeM4TL3/6L9mldjbs4GC
         o8mfmK6m0zVVny6CvwVDir6+oZkgFpDgpgnCSDd/rxo6sp9IFAukVpZdIBlU3t6ag15W
         Vr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=panOOwwGkkzyCTTovUlDWm2m9ZHmKPk+jlfgRntLo3E=;
        b=gvN1UfQhVc5d8QxhdfbDpJS/Wj+2KTbW8HZlU+pctn4xwEl6XhzCzRnxaMBJ/YqWhw
         i9eeeuFS1hTYQ9DUKjN1hWQJJSX0cdvj6PhClD2jRVuatNxsT9GnMnE7n/FYHzjhiIMd
         rHqRuH6UscYb7YRIgIEgtSK3v2BhsOxU5TMBrbIh0zfyqw9QRaP+mW+kjIUpX4dGewxM
         tJsD5w9DtcAmpigK9+tNpf/4F67LdO5VTjgDNBe81oCKHZ3x5DsDyWFWp1bj/xSSR6l5
         75jMJv2pEsecoqvvgJDNp3yZYOiBYPiC0XEvAOVey3aXKGfkycBWlwsX+aOLD4NqumIn
         8A6w==
X-Gm-Message-State: AOAM531Scmi3AkBWwQQDgVpxQuuWN6oeRK98DxbajX2d9SnNyoZxv0Gk
        7tHCHGZHMU866ABasaqRlmwxECu2mS0=
X-Google-Smtp-Source: ABdhPJzC4wHX/tA3fLVgch8Zk7V+2XXE2X/9xFYOF7m3139bwsbGLKAj57ABvxhfdwXJ1NDf5OcTvQ==
X-Received: by 2002:a5d:65c4:: with SMTP id e4mr28411964wrw.287.1619519910712;
        Tue, 27 Apr 2021 03:38:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1sm1348916wrq.6.2021.04.27.03.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:30 -0700 (PDT)
Message-Id: <6f15c15573afcef08f7ab2f4e14ef4cdb575261c.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:12 +0000
Subject: [PATCH v2 11/21] t5304: restyle: trim empty lines, drop ':' before >
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t5304-prune.sh | 74 +++++++++++++-----------------------------------
 1 file changed, 20 insertions(+), 54 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index b447ce56a9b2..7f47f13c78e8 100755
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

