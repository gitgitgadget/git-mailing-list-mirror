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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A83DC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 10:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524856196C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 10:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhC1KQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1KQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 06:16:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E761C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 03:16:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d191so5121055wmd.2
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EssuilH+zUMe0VyEIVnUWERlDaZ2QkcokXyO95KJ2Vk=;
        b=AP/X2+GT7sO3cn8lrw7ffxldUJCJVguousrcPXkzfkzv/WQQHZwiXtx8ZK6qwp7DzE
         p8JB7qjWJ1BRqZVt8R28EXJbE4h5eyWltJuF91KiInBW4wWfIZS+aOvIqi3EjLt1BaYu
         OPmwOM2AEhn44WrzL2uSz3FuA4a2tYmXHQIKKryxIt3xZNkEwqoW27nvGEnqy7vslYD0
         7ZAy5ADmcEaMUlQqvD/i5FdiKG8zvgwh3lOe7p5uL2xJ005UdrrYcHyoDLecrZWBhcfh
         4yFI5LLTWbiA5KewCewzCyUfC/CGSH9JMngQVLwPb4uM3xEY4xtNp5PfE6JGDWqFIF9b
         H5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EssuilH+zUMe0VyEIVnUWERlDaZ2QkcokXyO95KJ2Vk=;
        b=NxJX/7jDIec8CpYU0J5IPrbv9MTx0uQQ4tfRj4Oi1+C5egH3qr+vQULmjQxV5EFrJ0
         MI12aIEBzQ7sDqMqL0RS/lUeWwXj2SMsSjgeH1AGhucwbtyE9JjsxKbrj7PgCj8O4IqE
         RMo9jivIvsHc16pH8+RyXWNxz2U/gSXA2RQ1auGUECoML9gQ7n9VH0xOxz72FuwGfeSl
         7B4hqpMuuz/kz+hEiO1Ay8UDKH9uhviSuADJWaV2J2tCYwkTl9GB4BsBGhNowo3+PnV+
         Mkj4MMA3P34ewqP3Ec4rIIdbVyInChv33UeodFYwS9vIZDeVN5mp99dbfFS7NDOHnwN1
         YAwQ==
X-Gm-Message-State: AOAM531/dRS5Vlg3V24wkrap7LmEPf+fquCV1qDiRJDzjBfJ+cfj/8rw
        JjBghpT7bjH9+yeORhotkZyYqpoI/3w=
X-Google-Smtp-Source: ABdhPJzNW/bUiK99/khvVBiJDtcIokbNowECVuLxBdP8608FvbsBq2YdunvkKCGSXTxkR/qLXjdMyg==
X-Received: by 2002:a05:600c:3796:: with SMTP id o22mr12659552wmr.139.1616926583836;
        Sun, 28 Mar 2021 03:16:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm22744144wrw.69.2021.03.28.03.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 03:16:23 -0700 (PDT)
Message-Id: <pull.920.v2.git.1616926582735.gitgitgadget@gmail.com>
In-Reply-To: <pull.920.git.1616913298624.gitgitgadget@gmail.com>
References: <pull.920.git.1616913298624.gitgitgadget@gmail.com>
From:   "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Mar 2021 10:16:22 +0000
Subject: [PATCH v2] Documentation: make (sub)command options conform to TD of
 option parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Chinmoy <chinmoy12c@gmail.com>,
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
    Documentation: make (sub)command options conform to TD of option parsing
    
    The Git suite option parsing API's Technical Documentation suggests this
    about the option descriptions of a (sub)command:
    
    description is a short string to describe the effect of the option. It
    shall begin with a lower-case letter and a full stop (.) shall be
    omitted at the end.
    
    Various (sub)commands' option arrays don't follow the guideline provided
    by the parse_options Documentation regarding the descriptions.
    
    Signed-off-by: Chinmoy Chakraborty chinmoy12c@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-920%2Fchinmoy12c%2Fissue_636-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-920/chinmoy12c/issue_636-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/920

Range-diff vs v1:

 1:  817b25caa931 ! 1:  b032c2fa5b28 Documentation: amended usages of various (sub)commands
     @@ Metadata
      Author: Chinmoy Chakraborty <chinmoy12c@gmail.com>
      
       ## Commit message ##
     -    Documentation: amended usages of various (sub)commands
     +    Documentation: make (sub)command options conform to TD of option parsing
      
          The Git suite option parsing API's Technical Documentation suggests this
          about the option descriptions of a (sub)command:


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
