Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2920C35240
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724A9214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki0flzkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgAaUQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34435 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgAaUQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id s144so9564389wme.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7OIxkWhiTuACvbhbr0mgY5mdi0HMxPaJU+8Iq5N0peE=;
        b=ki0flzkU0FHshsd5Hc0BAAIaYWrt11A0TCwWtUtrsoenmgT+GdKh1V5Jw6vvVlJ/G8
         qjwkRCY2wOMf977beom977iCu9SvgKMIw9EnhfTgrjluRlJcSA7i5gFCWSC6x0hwz2Yd
         tH0J8v7RfR3aJ4Rt+hp9+D0R7hyHwcYWO59G/zj+85vf7QQ6xfp5is3ojjh2XtRCLAgN
         LZ8512YoUhYH1TvHjvAKu3D4teRAQYr2CejQZzP6tjY/2ZVvTpqnKHq1FclU9Vb4fbdS
         3x5XMRTe+u1zb91nIHrZ38BnwzC89MMQZzrxK0EO8/CtOEvhQZRU+YlLvQ8PgcEUFak8
         k5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7OIxkWhiTuACvbhbr0mgY5mdi0HMxPaJU+8Iq5N0peE=;
        b=pFPkNRND2jAFlP3KQWGr/lNpRMtIBNIVHBCFWb4F71X7yrc5jej8RsnuclBGb3D7yE
         WHThxGLsYrEsmCCA+GLuoSPSbdD3VED4WWccQOv+C0n0D8a58bVwRk89K4S3PYrfTrm1
         Nxh/a2bVJf44tLTUKRSRH+1rfYulGP4K/33R4qit4PUMlOv5jDRpgfu8VSwp6BVvJ+LC
         tb0uXDLZ1Kx3dHnIjPLBTwvozUPD8ER7CgIGcc/uN3sAMmHl9itu6Oa3+jKLAjK1LorE
         JcZsYYbrnVWNVkelVOSfXpSLFdRTj9PghDz1vnkoiTBeDjPlGYYBvr4sApmwww8ViBhv
         ezmQ==
X-Gm-Message-State: APjAAAUylH0Tp5aQO59EpYdk+TbRR9d+zyzXAbsssrjfUK9+kRX/ZA9g
        471G5rX2CE0aifTpOHxxc+RnIbRk
X-Google-Smtp-Source: APXvYqyvxNFnIgU6Ua63V5Y4x9zcf6fEHcfTUaEZtPMP5O8WByw8wRCfaA+vZT+D0MHAP7sulpmwfA==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr14404297wmg.66.1580501786527;
        Fri, 31 Jan 2020 12:16:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b67sm12622022wmc.38.2020.01.31.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:26 -0800 (PST)
Message-Id: <3dd8f97b3a7c301955aba7dd5778549d1b49b0fd.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:14 +0000
Subject: [PATCH v4 14/15] sparse-checkout: improve docs around 'set' in cone
 mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The existing documentation does not clarify how the 'set' subcommand
changes when core.sparseCheckoutCone is enabled. Correct this by
changing some language around the "A/B/C" example. Also include a
description of the input format matching the output of 'git ls-tree
--name-only'.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 4834fb434d..0914619881 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -50,6 +50,14 @@ To avoid interfering with other worktrees, it first enables the
 +
 When the `--stdin` option is provided, the patterns are read from
 standard in as a newline-delimited list instead of from the arguments.
++
+When `core.sparseCheckoutCone` is enabled, the input list is considered a
+list of directories instead of sparse-checkout patterns. The command writes
+patterns to the sparse-checkout file to include all files contained in those
+directories (recursively) as well as files that are siblings of ancestor
+directories. The input format matches the output of `git ls-tree --name-only`.
+This includes interpreting pathnames that begin with a double quote (") as
+C-style quoted strings.
 
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
@@ -128,9 +136,12 @@ the following patterns:
 ----------------
 
 This says "include everything in root, but nothing two levels below root."
-If we then add the folder `A/B/C` as a recursive pattern, the folders `A` and
-`A/B` are added as parent patterns. The resulting sparse-checkout file is
-now
+
+When in cone mode, the `git sparse-checkout set` subcommand takes a list of
+directories instead of a list of sparse-checkout patterns. In this mode,
+the command `git sparse-checkout set A/B/C` sets the directory `A/B/C` as
+a recursive pattern, the directories `A` and `A/B` are added as parent
+patterns. The resulting sparse-checkout file is now
 
 ----------------
 /*
-- 
gitgitgadget

