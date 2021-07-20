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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315C1C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF036108B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbhGTKAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbhGTJ4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532B7C0613EF
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l7so25438741wrv.7
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RoQDZcAdoGUDb6H+X9AUIqAxsZArFcVOc4P0K4BHhpg=;
        b=PFzCzA4ZnkvCy5apeXBJRhSgAQs95G79vovNutdvgDWBXOyoYGAZNIZ5y60bqgli0A
         8VNoNcTri5QkwbO2t9lEwFAJxkf6mT0GU7r7qnmCfXYbMEn5mu6hT1LL2iK3+0LyTrsG
         gxL6E/0mOIm8iArqeJT7mRuT3K3iQXly0bdzpcCPFhDMvcs1M+Ym9Hsb0fI2DYFK+nz0
         LJ/hLWvaNVYUAGGvjgefG2CO5Q9Zp8oF6Lwi0gSi1+xxdHaw3VL4qCA9OViMrgrQA/w/
         lRpOMY3okFRMTYRjLdAjMSeiY42/UQjtkczw+B6jy8y4VLbT3CDSyDgCqi/vFbp7UHRq
         nNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RoQDZcAdoGUDb6H+X9AUIqAxsZArFcVOc4P0K4BHhpg=;
        b=OGQZKX00D4P+AGjTF0L6Ho2Rhh2giiIpqHnp19VEQ1jMQDWuHsVUA7FYscutmH17Ee
         j3WLdBxIGrQUTFEw0IOSWlj0Mn4hlhmZDL5cPa5d5E5HRD9zUiGZJgrqkphXQS/OEDX0
         4EnvWBOO2PhdCP6AmsJ0+WkXJz/WaM8ppGfGdWWjeRLf1tMDSVTFEUGZh8GDVGY1uatr
         rPmRph12dVkvI+INdaMeBNGeVxP28wKBDZbZaiXQm3JJP3FOZ9xeA+UPdkLwCeZf8az+
         UGDMlE1d9H1JrWYQSJCHUszsxjRqxPwUtQJPx0SrYxMxOFHKYGc0ds2Sc923CkY1NrEb
         sbpA==
X-Gm-Message-State: AOAM531nhX8g4CBZPW6yMRLw6qwe/RorSt37WczDQlZgAz/PU8Y8A9xA
        lfAsDBvRqKlpkdLSvb91C682UQ1NbqQ=
X-Google-Smtp-Source: ABdhPJxup/QRYTBm/nWs5764/9866HcdzaptuKO/49bT+/MqI2rM/hnbpKIQGscWuqABf9Hhom4vRA==
X-Received: by 2002:adf:ec4b:: with SMTP id w11mr35276003wrn.420.1626777400036;
        Tue, 20 Jul 2021 03:36:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16sm2044885wmg.11.2021.07.20.03.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:39 -0700 (PDT)
Message-Id: <ef8ce0e6ebceb715e75c567a3caf5a64052b5312.1626777394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:29 +0000
Subject: [PATCH v2 08/12] diff --color-moved: shrink potential moved blocks as
 we go
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

Rather than setting `match` to NULL and then looping over the list of
potential matched blocks for a second time to remove blocks with no
matches just filter out the blocks with no matches as we go.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 42 ++++++------------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/diff.c b/diff.c
index b03f79b626c..068473c0be3 100644
--- a/diff.c
+++ b/diff.c
@@ -997,12 +997,12 @@ static void add_lines_to_move_detection(struct diff_options *o,
 static void pmb_advance_or_null(struct diff_options *o,
 				struct emitted_diff_symbol *l,
 				struct moved_block *pmb,
-				int pmb_nr)
+				int *pmb_nr)
 {
-	int i;
+	int i, j;
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
-	for (i = 0; i < pmb_nr; i++) {
+	for (i = 0, j = 0; i < *pmb_nr; i++) {
 		int match;
 		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
@@ -1017,37 +1017,9 @@ static void pmb_advance_or_null(struct diff_options *o,
 				xdiff_compare_lines(cur->es->line, cur->es->len,
 						    l->line, l->len, flags);
 		if (match)
-			pmb[i].match = cur;
-		else
-			moved_block_clear(&pmb[i]);
+			pmb[j++].match = cur;
 	}
-}
-
-static int shrink_potential_moved_blocks(struct moved_block *pmb,
-					 int pmb_nr)
-{
-	int lp, rp;
-
-	/* Shrink the set of potential block to the remaining running */
-	for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
-		while (lp < pmb_nr && pmb[lp].match)
-			lp++;
-		/* lp points at the first NULL now */
-
-		while (rp > -1 && !pmb[rp].match)
-			rp--;
-		/* rp points at the last non-NULL */
-
-		if (lp < pmb_nr && rp > -1 && lp < rp) {
-			pmb[lp] = pmb[rp];
-			memset(&pmb[rp], 0, sizeof(pmb[rp]));
-			rp--;
-			lp++;
-		}
-	}
-
-	/* Remember the number of running sets */
-	return rp + 1;
+	*pmb_nr = j;
 }
 
 /*
@@ -1140,9 +1112,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			continue;
 		}
 
-		pmb_advance_or_null(o, l, pmb, pmb_nr);
-
-		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
+		pmb_advance_or_null(o, l, pmb, &pmb_nr);
 
 		if (pmb_nr == 0) {
 			/*
-- 
gitgitgadget

