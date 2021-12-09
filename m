Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED75C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhLIKeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbhLIKdy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCB2C061353
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:20 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so6219760wme.0
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nXlUzK0eG1nytfPPrkrw0gtj2yvs5u/jSO3jH2X9/oQ=;
        b=owjJK6X4p+JTjFnWr/mNHTlciPp+YQc/xgS2Gf0wHNOgLqWFGB6jCBuLVYK5ulC7ez
         OMrpTyf+bpx+niTGE+B6Xa7/pLeGQWanuNH89sb3vGf5fifc3P4Uj4PTAD48Tp74SUyf
         WDAjcQspiKWMtrCCwHBmUFLloBrRX1SFs9BYToWKZvI75gIcjbZ1b9LFDV+Ap+WMB6fT
         wHbRYKQoxO1msHrRekra8yY8Q9/1KccvyUc4MYjBQo8zyJRoIblIKjc98hpCJWXQ0MJP
         0D+jjHLUTJSRH8X/U3BHVqvWUaHavQSGzRqRjV4i3F3hdjog1ayxLnwUH39Yq+TTq1BJ
         gT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nXlUzK0eG1nytfPPrkrw0gtj2yvs5u/jSO3jH2X9/oQ=;
        b=zhg1gg19ryNyD9sOhNJBn9qqYBE8YFAASm+z/K42rDMnLUPKA7kHCG+lNQy4vvm30b
         isXGhvtpZH+MbQz+Gnb+ugEIQbk2rxFPeuDi2dfWjrijiEv8OBTPvl1xttYJgN3a4Bqm
         JPm2EGyWWv9T5k3j7o522qF42GBasuTuY340SEzdUc4wj0sit+u2X6VXKy7rjVnKydjJ
         REGwRWcZbIV56mGVvujUGYexdDs04ThfGyxShWOcVKhzys7W3ExVXm7RYuqSJ/baq37v
         elg2x+SweT56QvfkSYkqaLCUjpTSy1+jKnMe/+yjITf/zBQaAE76fJhqVJfsLPag5d05
         vb0A==
X-Gm-Message-State: AOAM530iWJbJT7EanQuc9LjpVj1urEO4XMFTNuMZlGsO06HjY879ruzd
        yemrhhXyOH7e9PvHFSxgKUHkag0xyRY=
X-Google-Smtp-Source: ABdhPJyYHOR75EQHbkx7F7uXGwckHvhaXzIbwFhEAxVgKCXOGOBJKkrGSBKDf76cPTGVQ7PQ57FLMg==
X-Received: by 2002:a05:600c:378b:: with SMTP id o11mr6120168wmr.157.1639045819123;
        Thu, 09 Dec 2021 02:30:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm5559894wrr.47.2021.12.09.02.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:18 -0800 (PST)
Message-Id: <fb413cab3a86a8a880ce3a5b10769764bb0e49e6.1639045809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:30:03 +0000
Subject: [PATCH v5 09/15] diff --color-moved: call comparison function
 directly
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

This change will allow us to easily combine pmb_advance_or_null() and
pmb_advance_or_null_multi_match() in the next commit. Calling
xdiff_compare_lines() directly rather than using a function pointer
from the hash map has little effect on the run time.

Test                                                                  HEAD^             HEAD
-------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38(0.35+0.03)   0.38(0.32+0.06) +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.87(0.83+0.04)   0.87(0.80+0.06) +0.0%
4002.3: diff --color-moved-ws=allow-indentation-change large change   0.97(0.92+0.04)   0.97(0.93+0.04) +0.0%
4002.4: log --no-color-moved --no-color-moved-ws                      1.17(1.06+0.10)   1.16(1.10+0.05) -0.9%
4002.5: log --color-moved --no-color-moved-ws                         1.32(1.24+0.08)   1.31(1.22+0.09) -0.8%
4002.6: log --color-moved-ws=allow-indentation-change                 1.36(1.25+0.10)   1.35(1.25+0.10) -0.7%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 78a486021ab..22e0edac173 100644
--- a/diff.c
+++ b/diff.c
@@ -994,17 +994,20 @@ static void add_lines_to_move_detection(struct diff_options *o,
 }
 
 static void pmb_advance_or_null(struct diff_options *o,
-				struct moved_entry *match,
-				struct hashmap *hm,
+				struct emitted_diff_symbol *l,
 				struct moved_block *pmb,
 				int pmb_nr)
 {
 	int i;
+	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
+
 	for (i = 0; i < pmb_nr; i++) {
 		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
 				prev->next_line : NULL;
-		if (cur && !hm->cmpfn(o, &cur->ent, &match->ent, NULL)) {
+		if (cur && xdiff_compare_lines(cur->es->line, cur->es->len,
+						l->line, l->len,
+						flags)) {
 			pmb[i].match = cur;
 		} else {
 			pmb[i].match = NULL;
@@ -1195,7 +1198,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
 			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
 		else
-			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
+			pmb_advance_or_null(o, l, pmb, pmb_nr);
 
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
-- 
gitgitgadget

