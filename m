Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90F2C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E0664DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhBPMCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhBPL7w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:59:52 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DC0C0617A9
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:24 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l12so12622019wry.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pvGma8kuJWMg4MnqQNa+39Xf9i0qHeVMJBPV0zf2dI=;
        b=rdvjRtMuZcPM8LTT+xupxSsg6JKive3sBpLYeDImVuQP+n7m/HeC3r6jHaf7QkZvNV
         CdWGzJVxtUbvvDO3Ro9ukuvacFcNQ75AUG/FVaGSQQtBk5NzMES1DY6VMzWEXMkBGIcx
         nCic1SSknVNFuMZJX0CtMcfPKk9qEzSDb3D4K8+NmjQuBVtU0lsLYk+wedKUNcZqZRPJ
         ynNAz7YCrXOgCTOvwJGEdXVQsRf/TrSksaxFEmMPHu6lWwnF7fz0c/jd8cjA8bQ3CUfI
         0DAOwVNA4A+G+KRUQK+Wmib+wG1y5OJMxt1SJB6m3NcwScGNZIz07jW1BGkEMmRQDIOF
         9/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pvGma8kuJWMg4MnqQNa+39Xf9i0qHeVMJBPV0zf2dI=;
        b=Ut/M8PNfsG9Eygi2QXU68noDImHMsR++vKo3TvoE8zCBb2ak5n131gmmoDbUfbyUGz
         V8TF6tlZrYQrFk+CGerxtKDIoqfsIwkF2ee2l9nezM41TX1+cTBl3TnyKQOnMZOHHvWi
         CLtrQrAxGx6AniNafiIBY39U69MKl7/EZIf2Nx3nJLA3wNOq3glLE3FSEOh6f1oz+CVd
         +VE+XGdc5hbXkIsOWHQuCopIHhk5H1LUIKbY9QgEs5eW5u24wbpYAEo3R8agVI7h4wyJ
         wC/dEd6LFWUHoZBvv3n71rr5yyG9p3An/SSSTzs5iBYV/57iIdVOG8QuzvnzOpWp7y8C
         nu9g==
X-Gm-Message-State: AOAM533BAcXLTnlhqbY8q8wCIKkklyimj2Zq/ZiOKEAX5PPLYtVw2Odc
        n2Ct+fFjYpHwEWMBaGp0QuLEJq4oPVHGvQ==
X-Google-Smtp-Source: ABdhPJxyMxTYiGJwNR8uOa5hC1Z54P1i0pE1Wab1+Kef+wUkWyALxtuxeBoCO3ifLo/mxueL8jI02A==
X-Received: by 2002:a05:6000:8f:: with SMTP id m15mr22434735wrx.376.1613476702757;
        Tue, 16 Feb 2021 03:58:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/22] pickaxe/style: consolidate declarations and assignments
Date:   Tue, 16 Feb 2021 12:57:51 +0100
Message-Id: <20210216115801.4773-13-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor contains() to do its assignments at the same time that it
does its declarations.

This code could have been refactored in ef90ab66e8e (pickaxe: use
textconv for -S counting, 2012-10-28) when a function call between the
declarations and assignments was removed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index a9c6d60df22..a278b9b71d9 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -70,13 +70,9 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 
 static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 {
-	unsigned int cnt;
-	unsigned long sz;
-	const char *data;
-
-	sz = mf->size;
-	data = mf->ptr;
-	cnt = 0;
+	unsigned int cnt = 0;
+	unsigned long sz = mf->size;
+	const char *data = mf->ptr;
 
 	if (regexp) {
 		regmatch_t regmatch;
-- 
2.30.0.284.gd98b1dd5eaa7

