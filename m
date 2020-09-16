Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11B2C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5830621582
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io68xU74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgIPSMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgIPSK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:10:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB2CC061756
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so7858923wrn.10
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a99TZs8RDfEzZQgrvCmmxLFT3tTlt4p0jVhkvTLfJno=;
        b=io68xU74T3OErxLfxWsqQMu9gjsEHCfPJ0l/G+HkoxDglbId1NgRNSkshdOewU+DDH
         cRZi5MTVX6Wba8COMm/mRi6D8EgvlhSrEvN9+++XJDfC/H2YdMUt8lQYlDbo1KLcESZy
         Al1SXM9gIPB+EH8Vc9Xkm3Zf9xrWcxsJxNZ0d+DEmj3Q8bmr8rgwL3E0vCrxMwcYXGUu
         g2pXMn8eiG9a17aEHgPk4g4hf1FjJ6b3OBja6FugNRfkAYoZC4N3WnZy2P1cpR/kRYdO
         4J6IqiDG5LkCh0D3r32MkRaJ7ACrzngPwLPGKDmpF54X3O5aKyeLXE/YpS+PWtBvVgJZ
         N1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a99TZs8RDfEzZQgrvCmmxLFT3tTlt4p0jVhkvTLfJno=;
        b=LE9tWgjyQtoG2HtVLdbRmVH1teNfw78GX8NNwLobyicWxWjXy81m80uHbV7jiHUgaR
         27dMIJYorilBW5xZWoaIrltJUZgytBv+Vl0xYpMWaHwPC/QOrmDYhGnG2mbwGoLyrZke
         2pSJIp8VdSIFP3YcexauX0Fgk3XxOSOIbERUSNqzzj4ld8H/63yUFUfBvTQyqx89YDoZ
         WCQL8Jphm7YzjaBuFwid9Lgt2QJ1uvkXWO8NPagQ2oS2rYT7rGJNbifY7ksZNLB13CWZ
         +ZWfaYEio1Lz3kiV4tdnzqZASYjfAqrVdecBxIoKtleVydczr10bqfwQDMzpHOSEFRH1
         cWwQ==
X-Gm-Message-State: AOAM532CJwrizwZjPNduZ7wWv9dOl7273EUshVu6bM5/tANyp3h3zT2h
        qw/f5zr7OTUtjXagbnDx94+RRM9E/iM=
X-Google-Smtp-Source: ABdhPJw1OFRZQrRp/Mqf75enPCwyky3crh05nAPF7wiJHdIQjafy0Egr6JOKwvjpsG72bqilOjHWkg==
X-Received: by 2002:adf:ec86:: with SMTP id z6mr28686349wrn.109.1600279855041;
        Wed, 16 Sep 2020 11:10:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm32931999wrh.6.2020.09.16.11.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:10:54 -0700 (PDT)
Message-Id: <587ddca42ae36be3d5b333cefe1f9af768bacc9a.1600279853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.git.1600279853.gitgitgadget@gmail.com>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 18:10:49 +0000
Subject: [PATCH 1/5] fast-export: avoid using unnecessary language in a code
 comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In an ongoing effort to avoid non-inclusive language, let's avoid using
the branch name "master" in a code comment.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1b8fca3ee0..5527135ba8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1026,7 +1026,7 @@ static void handle_tags_and_duplicates(struct string_list *extras)
 				/*
 				 * Getting here means we have a commit which
 				 * was excluded by a negative refspec (e.g.
-				 * fast-export ^master master).  If we are
+				 * fast-export ^HEAD HEAD).  If we are
 				 * referencing excluded commits, set the ref
 				 * to the exact commit.  Otherwise, the user
 				 * wants the branch exported but every commit
-- 
gitgitgadget

