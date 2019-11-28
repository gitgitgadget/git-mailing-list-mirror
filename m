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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57247C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295DE21774
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuR5LkJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfK1TcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:32:23 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:40533 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfK1TcW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 14:32:22 -0500
Received: by mail-wm1-f44.google.com with SMTP id y5so12727436wmi.5
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 11:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+UfiOnuE1uHHqLaqJrZF+9D8jVPuGot7i0UjK9ko0zo=;
        b=HuR5LkJD4gMe1tJ/rvaem/1DKEbj/iOTiB0ZbeslOkT9Tn2/n6+n4AUMWVSePwfnWv
         UxFmq6Zf2R5icFhwpdgkxtd9hw10p0M3w9qOBMgqu7Lei0VQHvllSgr1PMjmxq0RBwAP
         Ir/msT7nziR6zWN1UyU3sL7JqZ19I4O/2LDxtyRDgk/wUndymY8Nw6sy3B/SGUceTCZ3
         ORjosrdp7BkZvdjGCIncsUdmTp7WtYJUAzSgmrwjHbnJOcokBQrY+r6RpylFnlpfONTA
         4m+yklXehCMjLK+dnpSqua+jbmsDbTvYS/zhTel6QaWQZBkrn0dFfyaOX6Ice6E9mwLY
         yXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+UfiOnuE1uHHqLaqJrZF+9D8jVPuGot7i0UjK9ko0zo=;
        b=T1dV5CgIrlG1AImkxUz3Q9iQEX5GADbLNyjr2crGsZlnX1YotKnnc97Nva4uQA1358
         VZWXWKGbZoP4S07XRqTgxJ4JxzQ6ScBfaiCpOfAJZyC1ZbTdONBFAGwlZGzM5Vu71ZjN
         LZbUL7YatMDLDaFK7+ectzF1us3mhum7xL4EdshEVrHPSNrpXzrKcYqPQ/nw6tQL3Bjk
         Ml6vWSCf9eoRtWVFjorDpsvHf2cFpwaS64wpwfGKJ6nBc6Mv42w91819mUgE5GVk838x
         M4WCerEDynfSbY6mZ8cErESYGctd5tTG46gx+Q3cPTAwgVZS+BGrDrDJF/qSRjv7aiwp
         Zcgg==
X-Gm-Message-State: APjAAAWK4+sPtQOqNCkD0AfgvSw8A9qS8QfmrWKxL9rq8kjTnT+XgXwQ
        4ZS0ZclC3Qz2IQRfwIjnS+t3lLDi
X-Google-Smtp-Source: APXvYqyxlQHM6AdljEBB831J6O+3nEDMQ+9h8JGyEX9RLxf9gC4SsjIbB27RQ0jkVHfXmfs4YRmheQ==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr10698828wma.177.1574969540545;
        Thu, 28 Nov 2019 11:32:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm24765598wrr.76.2019.11.28.11.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 11:32:20 -0800 (PST)
Message-Id: <771947d01f759a72b9f8999e929bf1f7765327aa.1574969538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.479.git.1574969538.gitgitgadget@gmail.com>
References: <pull.479.git.1574969538.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Nov 2019 19:32:14 +0000
Subject: [PATCH 1/5] parse_branchname_arg(): fix dash_dash_pos, drop argcount
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

`dash_dash_pos` was only calculated under `opts->accept_pathspec`. This
is unexpected to readers and made it harder to reason about the code.
Fix this by restoring the expected meaning.

Simplify the code by dropping `argcount` and useless `argc` / `argv`
manipulations.

This should not change behavior in any way.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3634a3dac1..655b389756 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1121,7 +1121,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 				int *dwim_remotes_matched)
 {
 	const char **new_branch = &opts->new_branch;
-	int argcount = 0;
 	const char *arg;
 	int dash_dash_pos;
 	int has_dash_dash = 0;
@@ -1180,17 +1179,21 @@ static int parse_branchname_arg(int argc, const char **argv,
 	arg = argv[0];
 	dash_dash_pos = -1;
 	for (i = 0; i < argc; i++) {
-		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
+		if (!strcmp(argv[i], "--")) {
 			dash_dash_pos = i;
 			break;
 		}
 	}
-	if (dash_dash_pos == 0)
-		return 1; /* case (2) */
-	else if (dash_dash_pos == 1)
-		has_dash_dash = 1; /* case (3) or (1) */
-	else if (dash_dash_pos >= 2)
-		die(_("only one reference expected, %d given."), dash_dash_pos);
+
+	if (opts->accept_pathspec) {
+	    if (dash_dash_pos == 0)
+		    return 1; /* case (2) */
+	    else if (dash_dash_pos == 1)
+		    has_dash_dash = 1; /* case (3) or (1) */
+	    else if (dash_dash_pos >= 2)
+		    die(_("only one reference expected, %d given."), dash_dash_pos);
+	}
+
 	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
 
 	if (!strcmp(arg, "-"))
@@ -1241,15 +1244,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 		if (!recover_with_dwim) {
 			if (has_dash_dash)
 				die(_("invalid reference: %s"), arg);
-			return argcount;
+			return 0;
 		}
 	}
 
-	/* we can't end up being in (2) anymore, eat the argument */
-	argcount++;
-	argv++;
-	argc--;
-
 	setup_new_branch_info_and_source_tree(new_branch_info, opts, rev, arg);
 
 	if (!opts->source_tree)                   /* case (1): want a tree */
@@ -1262,15 +1260,11 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 * even if there happen to be a file called 'branch';
 		 * it would be extremely annoying.
 		 */
-		if (argc)
+		if (argc > 1)
 			verify_non_filename(opts->prefix, arg);
-	} else if (opts->accept_pathspec) {
-		argcount++;
-		argv++;
-		argc--;
 	}
 
-	return argcount;
+	return (dash_dash_pos == 1) ? 2 : 1;
 }
 
 static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
-- 
gitgitgadget

