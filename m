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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78502C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BABF61924
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhC1GfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 02:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhC1GfB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 02:35:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EB2C061762
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 23:35:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so6914639wmd.4
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 23:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=7RElJ4AdSvAUR6FYwpxIcE6M0X0aJjnK9HjCuIeqpB4=;
        b=kK/GUc+/tNqZQdYw9515wvLTSwHWys0M99jkCuYUm3vTnGNfqYmsnlHAvIerxu5lu1
         AUMB5YkTqMCZXOWwh0qUCjAd+jQvB5kxm/4De9mpdbZubh2+Mb/wVUr8vZxxJQrLhDCx
         FPoMeLRczYgAC4WPLXVCIWCvzDVyci+byZeYupHWaXeKltE5JZFK40Fz75K61qOjjWrL
         S5S8/isiN9xsg18NCrKtjK7NDZI/lig7xTGdIg1cdHoAa73Ce6/etr55NZmUjk+iU9X0
         kpP9d/QHNqoWFk1NmWp27WgLZD3qR5YMrS4mpbs53QRjQFaXcaHd7HyuySSma83DLVEU
         aTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7RElJ4AdSvAUR6FYwpxIcE6M0X0aJjnK9HjCuIeqpB4=;
        b=swlgah9tmP9zPjpmdZQ7wftIgIVTmTcw/+0TT0NsMzKtdFffaYauuOwmukHFe3FeeL
         uJ9kw9sJf7t2gX/5tEMM54mYMKhA57EmK92RMViGMlKUpaoyJ36DnaaOu8dYSzpq3yQt
         O4O4mT9I2aEVUxZxuzlfcDnfVP/2vKw2I3OtTcGciSckE+/W9SjYUPPPNdzBQ92Rz57o
         R3rYcDivhHpQDjX+bUGA1GzuS714OLS4awQXV/46+ac2jur98KlckbnRAk4xMf6wobHB
         WgyiWQ1HfTSsxAMzI5rqlgarjmIibnxKsIqlO1OdC5Y+d0PicX2t/t+/HyeaPU3Db9V6
         6j/A==
X-Gm-Message-State: AOAM531176JPra7LrHKX7LBmUOyrfk4QHIzLLyLcAROUQkfCGCVvJY2U
        A7dPfTDeLcpYQkls8NQGbNZfRl91zZs=
X-Google-Smtp-Source: ABdhPJx9gfhTtq2G/GJI6saORiegJO9pLjFPWW8J6rqCPdhH2cE36VW4BcE7J/SsfG31C/OR7MiCtQ==
X-Received: by 2002:a05:600c:2f08:: with SMTP id r8mr19851337wmn.95.1616913299379;
        Sat, 27 Mar 2021 23:34:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y205sm23354949wmc.18.2021.03.27.23.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 23:34:59 -0700 (PDT)
Message-Id: <pull.920.git.1616913298624.gitgitgadget@gmail.com>
From:   "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Mar 2021 06:34:58 +0000
Subject: [PATCH] Documentation: amended usages of various (sub)commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chinmoy <chinmoy12c@gmail.com>,
        Chinmoy Chakraborty <chinmoy12c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chinmoy Chakraborty <chinmoy12c@gmail.com>

The Git suite option parsing API's Technical Documentation suggests this
about the option descriptions of a (sub)command:

`description` is a short string to describe the effect of the option.
It shall begin with a lower-case letter and a full stop (.) shall be
omitted at the end.

Various (sub)commands' option arrays don't follow the guideline provided
by the parse_options Documentation regarding the descriptions.

Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
---
    Documentation: amended usages of various (sub)commands
    
    The Git suite option parsing API's Technical Documentation suggests this
    about the option descriptions of a (sub)command:
    
    description is a short string to describe the effect of the option. It
    shall begin with a lower-case letter and a full stop (.) shall be
    omitted at the end.
    
    Various (sub)commands' option arrays don't follow the guideline provided
    by the parse_options Documentation regarding the descriptions.
    
    Signed-off-by: Chinmoy Chakraborty chinmoy12c@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-920%2Fchinmoy12c%2Fissue_636-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-920/chinmoy12c/issue_636-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/920

 builtin/column.c     | 8 ++++----
 builtin/range-diff.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/column.c b/builtin/column.c
index e815e148aa18..40d4b3bee2dd 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -27,10 +27,10 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "command", &real_command, N_("name"), N_("lookup config vars")),
 		OPT_COLUMN(0, "mode", &colopts, N_("layout to use")),
 		OPT_INTEGER(0, "raw-mode", &colopts, N_("layout to use")),
-		OPT_INTEGER(0, "width", &copts.width, N_("Maximum width")),
-		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("Padding space on left border")),
-		OPT_INTEGER(0, "nl", &copts.nl, N_("Padding space on right border")),
-		OPT_INTEGER(0, "padding", &copts.padding, N_("Padding space between columns")),
+		OPT_INTEGER(0, "width", &copts.width, N_("maximum width")),
+		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("padding space on left border")),
+		OPT_INTEGER(0, "nl", &copts.nl, N_("padding space on right border")),
+		OPT_INTEGER(0, "padding", &copts.padding, N_("padding space between columns")),
 		OPT_END()
 	};
 
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 78bc9fa77062..50318849d657 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	struct option range_diff_options[] = {
 		OPT_INTEGER(0, "creation-factor",
 			    &range_diff_opts.creation_factor,
-			    N_("Percentage by which creation is weighted")),
+			    N_("percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
 		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,

base-commit: 84d06cdc06389ae7c462434cb7b1db0980f63860
-- 
gitgitgadget
