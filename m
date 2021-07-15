Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805CAC07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518A5613BA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 12:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhGONBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhGONBm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 09:01:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01844C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 05:58:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u1so7713299wrs.1
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yxB0SjzgvP1NzkpVGJMuh/ru3JWZ8TnH8OBwV3Z7zVU=;
        b=ZptUz7EwE9zVCz6OYyV7XXrneur0C3OCjIz09o9UjDpTYjLlTG866dYUsx7Qkwi56E
         wIA6baGTn8G6fp6rSRjcwoElvO3olHrgXy0EriGJtEqwInrvaV2YjK2E3RUPXDTMptED
         Vhc/ubrCfISxtHCnQ9clseWRzEXDwbj/byRz7Sc9coxie8b0/0BV3xqDaIEUkg1SAr1k
         xGK6XuHQ4JbZDpK+UWb+Mk6rtZc2gLSRo5IytbQqd3OuKyZyDQWwqDgyG/I+hR632bBU
         OikuCn3GBWuDUMlSpYSpIhX3CiWXXOa+PxV1rezmIZ1MYXNaRHiXVTS1rWbXqIbZ+HUZ
         Y0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yxB0SjzgvP1NzkpVGJMuh/ru3JWZ8TnH8OBwV3Z7zVU=;
        b=k45oIcouHfwRKuNrQ4rpK+5Amh2t1HjkvsLUuPoo/MJXoM9hwkrs00IV9V+gw3cujW
         SFSzmO6XGf7gcqHPKzFqUSfk5LK1Ey4iUxeNzR539/CcszqUrif4I55MuN+rZ4JkFutS
         9/SV099f8NBOF0bwQO0pOOrDnylElD1C8qy8yf9u0W+uFhulfA5koDczt1G87rkvE2eE
         2czkINolIbHeUgmVRSlyep1+9rGW42uZLDlYzDbdOnd11oVhp27ItRL0fGibGlPGLuX0
         CLZdRMZDAxQnTOQSWwJg6oTkUZUVUj9EXJIRepxlTx4BobFUrhriffFu8uZJWBjcs0ng
         BqSA==
X-Gm-Message-State: AOAM532X7dDxhtfM9qoOEYu87S8GxIwJfEW82m387b1XsTJN7dhooG/c
        1ZXxzqMqKpJRCG4SHo6F1ZKCt7UcH/M=
X-Google-Smtp-Source: ABdhPJxOK6NVxjpkCne+ULbprMOz4vQ+uXP77U2MFT4Z3ECLqG8eOqGH/gl982ZErxfR/vBwSAZOdw==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr5462113wrq.210.1626353926613;
        Thu, 15 Jul 2021 05:58:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13sm6348136wrp.80.2021.07.15.05.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 05:58:46 -0700 (PDT)
Message-Id: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 12:58:44 +0000
Subject: [PATCH] parse-options: don't complete option aliases by default
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
        Philippe Blain <levraiphilippeblain@gmail.com>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-996%2Fphil-blain%2Fclone-recurse-completion-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-996/phil-blain/clone-recurse-completion-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/996

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
