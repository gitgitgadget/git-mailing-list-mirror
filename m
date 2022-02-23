Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C47BC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243850AbiBWSZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbiBWSZt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:25:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0404A90F
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:21 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u1so41028043wrg.11
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mKHL2nL51eB+mDp6PJ2T49JTazVcHNXbFerl3otKkM4=;
        b=c1CfFQPGGU0TlI6c8UjZe14vt3vKNsuk8os0WYFE4q7WgU5Tb1jlhdy4ubfdPPWnM3
         ejWCyhccVvNlGAoK9pyhEXP0JiyEBZMYBdyhixsunbDGQxWASIcNhgtNAGl9YEEx/ynt
         n9NB74lsF5vZF6/FKccixKw6AHezVVHWXczZeTl9hzp/fmgTmvB9ANLH/ESJTxlcBa+Q
         5YCIMX3tQUPEXyES+PhTQwYbJD21XkU0zvfRkpG27erOh3XZxWQrpz0ZibtSjIi0KZmA
         Tdk2o6h7gZrI/L/ImDIxItzxu7kiXc+bYmeGApHl2W+96vmzrSYAYPol7jCglUzbVf6Q
         A2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mKHL2nL51eB+mDp6PJ2T49JTazVcHNXbFerl3otKkM4=;
        b=TlQgV5Zsa93NkksM4lg1aPYN9VNzulRIRRqsxnSwx+LEVS/fNcGQR0N0RTkBKkwXOn
         TFe/hGilvRdQ2ovgbZyIpmPk7pcmFjuQB17zl9Gp+7o9cG7msVl3KWRLRKTaL97gXOx7
         5pHDn4fmvgedfpdPqejxGgaFiqMKaWFMmUnUVmecureJMmrHx7PO66WV2uquA18vn8R1
         0kBbp1kJ98/abB0HLXzlOoFKvlMj9HjHFxrAsj3p6PS5vQmdZ2MZkI2NQuDRtRGQc8Sf
         wG0J8nQtSc2ptCZEPfFnEBTT+FRZE4pUr21RR0gXn8hIl8rJNOddvDLrOnOvpWkF8rC4
         1tSg==
X-Gm-Message-State: AOAM533/+cmf8EHB5uvTm+gTO5vea7FBmxJViwy9uJCgXUfbTTCRPxMt
        /2AFtH9I7J/at4veCmOz4Qkjp2MWoBU=
X-Google-Smtp-Source: ABdhPJwxXfp1WvAzs6mgqvs/TNkmjWXZEHafxV24GXafuv4hxhUl6/JIzCXn9DQ4t4/YtcvJsgsVDg==
X-Received: by 2002:a05:6000:1863:b0:1ed:9e83:c956 with SMTP id d3-20020a056000186300b001ed9e83c956mr663848wri.588.1645640719968;
        Wed, 23 Feb 2022 10:25:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm345319wmq.41.2022.02.23.10.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:25:19 -0800 (PST)
Message-Id: <c21c9b9be348640b7519ecc454331d7f1493228a.1645640717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:25:11 +0000
Subject: [PATCH 2/7] status: fix nested sparse directory diff in sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:stolee@gmail.com" <[stolee@gmail.com]@vger.kernel.org>,
        "mailto:newren@gmail.com" <[newren@gmail.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add the 'recursive' flag to 'wt_status_collect_changes_index(...)'. Without
the 'recursive' flag, 'git status' could report index changes incorrectly
when the following conditions were met:

* sparse index is enabled
* there is a difference between the index and HEAD in a file inside a
  *subdirectory* of a sparse directory
* the sparse directory index entry is *not* expanded in-core

In this scenario, 'git status' would not recurse into the sparse directory's
subdirectories to identify which file contained the difference between the
index and HEAD. Instead, it would report the immediate subdirectory itself
as "modified".

Example:

$ git init
$ mkdir -p sparse/sub
$ echo test >sparse/sub/foo
$ git add .
$ git commit -m "commit 1"
$ echo somethingelse >sparse/sub/foo
$ git add .
$ git commit -a -m "commit 2"
$ git sparse-checkout set --cone --sparse-index 'sparse'
$ git reset --soft HEAD~1
$ git status
On branch master
You are in a sparse checkout.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   sparse/sub

The 'recursive' diff option in 'wt_status_collect_changes_index' corrects
this by indicating that 'git status' should recurse into sparse directories
to find modified files. Given the same repository setup as the example
above, the corrected result of `git status` is:

$ git status
On branch master
You are in a sparse checkout.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   sparse/sub/foo

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 7 +++++++
 wt-status.c                              | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 9ef7cd80885..b1dcaa0e642 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -278,6 +278,13 @@ test_expect_success 'status with options' '
 	test_all_match git status --porcelain=v2 -uno
 '
 
+test_expect_success 'status with diff in unexpanded sparse directory' '
+	init_repos &&
+	test_all_match git checkout rename-base &&
+	test_all_match git reset --soft rename-out-to-out &&
+	test_all_match git status --porcelain=v2
+'
+
 test_expect_success 'status reports sparse-checkout' '
 	init_repos &&
 	git -C sparse-checkout status >full &&
diff --git a/wt-status.c b/wt-status.c
index 335e723a71e..4a5b9beeca1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -651,6 +651,15 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
 	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
+
+	/*
+	 * The `recursive` option must be enabled to show differences in files
+	 * *more than* one level deep in a sparse directory index entry (e.g., given
+	 * sparse directory 'sparse-dir/', reporting a difference in the file
+	 * 'sparse-dir/another-dir/my-file').
+	 */
+	rev.diffopt.flags.recursive = 1;
+
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
 	object_array_clear(&rev.pending);
-- 
gitgitgadget

