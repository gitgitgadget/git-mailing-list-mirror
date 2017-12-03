Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D79820C11
	for <e@80x24.org>; Sun,  3 Dec 2017 17:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbdLCREh (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 12:04:37 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38033 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbdLCREc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 12:04:32 -0500
Received: by mail-wr0-f195.google.com with SMTP id o2so14788249wro.5
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 09:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jXk+4doVLN12qkg5gufzmt5oSTsi+VeHQqMUM3F6VJk=;
        b=qk61MeIydPQORDAaqQlZFzsrf0mF9VpUHL94dSuDjR4VW5ImTlKJiyP9owAbcskMFk
         fYQWA17p+qPA8sE+lvy09hut3Q40B5jV51iwwP0cXmEw1DiicJraMrNcTNxjg2bQw4A6
         PPSw69sMQIfd5CoWLq9loBPErnsrc5bH3ZnaBbClhZ9e04REnQo1PKRL3ldhzdpc6asP
         Symx6/PBZW/qmH2dd9YLMi/VO3SiLBzbZbUZPoR+YHs6mwDoErBP7tpCZjQIl7pE3Ujw
         ub1erF1q60SVKQe0943j+uOL16imw9HCCEfL+KBm7PwjM4uQWrM3Xk/gzSeOdFocTQpc
         qU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jXk+4doVLN12qkg5gufzmt5oSTsi+VeHQqMUM3F6VJk=;
        b=YkGTZ4kk2PE48GBNOx2T3fxfWDEe5nKLjIKscKQs/e47YjGecz9NiqaOq+wMEKLs94
         L6G/8lx8BOKnhPpuCN3BWMUJBAXfaCTHTgrPNURM2qEfX73D+kd99s3gTEq3R3tRvju+
         x49cw7ID4rwLQk72ytghgtLH5t4/dBgAVe+ajDmubhW8/C6KgpuXQKE1/MR+7bZBcUd/
         urL3KUZTpWzneKogDMVhtYP/WdgygPE7t/I+VNUXSu4wWGPmq1UuGMEZMpjGgFG3YiU6
         wTSjLMRmFlKy2zNPCEuTL1xnfJYD75i8B24hBf2PLOTC6Gvt0bV7ABrXbBmmvEMYu4RL
         X0eA==
X-Gm-Message-State: AJaThX5LumTCBLM+iwe7yVNXH/BSOW2vwFBt0jl38BRAa8JZyLe5bFDi
        /HEAqurTyzth4XEgjpB9/yYGqFFP
X-Google-Smtp-Source: AGs4zMbMfXj4BCcRfiQ1eJ30CRWvPlCDqVVi3riiCMnOefisedOYNfIdVD/ABP8JXy00grhftGUZdg==
X-Received: by 10.223.161.158 with SMTP id u30mr10816124wru.200.1512320670632;
        Sun, 03 Dec 2017 09:04:30 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v192sm2340134wme.1.2017.12.03.09.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 09:04:30 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] diff: use skip_to_opt_val()
Date:   Sun,  3 Dec 2017 18:04:15 +0100
Message-Id: <20171203170415.15939-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.271.g1a4e40aa5d.dirty
In-Reply-To: <20171203170415.15939-1-chriscool@tuxfamily.org>
References: <20171203170415.15939-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Let's simplify diff option parsing using skip_to_opt_val().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 diff.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 2ebe2227b4..067b498187 100644
--- a/diff.c
+++ b/diff.c
@@ -4508,17 +4508,11 @@ int diff_opt_parse(struct diff_options *options,
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-	else if (!strcmp(arg, "-X") || !strcmp(arg, "--dirstat"))
-		return parse_dirstat_opt(options, "");
-	else if (skip_prefix(arg, "-X", &arg))
-		return parse_dirstat_opt(options, arg);
-	else if (skip_prefix(arg, "--dirstat=", &arg))
+	else if (skip_prefix(arg, "-X", &arg) || skip_to_opt_val(arg, "--dirstat", &arg))
 		return parse_dirstat_opt(options, arg);
 	else if (!strcmp(arg, "--cumulative"))
 		return parse_dirstat_opt(options, "cumulative");
-	else if (!strcmp(arg, "--dirstat-by-file"))
-		return parse_dirstat_opt(options, "files");
-	else if (skip_prefix(arg, "--dirstat-by-file=", &arg)) {
+	else if (skip_to_opt_val(arg, "--dirstat-by-file", &arg)) {
 		parse_dirstat_opt(options, "files");
 		return parse_dirstat_opt(options, arg);
 	}
@@ -4540,13 +4534,13 @@ int diff_opt_parse(struct diff_options *options,
 		return stat_opt(options, av);
 
 	/* renames options */
-	else if (starts_with(arg, "-B") || starts_with(arg, "--break-rewrites=") ||
-		 !strcmp(arg, "--break-rewrites")) {
+	else if (starts_with(arg, "-B") ||
+		 skip_to_opt_val(arg, "--break-rewrites", &optarg)) {
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -B: %s", arg+2);
 	}
-	else if (starts_with(arg, "-M") || starts_with(arg, "--find-renames=") ||
-		 !strcmp(arg, "--find-renames")) {
+	else if (starts_with(arg, "-M") ||
+		 skip_to_opt_val(arg, "--find-renames", &optarg)) {
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -M: %s", arg+2);
 		options->detect_rename = DIFF_DETECT_RENAME;
@@ -4554,8 +4548,8 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
 		options->irreversible_delete = 1;
 	}
-	else if (starts_with(arg, "-C") || starts_with(arg, "--find-copies=") ||
-		 !strcmp(arg, "--find-copies")) {
+	else if (starts_with(arg, "-C") ||
+		 skip_to_opt_val(arg, "--find-copies", &optarg)) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			options->flags.find_copies_harder = 1;
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-- 
2.15.1.271.g1a4e40aa5d.dirty

