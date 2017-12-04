Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2910F20954
	for <e@80x24.org>; Mon,  4 Dec 2017 12:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753990AbdLDM5W (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 07:57:22 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:41501 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753983AbdLDM5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 07:57:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id g75so5654286wme.0
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/P2dqv5XNjdwwGIw8e0/Rqz4fB3rkrIesgdENf4xPBI=;
        b=MoAaiVMOdmB5bYP7w+1DzcBkhZ6qqZYq609qCiG3PcDjOu3m3uWzuCiZuIA+F2HemL
         KE1kvXgznvERV9fbHUhBCTC+33CLXJBan805e3Bi3akyt+k+5ZTj42EJSMg+77m8oOLf
         oSId9ymROJWFQ8Rs3HYYAoXtbhJlALd9VY5/xANcRYVvgDotiMpRrJjGFNCXoLp+D8j2
         rqDPh7dWmba4f+296eEGjCMkTfOKy0nTccDwW/Xg0fTZu9yhsjevmKlHbRxBLRUISW6V
         iY7SKVtCc5OZZm1kUdh11TZvAqqPxlyIzQ0SH2F9O3MYUHOIHzUiCUBOcpIDOXX24ieG
         z08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/P2dqv5XNjdwwGIw8e0/Rqz4fB3rkrIesgdENf4xPBI=;
        b=j0W4bXq2L+XyAGgKNNqlnwJXjixpfq9xtizTME5nY/Z/TKFXLfGU6Lg7gNSsGVXTAS
         zjzbXkIQCZzMuvaEoNGMxJeGjugc+YFlRMC4UQfQ4eGhUd7rzK6M3rsjkU90X4lDWg11
         v4RouAwagKzZ2pbKY2v4tzAEWOIT8f63mfy40iYiPsoG1XRw0oY5HgVlWbTQHCAgVShi
         WTCSAYLXPbXGZl1MfmwIr27vOs6w8+Cb6yEewuOCnsARMTe71jmAOSecE7Ghp4Bj2z12
         McU2l9KeckIcACOOWuGPco8ZGKAw0zAHOJ3JyMzzwl05AUxueMmFv7RuuiRA/FPumzYK
         PJog==
X-Gm-Message-State: AKGB3mLrl1yeEwZL/qdO3P/1n3/OMwbyKzVVf/DUgNv7B5kXvZnJ3znZ
        6idj9jHHJK3yIzwFqPZBdWg39Vlz
X-Google-Smtp-Source: AGs4zMbYOM0aPQofw4/idWBz3M0GMRKBqMGjniDj46SbH8/61cltWNnSHsiDJJsb9zEsTY5JifBW+w==
X-Received: by 10.28.214.145 with SMTP id n139mr3393203wmg.59.1512392237057;
        Mon, 04 Dec 2017 04:57:17 -0800 (PST)
Received: from localhost.localdomain ([195.68.12.6])
        by smtp.gmail.com with ESMTPSA id 30sm12456948wrl.22.2017.12.04.04.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 04:57:16 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/4] diff: use skip_to_optional_val()
Date:   Mon,  4 Dec 2017 13:56:16 +0100
Message-Id: <20171204125617.4931-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.274.g3f22e311ce.dirty
In-Reply-To: <20171204125617.4931-1-chriscool@tuxfamily.org>
References: <20171204125617.4931-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Let's simplify diff option parsing using
skip_to_optional_val().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 diff.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/diff.c b/diff.c
index 2ebe2227b4..83509f0658 100644
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
+		 skip_to_optional_val(arg, "--dirstat", &arg))
 		return parse_dirstat_opt(options, arg);
 	else if (!strcmp(arg, "--cumulative"))
 		return parse_dirstat_opt(options, "cumulative");
-	else if (!strcmp(arg, "--dirstat-by-file"))
-		return parse_dirstat_opt(options, "files");
-	else if (skip_prefix(arg, "--dirstat-by-file=", &arg)) {
+	else if (skip_to_optional_val(arg, "--dirstat-by-file", &arg)) {
 		parse_dirstat_opt(options, "files");
 		return parse_dirstat_opt(options, arg);
 	}
@@ -4540,13 +4535,13 @@ int diff_opt_parse(struct diff_options *options,
 		return stat_opt(options, av);
 
 	/* renames options */
-	else if (starts_with(arg, "-B") || starts_with(arg, "--break-rewrites=") ||
-		 !strcmp(arg, "--break-rewrites")) {
+	else if (starts_with(arg, "-B") ||
+		 skip_to_optional_val(arg, "--break-rewrites", &optarg)) {
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -B: %s", arg+2);
 	}
-	else if (starts_with(arg, "-M") || starts_with(arg, "--find-renames=") ||
-		 !strcmp(arg, "--find-renames")) {
+	else if (starts_with(arg, "-M") ||
+		 skip_to_optional_val(arg, "--find-renames", &optarg)) {
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
+		 skip_to_optional_val(arg, "--find-copies", &optarg)) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			options->flags.find_copies_harder = 1;
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
@@ -4568,12 +4563,8 @@ int diff_opt_parse(struct diff_options *options,
 		options->flags.rename_empty = 1;
 	else if (!strcmp(arg, "--no-rename-empty"))
 		options->flags.rename_empty = 0;
-	else if (!strcmp(arg, "--relative"))
-		options->flags.relative_name = 1;
-	else if (skip_prefix(arg, "--relative=", &arg)) {
+	else if (skip_to_optional_val(arg, "--relative", &options->prefix))
 		options->flags.relative_name = 1;
-		options->prefix = arg;
-	}
 
 	/* xdiff options */
 	else if (!strcmp(arg, "--minimal"))
-- 
2.15.1.274.g3f22e311ce.dirty

