Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C92C4332E
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AE365260
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhCHUFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhCHUEs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:04:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C194FC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:04:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo4556882wmq.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRAOetPN2jrf2kI78zrZYeRvhNX/StD1ZwQ8dgd+gRY=;
        b=KFR7TJ6PGbVRghqy5eArPS7voWzNX0QD2NkUl5cBmw3yyezZXnWBu01ZVuUetOIbdV
         2qk4Zw9mXHOMp07SixS/1MRw9PdDHA4oDnWVBBrqHM/wwi0GbhtN2AlI7heLH7on+FUU
         KgBZvTgtrGEyEfMGT3d2HtzOhStw9eIsWFRN4W1E+fTm3U3WvqEO/zff40eon9c+8Baq
         6bolzwbNrlWasq8Cct/7pjLhjASWH05SqGTRiTM2x3qtZo4Uzqs6XwBOABikZed/iVpa
         HyMrJZWBpIlOolVG0GW4eIkF2grpI7JJ6cHd9Mn+gl7vB46v1SaEADjkCzenlvnLh8cy
         RuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRAOetPN2jrf2kI78zrZYeRvhNX/StD1ZwQ8dgd+gRY=;
        b=Pw6XU2nQRQgQ6mYlvzw+EU6kW2ia5Ch9PDVRIMdYolkGjAKXhbDmWfZ6bZOlFINf3D
         ntJVl5y48wBGkfntJCtwoOPIwn8M+kxKUHCsZi1KJvL4esn5/1id2Bn/5SIvXIN2IU/W
         1d5HY4ZOQFwK6SLj/plPMo0dnSGPnICZ2rnXJIh0NqSU3X7BtU4qVn/+EjSzfiRTM55+
         yu/qs95Uq3K5O9kOFsiXgpGh0wmoTSsYAHcN2kRx97ZjFkb3o8n8cGU7BInqSiViQBml
         a+oRyaGo4uyZBJbVoozN1W+MsW9FdFiVv7zHOvOZP9/EaJJu7fD2tAGO7QRot1XDCZnm
         jufw==
X-Gm-Message-State: AOAM532Y/L7T439XE3mv/9kJT1upnDVaDKT27wdRiLvzSlQyOApIkGCj
        VNM16heeneMxEyF19uphiXOTVpA5IsNX4g==
X-Google-Smtp-Source: ABdhPJxi9/NWYhWggM+kAZ1CTrziOiN8fimuMqvfZIjMfMPoHCzFP1LBm7X8Qa3H+yxZjXR2THDheg==
X-Received: by 2002:a1c:3c8b:: with SMTP id j133mr440356wma.164.1615233886283;
        Mon, 08 Mar 2021 12:04:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q15sm20790786wrr.58.2021.03.08.12.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:04:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/7] object tests: add test for unexpected objects in tags
Date:   Mon,  8 Mar 2021 21:04:25 +0100
Message-Id: <20210308200426.21824-7-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blind spot in the tests added in 0616617c7e1 (t: introduce tests
for unexpected object types, 2019-04-09), there were no meaningful
tests for checking how we reported on finding the incorrect object
type in a tag, i.e. one that broke the "type" promise in the tag
header.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6102-rev-list-unexpected-objects.sh | 113 ++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 52cde097dd5..2ea1982b9ed 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -31,7 +31,8 @@ test_expect_success 'setup unexpected non-tree entry' '
 '
 
 test_expect_success 'traverse unexpected non-tree entry (lone)' '
-	test_must_fail git rev-list --objects $broken_tree
+	test_must_fail git rev-list --objects $broken_tree >output 2>&1 &&
+	test_i18ngrep "not a tree" output
 '
 
 test_expect_success 'traverse unexpected non-tree entry (seen)' '
@@ -124,4 +125,114 @@ test_expect_success 'traverse unexpected non-blob tag (seen)' '
 	test_i18ngrep "not a blob" output
 '
 
