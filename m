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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D7BC433FE
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BD361159
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhITXkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbhITXih (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:38:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3F4C0EFE46
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w17so23897363wrv.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Dn9LtMSl7G8Dsx58rCmmkRzvnmEh9XKceWK9GqPW90=;
        b=SUVdnWj9rTtFW0CJPwyFT4av6IGDtjEvkey/hvfefAoJ4RkDIdT4zAKC+0HQF47cC7
         PqTaKfLrVZadkIUZlH0ooEwdRQxagktugJNdwikcgD+qyyOU34QSJI3M4UQx98dtZw1P
         i0VMBgRMPZDk//lSBQ9yv3dP6tudvwk54qsi0AoXZLshLgPxJYX9YoolK1m3QCRGsRNf
         hbRtGgnWK04RNmp/N+L/NMKNYa4QIlyLpIKVoet9iFt39oILaOi1M73a/xCLfTTx2euS
         /5ZqnmBU90WlRiJvXGGpxdfaqFA6c8+2XdsEmlc5lUOJM1HG6evmIPdIQ9W48okWTYMq
         y//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6Dn9LtMSl7G8Dsx58rCmmkRzvnmEh9XKceWK9GqPW90=;
        b=Andq4AhNwAVgDrthXZxiUsI/jeuWSal0PoxBPKp4nyAoOxDGywPBhlaJrZ1EEunMhz
         aTxHKWTfGRekpC2AA6w4AziDJEYX3+opuZAkGzFA9iBGWyyi0fxsmQkLa8Eh0hsA9m/2
         SD4tuTXN8DbpI5FzRlduH0NQVFLq13QUduiFCp+SXgqVWotUXfNBybGDjxtxC61KJJtI
         QnqkwZDw7bj4xcJ/k9iQTljpVfQXOoaO5NOjwyBYX0jl39f/3gL7McSpDjiIEQyoDywq
         nGRIf83zNKs1jVu9bQ4lfHEbmGWQTxyICIxOlSRxA87OWhxbK6azmo4VBdWoXw3wqX7K
         g4zg==
X-Gm-Message-State: AOAM530STBtPL2jgF3mIlDB78ZLzKeAo8SEK9cFx1BLvwuYTGDyizmUY
        3RrF+Qk+L1HpzD4qrcL/H5VulH/LGkk=
X-Google-Smtp-Source: ABdhPJxo0caaeYHuS9KJQfCmffWDZREgqg87zzR3YLzjoINVaLBYNKbb+7VA+cd1ilC+PDWP+o1ucw==
X-Received: by 2002:a05:6000:1865:: with SMTP id d5mr20911045wri.248.1632159948045;
        Mon, 20 Sep 2021 10:45:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm16476109wrt.12.2021.09.20.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:47 -0700 (PDT)
Message-Id: <79a3518dc15cbf07991535a779b141e3ccefc6f4.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:37 +0000
Subject: [PATCH v3 14/14] advice: update message to suggest '--sparse'
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
 advice.c                       | 11 ++++++-----
 t/t3602-rm-sparse-checkout.sh  |  9 ++++++---
 t/t3705-add-sparse-checkout.sh |  9 ++++++---
 t/t7002-mv-sparse-checkout.sh  |  9 ++++++---
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/advice.c b/advice.c
index 0b9c89c48ab..713fff49ee3 100644
--- a/advice.c
+++ b/advice.c
@@ -293,15 +293,16 @@ void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
 	if (!pathspec_list->nr)
 		return;
 
-	fprintf(stderr, _("The following pathspecs didn't match any"
-			  " eligible path, but they do match index\n"
-			  "entries outside the current sparse checkout:\n"));
+	fprintf(stderr, _("The following paths and/or pathspecs matched paths that exist\n"
+			  "outside of your sparse-checkout definition, so will not be\n"
+			  "updated in the index:\n"));
 	for_each_string_list_item(item, pathspec_list)
 		fprintf(stderr, "%s\n", item->string);
 
 	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
-			  _("Disable or modify the sparsity rules if you intend"
-			    " to update such entries."));
+			  _("If you intend to update such entries, try one of the following:\n"
+			    "* Use the --sparse option.\n"
+			    "* Disable or modify the sparsity rules."));
 }
 
 void detach_advice(const char *new_name)
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 5f92b60a56a..ecce497a9ca 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -11,12 +11,15 @@ test_expect_success 'setup' "
 	git commit -m files &&
 
 	cat >sparse_error_header <<-EOF &&
-	The following pathspecs didn't match any eligible path, but they do match index
-	entries outside the current sparse checkout:
+	The following paths and/or pathspecs matched paths that exist
+	outside of your sparse-checkout definition, so will not be
+	updated in the index:
 	EOF
 
 	cat >sparse_hint <<-EOF &&
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: If you intend to update such entries, try one of the following:
+	hint: * Use the --sparse option.
+	hint: * Disable or modify the sparsity rules.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 10969efc23e..754b06a9663 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -44,12 +44,15 @@ test_sparse_entry_unstaged () {
 
 test_expect_success 'setup' "
 	cat >sparse_error_header <<-EOF &&
-	The following pathspecs didn't match any eligible path, but they do match index
-	entries outside the current sparse checkout:
+	The following paths and/or pathspecs matched paths that exist
+	outside of your sparse-checkout definition, so will not be
+	updated in the index:
 	EOF
 
 	cat >sparse_hint <<-EOF &&
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: If you intend to update such entries, try one of the following:
+	hint: * Use the --sparse option.
+	hint: * Disable or modify the sparsity rules.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 07dbfeb6d17..545748949aa 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -11,12 +11,15 @@ test_expect_success 'setup' "
 	git commit -m files &&
 
 	cat >sparse_error_header <<-EOF &&
-	The following pathspecs didn't match any eligible path, but they do match index
-	entries outside the current sparse checkout:
+	The following paths and/or pathspecs matched paths that exist
+	outside of your sparse-checkout definition, so will not be
+	updated in the index:
 	EOF
 
 	cat >sparse_hint <<-EOF
-	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: If you intend to update such entries, try one of the following:
+	hint: * Use the --sparse option.
+	hint: * Disable or modify the sparsity rules.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
 "
-- 
gitgitgadget
