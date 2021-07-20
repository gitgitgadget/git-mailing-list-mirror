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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FF8C636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C09961175
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhGTJ7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbhGTJ4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAB2C0613E9
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t5so25418905wrw.12
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3SmJDJvsOG2gFGwfBSH1N2QCy/wGVsNdWNxop02Q4HM=;
        b=Iheq0QSSZFs+Jl90+wQYhZu5rvlzZOwE/cGMc7AhdRnQqtQzMGkrIl9kMawO2fWjCf
         Nyavh4h32qW2fP2yEM8laU1k+17un3jpdTMxaHyd+Hs1QIsPIaSd/Rm9jeNtG+xPLlzt
         6gk+WTDTHo2ob3gx60WcxOsYNUKaQAlL3dIuoMBvPlDPh+Q6+G5rNChk0ZvbKAvPq+XB
         CjWLkxKVuWXotiiyxLTBlr+hr4b8mCoVcbRdmGykk7SvbYmRDIX7CzlFPUu7bJqO+WS8
         H3TKHfempahk3RrXmtnx4OeOgSuLERVUOQnH8mtZo3eGj4pmE+tiWYI1ToqE0NQLl5qy
         yXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3SmJDJvsOG2gFGwfBSH1N2QCy/wGVsNdWNxop02Q4HM=;
        b=hb8ERQ1rQJayyFWFiZHJtl4dJnwe54fV+k11R+QyRyvENo5zbXhXT+5ABVyWjV1JCq
         I4V6QrlbEyNj1kqXcVMcVkSudG5ZMLXd+CU9gBnwVvUSkF7ho8342RXab9+mJGmi7QTQ
         4NXIqTG1qAm0W0R2nq89WoabZtmLl7ajyvSytJXl87hSJhsScCizDVtCYzbeKXlWTavc
         hWE/4RcbQOkX54rv/UX1DBi2socQhhZclEUd6nNLkwyUo8kTQHBH46HgkRPX7467qEAg
         CzsEEt/cwfKrpNXRTqkexDwyKvqVSLu9ju0LBrAyTiSKMnQRNC6FU5uv8spP3TkKjT6Z
         dvVw==
X-Gm-Message-State: AOAM533iFlT5bmrsFaqmUNlKmzscgIUhRRFqGsrf60DCXmoMgsBdRYzO
        mxRyHDWfn4cUPupWqzmZQGmPdX3CogE=
X-Google-Smtp-Source: ABdhPJwFH6kZT/LgduIDwrGtwY9wOZRIM+AstFs+fiA1jqiJx2eDsuep6NDVRhHM5Ev7MdoDc1ozLA==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr35349855wrr.296.1626777398874;
        Tue, 20 Jul 2021 03:36:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm19126278wmh.44.2021.07.20.03.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:38 -0700 (PDT)
Message-Id: <cfbdd447eeeff41a7cd32ba513ae302588438753.1626777394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:27 +0000
Subject: [PATCH v2 06/12] diff --color-moved: call comparison function
 directly
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

This change will allow us to easily combine pmb_advance_or_null() and
pmb_advance_or_null_multi_match() in the next commit. Calling
xdiff_compare_lines() directly rather than using a function pointer
from the hash map has little effect on the run time.

Test                                                                  HEAD^             HEAD
-------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41(0.37+0.04)   0.41(0.39+0.02) +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.82(0.79+0.02)   0.83(0.79+0.03) +1.2%
4002.3: diff --color-moved-ws=allow-indentation-change large change   0.92(0.89+0.03)   0.91(0.85+0.05) -1.1%
4002.4: log --no-color-moved --no-color-moved-ws                      1.31(1.21+0.10)   1.33(1.22+0.10) +1.5%
4002.5: log --color-moved --no-color-moved-ws                         1.47(1.36+0.10)   1.47(1.39+0.08) +0.0%
4002.6: log --color-moved-ws=allow-indentation-change                 1.50(1.41+0.09)   1.51(1.42+0.09) +0.7%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 55384449170..c056d917d0d 100644
--- a/diff.c
+++ b/diff.c
@@ -995,17 +995,20 @@ static void add_lines_to_move_detection(struct diff_options *o,
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
@@ -1154,7 +1157,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
 			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
 		else
-			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
+			pmb_advance_or_null(o, l, pmb, pmb_nr);
 
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
-- 
gitgitgadget

