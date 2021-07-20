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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8DEC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE3F6113C
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhGTJ7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbhGTJ4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C77C0613EE
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m11-20020a05600c3b0bb0290228f19cb433so1224708wms.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=80GoSsR6PdqwqviMcSNCekMfq0aB+E1fQQkO1RL2oMo=;
        b=Q/vKNCsF7xliISJe8s7T2P0T17NEmFIP85LncqdKGVglK9rIgBk2G1aH3VrlI9xjMB
         yhv8dWZdzCdPcRguBZLk/0Fs0Ged38P1cVFjkPbvTkgBkz96yLRRM3Sg2Slr4QPv3Knw
         YTJN+S3fwVzOlwfEFReLjBIChQOi0YXqAz+K9NQwEIJisIlmec26SBkIZwcdrZivIPY7
         PApLB8pXw8CE0aMD7T0AOl7T265aDLrJcD5fM+8GzIIdakZY6wjuV4G0IRYQ0+IR8usG
         lMjITHXe9jSDJRQJ63K/vqBkOEjY3wIUJOLztVL6LchbUb+F28RYCd2vmUUZtYtKj5h1
         ozFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=80GoSsR6PdqwqviMcSNCekMfq0aB+E1fQQkO1RL2oMo=;
        b=TG8nPkC9pW7u291M8c1Lie577d9ln9G7MOsaV2u2l56sziZz91rKPUwI+KqrudLuRx
         Yoe4y+O/USTBKa+uS4L6NdrRlazSnh2muBJKgMIbHH3N6WGKly8st4UZSZLIMzsDLeeY
         ykw7LVEbhZMBdVf46xW/hSjXO+dfRDVOzI8rpS4sWOv+564uCrs4yPvAmKDgmQRBz7kF
         f2zpj1Vm9i5gCDE7gJpnkeFJzAb0/PfDZcUZfe50YW8X0R1Sg4pKbj9dctZpcmiMOYKt
         CaCMaaSu+MeHsDxRsfmJ/hju5XoKWe3VF/JUOvZp5P/6Qg5Fagv4S9WHAiLbNa0yB8My
         /hlQ==
X-Gm-Message-State: AOAM53298GV/04fJnywHQqR/bxc9EUxKBBtUZQrPngev7o2bKsTHhnH+
        9rGOFFDCPk7fdguB6MVJOb2BdwZZZd8=
X-Google-Smtp-Source: ABdhPJzPgVAOd0y1xMMXJPO1oAPn+4frYFfJxNV9iRqkgHFVS+LuyfFT/U13wsquiscsumhGEIZBnA==
X-Received: by 2002:a05:600c:350b:: with SMTP id h11mr12359334wmq.20.1626777399490;
        Tue, 20 Jul 2021 03:36:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm22397624wrq.88.2021.07.20.03.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:39 -0700 (PDT)
Message-Id: <73ce9b54e869740ff23253d4153405444c673276.1626777394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:28 +0000
Subject: [PATCH v2 07/12] diff --color-moved: unify moved block growth
 functions
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

After the last two commits pmb_advance_or_null() and
pmb_advance_or_null_multi_match() differ only in the comparison they
perform. Lets simplify the code by combining them into a single
function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/diff.c b/diff.c
index c056d917d0d..b03f79b626c 100644
--- a/diff.c
+++ b/diff.c
@@ -1003,36 +1003,23 @@ static void pmb_advance_or_null(struct diff_options *o,
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
 	for (i = 0; i < pmb_nr; i++) {
+		int match;
 		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
 				prev->next_line : NULL;
-		if (cur && xdiff_compare_lines(cur->es->line, cur->es->len,
-						l->line, l->len,
-						flags)) {
-			pmb[i].match = cur;
-		} else {
-			pmb[i].match = NULL;
-		}
-	}
-}
 
-static void pmb_advance_or_null_multi_match(struct diff_options *o,
-					    struct emitted_diff_symbol *l,
-					    struct moved_block *pmb,
-					    int pmb_nr)
-{
-	int i;
-
-	for (i = 0; i < pmb_nr; i++) {
-		struct moved_entry *prev = pmb[i].match;
-		struct moved_entry *cur = (prev && prev->next_line) ?
-			prev->next_line : NULL;
-		if (cur && !cmp_in_block_with_wsd(o, cur, l, &pmb[i])) {
-			/* Advance to the next line */
+		if (o->color_moved_ws_handling &
+		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+			match = cur &&
+				!cmp_in_block_with_wsd(o, cur, l, &pmb[i]);
+		else
+			match = cur &&
+				xdiff_compare_lines(cur->es->line, cur->es->len,
+						    l->line, l->len, flags);
+		if (match)
 			pmb[i].match = cur;
-		} else {
+		else
 			moved_block_clear(&pmb[i]);
-		}
 	}
 }
 
@@ -1153,11 +1140,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			continue;
 		}
 
-		if (o->color_moved_ws_handling &
-		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
-		else
-			pmb_advance_or_null(o, l, pmb, pmb_nr);
+		pmb_advance_or_null(o, l, pmb, pmb_nr);
 
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
-- 
gitgitgadget

