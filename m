Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717FDC4167B
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 01:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiL3Bw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 20:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiL3BwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 20:52:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDAA1649E
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 17:52:23 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso14379586wmp.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 17:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lse1QU+Lhi4H6766Oof8f1cQlpMBRTUDHNMyx1/V7W4=;
        b=Apc8D92jR62J9MBHUSowk3Lf5gT+Kcie87wjIs9tCPrDRCHLiyBDGlHeOvxdCKl5y/
         kXBFqyzDoMaNfhcFRsSMAHnLXa+I6V//TdVsJ3fkqnnHoDAfBJaTayf5Im7IZNd2+ML/
         VrReHt1I0iJAsl4vbIO2UwCjLHX0XqK4D3PSiVnNxvBLCEF6Dz66pAJkO3cT4SH+G3Or
         xIGA+N8eF7rU6CK26ND/ivsL9Nrmw1P51wBKmDeEE70NVYx0v91ZsYCIZy9nuc2I3bLc
         5lKRKhZ9SmtDa/vVq81vgGohYnm+YmUxE6pQno89kBKHloTl9PYWUqbt4IbklX4p+8up
         4HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lse1QU+Lhi4H6766Oof8f1cQlpMBRTUDHNMyx1/V7W4=;
        b=g5kGKNVTaGhtHMbYS6dw8z74uKZjK+xLZNb4RqIr/13IiqqCTp2sTb/TW4EJe7sW4Q
         BkrD2XC6Nikw7KqxmjGBokzM8JLL3R3mRll59tcdd/mCBE7MFHviG/ogMe7s90DoTrxm
         m+VdMoABsJ/AmCCRdKEEm1qLokY9RhjwHhHqhATi2qI7vCTua2+k2zftruY5uvCZKJzV
         aR4/teKHEyYwgbXEKuXY48FWgpHZb2zIHDnLectS5KRPrJEy3hBxQXFVSKnN8BsaqVbe
         Cque/S3OdV0BdmqsNxhb+uOptFr3umjyIx/FcP9Pw9fqbQt7o6JrMOo/4ioQs76vpL0p
         Q7vA==
X-Gm-Message-State: AFqh2kqo572sdtVWmrijNF+vbbMx3UFve4MNt7n3Yzw6etLkAHnJ/yEF
        gPRY5YpPd8yihalwoazEgi4dCoI+j1Z4sQ==
X-Google-Smtp-Source: AMrXdXsVQdFwU2Ymf3VS6ZM+w9JmKx/1T2XU7hGM1d7gYfUDEVFq8C81IlGNmAKsm06gOmkBPQftNA==
X-Received: by 2002:a05:600c:3c8c:b0:3d9:719b:bd1b with SMTP id bg12-20020a05600c3c8c00b003d9719bbd1bmr19441274wmb.33.1672365141924;
        Thu, 29 Dec 2022 17:52:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm26649298wmb.38.2022.12.29.17.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 17:52:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] object tests: add test for unexpected objects in tags
Date:   Fri, 30 Dec 2022 02:52:14 +0100
Message-Id: <patch-v2-1.3-0abf873f1e3-20221230T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>
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

As these tests happen to run into a memory leak skip them under
SANITIZE=leak, as the test file was previously marked leak-free in
[3]. There is a concurrent fix for the leak in question[4].

1. https://lore.kernel.org/git/YGTGgFI19fS7Uv6I@coredump.intra.peff.net/
2. https://lore.kernel.org/git/patch-18.20-aa4df0e1b5c-20221228T175512Z-avarab@gmail.com/
3. dd9cede9136 (leak tests: mark some rev-list tests as passing with
   SANITIZE=leak, 2021-10-31)
4. https://lore.kernel.org/git/patch-18.20-aa4df0e1b5c-20221228T175512Z-avarab@gmail.com/

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6102-rev-list-unexpected-objects.sh | 146 +++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 9350b5fd2c2..f1c30db2654 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -130,4 +130,150 @@ test_expect_success 'traverse unexpected non-blob tag (seen)' '
 	test_i18ngrep "not a blob" output
 '
 
+test_expect_success !SANITIZE_LEAK 'setup unexpected non-tag tag' '
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
+test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to commit & tag)' '
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
+test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to tree)' '
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
+test_expect_failure !SANITIZE_LEAK 'traverse unexpected incorrectly typed tag (to blob)' '
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
+test_expect_failure !SANITIZE_LEAK 'traverse unexpected non-tag tag (tree seen to blob)' '
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
+test_expect_failure !SANITIZE_LEAK 'traverse unexpected objects with for-each-ref' '
+	cat >expect <<-EOF &&
+	error: bad tag pointer to $tree in $tag_tag_tree
+	fatal: parse_object_buffer failed on $tag_tag_tree for refs/tags/tag_tag_tree
+	EOF
+	test_must_fail git for-each-ref --format="%(*objectname)" 2>actual &&
+	test_cmp expect actual
+'
+
+>fsck-object-isa
+test_expect_success 'setup: unexpected objects with fsck' '
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
+test_expect_success !SANITIZE_LEAK 'traverse unexpected non-tag tag (blob seen to blob)' '
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
2.39.0.1153.g589e4efe9dc

