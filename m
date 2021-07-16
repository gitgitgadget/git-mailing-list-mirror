Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA0C636C9
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 01:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 539A4613E0
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 01:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhGPB6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 21:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhGPB6m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 21:58:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFFFC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 18:55:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d12so10119231wre.13
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OwR31icCmyqWgLwjoKVduwMgc6aTdhxG4P90tJoBODY=;
        b=jy/VtRbQ86/JqO9JbXGqAwrkL4MGBmPvJ5DTrnJcZ0baQimZDkAUBPfxGUkzweHviw
         Rb4Vd/YPk68tewCrLP1qvHQfc/Ijy38FcNUNAJZVLanu2rQCn91gbs4GpVH0pEBC63cu
         pyYTMOSvLcgmBWbWlWDyugf5UxUWb4LJf+VDqFrQmlFW2EymdsnDdD2k2czcseL5W8sH
         DqryPM/JPN1tjFNS249ya+wSyD7eFZtiG8/EAAZnQCRWaXfpj53sdp10g5SuI5dGnv8W
         8x6Fw40giWITW9Mw0S/o0iIzCxdqLx3qFGusMVmgPhi6JxLRUPKpPZoB7izwj0xSWGGo
         gUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OwR31icCmyqWgLwjoKVduwMgc6aTdhxG4P90tJoBODY=;
        b=RWgBOpotUpprLLCriQ5zQlpObE8J/DWf84whVu649niDpn3vlTalTwdzIljnB6VpAi
         sG2nMMld9pIwCiwwb/EQEhnU0toBiwFV+Y0j0RsvlLGcDPI5Hy1egbqA2iwqBml+VAzi
         XVYdmRdXNC514eSETLzfP5D4g6m/XPFiHnOGzZxv+y/NUkzyTIogcsyy7iU7jvtBwhr3
         8y+y4oLeU+Z/ZU7FkN+UKPn2X5h14+gKIzYpZFl/sXr8Ci2ZIm8IM+pTG36bgMOHlDxu
         6ARiqcU4BWayRDGlJklBenUusw8p9tU4evDxBNJqjYNp2mKprXX2Y+hUe9KCOmG+t9pa
         vd9w==
X-Gm-Message-State: AOAM531yqyHKL3A0GfiytkAMaO7ii7XHnfFbGcUtmstzj+Da+mFt5/YO
        MZ5t5p5XLJykM87/hXEfOgsFXjVAYYc=
X-Google-Smtp-Source: ABdhPJxj+jNLmN/0KzcNYaWaaxbRDlSS6O8cu+IM9gJZtZsT6kyMDuNv/jmFYj4/V+22fPmIC4zd3A==
X-Received: by 2002:a5d:5141:: with SMTP id u1mr9139523wrt.193.1626400545221;
        Thu, 15 Jul 2021 18:55:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm6451042wma.48.2021.07.15.18.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 18:55:44 -0700 (PDT)
Message-Id: <pull.996.v2.git.1626400544014.gitgitgadget@gmail.com>
In-Reply-To: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
References: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 01:55:43 +0000
Subject: [PATCH v2] parse-options: don't complete option aliases by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Brandon Williams <bwilliamseng@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 'OPT_ALIAS' was created in 5c387428f1 (parse-options: don't emit
"ambiguous option" for aliases, 2019-04-29), 'git clone
--git-completion-helper', which is used by the Bash completion script to
list options accepted by clone (via '__gitcomp_builtin'), lists both
'--recurse-submodules' and its alias '--recursive', which was not the
case before since '--recursive' had the PARSE_OPT_HIDDEN flag set, and
options with this flag are skipped by 'parse-options.c::show_gitcomp',
which implements 'git <cmd> --git-completion-helper'.

This means that typing 'git clone --recurs<TAB>' will yield both
'--recurse-submodules' and '--recursive', which is not ideal since both
do the same thing, and so the completion should directly complete the
canonical option.

At the point where 'show_gitcomp' is called in 'parse_options_step',
'preprocess_options' was already called in 'parse_options', so any
aliases are now copies of the original options with a modified help text
indicating they are aliases.

Helpfully, since 64cc539fd2 (parse-options: don't leak alias help
messages, 2021-03-21) these copies have the PARSE_OPT_FROM_ALIAS flag
set, so check that flag early in 'show_gitcomp' and do not print them,
unless the user explicitely requested that *all* completion be shown (by
setting 'GIT_COMPLETION_SHOW_ALL'). After all, if we want to encourage
the use of '--recurse-submodules' over '--recursive', we'd better just
suggest the former.

The only other options alias is 'log' and friends' '--mailmap', which is
an alias for '--use-mailmap', but the Bash completion helpers for these
commands do not use '__gitcomp_builtin', and thus are unnaffected by
this change.

Test the new behaviour in t9902-completion.sh. As a side effect, this
also tests the correct behaviour of GIT_COMPLETION_SHOW_ALL, which was
not tested before. Note that since '__gitcomp_builtin' caches the
options it shows, we need to re-source the completion script to clear
that cache for the second test.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    parse-options: don't complete option aliases by default
    
    Changes since v1:
    
     * Added a paragraph to the commit message to clarify that the goal of
       this patch is to have the completion show only the canonical option
       and not its alias.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-996%2Fphil-blain%2Fclone-recurse-completion-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-996/phil-blain/clone-recurse-completion-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/996

Range-diff vs v1:

 1:  091a59323b7 ! 1:  9ae43e17e0c parse-options: don't complete option aliases by default
     @@ Commit message
          options with this flag are skipped by 'parse-options.c::show_gitcomp',
          which implements 'git <cmd> --git-completion-helper'.
      
     +    This means that typing 'git clone --recurs<TAB>' will yield both
     +    '--recurse-submodules' and '--recursive', which is not ideal since both
     +    do the same thing, and so the completion should directly complete the
     +    canonical option.
     +
          At the point where 'show_gitcomp' is called in 'parse_options_step',
          'preprocess_options' was already called in 'parse_options', so any
          aliases are now copies of the original options with a modified help text


 parse-options.c       |  2 +-
 t/t9902-completion.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index e6f56768ca5..2abff136a17 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -585,7 +585,7 @@ static int show_gitcomp(const struct option *opts, int show_all)
 		if (!opts->long_name)
 			continue;
 		if (!show_all &&
-			(opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE)))
+			(opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE | PARSE_OPT_FROM_ALIAS)))
 			continue;
 
 		switch (opts->type) {
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cb057ef1613..11573936d58 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2404,6 +2404,19 @@ test_expect_success 'sourcing the completion script clears cached --options' '
 	verbose test -z "$__gitcomp_builtin_notes_edit"
 '
 
+test_expect_success 'option aliases are not shown by default' '
+	test_completion "git clone --recurs" "--recurse-submodules "
+'
+
+test_expect_success 'option aliases are shown with GIT_COMPLETION_SHOW_ALL' '
+	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+	GIT_COMPLETION_SHOW_ALL=1 && export GIT_COMPLETION_SHOW_ALL &&
+	test_completion "git clone --recurs" <<-\EOF
+	--recurse-submodules Z
+	--recursive Z
+	EOF
+'
+
 test_expect_success '__git_complete' '
 	unset -f __git_wrap__git_main &&
 

base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
-- 
gitgitgadget
