Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC567C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B4C61107
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhGTKAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbhGTJ4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1999C0613DD
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1304187wmc.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nunq3FkTqdTpNuMe+/uq7V+j0dRIWt2R3G2vbK6JIQQ=;
        b=t7Y/HbtqCLF/A9Hean4DFu8siLoB2UX/itioZPFiIpM3ZMRc0oHzD/oc9ExTrro97g
         lrAYBPuCeWRTSIx/P/uVmZ+/jgRP1Y2VREgHcuexmlmrP8UDTFyMi7qDw0u+Q3JS40s7
         zKAaBd+huhLEyRzKcHTSZMJpENv8iHeToDb8aMYM919sxwr0krONtdlb5vOHUJDnHn1L
         7B7f0VK6+E6KWVVpjvf6gRLIkkyf4nYrpROcqGp/ws5NDBcrNo1DYyrmlr7GhSk7dHIk
         De9omrMiSjDN0KvGxddB3IPGPMrld2L8beKoFobIcrBuCRGhQS8NwLhWfRxAeE8PMVYh
         LGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nunq3FkTqdTpNuMe+/uq7V+j0dRIWt2R3G2vbK6JIQQ=;
        b=N8V9MqFNqP6c+Ub8iLnh7/oekJX96Vmo9u5EvrlB9s55Hy/LjG9ZYt7c1zHk996J0d
         Ye6fZr7NRTw9UJU2fkqFc3UWbFG/Be7m2P9rWNUX4rt50/IE1bO/JVdtO9xQhAgrcnta
         8v2qE/MWuldS4E79qV7wtQPsuqVVZVC2ljHKLCFDiJvwxD6ku/Y3cCVMxKCn8UFXjYFi
         zeijOliyIAdR4te6xulP29ybo9tYXYvMZ3N3Ftsv6l2rjAuLcvXIGRrzWuTob6eZHHhz
         0fK82YvLDa97tmqyfK7TyPSxXeEmxg8LZbiGtd0+WoZvI+GyWWymdgEp45To5ePMnjov
         wYeA==
X-Gm-Message-State: AOAM533Q6lJlz3kC4lyagU1V9km62qyXOLcTocgBVIsAHa8sKHnrl7oA
        VOrBI+OdGCMqKVXDzFbfu1nvakZ8gn8=
X-Google-Smtp-Source: ABdhPJwdBE/47AMbvL+4UTNwQd4oQ5yeY6jZtNIUkmmt7aH7nyq2s1e3sj/OoUIOyrVaWbbVZzCRsA==
X-Received: by 2002:a05:600c:3783:: with SMTP id o3mr31772451wmr.23.1626777400623;
        Tue, 20 Jul 2021 03:36:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm9445820wrt.24.2021.07.20.03.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:40 -0700 (PDT)
Message-Id: <9d0a042eae17e449d6fd5a4cb7df31a8a02d972c.1626777394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:30 +0000
Subject: [PATCH v2 09/12] diff --color-moved: stop clearing potential moved
 blocks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

moved_block_clear() was introduced in 74d156f4a1 ("diff
--color-moved-ws: fix double free crash", 2018-10-04) to free the
memory that was allocated when initializing a potential moved
block. However since 21536d077f ("diff --color-moved-ws: modify
allow-indentation-change", 2018-11-23) initializing a potential moved
block no longer allocates any memory. Up until the last commit we were
relying on moved_block_clear() to set the `match` pointer to NULL when
a block stopped matching, but since that commit we do not clear a
moved block that does not match so it does not make sense to clear
them elsewhere.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/diff.c b/diff.c
index 068473c0be3..4b5776a5a0a 100644
--- a/diff.c
+++ b/diff.c
@@ -807,11 +807,6 @@ struct moved_block {
 	int wsd; /* The whitespace delta of this block */
 };
 
-static void moved_block_clear(struct moved_block *b)
-{
-	memset(b, 0, sizeof(*b));
-}
-
 #define INDENT_BLANKLINE INT_MIN
 
 static void fill_es_indent_data(struct emitted_diff_symbol *es)
@@ -1093,11 +1088,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		if (pmb_nr && (!match || l->s != moved_symbol)) {
-			int i;
-
 			adjust_last_block(o, n, block_length);
-			for(i = 0; i < pmb_nr; i++)
-				moved_block_clear(&pmb[i]);
 			pmb_nr = 0;
 			block_length = 0;
 			flipped_block = 0;
@@ -1155,8 +1146,6 @@ static void mark_color_as_moved(struct diff_options *o,
 	}
 	adjust_last_block(o, n, block_length);
 
-	for(n = 0; n < pmb_nr; n++)
-		moved_block_clear(&pmb[n]);
 	free(pmb);
 }
 
-- 
gitgitgadget

