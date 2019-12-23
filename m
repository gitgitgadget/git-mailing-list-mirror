Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC7EC2D0DB
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7E720643
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGTmbdtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLWSuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38112 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfLWSuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id i16so16119124edr.5
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cVdPlPILZi1d/pQbIp22+mGbtwH6yjwXLa5cYI0NUSM=;
        b=iGTmbdtKkfNTBOoYwBuK2wz6ZsxBg80FPbNn0P8pCYlcTJVEO74M/1MmVTH+GqRaNI
         RsAiCGupXH3N3irWFsHufLAfsgqr6ps2r4V4Lbww6KUrY5VtCZTUw3Zy5uGg32ZlktfB
         hXNAoG5M9Z37Udk2xb0j9ZnaqUQQAboAVe6H0JZBd2mapvde4bO/qL0H3xumq5GR1MWB
         j4prQyOtnGZzIugYfl5Aj7OGCJ/FvJGqG2IhJvORD9gOcgbqMLOt+Sd9PirVy+QQzycN
         LZeJbLn+0tZ4+TJp/k4P/GlAdxfgFfM3k06g11hbamzioz4fP2ORucegMhLS2WzwCANF
         6xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cVdPlPILZi1d/pQbIp22+mGbtwH6yjwXLa5cYI0NUSM=;
        b=X49MxdY+0t10H5taxbHgitE9+kQaQnMVvGbBMxf1zVm1ftgfjNlg3rNS/7sxG4ffV2
         N6jlzoJoZcifsjHTuF9l0/qvZ/5BRuwoUKumQHpb83Z9QjLmxGG6mpjZwIHJ73pnB32J
         neSj35zdqJePV7I2EgX9wVB2DpGx2nbaHHDUMgjlmBpSIpb120SURIWzneO/JWqXY/bz
         /Z5Cn/VYe+jJtQmL2JY0XMR/+iDO7fgbhukuw7ZlQs8QFdXcHF1Oe2H1VxwzVFIM1klY
         CGv6WdccqNmN7CSjiM4ImbaA9hrjoGGk8m8qj54yzYRgrHxtIq21zR+ZU2CRno9QvB52
         8wiw==
X-Gm-Message-State: APjAAAUYU5i/dF4yrVm9Qb3MRUW3GPhKeT8VTjxC6Jae8HAHEliUKXrO
        9o+aNZdMaSSnoGwQuQIdDMdCRWev
X-Google-Smtp-Source: APXvYqxWW8b0ojvvMvEcFvTi3xPdhXD9g1uqJe1EPPj2u8u5DiUhnSgoP8MUjvuwG/h7fga83lqWRQ==
X-Received: by 2002:a17:906:248f:: with SMTP id e15mr33242384ejb.141.1577127007728;
        Mon, 23 Dec 2019 10:50:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm2373307edr.14.2019.12.23.10.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:07 -0800 (PST)
Message-Id: <7c3f2e07f3d388730f2a2ba48c70ad1590a91d99.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:53 +0000
Subject: [PATCH v2 09/15] rebase: move incompatibility checks between backend
 options a bit earlier
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7027e34567..d2b99e9908 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1906,6 +1906,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
+	if (options.git_am_opts.argc) {
+		/* all am options except -q are compatible only with --am */
+		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
+			if (strcmp(options.git_am_opts.argv[i], "-q"))
+				break;
+
+		if (is_interactive(&options) && i >= 0)
+			die(_("cannot combine am options with either "
+			      "interactive or merge options"));
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
@@ -1936,17 +1947,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (reschedule_failed_exec >= 0)
 		options.reschedule_failed_exec = reschedule_failed_exec;
 
-	if (options.git_am_opts.argc) {
-		/* all am options except -q are compatible only with --am */
-		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
-			if (strcmp(options.git_am_opts.argv[i], "-q"))
-				break;
-
-		if (is_interactive(&options) && i >= 0)
-			die(_("cannot combine am options with either "
-			      "interactive or merge options"));
-	}
-
 	if (options.signoff) {
 		if (options.type == REBASE_PRESERVE_MERGES)
 			die("cannot combine '--signoff' with "
-- 
gitgitgadget

