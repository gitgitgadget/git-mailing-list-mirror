Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F647C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbiBWSZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbiBWSZs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:25:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC634A915
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id x15so6663551wrg.8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kzJZ7Ha+YciR+J+jk+lFjoifxMFI5g5hsJOatJi0Vwk=;
        b=Qy1v3/5peu2SVYunL8kM55vP7RLBMeCgK5oQCnp8JJO0H7YCDtZc4gfLCK5yRB5D7m
         MiPEr10IOPKZW0nuztkOdtsrjiDJHnXb0AWEs6QQh+o9aOaXzQhDhNSlWtObExN1K9bG
         5OETbRVRPTbT1RKaZIUkS+k7zYumtXDnBOcW25MQlNnsf3Jl2InJQo59F6VG3KJvZHPu
         UToZpTObY3/yrjmnVRydvy77Oic3r8fxPb89ngc4QkeFWTFTi6ioDpWBzO66SXaHKT1I
         bPSsEHPUTTvc35cCaRsG+CZ/TCc3RTu2TKbn1f9gdkad/gWGPqm6tZ3sgSzQtp8TQkG2
         jlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kzJZ7Ha+YciR+J+jk+lFjoifxMFI5g5hsJOatJi0Vwk=;
        b=zVcF6AMY2jAAmBRp4AJkLoo2l8Oe5QIz2beGxOI7rMXGEPvfzug4ctLMcBjHIrsq0x
         00LqBtG74EtVI4f6ZoLl0Ap2Awq0C87ANdofhQBRzMRLn6izUBMPHE8CrqXn6hm8NAH0
         6YhBNQMZL/gmKesIiKAbsIuIGAynkXFTEhx9SIZQGFMbKhV0PUmM61e0fyV2ny9+q3i/
         BeLoYQxAGSjt34k3I3OfHSNG43alB9p5drxVt1VJHVQ2KM+xbME7dsUj5R9Vli+8yCXu
         xxzTR9Me4j031ntkmv0Q5LUAWNiUGls7FZaJQIzJszhot7gEbtsR2Bq1uwDvBUVNAxwz
         H+tg==
X-Gm-Message-State: AOAM531h/ujti02d7xibgfFKygmZhID907IoNmdCAtpG3VVQJexO+j6M
        XfMS/jKXPQkXQWFXlV1AweTz3CkjQzA=
X-Google-Smtp-Source: ABdhPJwKkxowPXGws/nuB7yhufP74ehjlIlGUJuvP/slk172bK7+5GstQemX3RyYru1v6+HsotUqsw==
X-Received: by 2002:a05:6000:1843:b0:1ea:3bdd:dae with SMTP id c3-20020a056000184300b001ea3bdd0daemr634505wri.235.1645640719121;
        Wed, 23 Feb 2022 10:25:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm306885wrf.15.2022.02.23.10.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:25:18 -0800 (PST)
Message-Id: <90da1f9f33a1383ba199f9b11e9890bc67e56edf.1645640717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:25:10 +0000
Subject: [PATCH 1/7] sparse-index: prevent repo root from becoming sparse
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

Prevent the repository root from being collapsed into a sparse directory by
treating an empty path as "inside the sparse-checkout". When collapsing a
sparse index (e.g. in 'git sparse-checkout reapply'), the root directory
typically could not become a sparse directory due to the presence of in-cone
root-level files and directories. However, if no such in-cone files or
directories were present, there was no explicit check signaling that the
"repository root path" (an empty string, in the case of
'convert_to_sparse(...)') was in-cone, and a sparse directory index entry
would be created from the repository root directory.

The documentation in Documentation/git-sparse-checkout.txt explicitly states
that the files in the root directory are expected to be in-cone for a
cone-mode sparse-checkout. Collapsing the root into a sparse directory entry
violates that assumption, as sparse directory entries are expected to be
outside the sparse cone and have SKIP_WORKTREE enabled. This invalid state
in turn causes issues with commands that interact with the index, e.g.
'git status'.

Treating an empty (root) path as in-cone prevents the creation of a root
sparse directory in 'convert_to_sparse(...)'. Because the repository root is
otherwise never compared with sparse patterns (in both cone-mode and
non-cone sparse-checkouts), the new check does not cause additional changes
to how sparse patterns are applied.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 dir.c                                    |  7 ++++---
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index d91295f2bcd..f1cbef23a8a 100644
--- a/dir.c
+++ b/dir.c
@@ -1463,10 +1463,11 @@ static int path_in_sparse_checkout_1(const char *path,
 	const char *end, *slash;
 
 	/*
-	 * We default to accepting a path if there are no patterns or
-	 * they are of the wrong type.
+	 * We default to accepting a path if the path is empty, there are no
+	 * patterns, or the patterns are of the wrong type.
 	 */
-	if (init_sparse_checkout_patterns(istate) ||
+	if (!strlen(path) ||
+	    init_sparse_checkout_patterns(istate) ||
 	    (require_cone_mode &&
 	     !istate->sparse_checkout_patterns->use_cone_patterns))
 		return 1;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f3a059e5af5..9ef7cd80885 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -244,6 +244,24 @@ test_expect_success 'expanded in-memory index matches full index' '
 	test_sparse_match git ls-files --stage
 '
 
+test_expect_success 'root directory cannot be sparse' '
+	init_repos &&
+
+	# Remove all in-cone files and directories from the index, collapse index
+	# with `git sparse-checkout reapply`
+	git -C sparse-index rm -r . &&
+	git -C sparse-index sparse-checkout reapply &&
+
+	# Verify sparse directories still present, root directory is not sparse
+	cat >expect <<-EOF &&
+	folder1/
+	folder2/
+	x/
+	EOF
+	git -C sparse-index ls-files --sparse >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'status with options' '
 	init_repos &&
 	test_sparse_match ls &&
-- 
gitgitgadget

