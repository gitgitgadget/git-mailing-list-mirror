Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A7DC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC6B610CE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhILNZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhILNY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73F0C061760
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u15so4212244wru.6
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+y2AAdAhEyZsmUIO9HanjQPgDeAly1FBHzUsSpXC6ic=;
        b=ImJa1iW9uPhRAhK8JOxl0pQ+YS8jO5LpJ7zAmOJ3wV6GSsKzxUYL0aejMyIl7yy2Z4
         9gBJjmfHfvDMve+fWTSPznV2XqvAOgL9ceTiJmOwaQicd7QrZ/FjW9FypONAiBN2mvqv
         bnvHdkgAC78LRiC+Cu5xwfsdqrTVqutPpEMi/BvmLtMjT4dbL8WyDHlGe6RvHOrt29SS
         YIrG+LBNEg1k5Lt7/8xsohkBUbcffMG672T5Gsxw/3+PV0oFoKoJarUFaluqzNmiR1ju
         DhYE+FHQW51ZMbtKNH1r2YTj875LNE2FWdOT75pUW7sabb0KKbMKyWfuY99wpsynmAOU
         YIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+y2AAdAhEyZsmUIO9HanjQPgDeAly1FBHzUsSpXC6ic=;
        b=vCmhkENOVS2jUBxHh7zGHOqF5NCp8kSx61d/6js6kYs4+iyC0JrKgOYKRoF7wF3kdT
         e8neh9uky5kBVpEiEeI3casIdYHEjjpvy2zyOw5NitBt47imH+7wVo0mYX95wT6pEwpS
         msBOGNkaRT8bd8tlJgLcgSqc3sCsp4Z05RNZe1zA7hBz64h2Ksuk4eEv0RlcrzPDeVj/
         TT1Lynna+Ly0aO0tHCulKz0+iuY3o0n/3q8olFkkBmu2hTODAR+CSnLVkKxZe8UaUMiq
         MPtaDuzDeVzWmhybVu/YhJ/axaaM32vOo24y6xOgXOIl4Rg6/MpdELISMX4PkH3A7JG3
         o24Q==
X-Gm-Message-State: AOAM531SF0laaKdfbvn+1GvBnGux/fnAwWfgNlvVil7mSGp2VVEcncGq
        KDhyP22ijtFV8IHWMK6ri0Asf1U1jbg=
X-Google-Smtp-Source: ABdhPJyUhkuTRYteDxS99mId11CwpodBQmwOFerz6ItRxISlUZoDqzRUILm04ivlKrVXgRARq0zVkQ==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr7327786wrr.278.1631453020335;
        Sun, 12 Sep 2021 06:23:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm4418605wrr.69.2021.09.12.06.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:40 -0700 (PDT)
Message-Id: <f2abc387822378e02d0b221baf9a09ac91d44d7d.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:30 +0000
Subject: [PATCH v2 14/14] advice: update message to suggest '--sparse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous changes modified the behavior of 'git add', 'git rm', and
'git mv' to not adjust paths outside the sparse-checkout cone, even if
they exist in the working tree and their cache entries lack the
SKIP_WORKTREE bit. The intention is to warn users that they are doing
something potentially dangerous. The '--sparse' option was added to each
command to allow careful users the same ability they had before.

To improve the discoverability of this new functionality, add a message
to advice.updateSparsePath that mentions the existence of the option.

The previous set of changes also modified the purpose of this message to
include possibly a list of paths instead of only a list of pathspecs.
Make the warning message more clear about this new behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 advice.c                       | 10 ++++++----
 t/t3602-rm-sparse-checkout.sh  |  6 +++---
 t/t3705-add-sparse-checkout.sh |  6 +++---
 t/t7002-mv-sparse-checkout.sh  |  6 +++---
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/advice.c b/advice.c
index 0b9c89c48ab..0deaf111795 100644
--- a/advice.c
+++ b/advice.c
@@ -293,14 +293,16 @@ void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
 	if (!pathspec_list->nr)
 		return;
 
-	fprintf(stderr, _("The following pathspecs didn't match any"
-			  " eligible path, but they do match index\n"
-			  "entries outside the current sparse checkout:\n"));
+	fprintf(stderr, _("The following paths and/or pathspecs matched "
+			  "paths that exist outside of your\n"
+			  "sparse-checkout definition, so will not be "
+			  "updated in the index:\n"));
 	for_each_string_list_item(item, pathspec_list)
 		fprintf(stderr, "%s\n", item->string);
 
 	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
-			  _("Disable or modify the sparsity rules if you intend"
+			  _("Disable or modify the sparsity rules or"
+			    " use the --sparse option if you intend"
 			    " to update such entries."));
 }
 
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 5f92b60a56a..712ddae2b15 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -11,12 +11,12 @@ test_expect_success 'setup' "
 	git commit -m files &&
 
 	cat >sparse_error_header <<-EOF &&
-	The following pathspecs didn't match any eligible path, but they do match index
-	entries outside the current sparse checkout:
+	The following paths and/or pathspecs matched paths that exist outside of your
+	sparse-checkout definition, so will not be updated in the index:
 	EOF
 
 	cat >sparse_hint <<-EOF &&
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: Disable or modify the sparsity rules or use the --sparse option if you intend to update such entries.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index cf2ccb87cf2..d51c96f8d72 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -44,12 +44,12 @@ test_sparse_entry_unstaged () {
 
 test_expect_success 'setup' "
 	cat >sparse_error_header <<-EOF &&
-	The following pathspecs didn't match any eligible path, but they do match index
-	entries outside the current sparse checkout:
+	The following paths and/or pathspecs matched paths that exist outside of your
+	sparse-checkout definition, so will not be updated in the index:
 	EOF
 
 	cat >sparse_hint <<-EOF &&
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: Disable or modify the sparsity rules or use the --sparse option if you intend to update such entries.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 07dbfeb6d17..3db7ddaba9a 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -11,12 +11,12 @@ test_expect_success 'setup' "
 	git commit -m files &&
 
 	cat >sparse_error_header <<-EOF &&
-	The following pathspecs didn't match any eligible path, but they do match index
-	entries outside the current sparse checkout:
+	The following paths and/or pathspecs matched paths that exist outside of your
+	sparse-checkout definition, so will not be updated in the index:
 	EOF
 
 	cat >sparse_hint <<-EOF
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: Disable or modify the sparsity rules or use the --sparse option if you intend to update such entries.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 "
-- 
gitgitgadget
