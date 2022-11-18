Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A99C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbiKRLrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241669AbiKRLrG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:47:06 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EC112AF1
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:47:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y24so1775811edi.10
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeibMuXDOcrY1SB7ENh6HTqdiuDSmneLOLX8+J/ew/A=;
        b=KQJUkU9a/fp5jRNtL7slJy+WzzfxUnLrme7peMoqiPQ5yiglYzRrsh1QT4OSI9L8wb
         qPZC6pltOIp8Ft6UzkXAZlP5KJxEAK24c9xLGRD2lGiCHTiWLyT4yL9UafPM0S7mRLig
         wH0IBNz2rfJGzYhECp3yUndox4jspc2F2KB/DzrTevTv0dCdKAVYJ3F9EBwlsfEGWjmM
         7P6xB9wKXB064XcwqTQlUyfjLJzY3yfIfgP8+dKMfQH9lZ0FAIcvHmmhWcO8qoH2Q51R
         iAM3vp6Ln1HndfS+ivt4G5+XkbYacLsX/Ms2dW9Coca0lIwIRX4rjzM9gOPxMn0tbfHP
         3gjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeibMuXDOcrY1SB7ENh6HTqdiuDSmneLOLX8+J/ew/A=;
        b=Hi3SobcmhBEpX7IZ1UKd+sDB0IL8PKc/xObHJRj1bsYRKqFzoyVUyUpnqver5djg9A
         6/KznC7ksTYgOecz5lGyofh+1CFXGQkgvLlTD8Sh0p4sOit8hYWqbzkdgqNk6R1c8pvg
         QjNslfpJ7DaeDxVtcU+dS9uHhaziaAXbjuBRdutIlJpaXyz60HAgh88J+lhCvo1FpPJn
         kLEUqoCILFWnYMI5SMOfJsOtjCf4TFwGpU/1MrI2s8qDOAaubXxHeMpmGtqwX357N0rQ
         haIYLliMI5qFuX9PMWJwmST91A0AObg3K+kQqh4h7gtYFXmxG9YNhIFplihNlV9fmIkR
         FaVQ==
X-Gm-Message-State: ANoB5pl/i3TojxJKNRhWWR143VTkb7hs6Zd0yajFRRE60PJIw3qrMYr7
        ZCVw5BxB7BMnW+NXJA/ykx6J0SGBzkrvaA==
X-Google-Smtp-Source: AA0mqf65JrO6YHKdFogERlhayTYt7qKPwiDFTpnyiKGqHgIQhkrETihYrillHQ6NIo7YZLwpJIm7wQ==
X-Received: by 2002:a05:6402:347:b0:469:2f23:3b99 with SMTP id r7-20020a056402034700b004692f233b99mr320921edw.44.1668772023706;
        Fri, 18 Nov 2022 03:47:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7dd48000000b004615e1bbaf4sm1705349edw.87.2022.11.18.03.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:47:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] object tests: add test for unexpected objects in tags
Date:   Fri, 18 Nov 2022 12:46:57 +0100
Message-Id: <patch-2.4-1b5544ec868-20221118T113442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1512.g9e0c09a155f
In-Reply-To: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>
References: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net> <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>
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

We'll report the wrong object type in these cases, and thus fail on
the "test_cmp", e.g. for the first "error: " output being tested here
we should say "$commit is a tag, not a commit", instead we say
"$commit is a commit, not a tag". This will be fixed in a subsequent
commit.

See the discussion & notes in [1] and downthread of there for test
snippets that are adapted here.

In the case of "fsck" which objects we visit in what order, and if we
report errors on them depends on their OIDs. So the test uses the
technique of extracting the OID/type combinations that fsck does
report, and asserting that those are correct (currently, it's far from
correct).

1. https://lore.kernel.org/git/YGTGgFI19fS7Uv6I@coredump.intra.peff.net/

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6102-rev-list-unexpected-objects.sh | 146 +++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 9350b5fd2c2..ac49f7182fd 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -130,4 +130,150 @@ test_expect_success 'traverse unexpected non-blob tag (seen)' '
 	test_i18ngrep "not a blob" output
 '
 
