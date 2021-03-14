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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69AFC4332D
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA7664EB7
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhCNSsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 14:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbhCNSrt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 14:47:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75177C061765
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 12so1834761wmf.5
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZvTWExSIs1Egi3lbG0ImgK5994pq9tE5fF5dSYpfllM=;
        b=TJVZLyQhrjgHY5NB1XuagRl0LExE7UeJ7EnqacbPLtS/vHpqFAFx4Umuw3MZN/Jskg
         TfEXZjRRUO3BKIP0WtGuakC5rsmK6d9UnM5hFkROGRWdH5pPtazuvvrcgAYzLIqNcVMu
         CxZP8KWVFjUlsWcFOYqzMwsC7NUnSBCRdgOkZwyLlGUysIps3stnLNkYq+pg8BU25Z0Y
         bzRnmRcS3GoOxH/tD6w4GrcO49AoISSx7SvyWwDPgTjBaDc+pW2+lOE+xoCv2M2/vVkF
         GYJJ5IVXecG7WCZoYGslqKU0D3vZvcq0hbZgaSJ9+wfIq3Hu3b5sVbHPIhDcVhvvNEMn
         8SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZvTWExSIs1Egi3lbG0ImgK5994pq9tE5fF5dSYpfllM=;
        b=B2FlXH3pag2I5C1vaN884w4dRCINNvZIzRqqSz7ytGETACN5zeTZ3shnT4oCXbNDhp
         YQkR4zUZi3fYkToxc949KW+neWN2VLwmeLkKq+2/4+CIGbTiOens7BYWSboWPbI5RY03
         XCYQaGBJf7v245GQME/saIrIl4YdhdncxitlKa34+I8HHtYlxSuL6NDm3usoHHn6odDN
         ApTK5opa8r0CAlwwlifTl2UvRj0duZWpmXk7exG6eCMGiMN5i3yTa5YhP1ULnJzgXFdR
         60nmMY8c9KXP53ru6N2P4XPYSn3hMQkBJHJDMiSaWml637s+UBfQ6T5G/Y0SGW/Vhu34
         lV6Q==
X-Gm-Message-State: AOAM533NMxiiEpSaYvgUxrqlXK/qsB/mvLQBJIbs9J+vxftE6igPJsa/
        pkkfFNchxtJ1wol863GoPpBdlorFCLY=
X-Google-Smtp-Source: ABdhPJxNnjG0489Dr1SX5GFzmYvy1D8u44/wVmMUIIhkwfX+0cqvJrbiJ4P/dTSrKDgW/fM+BY/m4Q==
X-Received: by 2002:a05:600c:4305:: with SMTP id p5mr22444373wme.58.1615747667220;
        Sun, 14 Mar 2021 11:47:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm15708264wrt.8.2021.03.14.11.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 11:47:46 -0700 (PDT)
Message-Id: <2b03785bd4cb76285989aff259af57890ea9fe08.1615747662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
        <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 18:47:40 +0000
Subject: [PATCH v2 7/9] parse-options: convert bitfield values to use binary
 shift
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

Because it's easier to read, but also likely to be easier to maintain.
I am making this change because I need to add a new flag in a later
commit.

Also add a trailing comma to the last enum entry to simplify addition of
new flags.

This changee was originally suggested by Peff in:
https://public-inbox.org/git/YEZ%2FBWWbpfVwl6nO@coredump.intra.peff.net/

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 parse-options.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index ff6506a50470..36ce0a44b2e9 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -28,26 +28,26 @@ enum parse_opt_type {
 };
 
 enum parse_opt_flags {
-	PARSE_OPT_KEEP_DASHDASH = 1,
-	PARSE_OPT_STOP_AT_NON_OPTION = 2,
-	PARSE_OPT_KEEP_ARGV0 = 4,
-	PARSE_OPT_KEEP_UNKNOWN = 8,
-	PARSE_OPT_NO_INTERNAL_HELP = 16,
-	PARSE_OPT_ONE_SHOT = 32
+	PARSE_OPT_KEEP_DASHDASH = 1 << 0,
+	PARSE_OPT_STOP_AT_NON_OPTION = 1 << 1,
+	PARSE_OPT_KEEP_ARGV0 = 1 << 2,
+	PARSE_OPT_KEEP_UNKNOWN = 1 << 3,
+	PARSE_OPT_NO_INTERNAL_HELP = 1 << 4,
+	PARSE_OPT_ONE_SHOT = 1 << 5,
 };
 
 enum parse_opt_option_flags {
-	PARSE_OPT_OPTARG  = 1,
-	PARSE_OPT_NOARG   = 2,
-	PARSE_OPT_NONEG   = 4,
-	PARSE_OPT_HIDDEN  = 8,
-	PARSE_OPT_LASTARG_DEFAULT = 16,
-	PARSE_OPT_NODASH = 32,
-	PARSE_OPT_LITERAL_ARGHELP = 64,
-	PARSE_OPT_SHELL_EVAL = 256,
-	PARSE_OPT_NOCOMPLETE = 512,
-	PARSE_OPT_COMP_ARG = 1024,
-	PARSE_OPT_CMDMODE = 2048
+	PARSE_OPT_OPTARG  = 1 << 0,
+	PARSE_OPT_NOARG   = 1 << 1,
+	PARSE_OPT_NONEG   = 1 << 2,
+	PARSE_OPT_HIDDEN  = 1 << 3,
+	PARSE_OPT_LASTARG_DEFAULT = 1 << 4,
+	PARSE_OPT_NODASH = 1 << 5,
+	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
+	PARSE_OPT_SHELL_EVAL = 1 << 7,
+	PARSE_OPT_NOCOMPLETE = 1 << 8,
+	PARSE_OPT_COMP_ARG = 1 << 9,
+	PARSE_OPT_CMDMODE = 1 << 10,
 };
 
 enum parse_opt_result {
-- 
gitgitgadget

