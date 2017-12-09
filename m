Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76541F406
	for <e@80x24.org>; Sat,  9 Dec 2017 20:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbdLIUk3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 15:40:29 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42169 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdLIUk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 15:40:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id b199so4449611wme.1
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 12:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qGV4G+2ny5J0BPOjo/Xq0kN64mNEY2Do44pgFBqxxTI=;
        b=G9P7ijRZne4crzAIO1jbvJCOHzXvrIJ4bjFscafUFrucLhwGJirk34DFiwkyTia0iZ
         azNoeCrZHbe6nDHpjq3mDiUBAfH+srgCyqu975jA/9kFOumJCuFRVhNYT72NMRlIqwjV
         I6vv9TLc9oq/Zza3eaIScuMz7j0eQ3at8U1qSX8jIIxSU3f5mhJ6um2+sFrTE33AsBNz
         7E69dEbqhnJwA76DjDnzNqO9sEOBXX7EvteEaP7o4ISTp48cV2R5PbfZNW1obelWzT72
         u5QSTkHwqwFm2Pnuye2m6WCempc8Khmoh6zph7jUPsVzFCYWfEY6M+uybw3uEguEJZ98
         HMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qGV4G+2ny5J0BPOjo/Xq0kN64mNEY2Do44pgFBqxxTI=;
        b=CYwqoKOzJmZkDaYndFTdmCrpbjJhroXo8KTL4Wn1cheMVJNvp00ycLCDljyEWSN9fL
         Ns4Q2pKGhauurHUWgNG0ZnIuu1zbCSshvFfe0v4/l1wYYlDtxGDjaY4vEpfwALTxunE9
         ezi3lP5YdhqUp3PfXjnrEC1LXuO+7RiZSjhkEQFRD4OpI7KOiJsAwXSjpwcF5rl5MDfe
         9sS1eXvNIiciKWM0FpUZxzhOlvSlLtVqIHw0lvkemlmzwYBCJiuow+Xn/5YjrdWCzEyY
         7QQevNU8wJSeRCTInjZ/rZRDxvp+tB31kfu3e68/TW1ZuReLEPoz5tl7dAsuGzQNjPuM
         Gsiw==
X-Gm-Message-State: AKGB3mKCVXUUKOjoMrKK+640Uo5jlnJGQcHoSCGTkUGgyYWjyuPto4oi
        Uh6GToLNEgUsIdsSZ/Wz7r/aiSQf
X-Google-Smtp-Source: AGs4zMbxgMeTS4YFazr/GrdPIpTTu0dGP8d9t0xsU+8PU7p8OXY3DoSvOuoCIhePvczdMspoP+EFCQ==
X-Received: by 10.28.211.211 with SMTP id k202mr7388210wmg.113.1512852026119;
        Sat, 09 Dec 2017 12:40:26 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v18sm12491283wrv.37.2017.12.09.12.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Dec 2017 12:40:25 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/7] diff: use skip_to_optional_arg()
Date:   Sat,  9 Dec 2017 21:40:09 +0100
Message-Id: <20171209204013.10997-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171209204013.10997-1-chriscool@tuxfamily.org>
References: <20171209204013.10997-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Let's simplify diff option parsing using skip_to_optional_arg().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 2ebe2227b4..464a53adb5 100644
--- a/diff.c
+++ b/diff.c
@@ -4508,17 +4508,12 @@ int diff_opt_parse(struct diff_options *options,
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-	else if (!strcmp(arg, "-X") || !strcmp(arg, "--dirstat"))
-		return parse_dirstat_opt(options, "");
-	else if (skip_prefix(arg, "-X", &arg))
-		return parse_dirstat_opt(options, arg);
-	else if (skip_prefix(arg, "--dirstat=", &arg))
+	else if (skip_prefix(arg, "-X", &arg) ||
+		 skip_to_optional_arg(arg, "--dirstat", &arg))
 		return parse_dirstat_opt(options, arg);
 	else if (!strcmp(arg, "--cumulative"))
 		return parse_dirstat_opt(options, "cumulative");
-	else if (!strcmp(arg, "--dirstat-by-file"))
-		return parse_dirstat_opt(options, "files");
-	else if (skip_prefix(arg, "--dirstat-by-file=", &arg)) {
+	else if (skip_to_optional_arg(arg, "--dirstat-by-file", &arg)) {
 		parse_dirstat_opt(options, "files");
 		return parse_dirstat_opt(options, arg);
 	}
@@ -4540,13 +4535,13 @@ int diff_opt_parse(struct diff_options *options,
 		return stat_opt(options, av);
 
 	/* renames options */
-	else if (starts_with(arg, "-B") || starts_with(arg, "--break-rewrites=") ||
-		 !strcmp(arg, "--break-rewrites")) {
+	else if (starts_with(arg, "-B") ||
+		 skip_to_optional_arg(arg, "--break-rewrites", NULL)) {
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -B: %s", arg+2);
 	}
-	else if (starts_with(arg, "-M") || starts_with(arg, "--find-renames=") ||
-		 !strcmp(arg, "--find-renames")) {
+	else if (starts_with(arg, "-M") ||
+		 skip_to_optional_arg(arg, "--find-renames", NULL)) {
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -M: %s", arg+2);
 		options->detect_rename = DIFF_DETECT_RENAME;
@@ -4554,8 +4549,8 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
 		options->irreversible_delete = 1;
 	}
-	else if (starts_with(arg, "-C") || starts_with(arg, "--find-copies=") ||
-		 !strcmp(arg, "--find-copies")) {
+	else if (starts_with(arg, "-C") ||
+		 skip_to_optional_arg(arg, "--find-copies", NULL)) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			options->flags.find_copies_harder = 1;
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-- 
2.15.1.361.g8b07d831d0

