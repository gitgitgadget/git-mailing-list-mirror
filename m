Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA506C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D173E61019
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243140AbhITXiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbhITXgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:36:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B73CC0EDAFE
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t18so32099703wrb.0
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NI4USuJlvyh9qzP66ETIQecQeOGGa/O6tXtFnDWTMmU=;
        b=P61QgP+bTpQWq3T0Y0igLVaATYMo3tzD/A1xXEo6Q3+X1JmKnHQotK7VbAR3Pc/cNa
         Wwx+wBn5Oaxcr1y1WjyCGFNn+duHHqaSawN9odCsKrZCZmXlQp3ZjC4j3op2SdjccshI
         ax0wM0ZsS1XVs/54xp2CmK5vyEfHHzRkMghtVha7q4rOE4FYClJeOSTqfeH6JDoPH8BP
         K/UphNBjjay0SgmAEPtBn4lezv8bENuIUCCF/IbSC+B4neSM+6oBjpzvMW9G0y0LnHjX
         2BNg/4V5fOvqe2dAUsT4Bh7TkFGVTaf4R5x8bX0qN4gWAzjj991AxoNlrK5RJo5zHRUx
         /ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NI4USuJlvyh9qzP66ETIQecQeOGGa/O6tXtFnDWTMmU=;
        b=T8kufCAy7MK0ihD/v1hnqWpP3i1tfhLhrDYvHdoLMcGl8DdVhSPftxOtDDWKp3i6jc
         LLpPaSo10s7Z2Up+jW5sHOFmSYE1SNDzbtF/LmLE8qYQIB9rdnxXvcH0KPrcDXtCF6P8
         COshCP2v4Fwur8R2qgsN3mnqkKPyDGZdykb8K/w5NRL3EE7xfG/kicMUHizLrLpWnCrc
         mO95Y8sfo01vnaN+PanBjCpOVs6EjPjbHEca78J6wv4XHhT1CPOjN7+1nD25VIIlxLfJ
         SnAtK1TMuuabCXqK1vpPlay3eO+Wzz+XJm22R7FAjFOR1gp5tR3e80V80nWiXeXatXIv
         sPIA==
X-Gm-Message-State: AOAM531uwhmYqyZl0yLwEWnmZdixVVYrVtrcFE6+/brOZ1IcV8oF6Hh3
        GhQG31P7GD3aX2WCOf2zBidE2iBaMuY=
X-Google-Smtp-Source: ABdhPJzDETUMM7PBlUynZWerjHkMWn7PM60ZczxvcdLXQyKfhEPaBczmqBjSd6AjUb4CgpxV4YdJ1A==
X-Received: by 2002:a1c:a713:: with SMTP id q19mr288407wme.42.1632159944943;
        Mon, 20 Sep 2021 10:45:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1sm885048wmk.2.2021.09.20.10.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:44 -0700 (PDT)
Message-Id: <2bd3448be5f688adecc7ccc2947532b2af26c5e4.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:32 +0000
Subject: [PATCH v3 09/14] add: update --chmod to skip sparse paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We added checks for path_in_sparse_checkout() to portions of 'git add'
that add warnings and prevent staging a modification, but we skipped the
--chmod mode. Update chmod_pathspec() to ignore cache entries whose path
is outside of the sparse-checkout cone (unless --sparse is provided).
Add a test in t3705.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                  |  4 +++-
 t/t3705-add-sparse-checkout.sh | 10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f8e3930608d..f87b8134b67 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -47,7 +47,9 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 		struct cache_entry *ce = active_cache[i];
 		int err;
 
-		if (!include_sparse && ce_skip_worktree(ce))
+		if (!include_sparse &&
+		    (ce_skip_worktree(ce) ||
+		     !path_in_sparse_checkout(ce->name, &the_index)))
 			continue;
 
 		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 0434cdfd9c6..9347705ad1c 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -169,11 +169,19 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	test_must_fail git add sparse_entry &&
 	test_sparse_entry_unstaged &&
 
+	test_must_fail git add --chmod=+x sparse_entry &&
+	test_sparse_entry_unstaged &&
+
 	# Avoid munging CRLFs to avoid an error message
 	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	test-tool read-cache --table >actual &&
-	grep "^100644 blob.*sparse_entry\$" actual
+	grep "^100644 blob.*sparse_entry\$" actual &&
+
+	git add --sparse --chmod=+x sparse_entry 2>stderr &&
+	test_must_be_empty stderr &&
+	test-tool read-cache --table >actual &&
+	grep "^100755 blob.*sparse_entry\$" actual
 '
 
 test_expect_success 'add obeys advice.updateSparsePath' '
-- 
gitgitgadget

