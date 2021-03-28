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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68059C433F1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369CC6197C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhC1CO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhC1CON (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:14:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B0C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x7so9313494wrw.10
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=srGDscnY1af5NcpHueTT5qqS2ZCDXZq+9tu9N+RmwxM=;
        b=bGocm2mp++XCjxKpz1tjX42LQEiwt6qNzSsvpXUQiAp0QnPYk6WkHurazqOtnl3wUF
         1FkbDQlddCKRN5hfhO0Y4O88ATD6BkI41pO7PMQkrcIh921xh+x4f7Xbsfrc9coyl6Cj
         HcA7kw0K3d4kbfPSzRkskPWzJvk42YD697+0vr6XvynRJ33tmdX0W/i7XiG82+DWqT7l
         hi9w3m6Kq1kmNxvoXElH01SyHuCl6x1hHEOW540X+5lvi9r/yp2wiTCell7MArvepHwG
         WdmY7FdMBh0W6nggfQtKvC4HUTm+sRBkXBloMDNCbtpjaS4BheaG44I5iMYANlXMtxm0
         J8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=srGDscnY1af5NcpHueTT5qqS2ZCDXZq+9tu9N+RmwxM=;
        b=bpn8siEWGVoA04XhD/qS2W2G0FjT1EoMoxFqq/cOX19d4AOj6K+sfu0BG1XGGGFfEE
         Q9VMLGk2d7JCX13dCfwb1goB85KrGXoNPSPmpZGzUIBaXivhXWE7gjD9qmS6nqQ0ksNj
         Xx/67TFaHQ0dvVt1hG2yALPFAUeropCC29mYgKFOrtmX3S+KaBqCiI3sO2L0HwubMwl5
         KuX9z9kEl1eQHJCp0rtTtDV/ihZRbV+WVyTg2+gJwKikxYXrr2gl6dnCt/nVWOBcpDFD
         BUt768AHhL0qbfuSjyXqNqBMOu1qvDVqXi54CBzc3wwXiV1Ysm/wCWS3JZx+mTzgy9kk
         od9A==
X-Gm-Message-State: AOAM5324WKfJMc8hkUhZLrkjVtSRrE1F6ppw2GY7g7CDBL6lmPxpyocq
        0kPwal3zFqAaJLhcSpbTP6nSJvhc0Jd8lQ==
X-Google-Smtp-Source: ABdhPJz/PDHH+S5s61IlnR8WvY/LTSKgOoN1HrlyiYmdhdjARS9t39onUQ0avGlyyqYtCTqDRQAPJw==
X-Received: by 2002:adf:f146:: with SMTP id y6mr21879081wro.45.1616897651415;
        Sat, 27 Mar 2021 19:14:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm11291524wrt.47.2021.03.27.19.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:14:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/10] object tests: add test for unexpected objects in tags
Date:   Sun, 28 Mar 2021 04:13:39 +0200
Message-Id: <patch-09.11-6a43bf897ae-20210328T021238Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
References: <20210308200426.21824-1-avarab@gmail.com> <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
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
2.31.1.442.g6c06c9fe35c

