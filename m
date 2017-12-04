Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDCD20954
	for <e@80x24.org>; Mon,  4 Dec 2017 12:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbdLDM51 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 07:57:27 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40146 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753985AbdLDM5T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 07:57:19 -0500
Received: by mail-wm0-f65.google.com with SMTP id f206so7881790wmf.5
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 04:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S4dvBHcsufC632FVahTKEL/vlHNiow8kB5t942mVa8U=;
        b=GufcAibcZtPEkXqXnQm2qFDEf+MToYD9WsFGr1wQZrP8NXLz8trUNoBIznbT7yshpo
         S/tuY9bpNhhvXJ60QhhsIWY3nPlbSuNKc1JU8lASejirMh2GmT/VnsexpeTiX/Mn69uT
         KEnUIUs7jgTx3KnoFfOboNzeXFKv5ibBP8EWpdsE6Dovgbd7bca+AT089dDTuBXRxXNY
         b0yzmusMEA+c9LlRDXx5Fprd2tPbp06JgWo5ShikOJNp+mYpPUiokC6vjl34QcnnLfHO
         CyKPs79AS4KirtCuKfkA3ICP+4NVNcRdczdt8tFnuPGXsbuGtIR3KJPnuMxL1BNh3zGl
         f3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S4dvBHcsufC632FVahTKEL/vlHNiow8kB5t942mVa8U=;
        b=hco2srEf10LftG01DdBQD2nl1+fxHAWIoF1V9XvOkJWhkPT4ITtJHudIq5FyQKpf0e
         qx6ijTaG1lwlnQwRLCKwGgD13AfFOayJh2S5X84EZD/MFxpBG9EDFawBOxHCdVOAL5n5
         2cWuEZIPD1Ebd9aBrsB3WRQgK+msijHD4VpkAtDlHXfCA0Z1K3TDE7QLk2Tk/zRxliuG
         IPSSPjnA2QC1qMZgKtI4Dy/PwvEYLP/OOQ9Y9r932U/1P6rV9Q2hOlFmjJ5Pyd6nS71/
         JzdFveYEbFLxBzYMC5qIjCef7+HxZA80D/0RdUXrvdPCSxlM1jsEqMJdpzv4fsWfOYzs
         4OzA==
X-Gm-Message-State: AKGB3mIDxd34mHt/bUW6C53Q0kTwAhu/47VDGDEE3hduNSpjKo+XkMc+
        opAsb4IfaifNFIgfaTy3hooenNQh
X-Google-Smtp-Source: AGs4zMbeqMrVnViGbShZzcphfY4Qi12q63F5aqU+2C3vaxNkjCsZUIFEOXvHBs1e2VENrvvyt3gA9Q==
X-Received: by 10.28.159.15 with SMTP id i15mr8018724wme.58.1512392238257;
        Mon, 04 Dec 2017 04:57:18 -0800 (PST)
Received: from localhost.localdomain ([195.68.12.6])
        by smtp.gmail.com with ESMTPSA id 30sm12456948wrl.22.2017.12.04.04.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 04:57:17 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/4] diff: use skip_to_optional_val_default()
Date:   Mon,  4 Dec 2017 13:56:17 +0100
Message-Id: <20171204125617.4931-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.274.g3f22e311ce.dirty
In-Reply-To: <20171204125617.4931-1-chriscool@tuxfamily.org>
References: <20171204125617.4931-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's simplify diff option parsing using
skip_to_optional_val_default().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 diff.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index 83509f0658..d234b4f0cb 100644
--- a/diff.c
+++ b/diff.c
@@ -4619,9 +4619,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--no-follow")) {
 		options->flags.follow_renames = 0;
 		options->flags.default_follow_renames = 0;
-	} else if (!strcmp(arg, "--color"))
-		options->use_color = 1;
-	else if (skip_prefix(arg, "--color=", &arg)) {
+	} else if (skip_to_optional_val_default(arg, "--color", &arg, "always")) {
 		int value = git_config_colorbool(NULL, arg);
 		if (value < 0)
 			return error("option `color' expects \"always\", \"auto\", or \"never\"");
@@ -4641,14 +4639,9 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm < 0)
 			die("bad --color-moved argument: %s", arg);
 		options->color_moved = cm;
-	} else if (!strcmp(arg, "--color-words")) {
-		options->use_color = 1;
-		options->word_diff = DIFF_WORDS_COLOR;
-	}
-	else if (skip_prefix(arg, "--color-words=", &arg)) {
+	} else if (skip_to_optional_val_default(arg, "--color-words", &options->word_regex, NULL)) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
-		options->word_regex = arg;
 	}
 	else if (!strcmp(arg, "--word-diff")) {
 		if (options->word_diff == DIFF_WORDS_NONE)
@@ -4687,15 +4680,10 @@ int diff_opt_parse(struct diff_options *options,
 		options->flags.textconv_set_via_cmdline = 1;
 	} else if (!strcmp(arg, "--no-textconv"))
 		options->flags.allow_textconv = 0;
-	else if (!strcmp(arg, "--ignore-submodules")) {
-		options->flags.override_submodule_config = 1;
-		handle_ignore_submodules_arg(options, "all");
-	} else if (skip_prefix(arg, "--ignore-submodules=", &arg)) {
+	else if (skip_to_optional_val_default(arg, "--ignore-submodules", &arg, "all")) {
 		options->flags.override_submodule_config = 1;
 		handle_ignore_submodules_arg(options, arg);
-	} else if (!strcmp(arg, "--submodule"))
-		options->submodule_format = DIFF_SUBMODULE_LOG;
-	else if (skip_prefix(arg, "--submodule=", &arg))
+	} else if (skip_to_optional_val_default(arg, "--submodule", &arg, "log"))
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
 		return parse_ws_error_highlight_opt(options, arg);
-- 
2.15.1.274.g3f22e311ce.dirty

