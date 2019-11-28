Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5EBC43215
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5499F21775
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD0g7lmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfK1TcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:32:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33319 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfK1TcX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 14:32:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so2767010wrq.0
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 11:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/5UMlCIswklxeMVedpg2esFSM+V/lkBd0ecdU6ZnX88=;
        b=kD0g7lmD3PA6VOAG5O1Zv+WvfqZTMGbolI8ddGqPQmCl6bWaLoWre3fEJJC9+o/s7A
         2RmNlWwdhGxKFfLShUDsoPBp1FzFPY7BbE1LjrCHYgyPIeJmd6bq7OV+ffk87uWTTjKm
         tSEACUIjKilzYxKEoNqpXTBAwwd7vgKE2IHBbJVwgteriV4Z+5KZyNTz58QTFiC1bTHc
         8XdxeGSlXShikRaCmYVlk0SJ8DGbTsYc/lQvhkoui3oOigNrrleNF77xFsc34nRSXAb7
         Sij+Z22JxQbY99Y30M/Ydmu4Bl95R7cWEfP/9pteF++Gie9WxogACKK4FdxQbMOOOI1s
         DqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/5UMlCIswklxeMVedpg2esFSM+V/lkBd0ecdU6ZnX88=;
        b=si8ryjNbSWC5HZVxk3fbrEMUPG64+dzIRcrOajRC/rIe3rlvgc/PjuMsfV445OhRmm
         SErJbwncbFtULrQNvf188cARj/IWqEbAHaudOupnqZJeIIiUY3kVZGKJBgGa5O4+u8HF
         /IhVD1Yl4HbkFaWnpMxNrgRkatmiFjYYT1lZUeZTCb6dhrjH+Va6/5AZ5leJlbIMFILT
         inrLoBnRSdqi9paKJekVp0GBx4da2X61sgoVGGgSTOtWfYCFj2CjmLz7zayQx8duKJis
         xRphkstCixmbNfTjK1iFdJEndYqI477fyN515mLQIGIKyvJgFiP1nxMBZptK0s6zAUHA
         barQ==
X-Gm-Message-State: APjAAAVjZN6mS2MYBRhigDwqeHYZSTenMUnbg/i5QZohcoU2WfRqTFrp
        Q0bjQRcTNl8t3nA4qNhN3uZvwOuC
X-Google-Smtp-Source: APXvYqwIiMbQOxUZ5Kw0xWA3Xgntn0p2slycGhWtWr7ylx36XG8echY2LuojRcZFEBtqp2qEZex1nQ==
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr43634854wrs.226.1574969541239;
        Thu, 28 Nov 2019 11:32:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm9101202wmf.47.2019.11.28.11.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 11:32:20 -0800 (PST)
Message-Id: <a84633a44474aa25bd1101a9ca2a5d9687900bf2.1574969538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.479.git.1574969538.gitgitgadget@gmail.com>
References: <pull.479.git.1574969538.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Nov 2019 19:32:15 +0000
Subject: [PATCH 2/5] parse_branchname_arg(): introduce expect_commit_only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

`has_dash_dash` unexpectedly takes `opts->accept_pathspec` into account.
While this may sound clever at first sight, it becomes pretty hard to
reason (and not be a victim) about code, especially in combination with
`argc` here:

	if (!(argc == 1 && !has_dash_dash) &&
	    !(argc == 2 && has_dash_dash) &&
	    opts->accept_pathspec)
		recover_with_dwim = 0;

Introduce a new non-obfuscated variable to reduce the amount of diffs in
next patch.

This should not change behavior in any way.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 655b389756..5c6131dbe6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1123,7 +1123,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	const char **new_branch = &opts->new_branch;
 	const char *arg;
 	int dash_dash_pos;
-	int has_dash_dash = 0;
+	int has_dash_dash = 0, expect_commit_only = 0;
 	int i;
 
 	/*
@@ -1194,7 +1194,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 		    die(_("only one reference expected, %d given."), dash_dash_pos);
 	}
 
-	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
+	if (has_dash_dash)
+	    expect_commit_only = 1;
+
+	opts->count_checkout_paths = !opts->quiet && !expect_commit_only;
 
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
@@ -1210,10 +1213,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
-		int could_be_checkout_paths = !has_dash_dash &&
+		int could_be_checkout_paths = !expect_commit_only &&
 			check_filename(opts->prefix, arg);
 
-		if (!has_dash_dash && !no_wildcard(arg))
+		if (!expect_commit_only && !no_wildcard(arg))
 			recover_with_dwim = 0;
 
 		/*
@@ -1242,7 +1245,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		}
 
 		if (!recover_with_dwim) {
-			if (has_dash_dash)
+			if (expect_commit_only)
 				die(_("invalid reference: %s"), arg);
 			return 0;
 		}
@@ -1253,7 +1256,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!opts->source_tree)                   /* case (1): want a tree */
 		die(_("reference is not a tree: %s"), arg);
 
-	if (!has_dash_dash) {	/* case (3).(d) -> (1) */
+	if (!expect_commit_only) {	/* case (3).(d) -> (1) */
 		/*
 		 * Do not complain the most common case
 		 *	git checkout branch
-- 
gitgitgadget