+test_expect_success 'setup unexpected non-tag tag' '
+	test_when_finished "git tag -d tag-commit tag-tag" &&
+
+	git tag -a -m"my tagged commit" tag-commit $commit &&
+	tag_commit=$(git rev-parse tag-commit) &&
+	git tag -a -m"my tagged tag" tag-tag tag-commit &&
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
+	git update-ref refs/tags/tag_tag_commit $tag_tag_commit &&
+	git update-ref refs/tags/tag_tag_tree $tag_tag_tree &&
+	git update-ref refs/tags/tag_tag_blob $tag_tag_blob &&
+
+	commit_tag_tag=$(git hash-object -w -t tag broken-commit-tag-tag) &&
+	commit_tag_tree=$(git hash-object -w -t tag broken-commit-tag-tree) &&
+	commit_tag_blob=$(git hash-object -w -t tag broken-commit-tag-blob) &&
+
+	git update-ref refs/tags/commit_tag_tag $commit_tag_tag &&
+	git update-ref refs/tags/commit_tag_tree $commit_tag_tree &&
+	git update-ref refs/tags/commit_tag_blob $commit_tag_blob
+'
+
+test_expect_failure 'traverse unexpected incorrectly typed tag (to commit & tag)' '
+	test_must_fail git rev-list --objects $tag_tag_commit 2>err &&
+	cat >expect <<-EOF &&
+	error: object $commit is a commit, not a tag
+	fatal: bad object $commit
+	EOF
+	test_cmp expect err &&
+
+	test_must_fail git rev-list --objects $commit_tag_tag 2>err &&
+	cat >expect <<-EOF &&
+	error: object $tag_commit is a tag, not a commit
+	fatal: bad object $tag_commit
+	EOF
+	test_cmp expect err
+'
+
+test_expect_failure 'traverse unexpected incorrectly typed tag (to tree)' '
+	test_must_fail git rev-list --objects $tag_tag_tree 2>err &&
+	cat >expect <<-EOF &&
+	error: object $tree is a tree, not a tag
+	fatal: bad object $tree
+	EOF
+	test_cmp expect err &&
+
+	test_must_fail git rev-list --objects $commit_tag_tree 2>err &&
+	cat >expect <<-EOF &&
+	error: object $tree is a tree, not a commit
+	fatal: bad object $tree
+	EOF
+	test_cmp expect err
+'
+
+test_expect_failure 'traverse unexpected incorrectly typed tag (to blob)' '
+	test_must_fail git rev-list --objects $tag_tag_blob 2>err &&
+	cat >expect <<-EOF &&
+	error: object $blob is a blob, not a tag
+	fatal: bad object $blob
+	EOF
+	test_cmp expect err &&
+
+	test_must_fail git rev-list --objects $commit_tag_blob 2>err &&
+	cat >expect <<-EOF &&
+	error: object $blob is a blob, not a commit
+	fatal: bad object $blob
+	EOF
+	test_cmp expect err
+'
+
+test_expect_failure 'traverse unexpected non-tag tag (tree seen to blob)' '
+	test_must_fail git rev-list --objects $tree $commit_tag_blob 2>err &&
+	cat >expect <<-EOF &&
+	error: object $blob is a blob, not a commit
+	fatal: bad object $blob
+	EOF
+	test_cmp expect err &&
+
+	test_must_fail git rev-list --objects $tree $tag_tag_blob 2>err &&
+	cat >expect <<-EOF &&
+	error: object $blob is a blob, not a tag
+	fatal: bad object $blob
+	EOF
+	test_cmp expect err
+'
+
+
+test_expect_failure 'traverse unexpected objects with for-each-ref' '
+	cat >expect <<-EOF &&
+	error: bad tag pointer to $tree in $tag_tag_tree
+	fatal: parse_object_buffer failed on $tag_tag_tree for refs/tags/tag_tag_tree
+	EOF
+	test_must_fail git for-each-ref --format="%(*objectname)" 2>actual &&
+	test_cmp expect actual
+'
+
+>fsck-object-isa
+test_expect_failure 'setup: unexpected objects with fsck' '
+	test_must_fail git fsck 2>err &&
+	sed -n -e "/^error: object .* is a .*, not a .*$/ {
+		s/^error: object \([0-9a-f]*\) is a \([a-z]*\), not a [a-z]*$/\\1 \\2/;
+		p;
+	}" <err >fsck-object-isa
+'
+
+while read oid type
+do
+	test_expect_failure "fsck knows unexpected object $oid is $type" '
+		git cat-file -t $oid >expect &&
+		echo $type >actual &&
+		test_cmp expect actual
+	'
+done <fsck-object-isa
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
2.38.0.1511.gcdcff1f1dc2

