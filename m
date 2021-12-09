Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E4C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhLIKeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhLIKdz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79C0C0617A1
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t9so8838882wrx.7
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p2vb6cLuLTkHSnEEqr1bN8UrIqfnfxxTwYxWo4ujnVY=;
        b=iEpMVoyQuNBlRU6HVUT0N61kcCV9OUht70bqyNHtxnvSV/6mEzVMFffrYaAQNJkNQA
         sHDtIQOwHGLqWn1ZqtcVHTm/64tKhkTM6ibd1NSpXzqgwbMwsCYPD1ZfrW9w4eQBCgdz
         b/IlEyR0Ee0+YALojHJYzNLOFrE8cSgIq2FP2dJAg5SbNUKSqDzsRvifNl4gVgPEJIzl
         pZObeOkh9WoCpUixMAIA/ailfHhQm6U2iuqOQaTVTj4dqfD8wr7Yr2Ab/ofVDO5LHfeZ
         iXYPlcLpy4ZaeqNAjDxZu5dEEid2HsEz+GrIwpGKqtQ/jqI2cnuljQM/RQaHRf70J2ce
         byRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p2vb6cLuLTkHSnEEqr1bN8UrIqfnfxxTwYxWo4ujnVY=;
        b=BFFRgUtmHgMHpwmQJFLUVVMYa7PPs6YaAW5SMPr3H0cnGcbmM/BDlxYYTPx8XWLuFD
         GOSKqTK0AkhS76wXwqQbIbbKxqnHhcve4lN6eAr6/dyIV3PrmL0pXdllDLIZbU/skuUp
         QR5Vn3uMhjZx4k5NHfOoiqUyHmbYTvawGVU35thEiJ4W7p0/AxqsnE/NXQXyisI9vcEH
         Q9SiiSp4agxubyEBSQUO/yFas5chXVDHIcKHUPo/6UrzrtvVME6mPTUr0pqlwHEEZh7L
         WMK1wd04uW3tjGZLOjQar8M47ADF1jhQP4Fv7oERbpUo2kjMfI5z60S6rno17TLDgCfP
         2VLQ==
X-Gm-Message-State: AOAM532b0ml/mMnrH2Ce4klca1dSDqwtOSVN8+WJ6yRVCcE4pOA5gLem
        0uyL3u1MRM2VhROnYktBWwW7AO/2qFo=
X-Google-Smtp-Source: ABdhPJy6FJD/OFGbV/1/KpZwWTp7SKU5yvVXLl9pi/3mHjYPSsA1rPMmj2fi1bnI3bkdwB4v87dRtg==
X-Received: by 2002:a5d:5251:: with SMTP id k17mr5409540wrc.482.1639045819978;
        Thu, 09 Dec 2021 02:30:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm5122500wrh.16.2021.12.09.02.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:19 -0800 (PST)
Message-Id: <ec8764082d5080284214b2c639f99984bad166ea.1639045809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:30:04 +0000
Subject: [PATCH v5 10/15] diff --color-moved: unify moved block growth
 functions
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

After the last two commits pmb_advance_or_null() and
pmb_advance_or_null_multi_match() differ only in the comparison they
perform. Lets simplify the code by combining them into a single
function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/diff.c b/diff.c
index 22e0edac173..51f092e724e 100644
--- a/diff.c
+++ b/diff.c
@@ -1002,36 +1002,23 @@ static void pmb_advance_or_null(struct diff_options *o,
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
-		if (cur && !cmp_in_block_with_wsd(cur, l, &pmb[i])) {
-			/* Advance to the next line */
+		if (o->color_moved_ws_handling &
+		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+			match = cur &&
+				!cmp_in_block_with_wsd(cur, l, &pmb[i]);
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
 
@@ -1194,11 +1181,7 @@ static void mark_color_as_moved(struct diff_options *o,
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