+test_expect_success 'setup unexpected non-tag tag' '
+	test_when_finished "git tag -d tag-commit tag-tag" &&
+
+	git tag -a -m"tagged commit" tag-commit $commit &&
+	tag_commit=$(git rev-parse tag-commit) &&
+	git tag -a -m"tagged tag" tag-tag tag-commit &&
+	tag_tag=$(git rev-parse tag-tag) &&
+
+	git cat-file tag tag-tag >good-tag-tag &&
+	git cat-file tag tag-commit >good-commit-tag &&
+
+	sed -e "s/$tag_commit/$commit/" <good-tag-tag >broken-tag-tag-commit &&
+	sed -e "s/$tag_commit/$tree/" <good-tag-tag >broken-tag-tag-tree &&
+	sed -e "s/$tag_commit/$blob/" <good-tag-tag >broken-tag-tag-blob &&
+
+	sed -e "s/$commit/$tag_commit/" <good-commit-tag >broken-commit-tag-tag &&
+	sed -e "s/$commit/$tree/" <good-commit-tag >broken-commit-tag-tree &&
+	sed -e "s/$commit/$blob/" <good-commit-tag >broken-commit-tag-blob &&
+
+	tag_tag_commit=$(git hash-object -w -t tag broken-tag-tag-commit) &&
+	tag_tag_tree=$(git hash-object -w -t tag broken-tag-tag-tree) &&
+	tag_tag_blob=$(git hash-object -w -t tag broken-tag-tag-blob) &&
+
+	commit_tag_tag=$(git hash-object -w -t tag broken-commit-tag-tag) &&
+	commit_tag_tree=$(git hash-object -w -t tag broken-commit-tag-tree) &&
+	commit_tag_blob=$(git hash-object -w -t tag broken-commit-tag-blob)
+'
+
+test_expect_success 'traverse unexpected incorrectly typed tag (to commit & tag)' '
+	test_must_fail git rev-list --objects $tag_tag_commit 2>err &&
+	cat >expected <<-EOF &&
+	error: object $commit is a tag, not a commit
+	fatal: bad object $commit
+	EOF
+	test_cmp expected err &&
+
+	test_must_fail git rev-list --objects $commit_tag_tag 2>err &&
+	cat >expected <<-EOF &&
+	error: object $tag_commit is a commit, not a tag
+	fatal: bad object $tag_commit
+	EOF
+	test_cmp expected err
+'
+
+test_expect_success 'traverse unexpected incorrectly typed tag (to tree)' '
+	test_must_fail git rev-list --objects $tag_tag_tree 2>err &&
+	cat >expected <<-EOF &&
+	error: object $tree is a tag, not a tree
+	fatal: bad object $tree
+	EOF
+	test_cmp expected err &&
+
+	test_must_fail git rev-list --objects $commit_tag_tree 2>err &&
+	cat >expected <<-EOF &&
+	error: object $tree is a commit, not a tree
+	fatal: bad object $tree
+	EOF
+	test_cmp expected err
+'
+
+test_expect_success 'traverse unexpected incorrectly typed tag (to blob)' '
+	test_must_fail git rev-list --objects $tag_tag_blob 2>err &&
+	cat >expected <<-EOF &&
+	error: object $blob is a tag, not a blob
+	fatal: bad object $blob
+	EOF
+	test_cmp expected err &&
+
+	test_must_fail git rev-list --objects $commit_tag_blob 2>err &&
+	cat >expected <<-EOF &&
+	error: object $blob is a commit, not a blob
+	fatal: bad object $blob
+	EOF
+	test_cmp expected err
+'
+
+test_expect_success 'traverse unexpected non-tag tag (tree seen to blob)' '
+	test_must_fail git rev-list --objects $tree $commit_tag_blob 2>err &&
+	cat >expected <<-EOF &&
+	error: object $blob is a commit, not a blob
+	fatal: bad object $blob
+	EOF
+	test_cmp expected err &&
+
+	test_must_fail git rev-list --objects $tree $tag_tag_blob 2>err &&
+	cat >expected <<-EOF &&
+	error: object $blob is a tag, not a blob
+	fatal: bad object $blob
+	EOF
+	test_cmp expected err
+'
+
+test_expect_success 'traverse unexpected non-tag tag (blob seen to blob)' '
+	test_must_fail git rev-list --objects $blob $commit_tag_blob 2>err &&
+	cat >expected <<-EOF &&
+	error: object $blob is a blob, not a commit
+	error: bad tag pointer to $blob in $commit_tag_blob
+	fatal: bad object $commit_tag_blob
+	EOF
+	test_cmp expected err &&
+
+	test_must_fail git rev-list --objects $blob $tag_tag_blob 2>err &&
+	cat >expected <<-EOF &&
+	error: object $blob is a blob, not a tag
+	error: bad tag pointer to $blob in $tag_tag_blob
+	fatal: bad object $tag_tag_blob
+	EOF
+	test_cmp expected err
+'
+
 test_done
-- 
2.31.0.rc1.210.g0f8085a843c

