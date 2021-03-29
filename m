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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FA3C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0173061935
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhC2Kq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhC2Kp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 06:45:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB84C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:45:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j9so10616414wrx.12
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kq7ggP9kHdt9VeVxE4+K2V+nhxA/W51SMgE2zsHcTzo=;
        b=iQlQ6ccou+f+U/ZwA/0pzvriiBUBSNyzE8/toa3HMWnqYKzcOH5+uwuJrPouumfS+S
         JV4kI8jd/hRICof9jdpLkLkjNSBane10HHxe6qvsipk44vPiakUjN1woQ7n0sfi/S465
         3h7RgcbhHfhUMubE6bqebgj/9HmkhKPbn6FDnFAOI2Zm0+3Awacu6U6r+OiiEuBkd70C
         umpWXoWLe3RsqD73awb1fHynzpbLdcu+eKygDNr7ZKF8AAmpdOKZYgRFwsYsbhMAsjoo
         ALgPYmZsK8QYIkmPsx0/JQSbOi7MGXWjglroB8EWRP3iibi15vhS6GnIVghXuOWtVfS9
         /u9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kq7ggP9kHdt9VeVxE4+K2V+nhxA/W51SMgE2zsHcTzo=;
        b=Kge90zTv8hR2wMnWpUmPkk7ExRX2uydITxI4YOzHVCUhTB9X8bzh7F7/hf0pI0K/ds
         ln5iR25U08vu4cZ7i2qFzgi+9XK7pqnrWt6atwz8Mto2amXdj4BsCBn+neWfBZJB4ryd
         lmQckwjZG/i3RQFv2O+rojU9BP0mTLdBc47hdDxX78YzvWiU0waNUgqDdioi0MsRAiSA
         sohU7/EEknMlMb/ZlzC+1ZpH5NjnrdDs8A8ueJeQZQzJLhhnJxzeOPvRdXkFbQkZpJJR
         GcDpUPnDN3rsvHykKE1Spl8CYSbbQ/Lj6Ctny/fa58U0KxKvEKQUa8q8qTZnMXYtintz
         FH7g==
X-Gm-Message-State: AOAM530kD23J8lPHCDU0EU11vQJrIFFQ37sCl3RXwBmwLOcReL94MeVf
        N9gac7lk3XJRJ3yKLqYHSHRyx+76Zcc=
X-Google-Smtp-Source: ABdhPJy+6/hLrfkbXIOB4M+5uG6IlMzGOZ27NYWXveSzPWoHIntOi0gluIZerSOnbtRkRny7VuS1xw==
X-Received: by 2002:a5d:4743:: with SMTP id o3mr28182423wrs.108.1617014754840;
        Mon, 29 Mar 2021 03:45:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13sm29869032wrp.31.2021.03.29.03.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:45:54 -0700 (PDT)
Message-Id: <pull.920.v3.git.1617014753305.gitgitgadget@gmail.com>
In-Reply-To: <pull.920.v2.git.1616926582735.gitgitgadget@gmail.com>
References: <pull.920.v2.git.1616926582735.gitgitgadget@gmail.com>
From:   "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 10:45:52 +0000
Subject: [PATCH v3] column, range-diff: downcase option description
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

It is customary not to begin the help text for each option given to
the parse-options API with a capital letter.Various (sub)commands'
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-920%2Fchinmoy12c%2Fissue_636-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-920/chinmoy12c/issue_636-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/920

Range-diff vs v2:

 1:  b032c2fa5b28 ! 1:  61be08b7dd73 Documentation: make (sub)command options conform to TD of option parsing
     @@ Metadata
      Author: Chinmoy Chakraborty <chinmoy12c@gmail.com>
      
       ## Commit message ##
     -    Documentation: make (sub)command options conform to TD of option parsing
     +    column, range-diff: downcase option description
      
     -    The Git suite option parsing API's Technical Documentation suggests this
     -    about the option descriptions of a (sub)command:
     +    It is customary not to begin the help text for each option given to
     +    the parse-options API with a capital letter.Various (sub)commands'
     +    option arrays don't follow the guideline provided by the parse_options
     +    Documentation regarding the descriptions.
      
     -    `description` is a short string to describe the effect of the option.
     -    It shall begin with a lower-case letter and a full stop (.) shall be
     -    omitted at the end.
     -
     -    Various (sub)commands' option arrays don't follow the guideline provided
     -    by the parse_options Documentation regarding the descriptions.
     +    Downcase the first word of some option descriptions for "column"
     +    and "range-diff".
      
          Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
      


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
