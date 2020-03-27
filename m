Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEDCC2D0EC
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48773206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+0Q+kyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgC0AtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:25 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38891 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgC0AtS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:18 -0400
Received: by mail-wr1-f48.google.com with SMTP id s1so9468220wrv.5
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LfbkNunChhVGUGhHG02K+M4rVbdDfPpixKCG62qfiI4=;
        b=g+0Q+kyvL8rERE8c6XRJVZBvxNqx/Fi3bfqmieRtA61OXcsUozjGShT1/M1LXsAlwU
         i5Y3RvZBXtFVKReWErdLOjycRZWK0wottDm2Kbqts8wzbSxwgGafbDgYrRYEs2Hd5BWV
         uwG5ElAqnuQ1sb2XRf3ZpGh2dXMPdnnuHDMuYFcptaxkIwivwDyr01KyJQ453I2TYuNJ
         eZEGigdS5XbROw9oF9uWpdWBewwtGF3q4CXQT9+2HX6LJ7PUBDIK3SWsQxLNh47/gzJu
         UIgbyddrSw1dDAugGhlmKTK9Nag76WdhQILslWjszFFm39UABW1UDBh/wEvVlZeIqPM5
         HYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LfbkNunChhVGUGhHG02K+M4rVbdDfPpixKCG62qfiI4=;
        b=UmYzyFsErpx0NrBURmcMlWtNDamNzzhF0/AaUcDte09TakOoHm9V7yLWYIAImKa32X
         KWCz+leQ5KjlBHZcTxTBO+wcdV7YWLo3SCr2GBscVlpy1zgRUZ8K+AFhsNHZdDFqqbn4
         dz9JqIlvH+5NqY+LhjCXM50Rxud1Fj/eWIABfrCG94kaIAWudwtKAChLhYHo+vMNJMVP
         EUbM1ZnUfKA6gS/EcM4jFT8XWX+v3YBjtjZnc2Yf+fjqo/DfH3Ll2v7aqghkxvYEQw2C
         XAHe7tVPP1s10KlKNX0o7nPT1XlKdLojBGjI0ptqOqlEiFcj9oTEudMLcbtFUVsh1k6h
         J3lA==
X-Gm-Message-State: ANhLgQ0By4J089oF66cfveWbsEIs+lBDbQk8QAPeE8GO3ioMKT5ggdv2
        JP1vbHqrFh/I+Ap9JnA/6vKqHnDZ
X-Google-Smtp-Source: ADFU+vvu6yiXs2xUQiEBWtlPI4YqfpVckNpAFIMASnWimOE8wFWwkeXCV3/O7RWydudXsF3xorNPSw==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr12537858wru.419.1585270154792;
        Thu, 26 Mar 2020 17:49:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm6001955wrw.2.2020.03.26.17.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:14 -0700 (PDT)
Message-Id: <74e13ccee408757beb8ae3bb1dddea8d34ef56bb.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:58 +0000
Subject: [PATCH v3 15/18] unpack-trees: make sparse path messages sound like
 warnings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The messages for problems with sparse paths are phrased as errors that
cause the operation to abort, even though we are not making the
operation abort.  Reword the messages to make sense in their new
context.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 6 +++---
 unpack-trees.c                     | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ed5e9059969..afbde89e605 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -288,7 +288,7 @@ test_expect_success 'not-up-to-date does not block rest of sparsification' '
 
 	git -C repo sparse-checkout set deep/deeper1 2>err &&
 
-	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_i18ngrep "The following paths are not up to date" err &&
 	test_cmp expect repo/.git/info/sparse-checkout &&
 	check_files repo/deep a deeper1 deeper2 &&
 	check_files repo/deep/deeper1 a deepest &&
@@ -328,10 +328,10 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	echo dirty >dirty/folder1/a &&
 
 	git -C dirty sparse-checkout init 2>err &&
-	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
+	test_i18ngrep "warning.*The following paths are not up to date" err &&
 
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
-	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
+	test_i18ngrep "warning.*The following paths are not up to date" err &&
 	test_path_is_file dirty/folder1/a &&
 
 	git -C dirty sparse-checkout disable 2>err &&
diff --git a/unpack-trees.c b/unpack-trees.c
index f9a5626a670..484d30a53a7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -50,10 +50,10 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	"",
 
 	/* WARNING_SPARSE_NOT_UPTODATE_FILE */
-	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+	"Path '%s' not uptodate; will not remove from working tree.",
 
 	/* WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN */
-	"Working tree file '%s' would be overwritten by sparse checkout update.",
+	"Path '%s' already present; will not overwrite with sparse update.",
 };
 
 #define ERRORMSG(o,type) \
@@ -172,9 +172,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		_("Cannot update submodule:\n%s");
 
 	msgs[WARNING_SPARSE_NOT_UPTODATE_FILE] =
-		_("Cannot update sparse checkout: the following entries are not up to date:\n%s");
+		_("The following paths are not up to date and were left despite sparse patterns:\n%s");
 	msgs[WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN] =
-		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
+		_("The following paths were already present and thus not updated despite sparse patterns:\n%s");
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
-- 
gitgitgadget

