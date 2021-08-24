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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0735C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EE9613CD
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbhHXVzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbhHXVzk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D76C061796
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n5so21000321wro.12
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zu1GxVrVYR7vuo/zV/03WGPmO61qj4th90I6raORv0Q=;
        b=TZfbA5Y47VLqgSHVjnD11hGdQAGrUicBjiUSTo0q26M3nBUYTVIPSRvwv72EsVrr1E
         HLNtPBLPtdY42iRo1t2RPBgLNJK7JNXKpWbE8O3IjMmwptWOyfuc7OdINVMgioS4QWok
         OQNuFYV5Hmlmeh+q4y8/AwzEoPLEJ8U2Xz0/3dHVwL9FJVbdnfDSleAMy3l8/lY4h2WX
         jEqGp8e1sniJLujArAYXlcwfEYsbZKKOnZrWhT1O9Izjwcb3OjalTdvmInFOeVC9iS7D
         7f0GZk1OOF2m712eRdgrJHh0y37ZwLs3hzk+sx/mNMy4iNjG0jE14pH8M06zbqBfu3Kq
         YIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zu1GxVrVYR7vuo/zV/03WGPmO61qj4th90I6raORv0Q=;
        b=lPfcMhm2vYAcTr1bMYoNdPpFuDo4ZZ5K8ZrN8Hy2fB0tctdsrm0XsxDDNTBda7IMyP
         I2/f0LDPH+N4rP8t02bd9QLOKGnUksqsFRvrkPrShC51ws+LbHKEDLu0XNX95+6/LEDX
         /ECQoxI/mGCDhGKPFXznhi38gUsHoytwUvFTtRCiibg8YIAbD+86voFYKlYN6oo9GWDy
         YEVoFwz4gBgTNel5uep931eUiR6usU4pt5zD1D3MZxg4UEpY3c1USPbkxKCYPvc9hezJ
         FyZKg83A/eEG3aqO863F8YyLBIxAn/xHZTOHHcJOhfw1qDz+4EeqrM1MCPl0QPBTG6mA
         42ww==
X-Gm-Message-State: AOAM530xAN6JzjMcC3L4zGGRpKfhqnbfgBY3eFMq4q8OKBHU5zTfX6oc
        caL+BQpjxpFCzxQshpKuiL+y/0CEipE=
X-Google-Smtp-Source: ABdhPJwnFZWT9NDxAPc6B2H6vQzow3Iu7bXemmRXAMqSH+1xIzUCTV++6++8miyExElNVZQsUiTI3A==
X-Received: by 2002:a5d:534e:: with SMTP id t14mr21766741wrv.109.1629842094049;
        Tue, 24 Aug 2021 14:54:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm3222142wmq.13.2021.08.24.14.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:53 -0700 (PDT)
Message-Id: <7749a69a38faeceadc7a8735fb3d0edd359c954c.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:45 +0000
Subject: [PATCH 13/13] advice: update message to suggest '--sparse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 advice.c                       | 3 ++-
 t/t3602-rm-sparse-checkout.sh  | 2 +-
 t/t3705-add-sparse-checkout.sh | 2 +-
 t/t7002-mv-sparse-checkout.sh  | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 0b9c89c48ab..695693e5fa8 100644
--- a/advice.c
+++ b/advice.c
@@ -300,7 +300,8 @@ void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
 		fprintf(stderr, "%s\n", item->string);
 
 	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
-			  _("Disable or modify the sparsity rules if you intend"
+			  _("Disable or modify the sparsity rules or"
+			    " use the --sparse option if you intend"
 			    " to update such entries."));
 }
 
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 44f3e923164..22170feef62 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup' "
 	EOF
 
 	cat >sparse_hint <<-EOF &&
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: Disable or modify the sparsity rules or use the --sparse option if you intend to update such entries.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 99c27dd9fb7..0a8071370d3 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -43,7 +43,7 @@ test_expect_success 'setup' "
 	EOF
 
 	cat >sparse_hint <<-EOF &&
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: Disable or modify the sparsity rules or use the --sparse option if you intend to update such entries.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 517fd587fa8..b6e9ea0b2c8 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup' "
 	EOF
 
 	cat >sparse_hint <<-EOF
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: Disable or modify the sparsity rules or use the --sparse option if you intend to update such entries.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 "
-- 
gitgitgadget
