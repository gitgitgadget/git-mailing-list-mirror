Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAE1C2D0D1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B19E20716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9oP7tqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfLSSCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:17 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45854 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfLSSCN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:13 -0500
Received: by mail-ed1-f52.google.com with SMTP id v28so5747489edw.12
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gVFcaXLqa523fg5lPrLd1LimL/DlQqVlqvL3IbZh+74=;
        b=h9oP7tqzodbLtX3OV1lKVUj51HGMIsgT1HihXoB/LWvDSVZMnLhhZZK4xnsOUdVx8/
         Gpnmel5RIwVv3U8n2uBn4oyIvIpsPHRs1eW5MbqhoXeFTogN//4+G0ZXgnyfEBgj8PLK
         afGKl5G/6lXlrfQSDLfnNV/hwgeg0DSpoiV1Jylta+eFDaK8GA4Ild0qp7cTIWAnsd/P
         Z6LpQ21a6ERxoGbsmK96nGZXyrZAbqb0iufzl3ngmQvhJ1+52cp1vuEhBkUeTPAJA+z+
         5F9ow18w4QC+9id9QWxfYeWHBEQuEr1kBqecIidV3vCaoxqECjmi8MqTGULhg1Un6X43
         8c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gVFcaXLqa523fg5lPrLd1LimL/DlQqVlqvL3IbZh+74=;
        b=ozxwQctXQbEt4qhhGdzNs9Zad5eTEvHsD3cudP3UsuKW7sAQy5VONKa1KS69oO7e2t
         4NCirnT6VaMm2yw4hDT4LiCpTDZ7uhW5YDWIWiOJI8DqjjktfPa2f7+xMv+COKHP+5yV
         sgh1St9LwoCIemyb3PIC/9YTwYIEa2KvI8rq9/j6V79UkKsVOm7veEcQ1IL8xWR3imSD
         sI7NzesildOuLsWlMy/pq96/VrpyXB4gx2f786B50iacCwYJpU6vqFOsXOrqYhm6gFEs
         rXftWzupJU6/xhyfkOEDy3gJW4Idc3ccf2jMVZD/L9GaLv7N3oXdCISh5y34rwnMHmif
         ElOg==
X-Gm-Message-State: APjAAAWvBDSKTzrzxvQ5rzbU9Je0Fh0A9oVjWgOjICSe5kS4VIKGYlQN
        z7kd+lHXnYpdGXB90d4y7LLFiCf7
X-Google-Smtp-Source: APXvYqw2Y8ZGOjcAPEm1AgbUEg0zLB5vEV3FAnSfEoMbQgGqGhM/k7PrfPYONR5++Kz7P3a1AFm5uA==
X-Received: by 2002:aa7:c2d3:: with SMTP id m19mr10482359edp.136.1576778531787;
        Thu, 19 Dec 2019 10:02:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3sm558092edb.50.2019.12.19.10.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:11 -0800 (PST)
Message-Id: <dc6e351796a89803a7b3dfdb7373b9c9f1ac3d8c.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:51 +0000
Subject: [PATCH v3 14/18] parse_branchname_arg(): simplify argument eating
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This patch abolishes two pieces of obfuscated code.

First is `if (argc)` condition, which in fact means "more then one arg"
due to `argc++` above.

Second is by far harder to grasp:
    if (!arg0_cant_be_pathspec) {...} else if (opts->accept_pathspec)
that is,
	if (opts->accept_pathspec && arg0_cant_be_pathspec)
which (quite unexpectedly) actually means
    if (opts->accept_pathspec && dash_dash_pos == 1)
and aims to "eat" that `--`.

Make both pieces easier to read by rewriting obfuscated conditions.

With both solved, I could keep argcount++/argv++/argc-- in the very end
of the function, but that was obviously useless code in this case, so I
deleted them as well.

This patch is not expected to change behavior in any way.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9144770b21..63f4bb4da6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1152,7 +1152,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 				struct object_id *rev)
 {
 	const char **new_branch = &opts->new_branch;
-	int argcount = 0;
 	const char *arg;
 	int dash_dash_pos;
 	int arg0_cant_be_pathspec = 0;
@@ -1272,15 +1271,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 		if (!recover_with_dwim) {
 			if (arg0_cant_be_pathspec)
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
@@ -1293,15 +1287,11 @@ static int parse_branchname_arg(int argc, const char **argv,
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
+	return (opts->accept_pathspec && dash_dash_pos == 1) ? 2 : 1;
 }
 
 static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
-- 
gitgitgadget

