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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501A1C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E67D61989
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 14:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhC2OrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 10:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhC2Oqi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 10:46:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7ABC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 07:46:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j18so13156624wra.2
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kFXo8/B9gH6+lfulGSmXcWY9c0thMqZQeWCu0PJk1K0=;
        b=CpkHgpziCQ7xM26PRabRp6yW/gygbJIN1lI7T9ZeecqeuUBJ3yy0hFVzbfJZHb2HhH
         pv/bAxyoc2WQgK1irdSGTVSEM6/QTUUbX50BIdaAZoJaVWmTb5iHgWH3g53tMgvUbkwP
         A/IbYuoqyLiFIibcVoK7OsVxOf0gxRk2hliJGyRfYsdcQOmOtRsW9MlFVnj47gO2h0dm
         +0lZ5ln4Y34SFGJPPjRD9RXUEwJ9+FfCfLH7X5dtOJMBqDa/12wnf9bjXzMR2cI59IM3
         ZTgRpxouDSVSQ1L+D/TveYCXv6EvszK1ldu2njbPQLtuBOyA9541Y8yf0IQkL1B4Hvoj
         rJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kFXo8/B9gH6+lfulGSmXcWY9c0thMqZQeWCu0PJk1K0=;
        b=GubYifoCvsTp/uYoGqbxFeHCeyFRk09dwNoGxr73Szq6xVsHsG9H9zONLgrUFZOcPW
         mnbfLaYnrgKbOMozP+3ah9Nc1bMXjIdP/0nliC/Evo1VG98J38yWo1eMIA4vZWotNhN7
         MqahbGE6vKtcXRk01FcraiKyRHWNwfictRQwXAYrXDxBHJaZW80Jje4PEf4rTVteVeLb
         kAtTbIgnTWi6hK8kGN+R6SDs0/LY1f1mNqXJzKVNIN5U5A2VNSgaJ7v8K2MWfz3u23jS
         Z9ecTbGU7TmQAhY4HVAAePGFOoEwB2Ujy9t3TpeLML9588U2FGsL9uf8g3orFgrld4IN
         OktQ==
X-Gm-Message-State: AOAM533NcRPeW6DIFQsU16L52Fs6rP55vyxVzTGytjFeVtKc3Mz/OF0M
        VYNyZK+njpNJH2QQRcib6wjoVSikFzs=
X-Google-Smtp-Source: ABdhPJzeDt+Ln96QcjZ+uO3WBhCK8Zudg+fU761UaLM6Qp/8oeDLmsmAhTYnCvNSvm/AooK08yJiIQ==
X-Received: by 2002:adf:dc91:: with SMTP id r17mr29045498wrj.293.1617029196767;
        Mon, 29 Mar 2021 07:46:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13sm30957008wrp.31.2021.03.29.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:46:35 -0700 (PDT)
Message-Id: <pull.920.v4.git.1617029194872.gitgitgadget@gmail.com>
In-Reply-To: <pull.920.v3.git.1617014753305.gitgitgadget@gmail.com>
References: <pull.920.v3.git.1617014753305.gitgitgadget@gmail.com>
From:   "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 14:46:34 +0000
Subject: [PATCH v4] column, range-diff: downcase option description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Chinmoy <chinmoy12c@gmail.com>,
        Chinmoy Chakraborty <chinmoy12c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chinmoy Chakraborty <chinmoy12c@gmail.com>

It is customary not to begin the help text for each option given to
the parse-options API with a capital letter. Various (sub)commands'
option arrays don't follow the guideline provided by the parse_options
Documentation regarding the descriptions.

Downcase the first word of some option descriptions for "column"
and "range-diff".

Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
---
    column, range-diff: downcase option description
    
    It is customary not to begin the help text for each option given to the
    parse-options API with a capital letter.Various (sub)commands' option
    arrays don't follow the guideline provided by the parse_options
    Documentation regarding the descriptions.
    
    Downcase the first word of some option descriptions for "column" and
    "range-diff".
    
    Signed-off-by: Chinmoy Chakraborty chinmoy12c@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-920%2Fchinmoy12c%2Fissue_636-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-920/chinmoy12c/issue_636-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/920

Range-diff vs v3:

 1:  61be08b7dd73 ! 1:  286668a91cb9 column, range-diff: downcase option description
     @@ Commit message
          column, range-diff: downcase option description
      
          It is customary not to begin the help text for each option given to
     -    the parse-options API with a capital letter.Various (sub)commands'
     +    the parse-options API with a capital letter. Various (sub)commands'
          option arrays don't follow the guideline provided by the parse_options
          Documentation regarding the descriptions.
      


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
