Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0944C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhLIKeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhLIKd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7D0C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso6183673wms.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hbX6ChgF1/7zCe8TRq2mAwsHjDZd1Mp8/GA16/PwtSw=;
        b=i+Pz3PR1ojL43V8shzQXD3V3fDTLvX2rs07xdIu1/MvNjV4EwdhqckLAhRzUW5XWae
         hGFg5F+zRZZJVQLstrGWs6qsJXumq8REEv0P85FI/KT+4vtxpbOxVgYnaNGHvTGMzHsO
         gpTKvBIOBXr5yJyEQhvc7vZdeUByZY6c8WlCvI+GyJqdgm1JdOgMtybQ2bGyI0dgpdKm
         kViOYdmwMcIitiota1fWBApct93TNRZQHPxqH7Mqqng1zuHu/x0NTMSXOokFFOm5aLK7
         e4cmPjjNy9tCzX5YNKlsaK4S2Rb5u9AgVSHe2v0zGY33iU7awPNwkwRxKZRtSXspVHE/
         s/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hbX6ChgF1/7zCe8TRq2mAwsHjDZd1Mp8/GA16/PwtSw=;
        b=nNOJbYkrgpycsu9qnundG13I4J2Am+/wfUHTr2OZeuLYsd04+p7M+89z4mkOzYfCIN
         54w2ecIdn/6UBL0CbpA2g7I9OPkZN039qVOmrSPMHaufSbUeMwj/cTYmsI+BuuX/ZnXO
         bSpAm4NbTyDV6fRUdEw6R4BTY05oWBOudZRiktNFFJEX7LXc2TZlLtUCqqSdcKfjKJvU
         HgwMVB/UTPcT7H81+Kjuq8/JfzANa2nksJIPtjaRlGRTVPnigVPKR6a9Icf4hz0jngQm
         vV5ZMH1FuOJ+WfVTc95cHMgoCfFs1nxxz0ZU0FoPsLINPTPdDYmCvhac7X0UHYcXWY/B
         yZSQ==
X-Gm-Message-State: AOAM533lKUadGCSq0xzwSeO4xZYudHd1OgdbWEOgJHca2N1yRI5fKhcB
        bwaudQt5KRN0ZqJJLO5XZlqYr2ppvok=
X-Google-Smtp-Source: ABdhPJwoPhjoMjz9gKVDfA5exetBM6IJfKR3O+A+0kZCyWpfomYszE70v77dD7QuDfO2vd7YeQbeIg==
X-Received: by 2002:a05:600c:6024:: with SMTP id az36mr4130933wmb.11.1639045821643;
        Thu, 09 Dec 2021 02:30:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r83sm8482093wma.22.2021.12.09.02.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:21 -0800 (PST)
Message-Id: <1db84490ee42bf8ad681d217de00a902ce9734c2.1639045809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:30:06 +0000
Subject: [PATCH v5 12/15] diff --color-moved: stop clearing potential moved
 blocks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
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
index 626fd47aa0e..ffbe09937bc 100644
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
@@ -1128,8 +1123,6 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		if (pmb_nr && (!match || l->s != moved_symbol)) {
-			int i;
-
 			if (!adjust_last_block(o, n, block_length) &&
 			    block_length > 1) {
 				/*
@@ -1139,8 +1132,6 @@ static void mark_color_as_moved(struct diff_options *o,
 				match = NULL;
 				n -= block_length;
 			}
-			for(i = 0; i < pmb_nr; i++)
-				moved_block_clear(&pmb[i]);
 			pmb_nr = 0;
 			block_length = 0;
 			flipped_block = 0;
@@ -1193,8 +1184,6 @@ static void mark_color_as_moved(struct diff_options *o,
 	}
 	adjust_last_block(o, n, block_length);
 
-	for(n = 0; n < pmb_nr; n++)
-		moved_block_clear(&pmb[n]);
 	free(pmb);
 }
 
-- 
gitgitgadget

