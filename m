Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D391C2D0C3
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99E820725
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsK6F6kN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfLPPsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:19 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:34135 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbfLPPsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:15 -0500
Received: by mail-wr1-f43.google.com with SMTP id t2so7884705wrr.1
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UTlc6qjNMhMEu4zUmegOUS6A2tNDjGefjNDO1CKZ5Kw=;
        b=EsK6F6kNaj5OqN43sSYOMHbGwbhXR3AXc0cLwLwgRLLULpEDhcQGQkxE+Zt7Z2KcHK
         qbcG5hd6IBUqnb55AalvMco6n50A9Da0ReIsi974jOc5wrg8BJsKprGpxdVIDubNwqgA
         JZRNklyBpTuNVEkKf9RPmWvioyoSRAxGwOJ+eizvNErK7GqH/fGcGGFB9dzhHeA38E4U
         L719T+Jgx2aj+QD/z1XSaTuWOCpuRS8efzo0s/NA/Vu3fVypBCXg9HpOuUbj1qpBOEli
         uWLuGTU7YpetahhtGk4dX+kF1DqIFTVcmuQqlFBvaKUbQfCMnRMpTNKcNF71RuNgbqTg
         Ryow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UTlc6qjNMhMEu4zUmegOUS6A2tNDjGefjNDO1CKZ5Kw=;
        b=i3UEbfDPcGiUn399AqZNtp/3NpFnsjJaheXXKBLS1VUdNEbdJo9vos/0sjzaz/Wf8y
         GsIMAL3IZN83ASwgDvMTLxtew+M9V7OI91YauilJpLPTT8l+pGVYsb+uXh/+SzK7eQLM
         h1uKPIkakEPUP7WbVKb3wWr5BkSoShp+iLbm8S5LjilsRSg+xG+tn/ZFxv82/RL2cieJ
         duD3i25XV+nTiuCzOs5l50K17vVrlDQp4dQuYgm6WbsymAgU06kdfUEDGY0EgKZvPKY4
         Q9GimX3wf+V3rP6vaWw3NkpkletYD5789FNbkuy7EVdlIujGv3ynEo6xgXiQIfz9+YZw
         8GaA==
X-Gm-Message-State: APjAAAWR87bVWJ6U1lOJEt2Bdsk4m7FUXVJrs6KrJAv2aRJusdVvAJwx
        dQmSxNK+OH4gYBMaiqL2zjneNzj5
X-Google-Smtp-Source: APXvYqzTCfFVtSgw78Tm8bAFeHbBtZH1DaOq/1oa+YzwnARRyfiRAsz6jO7ijzuvxPF5ilGnlBfXBA==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr30084618wrw.327.1576511293525;
        Mon, 16 Dec 2019 07:48:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm6052283wmh.11.2019.12.16.07.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:13 -0800 (PST)
Message-Id: <85f7ccc4e07294d8107b2f1ddd19b9b1c2a65708.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:56 +0000
Subject: [PATCH v2 08/18] doc: checkout: fix broken text reference
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

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-checkout.txt | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 2011fdbb1d..d47046e050 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -95,12 +95,10 @@ using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
 
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
-	This is similar to the "check out paths to the working tree
-	from either the index or from a tree-ish" mode described
-	above, but lets you use the interactive interface to show
-	the "diff" output and choose which hunks to use in the
-	result.  See below for the description of `--patch` option.
-
+	This is similar to the previous mode, but lets you use the
+	interactive interface to show the "diff" output and choose which
+	hunks to use in the result.  See below for the description of
+	`--patch` option.
 
 OPTIONS
 -------
-- 
gitgitgadget

